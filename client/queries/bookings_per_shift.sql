-- Кол-во броней, созданных сотрудником за смену
SELECT shift_id, shift.place_id, shift.employee_id, shift.start_utc, shift.finish_utc, COUNT(booking_id) as bookings
FROM shift
LEFT JOIN booking on booking.place_id = shift.place_id and
                   booking.creation_utc <= shift.finish_utc and
                    booking.creation_utc > shift.start_utc and
                     booking.employee_id = shift.employee_id
GROUP BY shift_id, shift.place_id, shift.employee_id, shift.start_utc, shift.finish_utc
ORDER BY bookings DESC;