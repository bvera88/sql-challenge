DROP TABLE employees;

CREATE TABLE employees (
employee_number INTEGER NOT NULL,
dob DATE NOT NULL,
first_name VARCHAR NOT NULL,
last_name VARCHAR NOT NULL,
gender VARCHAR NOT NULL,
date_hired DATE NOT NULL,
PRIMARY KEY (employee_number)
);

SELECT * FROM employees;

CREATE TABLE salary (
employee_number INTEGER NOT NULL,
salary INTEGER NOT NULL,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
FOREIGN KEY (employee_number) REFERENCES employees(employee_number)
);

SELECT * FROM salary;

CREATE TABLE dept_manager (
dept_number CHARACTER VARYING NOT NULL,
employee_number INTEGER NOT NULL,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
FOREIGN KEY (employee_number) REFERENCES employees(employee_number)
);

SELECT * FROM dept_manager;

CREATE TABLE titles(
employee_number INTEGER NOT NULL,
title VARCHAR NOT NULL,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
FOREIGN KEY (employee_number) REFERENCES employees(employee_number)
);

SELECT * FROM titles;

CREATE TABLE dept_employees (
employee_number INTEGER NOT NULL,
dept_number CHARACTER VARYING NOT NULL,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
FOREIGN KEY (employee_number) REFERENCES employees(employee_number)
);

SELECT * FROM dept_employees;

CREATE TABLE departments (
dept_number CHARACTER VARYING NOT NULL,
dept_name VARCHAR,
PRIMARY KEY (dept_number)
);

SELECT * FROM departments;

--creating an inner join to pull the salary from the salary.csv and joining using the employee ID
SELECT employees.employee_number, employees.last_name, employees.gender, salary.salary
FROM salary
INNER JOIN employees ON
employees.employee_number = salary.employee_number;

SELECT * FROM salary;

--listing employees who were hired in 1986
SELECT employee_number, date_hired
FROM employees
WHERE EXTRACT(year from date_hired) = 1986;

--listing managers of each department. department number, department name
--managers employee number, last name, first name, start and end dates.
--, employees.employee_number, employees.first_name, employees.last_name, employees.start_date

SELECT departments.dept_number, employees.employee_number, departments.dept_name, employees.first_name,
employees.last_name, employees.date_hired, dept_manager.end_date
FROM dept_manager
INNER JOIN departments ON dept_manager.dept_number = departments.dept_number
INNER JOIN employees ON employees.employee_number = dept_manager.employee_number;

--department of each employee:employee number, last name, first, department name
SELECT dept_employees.employee_number, employees.first_name, employees.last_name,
departments.dept_name
FROM dept_employees
INNER JOIN departments ON dept_employees.dept_number = departments.dept_number
INNER JOIN employees ON employees.employee_number = dept_employees.employee_number;

--all employees whose first name is Hercules and last name begins with B
SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--list all employess in the sales and development department
--employee number, last name, first name, department name
-- DROP TABLE new_employee;
SELECT dept_employees.employee_number, employees.first_name, employees.last_name,
departments.dept_name
FROM dept_employees
INNER JOIN departments ON dept_employees.dept_number = departments.dept_number
INNER JOIN employees ON employees.employee_number = dept_employees.employee_number
WHERE dept_name = 'Sales';

--list all employees in the Sales and Development departments,
--including their employee number, last name, first name, and department
--name
SELECT dept_employees.employee_number, employees.first_name, employees.last_name,
departments.dept_name
FROM dept_employees
INNER JOIN departments ON dept_employees.dept_number = departments.dept_number
INNER JOIN employees ON employees.employee_number = dept_employees.employee_number
WHERE dept_name = 'Sales'
OR dept_name = 'Development';

-- In descending order, list the frequency count of employee
-- last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS "last name count"
FROM employees
GROUP BY last_name
ORDER BY "last name count" DESC;

--just double checking the formula above here. the count seemed off. 
SELECT last_name
FROM employees
WHERE last_name = 'Baba';