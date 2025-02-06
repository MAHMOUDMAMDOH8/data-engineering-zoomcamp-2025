-- Active: 1719647882295@@172.18.0.2@5432@nyc_trip@public

## Question 3
SELECT 
    SUM(CASE WHEN trip_distance <= 1 THEN 1 ELSE 0 END)  "up to 1 mile",
    SUM(CASE WHEN trip_distance > 1 AND trip_distance <= 3 THEN 1 ELSE 0 END)  "1 to 3 miles",
    SUM(CASE WHEN trip_distance > 3 AND trip_distance <= 7 THEN 1 ELSE 0 END)  "3 to 7 miles",
    SUM(CASE WHEN trip_distance > 7 AND trip_distance <= 10 THEN 1 ELSE 0 END)  "7 to 10 miles",
    SUM(CASE WHEN trip_distance > 10 THEN 1 ELSE 0 END)  "over 10 miles"
FROM green_tripdata;


## Question 4
WITH date_cte AS (
    SELECT
        EXTRACT(DAY FROM lpep_pickup_datetime) AS pickup_day,
        MAX(trip_distance) AS max_trip
    FROM green_tripdata
    GROUP BY pickup_day
)
SELECT * FROM date_cte
order by max_trip desc
limit 1

## Question 5
WITH trip_cte AS (
    SELECT 
        green_tripdata."PULocationID" AS pickup_location_id,
        SUM(total_amount) AS total_amount
    FROM green_tripdata 
    WHERE DATE(lpep_pickup_datetime) = '2019-10-18'
    GROUP BY green_tripdata."PULocationID"
)
SELECT
    z."Zone",
    t.total_amount
FROM trip_cte t
LEFT JOIN taxi_zone z
    ON t.pickup_location_id = z."LocationID"
WHERE t.total_amount > 13000
ORDER BY t.total_amount DESC;

## Question 6
with trip_cte as (
    select
        z."Zone",
        max(t.tip_amount) as max_tip
    from green_tripdata t join taxi_zone z
        on t."DOLocationID" = z."LocationID"
    WHERE 
        z."Zone" = 'East Harlem North' 
    GROUP BY 1
)
SELECT * FROM trip_cte