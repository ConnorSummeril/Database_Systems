SELECT city.name, state.name, airport_seq_id, carrier.carrier_name, cargo.passengers, flight.cargo_id
    FROM city, state, airport, carrier, cargo, flight
        WHERE flight.origin_airport_id = '1129202'
        AND airport.airport_seq_id = '1129202' 
        AND city.market_id = airport.city_market_id;

SELECT city.name, state.name, airport_seq_id, carrier.carrier_name, cargo.freight, flight.cargo_id
    FROM city, state, airport, carrier, cargo, flight
        WHERE flight.origin_airport_id = '1129202'
        AND airport.airport_seq_id = '1129202' 
        AND city.market_id = airport.city_market_id;

SELECT city.name, state.name, flight.destination_airport_id, carrier.carrier_name
    FROM city, state, flight, carrier
        WHERE flight.destination_airport_id = '1129202';

SELECT city.name, flight.distance
    FROM city, flight
    WHERE CAST(flight.distance AS INT) > 500
    AND CAST(flight.distance AS INT) < 1200;