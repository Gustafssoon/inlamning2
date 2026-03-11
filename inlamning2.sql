-- Gabriel Gustafsson - YH25
-- Inlämning 2 - Avancerad SQL & Databashantering
-- Bokstugan

-- Skapa databasen och använd den
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


-- Infogar testdata i tabellen Kunder
INSERT INTO Kunder (Namn, Epost, Telefon, Adress) VALUES
('Anna Andersson', 'anna@mail.com', '070-1111111', 'Stora vägen 1, 111 11 Stockholm'),
('Bengt Bengtsson', 'bengt@mail.com', '070-2222222', 'Lilla vägen 2, 222 22 Göteborg'),
('Carl Carlsson', 'carl@mail.com', '070-3333333', 'Norra vägen 3, 333 33 Malmö'),
('Didrik Didriksson', 'didrik@mail.com', '070-4444444', 'Södra vägen 4, 444 44 Kalmar'),
('Erik Eriksson', 'erik@mail.com', '070-5555555', 'Östra vägen 5, 555 55 Nybro');			-- Lägger till kund som har registrerat sig men inte gjort en beställning ännu.

-- Infogar testdata i tabellen Böcker
INSERT INTO Bocker (Titel, ISBN, Forfattare, Pris, Lagerstatus) VALUES
('Star Wars: Heir to the Empire', '9780553296129', 'Timothy Zahn', 129.00, 10),
('The Game', '9780470835847', 'Ken Dryden', 159.00, 5),
('Clean Code: A Handbook of Agile Software Craftsmanship', '9780132350884', 'Robert C. Martin', 499.00, 8),
('The Hobbit', '9780261102217', 'J.R.R. Tolkien', 199.00, 25),
('Harry Potter and the Prisoner of Azkaban', '9780439136365', 'J.K. Rowling', 149.00, 18),		-- Lägger till en bok som inte har en beställning för tillfället
('Band of Brothers', '9780743211383', 'Stephen E. Ambrose', 179.00, 10),						-- Lägger till en bok som inte har en beställning för tillfället
('The Maze Runner', '9780385737944', 'James Dashner', 159.00, 16);								-- Lägger till en bok som inte har en beställning för tillfället

-- Infogar testdata i tabellen Beställningar
-- Här kopplas Kunder till sin order.
INSERT INTO Bestallningar (KundID, Datum, Totalbelopp) VALUES
(1, '2024-03-01', 328.00),  -- Anna: Star Wars (129) + Hobbit (199)
(1, '2024-03-15', 398.00),  -- Anna: 2 x Hobbit (199x2)
(2, '2024-03-05', 159.00),  -- Bengt: The Game
(3, '2024-03-10', 499.00),  -- Carl: Clean Code
(1, '2024-03-20', 499.00),  -- Anna: Clean Code
(4, '2024-03-22', 199.00),  -- Didrik: Hobbit
(2, '2024-03-25', 129.00);  -- Bengt: Star Wars

-- Infogar testdata i tabellen Orderrader
INSERT INTO Orderrader (OrderID, BokID, Antal, Pris) VALUES
(1, 1, 1, 129.00),  -- Order 1: 1 x Star Wars
(1, 4, 1, 199.00),  -- Order 1: 1 x Hobbit
(2, 4, 2, 199.00),  -- Order 2: 2 x Hobbit
(3, 2, 1, 159.00),  -- Order 3: 1 x The Game
(4, 3, 1, 499.00),  -- Order 4: 1 x Clean Code
(5, 3, 1, 499.00),  -- Order 5: 1 x Clean Code
(6, 4, 1, 199.00),  -- Order 6: 1 x Hobbit 
(7, 1, 1, 129.00);  -- Order 7: 1 x Star Wars


-- Visa allt i varje tabell
SELECT * FROM Kunder;
SELECT * FROM Bocker ORDER BY Pris DESC; -- Lista böcker dyrast till billigast
SELECT * FROM Bestallningar;
SELECT * FROM Orderrader;

-- Visa beställningar med kundnamn, orderID, datum och totalbelopp
SELECT Kunder.Namn, Bestallningar.OrderID, Bestallningar.Datum, Bestallningar.Totalbelopp FROM Bestallningar
INNER JOIN Kunder ON Bestallningar.KundID = Kunder.KundID;

-- Visa antal beställningar per kund
SELECT Kunder.Namn, COUNT(Bestallningar.OrderID) AS AntalBestallningar FROM Kunder
INNER JOIN Bestallningar ON Kunder.KundID = Bestallningar.KundID 
GROUP BY Kunder.Namn;

-- Visa kunder som gjort fler än 1 beställning
SELECT Kunder.Namn, COUNT(Bestallningar.OrderID) AS AntalBestallningar FROM Kunder
INNER JOIN Bestallningar ON Kunder.KundID = Bestallningar.KundID
GROUP BY Kunder.Namn
HAVING COUNT(Bestallningar.OrderID) > 1;

-- DROP DATABASE Bokstugan; -- Droppar databasen