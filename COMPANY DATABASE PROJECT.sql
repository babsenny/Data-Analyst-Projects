-- Question 1 Provide the complete info on all employees
 SELECT *
 FROM employee;
 
-- Question 2 What is the count of all employees?
 SELECT COUNT(*)
 FROM employee;
 
 -- Question 3 What is the count of all departments?
 SELECT COUNT(dnumber)
 FROM department;
 
 -- Question 5 Name of projects in Sugarland
  SELECT pname, plocation
 FROM project
 WHERE plocation = 'Sugarland';
 
 -- Question 6 Employees name and hours information 
 SELECT Fname, Lname, SUM(hours)
 FROM employee
 INNER JOIN works_on ON employee.ssn = works_on.essn
 GROUP BY Fname, Lname;
 
 -- Question 7 (Employees name that don't work on Project ProductX)
 SELECT Fname, Lname
 FROM employee
 JOIN project ON employee.Dno = project.dnum
 WHERE pname <> "ProductX"
 GROUP BY Fname, Lname;
 
 -- Question 8(Employer that worked the least)
 SELECT Fname, Lname, SUM(hours)
 FROM employee
 INNER JOIN works_on ON employee.ssn = works_on.essn
 GROUP BY Fname, Lname
 ORDER BY SUM(hours)
 LIMIT 1;
 
 -- Question 8(Employer that worked the most)
 SELECT Fname, Lname, SUM(hours)
 FROM employee
 INNER JOIN works_on ON employee.ssn = works_on.essn
 GROUP BY Fname, Lname
 ORDER BY SUM(hours) DESC;
 
 -- since we can see from the result that the max hour worked for is 40, we can edit the query to include only employees that worked for 40 hours
 
 SELECT Fname, Lname, SUM(hours)
 FROM employee
 INNER JOIN works_on ON employee.ssn = works_on.essn
 GROUP BY Fname, Lname
 HAVING SUM(hours) = 40;

-- Question 9 Who worked the most hours in Research dept?
 SELECT Fname, Lname, SUM(hours), dname
 FROM employee
 JOIN works_on ON employee.ssn = works_on.essn
 JOIN department ON employee.Dno = department.dnumber
 WHERE dname = 'research'
 GROUP BY Fname, Lname, dname;
 
 -- Question 10 Names of dependents for person who worked most hours in Research dept. 
 SELECT Fname, Lname, SUM(hours), dname, dependent_name
 FROM employee
 JOIN works_on ON employee.ssn = works_on.essn
 JOIN department ON employee.Dno = department.dnumber
 JOIN dependent ON employee.ssn = dependent.essn
 WHERE dname = 'research'
 GROUP BY Fname, Lname, dname, dependent_name
 ORDER BY SUM(hours);
 
-- Question 11 Provide the name of projects in either Department number 4 or 5
SELECT pname, dnum
FROM project
WHERE dnum = "4" OR dnum = "5";

-- Question 12 Provide the names of employees with either a son or wife dependent
SELECT employee.Fname, employee.Lname, dependent.relationship, dependent.sex
FROM employee
JOIN dependent ON employee.SSN = dependent.essn
WHERE dependent.relationship = "son" OR (dependent.relationship = "spouse" AND dependent.sex = "F")
GROUP BY employee.Fname, employee.Lname, dependent.relationship;

-- Question 13 Provide the names of employees with salary between $5k and $30k
SELECT Fname, Lname, Salary
FROM employee
WHERE Salary BETWEEN "5000" AND "30000";

-- Question 14 Provide the names of employees that worked between 20 and 30 hours
SELECT employee.Fname, employee.Lname, SUM(hours) as total_no_of_hours
FROM employee
JOIN works_on ON employee.SSN = works_on.essn
GROUP BY employee.Fname, employee.Lname
HAVING total_no_of_hours BETWEEN "30" AND "40";

 -- Question 15 Provide the department name and project name for projects in Houston, Sugarland, or Stafford
SELECT department.dname, project.pname, plocation
FROM department
INNER JOIN project
ON department.dnumber=project.dnum
WHERE plocation IN ('Houston', 'Sugarland', 'Stafford');

-- Question 16 Provide employees with A in First Name
SELECT Fname,Lname
FROM employee
WHERE Fname LIKE '%a%';

-- Question 17 Provide employees with Last Name that does not begin with W
SELECT *
FROM employee
WHERE Lname NOT LIKE 'W%'; 

-- Question 18 Provide employees with ‘a’ as the second letter
SELECT 	*
FROM employee
WHERE Fname LIKE '_a%';

-- Question 20 What is the total salary for employees that worked on either Product Z or X?
SELECT SUM(employee.salary), project.pname
FROM employee
JOIN project
ON employee.Dno=project.dnum
WHERE project.pname IN ('ProductZ', 'ProductX')
GROUP BY project.pname;

-- Question 21 Name of employees who first name start with A and order last name alphabetically
SELECT Fname, Lname
FROM employee
WHERE Fname LIKE 'A%'
ORDER BY Lname; 

-- Question 22 Name of employees in Department number 5 and salary ordered largest to smallest
SELECT Fname, Lname, Dno, Salary
FROM employee
WHERE Dno=5
ORDER BY Salary DESC;

-- Question 23 Sort employee birthdates from oldest to newest and then sort first names in alphabetical order
SELECT *
FROM employee
ORDER BY bdate DESC, Fname ASC;

-- Question 24 Sort employee salaries by largest to smallest and employee last names alphabetically
SELECT *
FROM employee
ORDER BY salary DESC, Lname;

-- Question 25 How many male and female employees are there?
SELECT sex, COUNT(sex) AS total_no
FROM employee
GROUP BY sex
ORDER BY total_no DESC; -- To put the highest sex first

-- Question 26 How many male and female dependents are there?
SELECT sex, COUNT(sex) AS total_no
FROM dependent 
GROUP BY sex
ORDER BY total_no DESC; -- To put the highest sex first

-- Question 27 How many projects are there for each location?
SELECT plocation, COUNT(*) AS total_no
FROM project
GROUP BY plocation;

-- Question 28 Identify the number of projects in each location and order by most to least projects
SELECT plocation, COUNT(*) AS total_no
FROM project
GROUP BY plocation
ORDER BY total_no DESC;

-- Question 29 Identify the number of male and female employees and order from most to least
SELECT sex, COUNT(sex) AS total_no
FROM employee
GROUP BY sex
ORDER BY total_no DESC; -- To put the highest sex first

-- Question 30 How many male and female spouses are there?
SELECT sex, COUNT(relationship) AS total_no
FROM dependent
WHERE relationship = "spouse"
GROUP BY sex;

--  Question 31 What departments pay over $50,000 to employees?
SELECT department.dname, SUM(employee.salary) as total_no
FROM employee
JOIN department ON employee.Dno = department.dnumber
GROUP BY department.dname
HAVING SUM(employee.salary) > 50000
ORDER BY total_no DESC;

-- Question 32 Provide the employee SSN and number of dependents for employees with more than 1 dependent
SELECT employee.SSN, COUNT(dependent.dependent_name) as total
FROM employee
JOIN dependent ON employee.SSN = dependent.essn
GROUP BY employee.SSN
HAVING total > 1;

-- Question 33 Provide the project locations with more than 1 project
SELECT plocation, COUNT(pnumber) as total
FROM project 
GROUP BY plocation 
HAVING count(pnumber)  > 1;

-- Question 34 Get the name, birthdate, sex, and salary for each employee.
SELECT Fname, Lname, bdate, sex, salary
FROM employee;

-- Question 34a Modify query to get only employees born after 1960.
SELECT Fname, Lname, bdate, sex, salary
FROM employee
WHERE bdate > "1960-12-31";

-- Question 34b Modify query to group by sex for those born after 1960 (remove name and salary)
SELECT  COUNT(bdate) AS total_no, sex
FROM employee
WHERE bdate > "1960-12-31"
GROUP BY sex;

-- Question 34cModify query to get the average salary for men and women employees born after 1960
SELECT  AVG(salary) AS avg_salary, sex
FROM employee
WHERE bdate > "1960-12-31"
GROUP BY sex;

-- Question 34d Modify query to get the average salary for men and women employees born after 1960 and with an average over $15,000 ranked from largest to smallest

SELECT  AVG(salary) AS avg_salary, sex
FROM employee
WHERE bdate > "1960-12-31"
GROUP BY sex
HAVING AVG(salary) > 15000
ORDER BY AVG(salary) DESC;






 
 