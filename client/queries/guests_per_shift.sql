-- кол-во гостевых посещений за смену
SELECT shift_id, shift.place_id, employee_id, shift.start_utc, shift.finish_utc, COUNT(visit_id) as guests
FROM shift
LEFT JOIN visit on shift.place_id = visit.place_id and
                   visit.start_utc <= shift.finish_utc and
                    visit.finish_utc > shift.start_utc
LEFT JOIN client on visit.client_id = client.client_id
WHERE card_level = 1
GROUP BY shift_id, shift.place_id, employee_id, shift.start_utc, shift.finish_utc
ORDER BY guests DESC
-- LIMIT 10;