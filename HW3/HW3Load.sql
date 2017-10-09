BEGIN;
-- Create state table
-- Create a temporary table for importing.
CREATE TABLE temp_table  AS
    SELECT * FROM state
        WITH NO DATA;

\COPY temp_table FROM './state.csv' WITH CSV HEADER DELIMITER AS ',';

-- Insert the values into the table such that the 
-- primary key is kept unique in the final table.
INSERT INTO state
SELECT *
FROM temp_table
ON CONFLICT DO NOTHING;
DROP TABLE temp_table;

-- Create city table
CREATE TABLE temp_table  AS
    SELECT * FROM state
        WITH NO DATA;

\COPY temp_table FROM './city.csv' WITH CSV HEADER DELIMITER AS ',';

INSERT INTO city
SELECT *
FROM temp_table
ON CONFLICT DO NOTHING;
DROP TABLE temp_table;

-- Create airport table
CREATE TABLE temp_table  AS
    SELECT airport_seq_id, airport_id FROM airport
        WITH NO DATA;

\COPY temp_table FROM './airport.csv' WITH CSV HEADER DELIMITER AS ',';

INSERT INTO airport
SELECT *
FROM temp_table
ON CONFLICT DO NOTHING;
DROP TABLE temp_table;

-- Carrier table creation.
CREATE TABLE temp_table  AS
    SELECT * FROM carrier
        WITH NO DATA;

\COPY temp_table FROM './carrier.csv' WITH CSV HEADER DELIMITER AS ',';

INSERT INTO carrier
SELECT *
FROM temp_table
ON CONFLICT DO NOTHING;
DROP TABLE temp_table;

-- Cargo table creation.
\COPY cargo(passengers, freight, mail) FROM './cargo.csv' WITH CSV HEADER DELIMITER AS ',';

-- Flight time table creation.
\COPY flight_time(year, quarter, month) FROM './time.csv' WITH CSV HEADER DELIMITER AS ',';

-- Flight table creation.
\COPY flight(distance, distance_group, distance_class, origin_airport_id, destination_airport_id) FROM './flight.csv' WITH CSV HEADER DELIMITER AS ','

