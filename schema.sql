-- create schema test;

-- -- each property is attached to a building (1 to 1)

-- create type test.city as ENUM ('Dubai', 'Montreal');
CREATE TYPE city_type AS ENUM('Dubai', 'Montreal');

-- create table test.building (
--     id bigserial primary key not null,
--     city test.city not null
-- );
DROP TABLE IF  EXISTS building;
DROP TABLE IF  EXISTS property;
DROP TABLE IF  EXISTS reservation;
DROP TABLE IF  EXISTS availability;


CREATE TABLE building (
   id bigserial primary key not null, 
   city city_type not null
);

-- insert into test.building (city) values ('Dubai');
-- insert into test.building (city) values ('Montreal');
INSERT INTO building (city) VALUES ('Dubai');
INSERT INTO building (city) VALUES ('Montreal');

-- -- properties/units
-- -- supported amenities on units, we'll use this for additional filtering
-- create type test.amenities_enum as ENUM ('WiFi', 'Pool', 'Garden', 'Tennis table', 'Parking');
-- create type test.property_type_enum as ENUM ('1bdr', '2bdr', '3bdr');
CREATE TYPE amenities_type_enum as ENUM ('WiFi', 'Pool', 'Garden', 'Tennis table', 'Parking');
CREATE TYPE property_type_enum as ENUM ('1bdr', '2bdr', '3bdr');

-- create table test.property (
--     id bigserial primary key not null,
--     building_id bigint references test.building on delete cascade not null,
--     title text unique not null,
--     property_type test.property_type_enum not null,
--     amenities test.amenities_enum[] not null
-- );
CREATE TABLE property (
    id bigserial primary key not null,
    building_id bigint references building on delete cascade not null, 
    title text unique not null,
    property_type property_type_enum not null,
    amenities amenities_type_enum[] not null,
    FOREIGN KEY (building_id) REFERENCES building (id)
);

-- insert into test.property (building_id, title, property_type, amenities) VALUES (1, 'Unit 1', '1bdr', '{WiFi,Parking}');
-- insert into test.property (building_id, title, property_type, amenities) VALUES (1, 'Unit 2', '2bdr', '{WiFi,Tennis table}');
-- insert into test.property (building_id, title, property_type, amenities) VALUES (1, 'Unit 3', '3bdr', '{Garden}');
-- insert into test.property (building_id, title, property_type, amenities) VALUES (2, 'Unit 4', '1bdr', '{Garden,Pool}');
INSERT INTO property (building_id, title, property_type, amenities) VALUES (1, 'Unit 1', '1bdr', '{WiFi,Parking}');
INSERT INTO property (building_id, title, property_type, amenities) VALUES (1, 'Unit 2', '2bdr', '{WiFi,Tennis table}');
INSERT INTO property (building_id, title, property_type, amenities) VALUES (1, 'Unit 3', '3bdr', '{Garden}');
INSERT INTO property (building_id, title, property_type, amenities) VALUES (2, 'Unit 4', '1bdr', '{Garden,Pool}');

-- -- reservations per unit
-- create table test.reservation (
--     id bigserial primary key not null,
--     check_in date not null,
--     check_out date not null,
--     property_id bigint references test.property on delete cascade not null
-- );
CREATE TABLE  reservation (
    id bigserial primary key not null,
    check_in date not null,
    check_out date not null,
    property_id bigint references property on delete cascade not null,
    FOREIGN KEY (property_id) REFERENCES property (id)
    
);

-- insert into test.reservation (check_in, check_out, property_id) VALUES ('2021-05-01', '2021-05-10', 1);
-- insert into test.reservation (check_in, check_out, property_id) VALUES ('2021-06-01', '2021-06-03', 1);
-- insert into test.reservation (check_in, check_out, property_id) VALUES ('2021-06-02', '2021-06-07', 2);
INSERT INTO reservation (check_in, check_out, property_id) VALUES ('2021-05-01', '2021-05-10', 1);
INSERT INTO reservation (check_in, check_out, property_id) VALUES ('2021-06-01', '2021-06-03', 1);
INSERT INTO reservation (check_in, check_out, property_id) VALUES ('2021-06-02', '2021-06-07', 2);

-- -- manual availability settings
-- create table test.availability (
--     id bigserial primary key not null,
--     property_id bigint references test.property on delete cascade not null,
--     start_date date not null,
--     end_date date not null,
--     is_blocked boolean default false
-- );
CREATE TABLE availability (
    id bigserial primary key not null,
    property_id bigint references property on delete cascade not null, 
    start_date date not null,
    end_date date not null,
    is_blocked boolean default false,
    FOREIGN KEY (property_id) REFERENCES property (id)
);

-- -- Note: when checking a unit availability, query both test.reservation & test.availability, if a unit has a reservation on an overlapping date range, or if it's
-- -- manually blocked (for example: for maintenance) and has an entry with is_blocked set to true with an overlapping start_date & end_date in test.availability

-- insert into test.availability (property_id, start_date, end_date, is_blocked) values (1, '2021-07-01', '2021-07-20', true); 
INSERT INTO availability (property_id, start_date, end_date, is_blocked) values (1, '2021-07-01', '2021-07-20', true); 






