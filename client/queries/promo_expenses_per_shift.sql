-- Кол-во проданных услуг (promo_expense) за смену
SELECT shift_id, employee_id, shift.place_id, start_utc, COUNT(expense_id) as promo_expenses
FROM shift
LEFT JOIN expense
ON expense.place_id = shift.place_id and
   expense.creation_utc >= start_utc and
   expense.creation_utc < get_next_shift_start(employee_id, shift.place_id, start_utc) and
   expense.creator_employee_id = employee_id and
   expense.is_promo_type = TRUE
GROUP BY shift_id, employee_id, shift.place_id, start_utc
ORDER BY promo_expenses DESC;