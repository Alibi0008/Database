CREATE DATABASE lab4;

CREATE TABLE Warehouses (
    warehouse_id SERIAL PRIMARY KEY,
    location VARCHAR(100),
    capacity INT
);

CREATE TABLE Boxes (
    box_id SERIAL PRIMARY KEY,
    code VARCHAR(4),
    contents VARCHAR(100),
    value DECIMAL(10, 2),
    warehouse_id INT REFERENCES Warehouses(warehouse_id)
);

INSERT INTO Warehouses (warehouse_id, location, capacity) VALUES
(1, 'Chicago', 3),
(2, 'Chicago', 4),
(3, 'New York', 7),
(4, 'Los Angeles', 2),
(5, 'San Francisco', 8);

INSERT INTO Boxes (code, contents, value, warehouse_id) VALUES
('0MN7', 'Rocks', 180, 3),
('4H8P', 'Rocks', 250, 1),
('4RT3', 'Scissors', 190, 4),
('7G3H', 'Rocks', 200, 1),
('8JN6', 'Papers', 75, 1),
('8Y6U', 'Papers', 50, 3),
('9J6F', 'Papers', 175, 2),
('LL08', 'Rocks', 140, 4),
('P0H6', 'Scissors', 125, 1),
('P2T6', 'Scissors', 150, 2),
('TU55', 'Papers', 90, 5);


SELECT * FROM Warehouses;

SELECT * FROM Boxes WHERE value > 150;

SELECT DISTINCT contents FROM Boxes;

SELECT warehouse_id, COUNT(*) AS box_count FROM Boxes GROUP BY warehouse_id;

SELECT warehouse_id, COUNT(*) AS box_count FROM Boxes GROUP BY warehouse_id HAVING COUNT(*) > 2;

INSERT INTO Warehouses (location, capacity) VALUES ('New York', 3);

INSERT INTO Boxes (code, contents, value, warehouse_id) VALUES ('H5RT', 'Papers', 200, 2);

UPDATE Boxes SET value = value * 0.85 WHERE box_id = (
    SELECT box_id FROM Boxes ORDER BY value DESC OFFSET 2 LIMIT 1
);

DELETE FROM Boxes WHERE value < 150;

DELETE FROM Boxes USING Warehouses WHERE Boxes.warehouse_id = Warehouses.warehouse_id AND Warehouses.location = 'New York' RETURNING *;
