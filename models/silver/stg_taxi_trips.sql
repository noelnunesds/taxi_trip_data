WITH taxi_trips as (
    SELECT
        md5(
            concat_ws(
                '|',
                VendorID,
                tpep_pickup_datetime,
                tpep_dropoff_datetime,
                trip_distance,
                pickup_longitude,
                pickup_latitude,
                dropoff_longitude,
                dropoff_latitude
            )
        ) AS trip_hash,

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
        inserted_at

    FROM 
        {{ source('bronze', 'trips') }}
)

SELECT * FROM taxi_trips;