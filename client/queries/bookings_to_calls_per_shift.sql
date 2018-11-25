-- Кол-во броней на кол-во входящих звонков (цель сотрудника за звонок - продать бронь)
SELECT shift.shift_id, shift.employee_id, shift.start_utc,
       shift_bookings.bookings, shift_calls.calls, (shift_bookings.bookings::float / shift_calls.calls) as coeff
FROM shift
INNER JOIN (
  SELECT shift_id, COUNT(booking_id) as bookings
FROM shift
LEFT JOIN booking on booking.place_id = shift.place_id and
                   booking.creation_utc <= shift.finish_utc and
                    booking.creation_utc > shift.start_utc and
                     booking.employee_id = shift.employee_id
GROUP BY shift_id
    ) as shift_bookings on shift_bookings.shift_id = shift.shift_id
INNER  JOIN (
  SELECT shift_id, COUNT(call.timestamp_utc) as calls
FROM shift
LEFT JOIN call on call.place_id = shift.place_id and
                   call.timestamp_utc <= shift.finish_utc and
                    call.timestamp_utc > shift.start_utc
GROUP BY shift_id
    ) as shift_calls on shift_calls.shift_id = shift.shift_id
WHERE shift_calls.calls <> 0
ORDER BY coeff DESC
