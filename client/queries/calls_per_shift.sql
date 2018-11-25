-- Кол-во входящих звонков за смену
SELECT shift_id, shift.place_id, shift.employee_id, shift.start_utc, shift.finish_utc, COUNT(call.timestamp_utc) as calls
FROM shift
LEFT JOIN call on call.place_id = shift.place_id and
                   call.timestamp_utc <= shift.finish_utc and
                    call.timestamp_utc > shift.start_utc
GROUP BY shift_id, shift.place_id, shift.employee_id, shift.start_utc, shift.finish_utc
ORDER BY calls DESC;