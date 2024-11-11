CREATE DATABASE lab7;

CREATE TABLE employees
(
    name          VARCHAR(10),
    surname       VARCHAR(10),
    employee_id   SERIAL PRIMARY KEY,
    first_name    VARCHAR(50),
    last_name     VARCHAR(50),
    email         VARCHAR(50),
    phone_number  VARCHAR(20),
    salary        INTEGER,
    department_id INTEGER REFERENCES departments
);

CREATE TABLE countries
(
    name         VARCHAR(10),
    country_id   serial primary key,
    country_name varchar(50),
    region_id    int,
    population   int
);

CREATE TABLE departments
(
    department_id   SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE,
    budget          INTEGER
);

CREATE INDEX idx_countries_name ON countries (name);

CREATE INDEX idx_employees_name_surname ON employees (name, surname);

CREATE UNIQUE INDEX idx_employees_salary_range ON employees (salary);

CREATE INDEX idx_employees_name_substring ON employees ((substring(name FROM 1 FOR 4)));

CREATE INDEX idx_employees_department_salary ON employees (department_id, salary);
CREATE INDEX idx_departments_budget ON departments (budget);