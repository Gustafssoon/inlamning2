-- Gabriel Gustafsson - YH25
-- Inlämning 2 - Avancerad SQL & Databashantering

-- Bokstugan
-- Skapa databasen och använd den
DROP DATABASE IF EXISTS Bokstugan;
CREATE DATABASE Bokstugan;
USE Bokstugan;

-- Skapar tabell: Kunder
CREATE TABLE Kunder (
    KundID INT AUTO_INCREMENT PRIMARY KEY, 							-- Ett unikt nummer för varje Kund
    Namn VARCHAR(100) NOT NULL,
    Epost VARCHAR(100) UNIQUE NOT NULL, 
    Telefon VARCHAR(50) NOT NULL,
    Adress VARCHAR(255) NOT NULL
);

-- Skapar tabell: Böcker
CREATE TABLE Bocker (
	BokID INT AUTO_INCREMENT PRIMARY KEY, 							-- Ett unikt id för varje Bok
    ISBN BIGINT UNIQUE NOT NULL,
    Titel VARCHAR(200) NOT NULL,
    Forfattare VARCHAR(100) NOT NULL,
    Pris DECIMAL(10,2) NOT NULL CHECK (Pris > 0), 					-- Pris måste vara större än 0
    Lagerstatus INT NOT NULL CHECK (Lagerstatus >= 0) 				-- Antal i lager, får ej vara negativ
);

-- Skapar tabell: Beställningar
CREATE TABLE Bestallningar (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,							-- Ett unikt id för varje order så att man vet vilken beställing det är.
    KundID INT NOT NULL,
    Datum TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 						-- Datum när beställningen skapas
	Totalbelopp DECIMAL(10,2) NOT NULL CHECK (Totalbelopp >= 0), 	-- Summan av beställningen
    FOREIGN KEY (KundID) REFERENCES Kunder(KundID) 					-- Hämtar primärnyckel från KundID i Kunder-tabellen.
);

-- Tabell: Orderrader
CREATE TABLE Orderrader (
    OrderradID INT AUTO_INCREMENT PRIMARY KEY,						-- Ett unikt id för varje orderrad så att man vet vilken order det är.
    OrderID INT NOT NULL,
    BokID INT NOT NULL,
    Antal INT NOT NULL CHECK (Antal > 0), 							-- Antal exemplar av boken. Får inte vara negativt antal.
    Pris DECIMAL(10,2) NOT NULL CHECK (Pris > 0),
	FOREIGN KEY (OrderID) REFERENCES Bestallningar(OrderID), 		-- Hämtar primärnyckel från OrderID i Beställningar-tabellen.
	FOREIGN KEY (BokID) REFERENCES Bocker(BokID) 					-- Hämtar primärnyckel från BokID i Böcker-tabellen.
);

-- Loggtabell för nya kunder
CREATE TABLE KundLogg (
    LoggID INT AUTO_INCREMENT PRIMARY KEY,
    KundID INT NOT NULL,
    Namn VARCHAR(100) NOT NULL,
    RegistreradDatum TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====
-- INDEX
-- =====

-- Index på e-post i Kunder
CREATE INDEX index_epost ON Kunder(Epost);

-- Se vårt index
SHOW INDEX FROM Kunder;

-- =========
-- TRIGGERS
-- =========

-- Trigger 1: logga när en ny kund registreras
DELIMITER $$

CREATE TRIGGER logga_ny_kund
AFTER INSERT ON Kunder
FOR EACH ROW
BEGIN
    INSERT INTO KundLogg (KundID, Namn)
    VALUES (NEW.KundID, NEW.Namn);
END $$

-- Trigger 2: minska lagersaldo när en orderrad läggs till
CREATE TRIGGER minska_lager
AFTER INSERT ON Orderrader
FOR EACH ROW
BEGIN
    UPDATE Bocker
    SET Lagerstatus = Lagerstatus - NEW.Antal
    WHERE BokID = NEW.BokID;
END $$

DELIMITER ;

-- ========
-- TESTDATA
-- ========

-- Infogar testdata i tabellen Kunder
INSERT INTO Kunder (Namn, Epost, Telefon, Adress) VALUES
('Anna Andersson', 'anna@mail.com', '070-1111111', 'Stora vägen 1, 111 11 Stockholm'),
('Bengt Bengtsson', 'bengt@mail.com', '070-2222222', 'Lilla vägen 2, 222 22 Göteborg'),
('Carl Carlsson', 'carl@mail.com', '070-3333333', 'Norra vägen 3, 333 33 Malmö'),
('Didrik Didriksson', 'didrik@mail.com', '070-4444444', 'Södra vägen 4, 444 44 Kalmar'),
('Erik Eriksson', 'erik@mail.com', '070-5555555', 'Östra vägen 5, 555 55 Nybro');

-- Infogar testdata i tabellen Böcker
INSERT INTO Bocker (ISBN, Titel, Forfattare, Pris, Lagerstatus) VALUES
(9780553296129, 'Star Wars: Heir to the Empire', 'Timothy Zahn', 129.00, 10),
(9780470835847, 'The Game', 'Ken Dryden', 159.00, 5),
(9780132350884, 'Clean Code: A Handbook of Agile Software Craftsmanship', 'Robert C. Martin', 499.00, 8),
(9780261102217, 'The Hobbit', 'J.R.R. Tolkien', 199.00, 25),
(9780439136365, 'Harry Potter and the Prisoner of Azkaban', 'J.K. Rowling', 149.00, 18),
(9780743211383, 'Band of Brothers', 'Stephen E. Ambrose', 179.00, 10),
(9780385737944, 'The Maze Runner', 'James Dashner', 159.00, 16);

-- Infogar testdata i tabellen Beställningar
-- Här kopplas Kunder till sin order.
INSERT INTO Bestallningar (KundID, Datum, Totalbelopp) VALUES
(1, '2024-03-01', 328.00), 
(1, '2024-03-15', 398.00), 
(2, '2024-03-05', 159.00),
(3, '2024-03-10', 499.00),
(1, '2024-03-20', 499.00),
(4, '2024-03-22', 199.00),
(2, '2024-03-25', 129.00),
(1, '2024-03-28', 149.00); 

-- Infogar testdata i tabellen Orderrader
INSERT INTO Orderrader (OrderID, BokID, Antal, Pris) VALUES
(1, 1, 1, 129.00),
(1, 4, 1, 199.00),
(2, 4, 2, 199.00),
(3, 2, 1, 159.00),
(4, 3, 1, 499.00),
(5, 3, 1, 499.00),
(6, 4, 1, 199.00),
(7, 1, 1, 129.00),
(8, 5, 1, 149.00);

-- ======================================
-- SELECTS FÖR ATT KONTROLLERA DATABASEN
-- ======================================

-- Hämta alla kunder
SELECT * FROM Kunder;

-- Hämta alla beställningar
SELECT * FROM Bestallningar;

-- Filtrera kunder baserat på namn
SELECT * FROM Kunder
WHERE Namn LIKE 'Anna%';

-- Filtrera kunder baserat på e-post
SELECT * FROM Kunder
WHERE Epost LIKE '%mail.com';

-- Sortera produkter efter pris, dyrast först
SELECT * FROM Bocker
ORDER BY Pris DESC;

-- ====================
-- UPPDATERA & TA BORT
-- ====================

-- Uppdatera en kunds e-postadress
UPDATE Kunder
SET Epost = 'anna.andersson@mail.com'
WHERE KundID = 1;

-- Kontrollera uppdateringen
SELECT * FROM Kunder WHERE KundID = 1;

-- Transaktion med ROLLBACK
START TRANSACTION;

-- Tar bort kund med kundID 5
DELETE FROM Kunder
WHERE KundID = 5;

-- Kontrollera att kunden är borttagen i den aktiva transaktionen
SELECT * FROM Kunder;

-- Ångra borttagningen
ROLLBACK;

-- Kontrollera att kunden finns kvar igen
SELECT * FROM Kunder WHERE KundID = 5;

-- ===================
-- 3. JOINs & GROUP BY
-- ====================

-- INNER JOIN: visa kunder som har lagt beställningar
SELECT Kunder.Namn, Bestallningar.OrderID, Bestallningar.Datum, Bestallningar.Totalbelopp FROM Bestallningar
INNER JOIN Kunder ON Bestallningar.KundID = Kunder.KundID;

-- LEFT JOIN: visa alla kunder, även de utan beställningar
SELECT Kunder.Namn, Bestallningar.OrderID, Bestallningar.Datum, Bestallningar.Totalbelopp FROM Kunder
LEFT JOIN Bestallningar ON Kunder.KundID = Bestallningar.KundID
ORDER BY Kunder.Namn;

-- GROUP BY: räkna antal beställningar per kund
SELECT Kunder.Namn, COUNT(Bestallningar.OrderID) AS AntalBestallningar FROM Kunder
LEFT JOIN Bestallningar ON Kunder.KundID = Bestallningar.KundID
GROUP BY Kunder.KundID, Kunder.Namn;

-- HAVING: visa kunder som gjort fler än 2 beställningar
SELECT Kunder.Namn, COUNT(Bestallningar.OrderID) AS AntalBestallningar FROM Kunder
INNER JOIN Bestallningar ON Kunder.KundID = Bestallningar.KundID
GROUP BY Kunder.KundID, Kunder.Namn
HAVING COUNT(Bestallningar.OrderID) > 2;

-- ========================
-- KONTROLLERA MIN DATABAS
-- ========================

-- Visa lagersaldo efter att orderrader lagts till
SELECT BokID, Titel, Lagerstatus
FROM Bocker;

-- Visa logg över registrerade kunder
SELECT * FROM KundLogg;

-- Visa alla tabeller
SELECT * FROM Kunder;
SELECT * FROM Bocker;
SELECT * FROM Bestallningar;
SELECT * FROM Orderrader;
SELECT * FROM KundLogg;
