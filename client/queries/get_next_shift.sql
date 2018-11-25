-- Функция, возвразающая время начала следующей смены сотрудника (сотрудники могут доделывать работу после смены,
-- учитываем ее в предыдущую)
CREATE OR REPLACE FUNCTION get_next_shift_start (bigint , int, timestamp)
RETURNS timestamp language sql as
$FUNCTION$
  SELECT start_utc
  FROM shift
  WHERE employee_id = $1 and place_id = $2 and start_utc > $3
  ORDER BY start_utc
  LIMIT 1;
$FUNCTION$;