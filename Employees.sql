
create table Employees (
	emp_no int NOT NULL,
	birthdate DATE NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR (30) NOT NULL,
	gender VARCHAR (30) NOT NULL,
	hire_date VARCHAR (30) NOT NULL)
	;
SELECT * FROM Employees;
create table Departments (
	Dept_No VARCHAR (30) NOT NULL,
	Dept_Name VARCHAR (30) NOT NULL)
	;

CREATE TABLE dept_employee (
  Emp_No INT NOT NULL,
  Dept_No VARCHAR(30) NOT NULL,
  From_date VARCHAR(30) NOT NULL,
  To_date VARCHAR (30) NOT NULL	
);

CREATE TABLE Dept_Manager (
  dept_no VARCHAR(30) NOT NULL,
  emp_no SERIAL PRIMARY KEY,
  from_date VARCHAR(30) NOT NULL,
  to_date VARCHAR (30) NOT NULL)	
;	
select * FROM Dept_Manager;

CREATE TABLE Salaries (
	Emp_No SERIAL PRIMARY KEY,
	Salary VARCHAR (30) NOT NULL,
	From_date VARCHAR(30) NOT NULL,
    To_date VARCHAR (30) NOT NULL)
;	

CREATE TABLE Titles (
	
	title_No SERIAL PRIMARY KEY,
	Emp_No VARCHAR (30) NOT NULL,
	Title VARCHAR (30) NOT NULL,
	From_date VARCHAR(30) NOT NULL,
    To_date VARCHAR (30) NOT NULL)
;	
--HOMEWORK Question #1 List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT
E.emp_no, E.last_name, E.first_name, E.gender, salaries.salary
FROM employees as E
RIGHT JOIN salaries
ON E.emp_no = salaries.emp_no
;


--HOMEWORK Question #2 List employees who were hired in 1986.
select
E.emp_no, E.last_name, E.first_name, E.hire_date
FROM employees as E
WHERE hire_date LIKE '1986%'
;

--HOMEWORK Question #3 List the managers of each department with the following information: department number, department name, 
--the manager's employee number, last name, first name, and start and end employment dates.
SELECT
D.dept_no, D.dept_name, DM.emp_no, DM.from_date, DM.to_date, E.first_name, E.last_name
FROM departments as D
INNER JOIN dept_manager as DM
ON (D.dept_no = DM.dept_no) 
INNER JOIN employees as E
ON (E.emp_no = DM.emp_no)
;

--HOMEWORK Question #4: List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT E.emp_no, E.last_name, E.first_name, departments.dept_name
FROM employees as E
INNER JOIN dept_employee
		ON E.emp_no = dept_employee.emp_no
INNER JOIN departments
		ON departments.dept_no = dept_employee.dept_no
;
--HOMEWORK Question #5: List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%'
;

--QUESTION #6: List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT departments.dept_name, employees.first_name, employees.last_name, employees.emp_no
FROM dept_employee, employees, departments 
WHERE dept_employee.emp_no = employees.emp_no AND
      departments.dept_no = dept_employee.dept_no AND
      departments.dept_name = ('Sales')
ORDER BY employees.last_name
;

--Questions #7: List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT departments.dept_name, employees.first_name, employees.last_name, employees.emp_no
FROM dept_employee, employees, departments 
WHERE dept_employee.emp_no = employees.emp_no AND 
	  departments.dept_no = dept_employee.dept_no AND
	  dept_name IN ('Sales','Development')
ORDER BY departments.dept_name 
;

--Question #8 In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT (last_name) as frequency
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC
;

