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
INSERT INTO piloti (nume, prenume, data_nasterii, nationalitate, echipa, abilitate, poza_nationalitate, poza_echipa) VALUES
('Hamilton', 'Lewis', '1985-01-07', 'UK', 'Mercedes', 88, 'imag1.png', 'imagi2.png'),
('Russell', 'George', '1998-02-15', 'UK', 'Mercedes', 78, 'imag1.png', 'imagi2.png'),
('Verstappen', 'Max', '1997-09-30', 'Netherlands', 'Red Bull Racing', 89, 'imag3.png', 'imagi3.png'),
('Perez', 'Sergio', '1990-01-26', 'Mexico', 'Red Bull Racing', 78, 'imag4.png', 'imagi3.png'),
('Leclerc', 'Charles', '1997-10-16', 'Monaco', 'Ferrari', 87, 'imag5.png', 'imagi4.png'),
('Sainz', 'Carlos', '1994-09-01', 'Spain', 'Ferrari', 85, 'imag6.png', 'imagi4.png'),
('Norris', 'Lando', '1999-11-13', 'UK', 'McLaren', 82, 'imag1.png', 'imagi5.png'),
('Ricciardo', 'Daniel', '1989-07-01', 'Australia', 'McLaren', 78, 'imag7.png', 'imagi5.png'),
('Alonso', 'Fernando', '1981-07-29', 'Spain', 'Alpine', 85, 'imag6.png', 'imagi6.png'),
('Ocon', 'Esteban', '1996-09-17', 'France', 'Alpine', 72, 'imag8.png', 'imagi6.png'),
('Gasly', 'Pierre', '1996-02-07', 'France', 'AlphaTauri', 73, 'imag8.png', 'imagi7.png'),
('Tsunoda', 'Yuki', '2000-05-11', 'Japan', 'AlphaTauri', 70, 'imag9.png', 'imagi7.png'),
('Vettel', 'Sebastian', '1987-07-03', 'Germany', 'Aston Martin', 80, 'imag10.png', 'imagi1.png'),
('Stroll', 'Lance', '1998-10-29', 'Canada', 'Aston Martin', 66, 'imag11.png', 'imagi1.png'),
('Schumacher', 'Mick', '1999-03-22', 'Germany', 'Haas', 58, 'imag10.png', 'imagi8.png'),
('Magnussen', 'Kevin', '1992-10-05', 'Denmark', 'Haas', 68, 'imag12.png', 'imagi8.png'),
('Bottas', 'Valtteri', '1989-08-28', 'Finland', 'Alfa Romeo', 78, 'imag13.png', 'imagi9.png'),
('Zhou', 'Guanyu', '1999-05-30', 'China', 'Alfa Romeo', 62, 'imag2.png', 'imagi9.png'),
('Albon', 'Alex', '1996-03-23', 'Thailand', 'Williams', 73, 'imag14.png', 'imagi10.png'),
('Latifi', 'Nicholas', '1995-06-29', 'Canada', 'Williams', 55, 'imag11.png', 'imagi10.png');



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

