{{
    config(schema="silver")
}}
WITH taxi_trips as (
    SELECT
        ROW_NUMBER() OVER (
            ORDER BY
                tpep_pickup_datetime,
                tpep_dropoff_datetime
        ) AS trip_id,
        VendorID,
        CAST(tpep_pickup_datetime AS TIMESTAMP) AS tpep_pickup_datetime,
        CAST(tpep_dropoff_datetime AS TIMESTAMP) AS tpep_dropoff_datetime,
        CAST(passenger_count AS INT) AS passenger_count,
        CAST(trip_distance AS DOUBLE) AS trip_distance,
        CAST(pickup_longitude AS DOUBLE) AS pickup_longitude,
        CAST(pickup_latitude AS DOUBLE) AS pickup_latitude,
        CAST(dropoff_longitude AS DOUBLE) AS dropoff_longitude,
        CAST(dropoff_latitude AS DOUBLE) AS dropoff_latitude,
        CAST(fare_amount AS DECIMAL(10,2)) AS fare_amount,
        CAST(total_amount AS DECIMAL(10,2)) AS total_amount,
        COALESCE(CAST(RateCodeID As STRING), "-") AS rate_code_id,
        CAST(payment_type AS INT) AS payment_type,
        inserted_at

    FROM 
        {{ source('bronze', 'trips') }}
)

SELECT * FROM taxi_trips;