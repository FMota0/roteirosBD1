-- Q1
SELECT * FROM department;

--Q2
SELECT * FROM dept_locations;

--Q3
SELECT * FROM employee;

--Q4
SELECT * FROM dependent;

--Q5
SELECT * FROM project;

--Q6
SELECT * FROM works_on;

--Q7
SELECT fname, lname FROM employee
WHERE sex = 'M';

--Q8
SELECT fname FROM employee
WHERE sex = 'M' and superssn IS NULL;

--Q9
SELECT empl1.fname AS employee_name, empl2.fname AS super_name
FROM employee AS empl1, employee AS empl2
WHERE empl1.superssn IS NOT NULL and empl1.superssn = empl2.ssn;

--Q10
SELECT empl1.fname AS employee_name
FROM employee AS empl1, employee AS empl2
WHERE empl1.superssn IS NOT NULL and empl1.superssn = empl2.ssn and empl2.fname = 'Franklin';

--Q11
SELECT dept.dname AS department_name, location.dlocation AS department_location
FROM department AS dept, dept_locations AS location
WHERE dept.dnumber = location.dnumber;

--Q12
SELECT dept.dname AS department_name
FROM department AS dept, dept_locations AS location
WHERE dept.dnumber = location.dnumber and location.dlocation LIKE 'S%';

--Q13
SELECT empl.fname AS employee_fname, empl.lname AS employee_lname, depe.dependent_name
FROM employee AS empl, dependent AS depe
WHERE empl.ssn = depe.essn;

--Q14
SELECT empl.fname || ' ' || empl.minit || ' ' || empl.lname AS full_name, empl.salary AS salary
FROM employee AS empl
WHERE salary > 50000;

--Q15
SELECT proj.pname AS project_name, dept.dname AS department_name
FROM project AS proj, department AS dept
WHERE proj.dnum = dept.dnumber;

--Q16
SELECT proj.pname AS project_name, empl.fname AS mgr_name
FROM project AS proj, department AS dept, employee AS empl
WHERE proj.dnum = dept.dnumber and dept.mgrssn = empl.ssn;

--Q17
SELECT proj.pname AS project_name, empl.fname AS employee_fname
FROM project AS proj, works_on AS work, employee AS empl
WHERE proj.pnumber = work.pno and work.essn = empl.ssn;

--Q18
SELECT empl.fname, depe.dependent_name, depe.relationship
FROM works_on AS work, dependent AS depe, employee AS empl
WHERE work.essn = depe.essn and work.pno = 91 and work.essn = empl.ssn;
