CREATE TABLE Books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    price DECIMAL(10, 2),
    quantity INT
);

CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    book_id INT REFERENCES Books(book_id),
    customer_id INT REFERENCES Customers(customer_id),
    order_date DATE,
    quantity INT
);

INSERT INTO Books (title, author, price, quantity) VALUES
('Database 101', 'A. Smith', 40.00, 10),
('Learn SQL', 'B. Johnson', 35.00, 15),
('Advanced DB', 'C. Lee', 50.00, 5);

INSERT INTO Customers (name, email) VALUES
('John Doe', 'johndoe@example.com'),
('Jane Doe', 'janedoe@example.com');

-- Задание 1: Транзакция для размещения заказа
BEGIN;
SELECT * FROM Orders;

INSERT INTO Orders (book_id, customer_id, order_date, quantity)
VALUES (1, 1, CURRENT_DATE, 2);

UPDATE Books
SET quantity = quantity - 2
WHERE book_id = 1;

COMMIT;

-- Задание 2: Транзакция с откатом
DO $$
BEGIN
    -- Проверка наличия достаточного количества книги
    IF (SELECT quantity FROM Books WHERE book_id = 3) >= 10 THEN
        -- Вставка нового заказа
        INSERT INTO Orders (book_id, customer_id, order_date, quantity)
        VALUES (3, 102, CURRENT_DATE, 10);

        UPDATE Books
        SET quantity = quantity - 10
        WHERE book_id = 3;
    ELSE
        RAISE NOTICE 'Not enough books in stock!';
    END IF;
END $$;



-- Задание 3: Демонстрация уровня изоляции
-- Сессия 1
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN;
UPDATE Books
SET price = 45.00
WHERE book_id = 2;

-- Сессия 2 (имитация)
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN;
SELECT price FROM Books WHERE book_id = 2;

COMMIT;

-- Сессия 2 повторно читает цену после коммита
SELECT price FROM Books WHERE book_id = 2;

-- Задание 4: Проверка надежности
BEGIN;

UPDATE Customers
SET email = 'newemail@example.com'
WHERE customer_id = 101;

COMMIT;

SELECT * FROM Customers WHERE customer_id = 101;

SELECT pg_reload_conf();

