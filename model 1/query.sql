-- Active: 1719647882295@@172.18.0.2@5432@nyc_trip@public

SELECT 
    SUM(CASE WHEN trip_distance <= 1 THEN 1 ELSE 0 END)  "up to 1 mile",
    SUM(CASE WHEN trip_distance > 1 AND trip_distance <= 3 THEN 1 ELSE 0 END)  "1 to 3 miles",
    SUM(CASE WHEN trip_distance > 3 AND trip_distance <= 7 THEN 1 ELSE 0 END)  "3 to 7 miles",
    SUM(CASE WHEN trip_distance > 7 AND trip_distance <= 10 THEN 1 ELSE 0 END)  "7 to 10 miles",
    SUM(CASE WHEN trip_distance > 10 THEN 1 ELSE 0 END)  "over 10 miles"
FROM green_tripdata;


WITH date_cte AS (
    SELECT
        EXTRACT(DAY FROM lpep_pickup_datetime) AS pickup_day,
        MAX(trip_distance) AS max_trip
    FROM green_tripdata
    GROUP BY pickup_day
)
SELECT * FROM date_cte
order by max_trip;
