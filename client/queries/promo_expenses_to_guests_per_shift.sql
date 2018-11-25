-- promo_expense должен быть предложен гостям. Кол-во проданных промо-предложений к количеству посетивших гостей
SELECT shift.shift_id, employee_id, place_id, start_utc,
       promo_expenses, guests, (promo_expenses::float / guests) as coeff
FROM shift
INNER JOIN (
  SELECT shift_id, COUNT(expense_id) as promo_expenses
FROM shift
LEFT JOIN expense
ON expense.place_id = shift.place_id and
   expense.creation_utc >= start_utc and
   expense.creation_utc < get_next_shift_start(employee_id, shift.place_id, start_utc) and
   expense.creator_employee_id = employee_id and
   expense.is_promo_type = TRUE
GROUP BY shift_id
    ) as promo on promo.shift_id = shift.shift_id
INNER JOIN (
  SELECT shift_id, COUNT(visit_id) as guests
FROM shift
LEFT JOIN visit on shift.place_id = visit.place_id and
                   visit.start_utc <= shift.finish_utc and
                    visit.finish_utc > shift.start_utc
LEFT JOIN client on visit.client_id = client.client_id
WHERE card_level = 1
GROUP BY shift_id
    ) as guests on guests.shift_id = shift.shift_id
ORDER BY coeff DESC;