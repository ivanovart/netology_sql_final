-- new_clients_per_shift / (new_clients_per_shift + guests_per_shift)
SELECT shift.shift_id, employee_id, place_id, start_utc,
       n_c.new_clients, guests.guests, (n_c.new_clients::float / (n_c.new_clients + guests.guests)) as coeff
FROM shift
INNER JOIN (SELECT shift_id, COUNT(client_id) as new_clients
FROM shift
LEFT JOIN client
ON client.creation_place_id = shift.place_id and
   client.creation_utc >= start_utc and
   client.creation_utc < get_next_shift_start(employee_id, place_id, start_utc) and
   client.creator_employee_id = employee_id
GROUP BY shift_id) AS n_c
  ON n_c.shift_id = shift.shift_id
INNER JOIN (SELECT shift_id, COUNT(visit_id) as guests
FROM shift
LEFT JOIN visit on shift.place_id = visit.place_id and
                   visit.start_utc <= shift.finish_utc and
                    visit.finish_utc > shift.start_utc
LEFT JOIN client on visit.client_id = client.client_id
WHERE card_level = 1
GROUP BY shift_id) AS guests ON guests.shift_id = shift.shift_id
ORDER BY coeff DESC;