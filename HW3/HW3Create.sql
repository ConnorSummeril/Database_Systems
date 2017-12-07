BEGIN;

DROP TABLE flight;
DROP TABLE airport;
DROP TABLE state;
DROP TABLE city;
DROP TABLE carrier;
DROP TABLE cargo;
DROP TABLE flight_time;

CREATE TABLE state(
    fips VARCHAR PRIMARY KEY,
    abbreviation VARCHAR,
    name VARCHAR
    );

CREATE TABLE city(
    market_id VARCHAR PRIMARY KEY,
    name VARCHAR,
    abbreviation VARCHAR,
    world_area_code VARCHAR
    );

CREATE TABLE airport(
    airport_seq_id VARCHAR PRIMARY KEY,
    airport_id VARCHAR,
    state_id VARCHAR REFERENCES state(fips),
    city_market_id VARCHAR REFERENCES city(market_id)
    );

CREATE TABLE carrier(
    unique_carrier VARCHAR PRIMARY KEY,
    airline_id VARCHAR,
    unique_carrier_entity VARCHAR,
    carrier_name VARCHAR,
    carrier_group VARCHAR,
    carrier_group_new VARCHAR,
    carrier_region VARCHAR
    );

CREATE TABLE cargo(
    cargo_id VARCHAR PRIMARY KEY,
    passengers VARCHAR,
    freight VARCHAR,
    mail VARCHAR
    );

CREATE TABLE flight_time(
    flight_time_id SERIAL PRIMARY KEY,
    year VARCHAR,
    quarter VARCHAR,
    month VARCHAR
    );

CREATE TABLE flight(
    flight_id SERIAL PRIMARY KEY,
    distance VARCHAR,
    distance_group VARCHAR,
    distance_class VARCHAR,
    origin_airport_id VARCHAR REFERENCES airport(airport_seq_id),
    destination_airport_id VARCHAR REFERENCES airport(airport_seq_id),
    cargo_id VARCHAR REFERENCES cargo(cargo_id)
    );

COMMIT;