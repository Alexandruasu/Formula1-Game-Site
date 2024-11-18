/*Pentru a putea conecta baza de date la site, va trebui să folosim următoarele privilegii și să le acceptăm*/
CREATE DATABASE formula1;
CREATE USER alex WITH ENCRYPTED PASSWORD 'alexu';
GRANT ALL PRIVILEGES ON DATABASE formula1 TO alex ;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO alex;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO alex;

CREATE TABLE IF NOT EXISTS curse (
    id_cursa SERIAL PRIMARY KEY,
    nume_cursa VARCHAR(100) NOT NULL,
    data_cursa DATE,
    locatie VARCHAR(100)
);
CREATE TABLE IF NOT EXISTS piloti (
    id_pilot SERIAL PRIMARY KEY,
    nume VARCHAR(50) NOT NULL,
    prenume VARCHAR(50) NOT NULL,
    data_nasterii DATE,
    nationalitate VARCHAR(50),
    echipa VARCHAR(50),
    anul INT CHECK (anul >= 1900 AND anul <= EXTRACT(YEAR FROM CURRENT_DATE)),
    abilitate INT CHECK (abilitate BETWEEN 0 AND 100), 
    poza_nationalitate VARCHAR(255),
    poza_echipa VARCHAR(255)
);
CREATE TABLE IF NOT EXISTS pilot_cursa (
    id_pilot INT REFERENCES piloti(id_pilot) ON DELETE CASCADE,
    id_cursa INT REFERENCES curse(id_cursa) ON DELETE CASCADE,
    pozitie_finala INT,
    calificari INT,
    PRIMARY KEY (id_pilot, id_cursa)
);
/*anul 2022*/
INSERT INTO piloti (nume, prenume, data_nasterii, nationalitate, echipa, anul, abilitate, poza_nationalitate, poza_echipa) VALUES
('Hamilton', 'Lewis', '1985-01-07', 'UK', 'Mercedes', 2022, 88, 'imag1.png', 'imagi2.png'),
('Russell', 'George', '1998-02-15', 'UK', 'Mercedes', 2022, 78, 'imag1.png', 'imagi2.png'),
('Verstappen', 'Max', '1997-09-30', 'Netherlands', 'Red Bull Racing', 2022, 89, 'imag3.png', 'imagi3.png'),
('Perez', 'Sergio', '1990-01-26', 'Mexico', 'Red Bull Racing', 2022, 78, 'imag4.png', 'imagi3.png'),
('Leclerc', 'Charles', '1997-10-16', 'Monaco', 'Ferrari', 2022, 87, 'imag5.png', 'imagi4.png'),
('Sainz', 'Carlos', '1994-09-01', 'Spain', 'Ferrari', 2022, 85, 'imag6.png', 'imagi4.png'),
('Norris', 'Lando', '1999-11-13', 'UK', 'McLaren', 2022, 82, 'imag1.png', 'imagi5.png'),
('Ricciardo', 'Daniel', '1989-07-01', 'Australia', 'McLaren', 2022, 78, 'imag7.png', 'imagi5.png'),
('Alonso', 'Fernando', '1981-07-29', 'Spain', 'Alpine', 2022, 85, 'imag6.png', 'imagi6.png'),
('Ocon', 'Esteban', '1996-09-17', 'France', 'Alpine', 2022, 72, 'imag8.png', 'imagi6.png'),
('Gasly', 'Pierre', '1996-02-07', 'France', 'AlphaTauri', 2022, 73, 'imag8.png', 'imagi7.png'),
('Tsunoda', 'Yuki', '2000-05-11', 'Japan', 'AlphaTauri', 2022, 70, 'imag9.png', 'imagi7.png'),
('Vettel', 'Sebastian', '1987-07-03', 'Germany', 'Aston Martin', 2022, 80, 'imag10.png', 'imagi1.png'),
('Stroll', 'Lance', '1998-10-29', 'Canada', 'Aston Martin', 2022, 66, 'imag11.png', 'imagi1.png'),
('Schumacher', 'Mick', '1999-03-22', 'Germany', 'Haas', 2022, 58, 'imag10.png', 'imagi8.png'),
('Magnussen', 'Kevin', '1992-10-05', 'Denmark', 'Haas', 2022, 68, 'imag12.png', 'imagi8.png'),
('Bottas', 'Valtteri', '1989-08-28', 'Finland', 'Alfa Romeo', 2022, 78, 'imag13.png', 'imagi9.png'),
('Zhou', 'Guanyu', '1999-05-30', 'China', 'Alfa Romeo', 2022, 62, 'imag2.png', 'imagi9.png'),
('Albon', 'Alex', '1996-03-23', 'Thailand', 'Williams', 2022, 73, 'imag14.png', 'imagi10.png'),
('Latifi', 'Nicholas', '1995-06-29', 'Canada', 'Williams', 2022, 55, 'imag11.png', 'imagi10.png');

/*anul 2021*/
INSERT INTO piloti (nume, prenume, data_nasterii, nationalitate, echipa, anul, abilitate, poza_nationalitate, poza_echipa) VALUES
('Hamilton', 'Lewis', '1985-01-07', 'UK', 'Mercedes', 2021, 88, 'imag1.png', 'imagi2.png'),
('Bottas', 'Valtteri', '1989-08-28', 'Finland', 'Mercedes', 2021, 85, 'imag13.png', 'imagi2.png'),
('Verstappen', 'Max', '1997-09-30', 'Netherlands', 'Red Bull Racing', 2021, 90, 'imag3.png', 'imagi3.png'),
('Perez', 'Sergio', '1990-01-26', 'Mexico', 'Red Bull Racing', 2021, 82, 'imag4.png', 'imagi3.png'),
('Leclerc', 'Charles', '1997-10-16', 'Monaco', 'Ferrari', 2021, 84, 'imag5.png', 'imagi4.png'),
('Sainz', 'Carlos', '1994-09-01', 'Spain', 'Ferrari', 2021, 83, 'imag6.png', 'imagi4.png'),
('Norris', 'Lando', '1999-11-13', 'UK', 'McLaren', 2021, 79, 'imag1.png', 'imagi5.png'),
('Ricciardo', 'Daniel', '1989-07-01', 'Australia', 'McLaren', 2021, 82, 'imag7.png', 'imagi5.png'),
('Alonso', 'Fernando', '1981-07-29', 'Spain', 'Alpine', 2021, 80, 'imag6.png', 'imagi6.png'),
('Ocon', 'Esteban', '1996-09-17', 'France', 'Alpine', 2021, 78, 'imag8.png', 'imagi6.png'),
('Gasly', 'Pierre', '1996-02-07', 'France', 'AlphaTauri', 2021, 80, 'imag8.png', 'imagi7.png'),
('Tsunoda', 'Yuki', '2000-05-11', 'Japan', 'AlphaTauri', 2021, 70, 'imag9.png', 'imagi7.png'),
('Vettel', 'Sebastian', '1987-07-03', 'Germany', 'Aston Martin', 2021, 80, 'imag10.png', 'imagi1.png'),
('Stroll', 'Lance', '1998-10-29', 'Canada', 'Aston Martin', 2021, 66, 'imag11.png', 'imagi1.png'),
('Schumacher', 'Mick', '1999-03-22', 'Germany', 'Haas', 2021, 60, 'imag10.png', 'imagi8.png'),
('Mazepin', 'Nikita', '1999-03-02', 'Russia', 'Haas', 2021, 55, 'imag16.png', 'imagi8.png'), 
('Raikkonen', 'Kimi', '1979-10-17', 'Finland', 'Alfa Romeo', 2021, 80, 'imag13.png', 'imagi9.png'),
('Giovinazzi', 'Antonio', '1993-12-14', 'Italy', 'Alfa Romeo', 2021, 72, 'imag15.png', 'imagi9.png'),
('Russell', 'George', '1998-02-15', 'UK', 'Williams', 2021, 71, 'imag1.png', 'imagi10.png'),
('Latifi', 'Nicholas', '1995-06-29', 'Canada', 'Williams', 2021, 55, 'imag11.png', 'imagi10.png');

/*2020*/
INSERT INTO piloti (nume, prenume, data_nasterii, nationalitate, echipa, anul, abilitate, poza_nationalitate, poza_echipa) VALUES
('Hamilton', 'Lewis', '1985-01-07', 'UK', 'Mercedes', 2020, 90, 'imag1.png', 'imagi2.png'),
('Bottas', 'Valtteri', '1989-08-28', 'Finland', 'Mercedes', 2020, 87, 'imag13.png', 'imagi2.png'),
('Verstappen', 'Max', '1997-09-30', 'Netherlands', 'Red Bull Racing', 2020, 90, 'imag3.png', 'imagi3.png'),
('Albon', 'Alex', '1996-03-23', 'Thailand', 'Red Bull Racing', 2020, 82, 'imag14.png', 'imagi3.png'),
('Leclerc', 'Charles', '1997-10-16', 'Monaco', 'Ferrari', 2020, 82, 'imag5.png', 'imagi4.png'),
('Vettel', 'Sebastian', '1987-07-03', 'Germany', 'Ferrari', 2020, 86, 'imag10.png', 'imagi4.png'),
('Norris', 'Lando', '1999-11-13', 'UK', 'McLaren', 2020, 75, 'imag1.png', 'imagi5.png'),
('Sainz', 'Carlos', '1994-09-01', 'Spain', 'McLaren', 2020, 79, 'imag6.png', 'imagi5.png'),
('Ricciardo', 'Daniel', '1989-07-01', 'Australia', 'Renault', 2020, 81, 'imag7.png', 'imagi11.png'),
('Ocon', 'Esteban', '1996-09-17', 'France', 'Renault', 2020, 75, 'imag8.png', 'imagi11.png'),
('Gasly', 'Pierre', '1996-02-07', 'France', 'AlphaTauri', 2020, 75, 'imag8.png', 'imagi7.png'),
('Kvyat', 'Daniil', '1994-04-26', 'Russia', 'AlphaTauri', 2020, 75, 'imag16.png', 'imagi7.png'),
('Stroll', 'Lance', '1998-10-29', 'Canada', 'Racing Point', 2020, 72, 'imag11.png', 'imagi12.png'),
('Perez', 'Sergio', '1990-01-26', 'Mexico', 'Racing Point', 2020, 83, 'imag4.png', 'imagi12.png'),
('Raikkonen', 'Kimi', '1979-10-17', 'Finland', 'Alfa Romeo', 2020, 80, 'imag13.png', 'imagi9.png'),
('Giovinazzi', 'Antonio', '1993-12-14', 'Italy', 'Alfa Romeo', 2020, 75, 'imag15.png', 'imagi9.png'),
('Magnussen', 'Kevin', '1992-10-05', 'Denmark', 'Haas', 2020, 75, 'imag12.png', 'imagi8.png'),
('Grosjean', 'Romain', '1986-04-17', 'France', 'Haas', 2020, 70, 'imag8.png', 'imagi8.png'),
('Russell', 'George', '1998-02-15', 'UK', 'Williams', 2020, 70, 'imag1.png', 'imagi10.png'),
('Latifi', 'Nicholas', '1995-06-29', 'Canada', 'Williams', 2020, 50, 'imag11.png', 'imagi10.png');

/*2019*/
INSERT INTO piloti (nume, prenume, data_nasterii, nationalitate, echipa, anul, abilitate, poza_nationalitate, poza_echipa) VALUES
('Hamilton', 'Lewis', '1985-01-07', 'UK', 'Mercedes', 2019, 90, 'imag1.png', 'imagi2.png'),
('Bottas', 'Valtteri', '1989-08-28', 'Finland', 'Mercedes', 2019, 88, 'imag13.png', 'imagi2.png'),
('Verstappen', 'Max', '1997-09-30', 'Netherlands', 'Red Bull Racing', 2019, 84, 'imag3.png', 'imagi3.png'),
('Gasly', 'Pierre', '1996-02-07', 'France', 'Red Bull Racing', 2019, 73, 'imag8.png', 'imagi3.png'),
('Leclerc', 'Charles', '1997-10-16', 'Monaco', 'Ferrari', 2019, 83, 'imag5.png', 'imagi4.png'),
('Vettel', 'Sebastian', '1987-07-03', 'Germany', 'Ferrari', 2019, 89, 'imag10.png', 'imagi4.png'),
('Norris', 'Lando', '1999-11-13', 'UK', 'McLaren', 2019, 78, 'imag1.png', 'imagi5.png'),
('Sainz', 'Carlos', '1994-09-01', 'Spain', 'McLaren', 2019, 83, 'imag6.png', 'imagi5.png'),
('Ricciardo', 'Daniel', '1989-07-01', 'Australia', 'Renault', 2019, 86, 'imag7.png', 'imagi11.png'),
('Hulkenberg', 'Nico', '1987-08-19', 'Germany', 'Renault', 2019, 80, 'imag10.png', 'imagi11.png'),
('Kvyat', 'Daniil', '1994-04-26', 'Russia', 'Toro Rosso', 2019, 75, 'imag16.png', 'imagi7.png'),
('Albon', 'Alex', '1996-03-23', 'Thailand', 'Toro Rosso', 2019, 78, 'imag14.png', 'imagi7.png'),
('Stroll', 'Lance', '1998-10-29', 'Canada', 'Racing Point', 2019, 68, 'imag11.png', 'imagi12.png'),
('Perez', 'Sergio', '1990-01-26', 'Mexico', 'Racing Point', 2019, 81, 'imag4.png', 'imagi12.png'),
('Raikkonen', 'Kimi', '1979-10-17', 'Finland', 'Alfa Romeo', 2019, 82, 'imag13.png', 'imagi9.png'),
('Giovinazzi', 'Antonio', '1993-12-14', 'Italy', 'Alfa Romeo', 2019, 70, 'imag15.png', 'imagi9.png'),
('Magnussen', 'Kevin', '1992-10-05', 'Denmark', 'Haas', 2019, 72, 'imag12.png', 'imagi8.png'),
('Grosjean', 'Romain', '1986-04-17', 'France', 'Haas', 2019, 70, 'imag8.png', 'imagi8.png'),
('Russell', 'George', '1998-02-15', 'UK', 'Williams', 2019, 71, 'imag1.png', 'imagi10.png'),
('Kubica', 'Robert', '1984-12-07', 'Poland', 'Williams', 2019, 68, 'imag12.png', 'imagi10.png');

/*2018*/
INSERT INTO piloti (nume, prenume, data_nasterii, nationalitate, echipa, anul, abilitate, poza_nationalitate, poza_echipa) VALUES
('Hamilton', 'Lewis', '1985-01-07', 'UK', 'Mercedes', 2018, 90, 'imag1.png', 'imagi2.png'),
('Bottas', 'Valtteri', '1989-08-28', 'Finland', 'Mercedes', 2018, 89, 'imag13.png', 'imagi2.png'),
('Verstappen', 'Max', '1997-09-30', 'Netherlands', 'Red Bull Racing', 2018, 82, 'imag3.png', 'imagi3.png'),
('Ricciardo', 'Daniel', '1989-07-01', 'Australia', 'Red Bull Racing', 2018, 86, 'imag7.png', 'imagi3.png'),
('Vettel', 'Sebastian', '1987-07-03', 'Germany', 'Ferrari', 2018, 88, 'imag10.png', 'imagi4.png'),
('Raikkonen', 'Kimi', '1979-10-17', 'Finland', 'Ferrari', 2018, 87, 'imag13.png', 'imagi4.png'),
('Norris', 'Lando', '1999-11-13', 'UK', 'McLaren', 2018, 82, 'imag1.png', 'imagi5.png'),
('Alonso', 'Fernando', '1981-07-29', 'Spain', 'McLaren', 2018, 82, 'imag6.png', 'imagi5.png'),
('Sainz', 'Carlos', '1994-09-01', 'Spain', 'Renault', 2018, 81, 'imag6.png', 'imagi11.png'),
('Hulkenberg', 'Nico', '1987-08-19', 'Germany', 'Renault', 2018, 80, 'imag10.png', 'imagi11.png'),
('Gasly', 'Pierre', '1996-02-07', 'France', 'Toro Rosso', 2018, 78, 'imag8.png', 'imagi7.png'),
('Hartley', 'Brendon', '1989-11-10', 'New Zealand', 'Toro Rosso', 2018, 62, 'imag18.png', 'imagi7.png'), 
('Perez', 'Sergio', '1990-01-26', 'Mexico', 'Force India', 2018, 78, 'imag4.png', 'imagi12.png'),
('Ocon', 'Esteban', '1996-09-17', 'France', 'Force India', 2018, 72, 'imag8.png', 'imagi12.png'),
('Leclerc', 'Charles', '1997-10-16', 'Monaco', 'Sauber', 2018, 77, 'imag5.png', 'imagi13.png'),
('Ericsson', 'Marcus', '1990-09-02', 'Sweden', 'Sauber', 2018, 65, 'imag17.png', 'imagi13.png'), 
('Stroll', 'Lance', '1998-10-29', 'Canada', 'Williams', 2018, 74, 'imag11.png', 'imagi10.png'),
('Sirotkin', 'Sergey', '1995-08-27', 'Russia', 'Williams', 2018, 61, 'imag16.png', 'imagi10.png'),
('Grosjean', 'Romain', '1986-04-17', 'France', 'Haas', 2018, 67, 'imag8.png', 'imagi8.png'),
('Magnussen', 'Kevin', '1992-10-05', 'Denmark', 'Haas', 2018, 70, 'imag12.png', 'imagi8.png');

/*2017*/
INSERT INTO piloti (nume, prenume, data_nasterii, nationalitate, echipa, anul, abilitate, poza_nationalitate, poza_echipa) VALUES
('Hamilton', 'Lewis', '1985-01-07', 'UK', 'Mercedes', 2017, 90, 'imag1.png', 'imagi2.png'),
('Bottas', 'Valtteri', '1989-08-28', 'Finland', 'Mercedes', 2017, 88, 'imag13.png', 'imagi2.png'),
('Verstappen', 'Max', '1997-09-30', 'Netherlands', 'Red Bull Racing', 2017, 80, 'imag3.png', 'imagi3.png'),
('Ricciardo', 'Daniel', '1989-07-01', 'Australia', 'Red Bull Racing', 2017, 84, 'imag7.png', 'imagi3.png'),
('Vettel', 'Sebastian', '1987-07-03', 'Germany', 'Ferrari', 2017, 87, 'imag10.png', 'imagi4.png'),
('Raikkonen', 'Kimi', '1979-10-17', 'Finland', 'Ferrari', 2017, 87, 'imag13.png', 'imagi4.png'),
('Alonso', 'Fernando', '1981-07-29', 'Spain', 'McLaren', 2017, 85, 'imag6.png', 'imagi5.png'),
('Vandoorne', 'Stoffel', '1992-03-26', 'Belgium', 'McLaren', 2017, 72, 'imag20.png', 'imagi5.png'),
('Perez', 'Sergio', '1990-01-26', 'Mexico', 'Force India', 2017, 80, 'imag4.png', 'imagi12.png'),
('Ocon', 'Esteban', '1996-09-17', 'France', 'Force India', 2017, 71, 'imag8.png', 'imagi12.png'),
('Massa', 'Felipe', '1981-04-25', 'Brazil', 'Williams', 2017, 75, 'imag19.png', 'imagi10.png'),
('Stroll', 'Lance', '1998-10-29', 'Canada', 'Williams', 2017, 77, 'imag11.png', 'imagi10.png'),
('Hulkenberg', 'Nico', '1987-08-19', 'Germany', 'Renault', 2017, 78, 'imag10.png', 'imagi11.png'),
('Palmer', 'Jolyon', '1991-01-20', 'UK', 'Renault', 2017, 60, 'imag1.png', 'imagi11.png'),
('Sainz', 'Carlos', '1994-09-01', 'Spain', 'Toro Rosso', 2017, 72, 'imag6.png', 'imagi7.png'),
('Kvyat', 'Daniil', '1994-04-26', 'Russia', 'Toro Rosso', 2017, 65, 'imag16.png', 'imagi7.png'),
('Ericsson', 'Marcus', '1990-09-02', 'Sweden', 'Sauber', 2017, 65, 'imag17.png', 'imagi13.png'),
('Wehrlein', 'Pascal', '1994-10-18', 'Germany', 'Sauber', 2017, 68, 'imag10.png', 'imagi13.png'),
('Grosjean', 'Romain', '1986-04-17', 'France', 'Haas', 2017, 75, 'imag8.png', 'imagi8.png'),
('Magnussen', 'Kevin', '1992-10-05', 'Denmark', 'Haas', 2017, 75, 'imag12.png', 'imagi8.png');

INSERT INTO curse (nume_cursa, data_cursa, locatie) VALUES
('Bahrain Grand Prix', '2022-03-20', 'Bahrain International Circuit'),
('Saudi Arabian Grand Prix', '2022-03-27', 'Jeddah Street Circuit'),
('Australian Grand Prix', '2022-04-10', 'Melbourne Grand Prix Circuit'),
('Emilia Romagna Grand Prix', '2022-04-24', 'Autodromo Enzo e Dino Ferrari'),
('Miami Grand Prix', '2022-05-08', 'Miami International Autodrome'),
('Spanish Grand Prix', '2022-05-22', 'Circuit de Barcelona-Catalunya'),
('Monaco Grand Prix', '2022-05-29', 'Circuit de Monaco'),
('Azerbaijan Grand Prix', '2022-06-12', 'Baku City Circuit'),
('Canadian Grand Prix', '2022-06-19', 'Circuit Gilles Villeneuve'),
('British Grand Prix', '2022-07-03', 'Silverstone Circuit'),
('Austrian Grand Prix', '2022-07-10', 'Red Bull Ring'),
('French Grand Prix', '2022-07-24', 'Circuit Paul Ricard'),
('Hungarian Grand Prix', '2022-07-31', 'Hungaroring'),
('Belgian Grand Prix', '2022-08-28', 'Circuit de Spa-Francorchamps'),
('Dutch Grand Prix', '2022-09-04', 'Circuit Zandvoort'),
('Italian Grand Prix', '2022-09-11', 'Monza Circuit'),
('Singapore Grand Prix', '2022-10-02', 'Marina Bay Street Circuit'),
('Japanese Grand Prix', '2022-10-09', 'Suzuka International Racing Course'),
('United States Grand Prix', '2022-10-23', 'Circuit of the Americas'),
('Mexican Grand Prix', '2022-10-30', 'Autodromo Hermanos Rodriguez'),
('Brazilian Grand Prix', '2022-11-13', 'Interlagos Circuit'),
('Abu Dhabi Grand Prix', '2022-11-20', 'Yas Marina Circuit');

