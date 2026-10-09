DROP DATABASE IF EXISTS Air_india_db;
CREATE DATABASE Air_india_db;
USE Air_india_db;

CREATE TABLE airlines (
    airline_id      INT PRIMARY KEY AUTO_INCREMENT,
    airline_name    VARCHAR(100) NOT NULL,
    country         VARCHAR(50)  NOT NULL,
    founded_year    INT
);

CREATE TABLE airports (
    airport_id      INT PRIMARY KEY AUTO_INCREMENT,
    airport_code    CHAR(3) NOT NULL UNIQUE,
    airport_name    VARCHAR(100) NOT NULL,
    city            VARCHAR(50)  NOT NULL,
    country         VARCHAR(50)  NOT NULL
);

CREATE TABLE aircraft (
    aircraft_id     INT PRIMARY KEY AUTO_INCREMENT,
    model           VARCHAR(50) NOT NULL,
    capacity        INT NOT NULL,
    airline_id      INT NOT NULL,
    FOREIGN KEY (airline_id) REFERENCES airlines(airline_id)
);

CREATE TABLE routes (
    route_id                INT PRIMARY KEY AUTO_INCREMENT,
    origin_airport_id       INT NOT NULL,
    destination_airport_id  INT NOT NULL,
    distance_km             INT NOT NULL,
    FOREIGN KEY (origin_airport_id) REFERENCES airports(airport_id),
    FOREIGN KEY (destination_airport_id) REFERENCES airports(airport_id)
);

CREATE TABLE flights (
    flight_id       INT PRIMARY KEY AUTO_INCREMENT,
    flight_number   VARCHAR(10) NOT NULL,
    route_id        INT NOT NULL,
    aircraft_id     INT NOT NULL,
    airline_id      INT NOT NULL,
    departure_time  DATETIME NOT NULL,
    arrival_time    DATETIME NOT NULL,
    status          VARCHAR(20) DEFAULT 'Scheduled',
    FOREIGN KEY (route_id) REFERENCES routes(route_id),
    FOREIGN KEY (aircraft_id) REFERENCES aircraft(aircraft_id),
    FOREIGN KEY (airline_id) REFERENCES airlines(airline_id)
);

CREATE TABLE passengers (
    passenger_id    INT PRIMARY KEY AUTO_INCREMENT,
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL,
    email           VARCHAR(100),
    nationality     VARCHAR(50)
);

CREATE TABLE bookings (
    booking_id      INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id    INT NOT NULL,
    flight_id       INT NOT NULL,
    booking_date    DATE NOT NULL,
    seat_class      VARCHAR(20) NOT NULL,
    fare            DECIMAL(10,2) NOT NULL,
    status          VARCHAR(20) DEFAULT 'Confirmed',
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);



INSERT INTO airlines (airline_name, country, founded_year) VALUES
('Air India', 'India', 1932),
('Air India Express', 'India', 2005),
('Vistara', 'India', 2013),
('IndiGo', 'India', 2006),
('SpiceJet', 'India', 2005);

INSERT INTO airports (airport_code, airport_name, city, country) VALUES
('DEL', 'Indira Gandhi International', 'Delhi', 'India'),
('BOM', 'Chhatrapati Shivaji Maharaj Intl', 'Mumbai', 'India'),
('BLR', 'Kempegowda International', 'Bengaluru', 'India'),
('MAA', 'Chennai International', 'Chennai', 'India'),
('CCU', 'Netaji Subhas Chandra Bose Intl', 'Kolkata', 'India'),
('HYD', 'Rajiv Gandhi International', 'Hyderabad', 'India'),
('AMD', 'Sardar Vallabhbhai Patel Intl', 'Ahmedabad', 'India'),
('GOI', 'Goa International', 'Goa', 'India'),
('PNQ', 'Pune Airport', 'Pune', 'India'),
('LHR', 'Heathrow', 'London', 'UK'),
('JFK', 'John F. Kennedy Intl', 'New York', 'USA'),
('DXB', 'Dubai International', 'Dubai', 'UAE'),
('SIN', 'Changi', 'Singapore', 'Singapore'),
('SYD', 'Kingsford Smith', 'Sydney', 'Australia');

INSERT INTO aircraft (model, capacity, airline_id) VALUES
('Boeing 787-8', 256, 1),
('Airbus A320neo', 180, 1),
('Boeing 777-300ER', 342, 1),
('Boeing 737-800', 189, 2),
('ATR 72', 70, 2),
('Airbus A321neo', 220, 3),
('Boeing 787-9', 290, 3),
('Airbus A320neo', 180, 4),
('Airbus A321neo', 232, 4),
('Boeing 737 MAX 8', 189, 5);

INSERT INTO routes (origin_airport_id, destination_airport_id, distance_km) VALUES
(1, 2, 10976),
(2, 1, 2324),
(1, 3, 909),
(3, 1, 12649),
(1, 4, 5006),
(4, 1, 4512),
(1, 5, 4157),
(5, 1, 2786),
(1, 6, 12566),
(6, 1, 2179),
(2, 3, 11587),
(3, 2, 12635),
(2, 12, 9435),
(12, 2, 1924),
(1, 10, 10174),
(10, 1, 7412),
(1, 11, 1020),
(4, 13, 988),
(1, 7, 2035),
(7, 1, 4082),
(2, 8, 4311),
(8, 2, 8779),
(3, 9, 10363),
(9, 3, 934),
(2, 14, 9695);

INSERT INTO flights (flight_number, route_id, aircraft_id, airline_id, departure_time, arrival_time, status) VALUES
('6E100', 7, 9, 4, '2025-01-23 07:45:00', '2025-01-23 12:45:00', 'Landed'),
('UK101', 23, 7, 3, '2025-01-13 08:15:00', '2025-01-13 12:45:00', 'Landed'),
('UK102', 3, 7, 3, '2024-12-13 11:30:00', '2024-12-13 16:30:00', 'Cancelled'),
('6E103', 15, 9, 4, '2024-12-16 12:00:00', '2024-12-16 21:30:00', 'Cancelled'),
('UK104', 20, 6, 3, '2025-02-12 06:00:00', '2025-02-12 07:15:00', 'Landed'),
('IX105', 3, 4, 2, '2024-12-13 12:30:00', '2024-12-13 21:00:00', 'Landed'),
('UK106', 12, 6, 3, '2024-12-27 21:30:00', '2024-12-27 23:45:00', 'Scheduled'),
('IX107', 24, 4, 2, '2024-12-21 14:45:00', '2024-12-21 20:00:00', 'Cancelled'),
('AI108', 11, 1, 1, '2024-12-30 01:30:00', '2024-12-30 09:00:00', 'Landed'),
('SG109', 7, 10, 5, '2025-03-02 10:15:00', '2025-03-02 19:00:00', 'Cancelled'),
('AI110', 15, 3, 1, '2025-01-03 04:15:00', '2025-01-03 13:45:00', 'Cancelled'),
('UK111', 19, 7, 3, '2025-02-13 12:30:00', '2025-02-13 16:45:00', 'Scheduled'),
('AI112', 16, 2, 1, '2025-03-07 01:00:00', '2025-03-07 04:15:00', 'Cancelled'),
('SG113', 14, 10, 5, '2024-12-09 12:45:00', '2024-12-09 21:15:00', 'Scheduled'),
('AI114', 1, 2, 1, '2025-02-26 17:30:00', '2025-02-26 23:30:00', 'Landed'),
('AI115', 14, 3, 1, '2025-01-28 00:30:00', '2025-01-28 09:45:00', 'Scheduled'),
('IX116', 4, 5, 2, '2025-02-20 16:15:00', '2025-02-20 19:45:00', 'Landed'),
('6E117', 18, 9, 4, '2024-12-01 19:30:00', '2024-12-02 03:30:00', 'Landed'),
('IX118', 12, 5, 2, '2024-12-31 01:15:00', '2024-12-31 03:15:00', 'Cancelled'),
('AI119', 16, 2, 1, '2025-03-08 17:15:00', '2025-03-08 21:00:00', 'Scheduled'),
('IX120', 6, 5, 2, '2025-02-06 19:45:00', '2025-02-07 00:00:00', 'Cancelled'),
('UK121', 10, 7, 3, '2025-02-24 20:30:00', '2025-02-25 05:15:00', 'Landed'),
('IX122', 8, 4, 2, '2024-12-09 10:00:00', '2024-12-09 19:15:00', 'Scheduled'),
('AI123', 8, 1, 1, '2024-12-10 22:00:00', '2024-12-11 02:00:00', 'Landed'),
('AI124', 11, 2, 1, '2025-02-04 07:30:00', '2025-02-04 15:45:00', 'Scheduled'),
('SG125', 5, 10, 5, '2025-02-12 15:15:00', '2025-02-13 00:00:00', 'Landed'),
('AI126', 4, 2, 1, '2025-02-23 13:30:00', '2025-02-23 21:15:00', 'Landed'),
('AI127', 24, 1, 1, '2025-02-25 20:00:00', '2025-02-25 21:45:00', 'Cancelled'),
('AI128', 11, 2, 1, '2025-01-01 06:15:00', '2025-01-01 16:00:00', 'Landed'),
('AI129', 14, 3, 1, '2025-01-05 14:15:00', '2025-01-05 17:00:00', 'Scheduled'),
('AI130', 4, 1, 1, '2025-02-22 17:00:00', '2025-02-22 19:15:00', 'Landed'),
('6E131', 14, 8, 4, '2025-01-31 06:45:00', '2025-01-31 08:00:00', 'Landed'),
('UK132', 1, 7, 3, '2025-01-03 14:30:00', '2025-01-03 22:15:00', 'Landed'),
('IX133', 7, 5, 2, '2024-12-28 01:00:00', '2024-12-28 07:00:00', 'Landed'),
('6E134', 19, 8, 4, '2025-02-03 16:15:00', '2025-02-03 17:15:00', 'Landed'),
('SG135', 3, 10, 5, '2024-12-09 21:15:00', '2024-12-10 04:15:00', 'Scheduled'),
('SG136', 8, 10, 5, '2025-02-15 01:00:00', '2025-02-15 08:30:00', 'Landed'),
('UK137', 7, 6, 3, '2024-12-31 08:45:00', '2024-12-31 12:15:00', 'Landed'),
('AI138', 11, 2, 1, '2024-12-02 14:00:00', '2024-12-02 16:15:00', 'Scheduled'),
('AI139', 9, 3, 1, '2025-01-14 02:15:00', '2025-01-14 08:45:00', 'Landed'),
('6E140', 15, 9, 4, '2025-03-01 09:00:00', '2025-03-01 18:30:00', 'Cancelled'),
('AI141', 4, 3, 1, '2025-01-03 03:00:00', '2025-01-03 12:15:00', 'Landed'),
('SG142', 10, 10, 5, '2024-12-27 22:30:00', '2024-12-28 03:00:00', 'Scheduled'),
('IX143', 16, 5, 2, '2024-12-07 02:45:00', '2024-12-07 07:45:00', 'Landed'),
('AI144', 11, 3, 1, '2025-02-20 08:15:00', '2025-02-20 17:00:00', 'Scheduled'),
('AI145', 1, 2, 1, '2024-12-10 22:15:00', '2024-12-11 07:15:00', 'Landed'),
('6E146', 19, 9, 4, '2024-12-19 13:15:00', '2024-12-19 14:45:00', 'Landed'),
('UK147', 2, 6, 3, '2024-12-27 21:15:00', '2024-12-27 23:45:00', 'Scheduled'),
('SG148', 14, 10, 5, '2025-03-06 04:15:00', '2025-03-06 07:30:00', 'Landed'),
('AI149', 1, 3, 1, '2025-03-05 10:45:00', '2025-03-05 15:15:00', 'Landed'),
('AI150', 23, 2, 1, '2025-01-18 01:45:00', '2025-01-18 06:00:00', 'Landed'),
('IX151', 12, 5, 2, '2024-12-30 07:00:00', '2024-12-30 11:45:00', 'Landed'),
('AI152', 9, 2, 1, '2025-03-09 08:30:00', '2025-03-09 18:15:00', 'Cancelled'),
('UK153', 18, 6, 3, '2024-12-04 03:30:00', '2024-12-04 07:00:00', 'Landed'),
('SG154', 4, 10, 5, '2025-01-25 11:30:00', '2025-01-25 18:30:00', 'Landed');

INSERT INTO passengers (first_name, last_name, email, nationality) VALUES
('Grace', 'Khan', 'grace.khan0@example.com', 'India'),
('Amit', 'Agarwal', 'amit.agarwal1@example.com', 'UK'),
('Rohan', 'Malhotra', 'rohan.malhotra2@example.com', 'UAE'),
('Yusuf', 'Saxena', 'yusuf.saxena3@example.com', 'Australia'),
('Divya', 'Mehta', 'divya.mehta4@example.com', 'UK'),
('John', 'Kulkarni', 'john.kulkarni5@example.com', 'India'),
('Liam', 'Gupta', 'liam.gupta6@example.com', 'Australia'),
('Wei', 'Saxena', 'wei.saxena7@example.com', 'India'),
('Lucas', 'Singh', 'lucas.singh8@example.com', 'Australia'),
('Shreya', 'Gupta', 'shreya.gupta9@example.com', 'UK'),
('Zainab', 'Singh', 'zainab.singh10@example.com', 'UAE'),
('Neha', 'Khan', 'neha.khan11@example.com', 'UK'),
('Fatima', 'Das', 'fatima.das12@example.com', 'Australia'),
('Peter', 'Bakshi', 'peter.bakshi13@example.com', 'India'),
('Liam', 'Pillai', 'liam.pillai14@example.com', 'India'),
('Vivek', 'Bose', 'vivek.bose15@example.com', 'India'),
('Manish', 'Singh', 'manish.singh16@example.com', 'India'),
('Aakash', 'Yadav', 'aakash.yadav17@example.com', 'Singapore'),
('Olivia', 'Bhat', 'olivia.bhat18@example.com', 'India'),
('Nikhil', 'Kapoor', 'nikhil.kapoor19@example.com', 'USA'),
('Yusuf', 'Khan', 'yusuf.khan20@example.com', 'UAE'),
('Farah', 'Yadav', 'farah.yadav21@example.com', 'India'),
('Fatima', 'Verma', 'fatima.verma22@example.com', 'India'),
('Lucas', 'Kulkarni', 'lucas.kulkarni23@example.com', 'Australia'),
('Liam', 'Gupta', 'liam.gupta24@example.com', 'India'),
('Anna', 'Tan', 'anna.tan25@example.com', 'Australia'),
('Manish', 'Tan', 'manish.tan26@example.com', 'India'),
('Vikram', 'Sharma', 'vikram.sharma27@example.com', 'India'),
('Arjun', 'Chopra', 'arjun.chopra28@example.com', 'Singapore'),
('Mark', 'Verma', 'mark.verma29@example.com', 'USA'),
('Shreya', 'Bakshi', 'shreya.bakshi30@example.com', 'Australia'),
('Grace', 'Khan', 'grace.khan31@example.com', 'UK'),
('Omar', 'Das', 'omar.das32@example.com', 'India'),
('Vikram', 'Bhat', 'vikram.bhat33@example.com', 'India'),
('Anna', 'Bansal', 'anna.bansal34@example.com', 'India'),
('Mark', 'Rao', 'mark.rao35@example.com', 'India'),
('Karan', 'Yadav', 'karan.yadav36@example.com', 'UAE'),
('Nikhil', 'Nair', 'nikhil.nair37@example.com', 'UAE'),
('Arjun', 'Sinha', 'arjun.sinha38@example.com', 'India'),
('Nikhil', 'Smith', 'nikhil.smith39@example.com', 'USA'),
('Fatima', 'Malhotra', 'fatima.malhotra40@example.com', 'UAE'),
('Olivia', 'Gupta', 'olivia.gupta41@example.com', 'USA'),
('Liam', 'Chauhan', 'liam.chauhan42@example.com', 'UAE'),
('Aakash', 'Chauhan', 'aakash.chauhan43@example.com', 'UAE'),
('Isha', 'Bakshi', 'isha.bakshi44@example.com', 'India'),
('Peter', 'Bansal', 'peter.bansal45@example.com', 'USA'),
('Isha', 'Reddy', 'isha.reddy46@example.com', 'India'),
('Aisha', 'Reddy', 'aisha.reddy47@example.com', 'UAE'),
('Omar', 'Bhat', 'omar.bhat48@example.com', 'India'),
('Suresh', 'Kapoor', 'suresh.kapoor49@example.com', 'India');

INSERT INTO bookings (passenger_id, flight_id, booking_date, seat_class, fare, status) VALUES
(46, 19, '2024-12-10', 'Economy', 48204.36, 'Cancelled'),
(6, 9, '2024-11-15', 'Economy', 42799.88, 'Confirmed'),
(46, 14, '2024-11-17', 'Economy', 8166.62, 'Cancelled'),
(30, 27, '2025-01-27', 'Economy', 45795.74, 'Confirmed'),
(50, 38, '2024-11-24', 'First', 69930.21, 'Confirmed'),
(31, 1, '2024-12-29', 'Economy', 16195.0, 'Confirmed'),
(35, 48, '2024-11-18', 'First', 59287.99, 'Confirmed'),
(32, 15, '2025-02-24', 'Economy', 47279.21, 'Confirmed'),
(22, 43, '2024-12-16', 'First', 64649.51, 'Confirmed'),
(9, 40, '2024-12-19', 'Business', 123886.66, 'Cancelled'),
(37, 43, '2024-11-29', 'Economy', 7085.76, 'Confirmed'),
(30, 12, '2025-01-23', 'Economy', 7693.25, 'Confirmed'),
(30, 21, '2025-01-12', 'Economy', 23840.01, 'Confirmed'),
(49, 54, '2024-11-28', 'Premium', 5938.77, 'Confirmed'),
(2, 48, '2024-12-04', 'Business', 23472.45, 'Confirmed'),
(42, 5, '2025-02-10', 'First', 70064.51, 'Confirmed'),
(13, 54, '2024-11-18', 'Economy', 4805.64, 'Confirmed'),
(31, 43, '2024-12-13', 'Economy', 10223.67, 'Confirmed'),
(45, 17, '2025-01-12', 'Economy', 44314.09, 'Confirmed'),
(50, 53, '2025-03-02', 'Economy', 74066.04, 'Cancelled'),
(2, 20, '2025-02-11', 'Business', 119351.98, 'Confirmed'),
(46, 13, '2025-01-25', 'Economy', 35401.89, 'Confirmed'),
(7, 45, '2025-01-12', 'Economy', 64318.04, 'Confirmed'),
(37, 51, '2024-12-21', 'Economy', 41883.22, 'Confirmed'),
(5, 33, '2024-12-07', 'First', 242902.33, 'Confirmed'),
(7, 28, '2025-01-26', 'Economy', 4582.91, 'Confirmed'),
(28, 12, '2025-01-02', 'First', 51096.45, 'Confirmed'),
(40, 52, '2024-11-30', 'Business', 215256.91, 'Confirmed'),
(47, 38, '2024-12-15', 'Economy', 16490.46, 'Confirmed'),
(18, 29, '2024-11-25', 'Economy', 60848.31, 'Cancelled'),
(43, 25, '2025-01-14', 'Economy', 35758.64, 'Confirmed'),
(32, 14, '2024-11-17', 'Economy', 10377.09, 'Confirmed'),
(39, 45, '2025-01-17', 'Economy', 54080.85, 'Confirmed'),
(6, 16, '2024-12-23', 'First', 44648.47, 'Confirmed'),
(45, 31, '2025-01-24', 'First', 357276.06, 'Confirmed'),
(6, 19, '2024-12-15', 'Economy', 53233.82, 'Confirmed'),
(43, 38, '2024-11-27', 'Economy', 18373.03, 'Confirmed'),
(28, 48, '2024-11-12', 'Business', 29690.49, 'Confirmed'),
(18, 20, '2025-02-23', 'Economy', 27362.24, 'Confirmed'),
(8, 48, '2024-11-12', 'Business', 43524.86, 'Confirmed'),
(13, 14, '2024-11-01', 'First', 47117.37, 'Cancelled'),
(39, 19, '2024-12-12', 'Economy', 69465.78, 'Confirmed'),
(24, 12, '2025-01-09', 'Economy', 6191.38, 'Confirmed'),
(18, 3, '2024-10-29', 'Economy', 4236.01, 'Confirmed'),
(41, 49, '2025-03-05', 'Premium', 10182.62, 'Cancelled'),
(19, 31, '2025-02-10', 'Premium', 87458.35, 'Confirmed'),
(17, 31, '2025-01-27', 'Economy', 69143.82, 'Confirmed'),
(5, 37, '2025-02-05', 'First', 77524.47, 'Confirmed'),
(37, 20, '2025-02-28', 'Economy', 44336.76, 'Cancelled'),
(49, 27, '2025-01-14', 'Business', 193818.32, 'Confirmed'),
(50, 34, '2024-11-29', 'Premium', 28942.99, 'Confirmed'),
(38, 28, '2025-02-21', 'Economy', 4395.3, 'Cancelled'),
(48, 7, '2024-12-10', 'Economy', 61615.15, 'Confirmed'),
(11, 16, '2025-01-17', 'Economy', 8958.1, 'Confirmed'),
(27, 29, '2024-12-13', 'First', 304713.59, 'Confirmed'),
(15, 19, '2024-12-01', 'First', 267417.92, 'Confirmed'),
(44, 15, '2025-01-16', 'Economy', 58869.6, 'Cancelled'),
(43, 52, '2024-11-25', 'Economy', 54019.89, 'Confirmed'),
(42, 10, '2025-02-25', 'Economy', 22779.92, 'Confirmed'),
(11, 51, '2024-12-12', 'Economy', 49588.32, 'Confirmed'),
(29, 8, '2024-11-06', 'Premium', 7570.68, 'Confirmed'),
(18, 33, '2024-12-28', 'Business', 157400.6, 'Cancelled'),
(3, 28, '2025-02-08', 'First', 20378.3, 'Confirmed'),
(6, 15, '2025-01-20', 'First', 332499.45, 'Cancelled'),
(2, 49, '2025-01-28', 'First', 57822.84, 'Confirmed'),
(49, 49, '2025-01-23', 'Economy', 8487.73, 'Confirmed'),
(18, 12, '2025-01-12', 'Business', 28051.45, 'Confirmed'),
(31, 23, '2024-10-27', 'Premium', 17830.07, 'Confirmed'),
(11, 22, '2025-02-05', 'Premium', 17714.47, 'Confirmed'),
(49, 36, '2024-11-18', 'Economy', 3967.31, 'Confirmed'),
(21, 8, '2024-12-20', 'Premium', 8360.77, 'Cancelled'),
(30, 27, '2025-01-30', 'Economy', 45065.19, 'Cancelled'),
(49, 32, '2025-01-27', 'First', 45779.03, 'Confirmed'),
(18, 36, '2024-11-10', 'Economy', 5256.76, 'Confirmed'),
(8, 2, '2024-12-28', 'First', 275100.16, 'Confirmed'),
(20, 36, '2024-12-03', 'Economy', 4232.99, 'Confirmed'),
(8, 30, '2024-12-26', 'Economy', 9510.58, 'Confirmed'),
(46, 19, '2024-12-04', 'Business', 206859.61, 'Confirmed'),
(31, 16, '2025-01-03', 'Premium', 14326.24, 'Confirmed'),
(39, 33, '2024-12-29', 'First', 340353.5, 'Confirmed'),
(50, 51, '2024-12-16', 'Premium', 66648.61, 'Confirmed'),
(1, 19, '2024-11-23', 'First', 270719.68, 'Cancelled'),
(43, 32, '2024-12-31', 'Economy', 8349.47, 'Confirmed'),
(22, 36, '2024-11-18', 'Business', 12018.09, 'Confirmed'),
(45, 16, '2025-01-01', 'Business', 25544.02, 'Confirmed'),
(21, 48, '2024-12-02', 'Premium', 19022.16, 'Confirmed'),
(43, 51, '2024-12-17', 'First', 338699.1, 'Confirmed'),
(9, 33, '2024-12-27', 'Business', 140351.75, 'Confirmed'),
(7, 34, '2024-12-18', 'Premium', 20259.84, 'Confirmed'),
(42, 10, '2025-02-13', 'Economy', 18326.02, 'Confirmed'),
(40, 45, '2025-01-29', 'Premium', 91759.96, 'Cancelled'),
(25, 21, '2025-01-05', 'First', 127955.07, 'Cancelled'),
(3, 40, '2024-12-01', 'Economy', 46548.37, 'Confirmed'),
(15, 48, '2024-12-20', 'Economy', 9997.65, 'Confirmed'),
(29, 11, '2025-01-01', 'First', 218142.67, 'Confirmed'),
(21, 51, '2024-12-25', 'Economy', 40209.51, 'Confirmed'),
(10, 16, '2024-12-15', 'Business', 26081.16, 'Confirmed'),
(11, 12, '2025-01-19', 'Economy', 9825.95, 'Cancelled'),
(44, 16, '2025-01-18', 'Premium', 17665.36, 'Confirmed'),
(30, 41, '2025-01-17', 'Economy', 44549.01, 'Confirmed');


CREATE OR REPLACE VIEW vw_air_india_master AS
SELECT
    -- flight
    f.flight_id,
    f.flight_number,
    f.status                                             AS flight_status,
    f.departure_time,
    f.arrival_time,
    DATE(f.departure_time)                               AS departure_date,
    DAYNAME(f.departure_time)                            AS departure_weekday,
    TIMESTAMPDIFF(MINUTE, f.departure_time, f.arrival_time) AS duration_min,
  
    al.airline_id,
    al.airline_name,
    
    ac.aircraft_id,
    ac.model                                             AS aircraft_model,
    ac.capacity,
   
    r.route_id,
    CONCAT(orig.airport_code, '->', dest.airport_code)   AS route_label,
    orig.airport_code                                    AS origin_code,
    orig.city                                            AS origin_city,
    orig.country                                         AS origin_country,
    dest.airport_code                                    AS dest_code,
    dest.city                                            AS dest_city,
    dest.country                                         AS dest_country,
    r.distance_km,
    rr.distance_km                                       AS return_distance_km,
    CASE WHEN orig.country = dest.country THEN 'Domestic'
         ELSE 'International' END                        AS route_type,
    b.booking_id,
    b.booking_date,
    DATE_FORMAT(b.booking_date, '%Y-%m')                 AS booking_month,
    b.seat_class,
    b.fare,
    b.status                                             AS booking_status,
    -- passenger
    p.passenger_id,
    CONCAT(p.first_name, ' ', p.last_name)               AS passenger_name,
    p.nationality
FROM flights f
JOIN      airlines   al   ON f.airline_id             = al.airline_id
JOIN      aircraft   ac   ON f.aircraft_id            = ac.aircraft_id
JOIN      routes     r    ON f.route_id               = r.route_id
JOIN      airports   orig ON r.origin_airport_id      = orig.airport_id
JOIN      airports   dest ON r.destination_airport_id = dest.airport_id
LEFT JOIN routes     rr   ON rr.origin_airport_id      = r.destination_airport_id   -- SELF JOIN:
                          AND rr.destination_airport_id = r.origin_airport_id       -- the return leg
LEFT JOIN bookings   b    ON f.flight_id              = b.flight_id
LEFT JOIN passengers p    ON b.passenger_id           = p.passenger_id;

-- Quick look at the view
SELECT * FROM vw_air_india_master LIMIT 10;

-- Q1. Confirmed Business/First bookings with a fare above 50,000, highest first.
SELECT booking_id, passenger_name, flight_number, route_label, seat_class, fare
FROM vw_air_india_master
WHERE booking_status = 'Confirmed'
  AND seat_class IN ('Business', 'First')
  AND fare > 50000
ORDER BY fare DESC;

-- Q2. Flights that have no bookings at all (LEFT JOIN effect inside the view).
SELECT flight_number, airline_name, route_label, flight_status
FROM vw_air_india_master
WHERE booking_id IS NULL
ORDER BY airline_name, flight_number;

-- Q3. DATA-QUALITY: bookings created after the flight had already departed.
SELECT booking_id, flight_number, booking_date, departure_date
FROM vw_air_india_master
WHERE booking_date > departure_date;

-- Q4. Round-trip check: routes whose outbound and return distances differ.
SELECT DISTINCT route_label, distance_km, return_distance_km,
       distance_km - return_distance_km AS difference_km
FROM vw_air_india_master
WHERE return_distance_km IS NOT NULL
  AND distance_km <> return_distance_km
ORDER BY difference_km DESC;

-- Q5. Confirmed revenue per airline, only airlines above 50,000.
SELECT airline_name, COUNT(booking_id) AS bookings, ROUND(SUM(fare), 2) AS revenue
FROM vw_air_india_master
WHERE booking_status = 'Confirmed'
GROUP BY airline_name
HAVING SUM(fare) > 50000
ORDER BY revenue DESC;

-- Q6. Seat classes with more than 5 bookings: count, average and highest fare.
SELECT seat_class, COUNT(*) AS bookings, ROUND(AVG(fare), 2) AS avg_fare, MAX(fare) AS max_fare
FROM vw_air_india_master
WHERE booking_id IS NOT NULL
GROUP BY seat_class
HAVING COUNT(*) > 5
ORDER BY avg_fare DESC;

-- Q7. Repeat customers: passengers with more than one confirmed booking.
SELECT passenger_name, COUNT(*) AS confirmed_bookings, ROUND(SUM(fare), 2) AS total_spend
FROM vw_air_india_master
WHERE booking_status = 'Confirmed'
GROUP BY passenger_id, passenger_name
HAVING COUNT(*) > 1
ORDER BY total_spend DESC;

-- Q8. Domestic vs International revenue by seat class.
SELECT route_type, seat_class, COUNT(*) AS bookings, ROUND(SUM(fare), 2) AS revenue
FROM vw_air_india_master
WHERE booking_status = 'Confirmed'
GROUP BY route_type, seat_class
ORDER BY route_type, revenue DESC;

-- Q9. Monthly bookings: confirmed vs cancelled count and confirmed revenue.
SELECT booking_month,
       SUM(CASE WHEN booking_status = 'Confirmed' THEN 1 ELSE 0 END)    AS confirmed,
       SUM(CASE WHEN booking_status = 'Cancelled' THEN 1 ELSE 0 END)    AS cancelled,
       ROUND(SUM(CASE WHEN booking_status = 'Confirmed' THEN fare ELSE 0 END), 2) AS confirmed_revenue
FROM vw_air_india_master
WHERE booking_id IS NOT NULL
GROUP BY booking_month
ORDER BY booking_month;

-- Q10. Aircraft models used on more than 2 distinct flights.
SELECT aircraft_model, COUNT(DISTINCT flight_id) AS flights_operated
FROM vw_air_india_master
GROUP BY aircraft_model
HAVING COUNT(DISTINCT flight_id) > 2
ORDER BY flights_operated DESC;

-- Q11. Airport departures: flights leaving each origin airport.
SELECT origin_code, origin_city, COUNT(DISTINCT flight_id) AS departures
FROM vw_air_india_master
GROUP BY origin_code, origin_city
ORDER BY departures DESC, origin_code;

-- Q12. Flight cancellation rate (%) per airline, worst first.
SELECT airline_name,
       COUNT(DISTINCT flight_id) AS total_flights,
       COUNT(DISTINCT CASE WHEN flight_status = 'Cancelled' THEN flight_id END) AS cancelled_flights,
       ROUND(COUNT(DISTINCT CASE WHEN flight_status = 'Cancelled' THEN flight_id END) * 100
             / COUNT(DISTINCT flight_id), 1) AS cancellation_pct
FROM vw_air_india_master
GROUP BY airline_name
ORDER BY cancellation_pct DESC;


-- Q13. ROW_NUMBER / RANK / DENSE_RANK of every confirmed fare inside its seat class (named window).
SELECT booking_id, seat_class, fare,
       ROW_NUMBER() OVER w AS row_num,
       RANK()       OVER w AS rank_pos,
       DENSE_RANK() OVER w AS dense_rank_pos
FROM vw_air_india_master
WHERE booking_status = 'Confirmed'
WINDOW w AS (PARTITION BY seat_class ORDER BY fare DESC)
ORDER BY seat_class, row_num;

-- Q14. Each passenger's booking sequence (ROW_NUMBER) with the previous and next fare (LAG / LEAD).
SELECT passenger_name, booking_id, booking_date, fare,
       ROW_NUMBER() OVER w AS booking_seq,
       LAG(fare)    OVER w AS previous_fare,
       LEAD(fare)   OVER w AS next_fare,
       fare - LAG(fare) OVER w AS change_vs_previous
FROM vw_air_india_master
WHERE booking_id IS NOT NULL
WINDOW w AS (PARTITION BY passenger_id ORDER BY booking_date, booking_id)
ORDER BY passenger_name, booking_seq;

-- Q15. Each passenger's most recent date (LAST_VALUE) and first date (FIRST_VALUE) of booking.
SELECT passenger_name, booking_id, booking_date,
       FIRST_VALUE(booking_date) OVER w AS first_booking_date,
       LAST_VALUE(booking_date)  OVER w AS latest_booking_date
FROM vw_air_india_master
WHERE booking_id IS NOT NULL
WINDOW w AS (PARTITION BY passenger_id ORDER BY booking_date, booking_id
             ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
ORDER BY passenger_name, booking_date;

-- Q16. Fare drift inside each flight + class: first fare sold vs every later fare.
SELECT flight_number, seat_class, booking_id, booking_date, fare,
       FIRST_VALUE(fare) OVER w                    AS first_fare_sold,
       ROUND(fare - FIRST_VALUE(fare) OVER w, 2)   AS change_vs_first,
       COUNT(*) OVER (PARTITION BY flight_id, seat_class) AS bookings_in_group
FROM vw_air_india_master
WHERE booking_status = 'Confirmed'
WINDOW w AS (PARTITION BY flight_id, seat_class ORDER BY booking_date, booking_id)
ORDER BY flight_number, seat_class, booking_date;

-- Q17. PERCENT_RANK and CUME_DIST of each fare inside its class.
SELECT booking_id, seat_class, fare,
       ROUND(PERCENT_RANK() OVER w, 3) AS percent_rank_in_class,
       ROUND(CUME_DIST()    OVER w, 3) AS cume_dist_in_class
FROM vw_air_india_master
WHERE booking_status = 'Confirmed'
WINDOW w AS (PARTITION BY seat_class ORDER BY fare)
ORDER BY seat_class, fare;

-- Q18. Each booking compared to its class average and its flight total (aggregate as window).
SELECT booking_id, flight_number, seat_class, fare,
       ROUND(AVG(fare) OVER (PARTITION BY seat_class), 2)               AS class_avg_fare,
       ROUND(fare - AVG(fare) OVER (PARTITION BY seat_class), 2)        AS diff_vs_class_avg,
       ROUND(SUM(fare) OVER (PARTITION BY flight_id), 2)                AS flight_revenue,
       ROUND(fare * 100 / SUM(fare) OVER (PARTITION BY flight_id), 1)   AS pct_of_flight_revenue
FROM vw_air_india_master
WHERE booking_status = 'Confirmed'
ORDER BY flight_number, fare DESC;

-- Q19. Running count and running revenue of confirmed bookings in booking order.
SELECT booking_id, booking_date, fare,
       COUNT(*)  OVER w AS running_bookings,
       ROUND(SUM(fare) OVER w, 2) AS running_revenue
FROM vw_air_india_master
WHERE booking_status = 'Confirmed'
WINDOW w AS (ORDER BY booking_date, booking_id)
ORDER BY booking_date, booking_id;

-- Q20. Most expensive and cheapest confirmed booking per airline (ranked both ways).
SELECT airline_name, booking_id, passenger_name, fare,
       RANK() OVER (PARTITION BY airline_name ORDER BY fare DESC) AS highest_rank,
       RANK() OVER (PARTITION BY airline_name ORDER BY fare ASC)  AS lowest_rank
FROM vw_air_india_master
WHERE booking_status = 'Confirmed'
ORDER BY airline_name, highest_rank;

-- Q21. Cancelled bookings: revenue lost, ranked within each airline.
SELECT airline_name, booking_id, passenger_name, route_label, fare AS lost_fare,
       DENSE_RANK() OVER (PARTITION BY airline_name ORDER BY fare DESC) AS loss_rank,
       ROUND(SUM(fare) OVER (PARTITION BY airline_name), 2)             AS airline_total_lost
FROM vw_air_india_master
WHERE booking_status = 'Cancelled'
ORDER BY airline_name, loss_rank;

-- Q22. Longest flights: duration rank overall and inside each airline.
SELECT DISTINCT flight_number, airline_name, route_label, duration_min,
       DENSE_RANK() OVER (ORDER BY duration_min DESC)                          AS overall_rank,
       DENSE_RANK() OVER (PARTITION BY airline_name ORDER BY duration_min DESC) AS airline_rank
FROM vw_air_india_master
ORDER BY overall_rank, flight_number;

-- Q23. Aircraft schedule audit: previous flight of the SAME aircraft via LAG,
--      flagging time overlaps and position mismatches (one row per flight).
SELECT aircraft_id, flight_number, route_label, departure_time, arrival_time,
       LAG(flight_number) OVER w AS previous_flight,
       LAG(route_label)   OVER w AS previous_route,
       LAG(arrival_time)  OVER w AS previous_arrival,
       CASE WHEN LAG(arrival_time) OVER w IS NULL            THEN 'First flight'
            WHEN LAG(arrival_time) OVER w > departure_time   THEN 'TIME OVERLAP'
            WHEN LAG(dest_code)    OVER w <> origin_code     THEN 'POSITION MISMATCH'
            ELSE 'OK' END AS schedule_check
FROM vw_air_india_master
WHERE flight_status <> 'Cancelled'
GROUP BY aircraft_id, flight_id, flight_number, route_label,
         departure_time, arrival_time, origin_code, dest_code
WINDOW w AS (PARTITION BY aircraft_id ORDER BY departure_time)
ORDER BY aircraft_id, departure_time;

-- Q24. Busiest weekday: flights per weekday with share of all flights (SUM OVER on a GROUP BY).
SELECT departure_weekday,
       COUNT(DISTINCT flight_id) AS flights,
       ROUND(COUNT(DISTINCT flight_id) * 100 / SUM(COUNT(DISTINCT flight_id)) OVER (), 1) AS pct_of_flights,
       RANK() OVER (ORDER BY COUNT(DISTINCT flight_id) DESC) AS busy_rank
FROM vw_air_india_master
GROUP BY departure_weekday
ORDER BY busy_rank;

-- Q25. Passenger nationality: confirmed revenue, share and rank.
SELECT nationality,
       COUNT(*)                AS bookings,
       ROUND(SUM(fare), 2)     AS revenue,
       ROUND(SUM(fare) * 100 / SUM(SUM(fare)) OVER (), 1) AS pct_of_revenue,
       DENSE_RANK() OVER (ORDER BY SUM(fare) DESC)        AS revenue_rank
FROM vw_air_india_master
WHERE booking_status = 'Confirmed'
GROUP BY nationality
ORDER BY revenue_rank;

-- Q26. Same-surname passengers on the same flight are flagged via COUNT OVER (possible families).
SELECT flight_number, passenger_name,
       SUBSTRING_INDEX(passenger_name, ' ', -1) AS last_name,
       COUNT(*) OVER (PARTITION BY flight_id, SUBSTRING_INDEX(passenger_name, ' ', -1)) AS same_surname_on_flight
FROM vw_air_india_master
WHERE booking_status = 'Confirmed'
ORDER BY same_surname_on_flight DESC, flight_number, passenger_name;

-- Q27. Bookings per passenger with ROW_NUMBER used to number passengers by spend, plus NTILE tier.
SELECT passenger_name,
       COUNT(*)            AS confirmed_bookings,
       ROUND(SUM(fare), 2) AS total_spend,
       ROW_NUMBER() OVER (ORDER BY SUM(fare) DESC) AS spend_position,
       NTILE(4)     OVER (ORDER BY SUM(fare) DESC) AS quartile,
       CASE NTILE(4) OVER (ORDER BY SUM(fare) DESC)
            WHEN 1 THEN 'Platinum' WHEN 2 THEN 'Gold'
            WHEN 3 THEN 'Silver'   ELSE 'Bronze' END AS loyalty_tier
FROM vw_air_india_master
WHERE booking_status = 'Confirmed'
GROUP BY passenger_id, passenger_name
ORDER BY spend_position;

-- Q28. Flight load factor with rank inside each airline (seats sold vs capacity).
SELECT airline_name, flight_number, capacity,
       SUM(CASE WHEN booking_status = 'Confirmed' THEN 1 ELSE 0 END) AS seats_sold,
       ROUND(SUM(CASE WHEN booking_status = 'Confirmed' THEN 1 ELSE 0 END) * 100 / capacity, 2) AS load_factor_pct,
       RANK() OVER (PARTITION BY airline_name
                    ORDER BY SUM(CASE WHEN booking_status = 'Confirmed' THEN 1 ELSE 0 END) * 100 / capacity DESC) AS rank_in_airline
FROM vw_air_india_master
GROUP BY airline_name, flight_id, flight_number, capacity
ORDER BY airline_name, rank_in_airline;

-- Q29. Daily confirmed revenue with running total and 3-day moving average.
SELECT booking_date,
       ROUND(SUM(fare), 2) AS daily_revenue,
       ROUND(SUM(SUM(fare)) OVER (ORDER BY booking_date), 2) AS running_total,
       ROUND(AVG(SUM(fare)) OVER (ORDER BY booking_date
                                  ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS moving_avg_3
FROM vw_air_india_master
WHERE booking_status = 'Confirmed'
GROUP BY booking_date
ORDER BY booking_date;

-- Q30. Month-over-month confirmed revenue growth (LAG over a grouped result).
SELECT booking_month,
       ROUND(SUM(fare), 2) AS revenue,
       ROUND(LAG(SUM(fare)) OVER (ORDER BY booking_month), 2) AS previous_month_revenue,
       ROUND((SUM(fare) - LAG(SUM(fare)) OVER (ORDER BY booking_month)) * 100
             / LAG(SUM(fare)) OVER (ORDER BY booking_month), 1) AS mom_growth_pct
FROM vw_air_india_master
WHERE booking_status = 'Confirmed'
GROUP BY booking_month
ORDER BY booking_month;

-- Q31. Top routes inside each airline (DENSE_RANK per partition) + share of airline revenue.
SELECT airline_name, route_label,
       ROUND(SUM(fare), 2) AS route_revenue,
       DENSE_RANK() OVER (PARTITION BY airline_name ORDER BY SUM(fare) DESC) AS route_rank,
       ROUND(SUM(fare) * 100 / SUM(SUM(fare)) OVER (PARTITION BY airline_name), 1) AS pct_of_airline
FROM vw_air_india_master
WHERE booking_status = 'Confirmed'
GROUP BY airline_name, route_id, route_label
ORDER BY airline_name, route_rank;

-- Q32. Pareto (80/20): cumulative revenue share of passengers, biggest spender first.
SELECT passenger_name,
       ROUND(SUM(fare), 2) AS total_spend,
       ROUND(SUM(SUM(fare)) OVER (ORDER BY SUM(fare) DESC, passenger_id) * 100
             / SUM(SUM(fare)) OVER (), 1) AS cumulative_pct,
       CASE WHEN (SUM(SUM(fare)) OVER (ORDER BY SUM(fare) DESC, passenger_id) - SUM(fare)) * 100
                 / SUM(SUM(fare)) OVER () < 80
            THEN 'Top 80% revenue' ELSE 'Long tail' END AS pareto_group
FROM vw_air_india_master
WHERE booking_status = 'Confirmed'
GROUP BY passenger_id, passenger_name
ORDER BY total_spend DESC;
