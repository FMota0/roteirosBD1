-- Q1
SELECT COUNT(*)
FROM employee AS empl
WHERE empl.sex = 'F';

-- Q2
SELECT AVG(empl.salary)
FROM employee AS empl
WHERE empl.sex = 'M' and empl.address LIKE '%TX%';

-- Q3
SELECT empl.superssn AS ssn_supervisor, COUNT(*) AS qtd_supervisionados
FROM employee AS empl
GROUP BY empl.superssn
ORDER BY qtd_supervisionados;

-- Q4
SELECT sempl.fname AS nome_supervisor, COUNT(*) AS qtd_supervisionados
FROM (employee AS empl JOIN employee AS sempl ON empl.superssn = sempl.ssn)
GROUP BY sempl.fname
ORDER BY qtd_supervisionados;

-- Q5
SELECT sempl.fname AS nome_supervisor, COUNT(*) AS qtd_supervisionados
FROM (employee AS empl LEFT OUTER JOIN employee AS sempl ON empl.superssn = sempl.ssn)
GROUP BY sempl.fname
ORDER BY qtd_supervisionados;

-- Q6
SELECT MIN(qtd_funcionarios) AS qtd
FROM (
    SELECT pno, COUNT(*) AS qtd_funcionarios
    FROM works_on
    GROUP BY pno
) AS qtd_on_proj;

-- Q7
SELECT

-- Q8
SELECT work.pno AS num_proj, AVG(empl.salary) AS media_sal
FROM (works_on AS work JOIN employee AS empl ON work.essn = empl.ssn)
GROUP BY work.pno;

-- Q9
SELECT work.pno AS num_proj, proj.pname AS proj_name, AVG(empl.salary) AS media_sal
FROM (works_on AS work JOIN employee AS empl ON work.essn = empl.ssn
    JOIN project AS proj ON work.pno = proj.pnumber)
GROUP BY work.pno, proj.pname
ORDER BY media_sal;

-- Q10
SELECT empl.fname, empl.salary
FROM (employee AS empl LEFT OUTER JOIN works_on AS work ON empl.ssn = work.essn)
WHERE (work.pno IS NULL or work.pno != 92) and NOT EXISTS (
    SELECT cempl.fname, cempl.salary
    FROM (employee AS cempl JOIN works_on AS cwork ON cempl.ssn = cwork.essn)
    WHERE cwork.pno = 92 and cempl.salary > empl.salary
)
ORDER BY empl.salary;




















-- Q11

-- Q12
SELECT work.pno AS num_proj, COUNT(*) AS qtd_func
FROM (works_on AS work RIGHT OUTER JOIN employee AS empl ON work.essn = empl.ssn)
GROUP BY work.pno
HAVING COUNT(*) < 5;

-- Q13

-- Q14
SELECT dname
FROM department
WHERE NOT EXISTS (
    SELECT * FROM project
    WHERE dnum = dnumber
);

-- Q15
