-- Кол-во новых клиентов за смену
SELECT shift_id, employee_id, place_id, start_utc, COUNT(client_id) as new_clients
FROM shift
LEFT JOIN client
ON client.creation_place_id = shift.place_id and
   client.creation_utc >= start_utc and
   client.creation_utc < get_next_shift_start(employee_id, place_id, start_utc) and
   client.creator_employee_id = employee_id
GROUP BY shift_id, employee_id, place_id, start_utc
ORDER BY new_clients DESC;