CREATE TABLE countries(
    name VARCHAR(20) PRIMARY KEY,
    lattitude INT,
    longitude INT,
    area INT,
    population INT,
    gdp BIGINT,
    gdpYear INT
);

INSERT INTO countries VALUES('Germany', 51, 9, 357022,
                             89594017, 3979000000000, 2016);
INSERT INTO countries VALUES('Netherlands', 52, 5, 41543,
                             17084719, 870800000000, 2016);
INSERT INTO countries VALUES('Belgium', 50, 4, 30528,
                             11491346, 508600000000, 2016);
INSERT INTO countries VALUES('Luxemburg', 49, 6, 2586,
                             594130, 60980000000, 2016);
INSERT INTO countries VALUES('Poland', 52, 20, 312685,
                             38476269, 1052000000000, 2016);
INSERT INTO countries VALUES('Czechia', 49, 15, 78867,
                             10674723, 350900000000, 2016);
INSERT INTO countries VALUES('Austria', 47, 13, 83871,
                             8754413, 416600000000, 2016);
INSERT INTO countries VALUES('France', 46, 2, 643801,
                             67106161, 2699000000000, 2016);
INSERT INTO countries VALUES('Switzerland', 47, 8, 41277,
                             8236303, 496300000000, 2016);

CREATE TABLE borders(
    name VARCHAR(20),
    adjacent_country VARCHAR(20) REFERENCES countries(name)
);
INSERT INTO borders VALUES('Germany', 'France');
INSERT INTO borders VALUES('Germany', 'Poland');
INSERT INTO borders VALUES('Germany', 'Belgium');
INSERT INTO borders VALUES('Germany', 'Netherlands');
INSERT INTO borders VALUES('Germany', 'Luxemburg');
INSERT INTO borders VALUES('Germany', 'Czechia');
INSERT INTO borders VALUES('Germany', 'Austria');
INSERT INTO borders VALUES('Germany', 'Switzerland');
INSERT INTO borders VALUES('France', 'Belgium');
INSERT INTO borders VALUES('France', 'Germany');
INSERT INTO borders VALUES('France', 'Switzerland');
INSERT INTO borders VALUES('France', 'Luxemburg');
INSERT INTO borders VALUES('Switzerland', 'France');
INSERT INTO borders VALUES('Switzerland', 'Austria');
INSERT INTO borders VALUES('Switzerland', 'Germany');
INSERT INTO borders VALUES('Austria', 'Switzerland');
INSERT INTO borders VALUES('Austria', 'Germany');
INSERT INTO borders VALUES('Austria', 'Czechia');
INSERT INTO borders VALUES('Czechia', 'Austria');
INSERT INTO borders VALUES('Czechia', 'Germany');
INSERT INTO borders VALUES('Czechia', 'Poland');
INSERT INTO borders VALUES('Poland',  'Austria');
INSERT INTO borders VALUES('Poland', 'Germany');
INSERT INTO borders VALUES('Netherlands', 'Germany');
INSERT INTO borders VALUES('Netherlands', 'Belgium');
INSERT INTO borders VALUES('Belgium', 'France');
INSERT INTO borders VALUES('Belgium', 'Netherlands');
INSERT INTO borders VALUES('Belgium', 'Germany');
INSERT INTO borders VALUES('Belgium', 'Luxemburg');
INSERT INTO borders VALUES('Luxemburg', 'Belgium');
INSERT INTO borders VALUES('Luxemburg', 'Germany');
INSERT INTO borders VALUES('Luxemburg', 'France');
SELECT * FROM countries;

SELECT adjacent_country FROM borders
    WHERE name = 'Germany';

SELECT * FROM countries
    WHERE population > 35000000;

SELECT countries.name, population FROM countries, borders
    WHERE adjacent_country = 'Germany'
    AND population > 35000000;

DROP TABLE borders;
DROP TABLE countries;