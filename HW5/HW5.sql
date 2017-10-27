DROP TABLE flight;
DROP TABLE booking;
DROP TABLE city;
DROP TABLE airline;
DROP TABLE customer_phone_numbers;
DROP TABLE phone_number;
DROP TABLE customer;
DROP TABLE mailing_address;

CREATE TABLE mailing_address (
    id SERIAL PRIMARY KEY,
    street VARCHAR,
    city VARCHAR,
    province VARCHAR,
    state VARCHAR,
    CHECK ((state IS NOT NULL AND province is NULL)
          OR (province IS NOT NULL AND state is NULL)),
    postal_code VARCHAR,
    country_code VARCHAR
);

CREATE TABLE customer(
    id BIGINT PRIMARY KEY,
    first_name VARCHAR,
    last_name VARCHAR,
    mailing_address_id INT REFERENCES mailing_address(id)
);

CREATE TABLE phone_number(
    id INT PRIMARY KEY,
    coutry_code INT,
    area_code INT,
    local_number INT
);

CREATE TABLE customer_phone_numbers(
    customer_id INT REFERENCES customer(id),
    phone_number_id INT REFERENCES phone_number(id),
    UNIQUE (customer_id, phone_number_id)
);

CREATE TABLE city(
    id INT PRIMARY KEY,
    name VARCHAR
);

CREATE TABLE airline(
    code CHAR(3) PRIMARY KEY,
    name VARCHAR
);

CREATE TABLE booking(
    id BIGINT PRIMARY KEY,
    city INT REFERENCES city(id),
    book_date TIME
);

CREATE TABLE flight(
    unique_flight_number BIGINT PRIMARY KEY,
    flight_origin_code INT REFERENCES city(id),
    flight_destination_code INT REFERENCES city(id),
    airline_code CHAR(3) REFERENCES airline(code),
    flight_duration TIME,
    booking_id BIGINT REFERENCES booking(id),
    flight_number INT,
    local_departure_time TIME,
    local_departure_date DATE,
    local_arrival_time TIME,
    local_arrival_date DATE,
    billed_customer BIGINT REFERENCES customer(id),
    flying_customer BIGINT REFERENCES customer(id)
);