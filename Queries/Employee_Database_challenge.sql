Create Table Departments (
dept_no Varchar(4) Not NULL,
dept_name Varchar(10) Not Null,
PRIMARY KEY(dept_no),
UNIQUE(	dept_name)
);
Create Table Employees ( 
emp_no int Not Null,
birth_date date Not Null,
frist_name Varchar(8) Not Null,
last_name Varchar(8) Not NULL,
gender Varchar(5) Not Null,
hire_date date Not Null,
primary Key (emp_no)
);

Create Table dept_manager (
dept_no Varchar(4) Not Null,
emp_no int Not Null,
from_date date Not Null,
to_date date Not Null,
foreign key(emp_no) REFERENCES Employees(emp_no),
foreign key(dept_no) REFERENCES departments(dept_no),
primary key(emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
	Foreign key(emp_no) References Employees(emp_no),
	primary key(emp_no));
	
Create Table dept_emp (
emp_no int Not Null,
dept_no int  Not Null, 
from_date date Not Null,
to_date date Not Null,
foreign key (emp_no) References employees(emp_no) );

Create table Tiles (
emp_no int Not Null,
title Varchar(50) Not Null,
from_date date Not Null,
to_date date Not Null,
foreign key (emp_no) References employees(emp_no),
Primary key(emp_no)); 

select e.emp_no, e.first_name, e.last_name, ti.title, ti.from_date, ti.to_date into retirement_info
from employees as e 
inner join titles as ti
on e.emp_no = ti.emp_no
where birth_date between '1952-01-01' and '1955-12-31'
order by emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
select distinct on(emp_no) emp_no, first_name, last_name, title into unique_titles
from retirement_info
where to_date = '9999-01-01'
order by emp_no;

select count(emp_no) as "total_employees", title from unique_titles
group by title
order by total_employees desc;

--Finding the mentorship eligibility 
select distinct on(emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, ti.title into mentorship_eligibility
from employees as e
inner join dept_emp as de
on e.emp_no = de.emp_no
Inner join titles as ti
on e.emp_no = ti.emp_no
where (de.to_date = '9999-01-01')
AND (birth_date between '1965-01-01' and '1965-12-31')
order by emp_no;

