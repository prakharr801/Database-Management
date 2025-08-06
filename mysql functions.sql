
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    JoinDate DATE
);

CREATE TABLE Attendance (
    AttID INT PRIMARY KEY,
    EmpID INT,
    AttDate DATE,
    Status VARCHAR(10), -- Present / Absent
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID)
);

-- 1. Get employee name by ID
DELIMITER $$
CREATE FUNCTION get_employee_name(eid INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE ename VARCHAR(50);
    SELECT Name INTO ename FROM Employees WHERE EmpID = eid;
    RETURN ename;
END$$
DELIMITER ;

-- 2. Calculate total salary expense for a department
DELIMITER $$
CREATE FUNCTION total_salary_department(dept VARCHAR(50))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(Salary) INTO total FROM Employees WHERE Department = dept;
    RETURN IFNULL(total,0);
END$$
DELIMITER ;

-- 3. Get total number of employees in a department
DELIMITER $$
CREATE FUNCTION total_employees_department(dept VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cnt INT;
    SELECT COUNT(*) INTO cnt FROM Employees WHERE Department = dept;
    RETURN cnt;
END$$
DELIMITER ;

-- 4. Get total present days of an employee
DELIMITER $$
CREATE FUNCTION total_present_days(eid INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cnt INT;
    SELECT COUNT(*) INTO cnt FROM Attendance 
    WHERE EmpID = eid AND Status = 'Present';
    RETURN IFNULL(cnt,0);
END$$
DELIMITER ;

-- 5. Get total absent days of an employee
DELIMITER $$
CREATE FUNCTION total_absent_days(eid INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cnt INT;
    SELECT COUNT(*) INTO cnt FROM Attendance 
    WHERE EmpID = eid AND Status = 'Absent';
    RETURN IFNULL(cnt,0);
END$$
DELIMITER ;

-- 6. Get attendance percentage of an employee
DELIMITER $$
CREATE FUNCTION attendance_percentage(eid INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE total_days INT;
    DECLARE present_days INT;
    SELECT COUNT(*) INTO total_days FROM Attendance WHERE EmpID = eid;
    SELECT COUNT(*) INTO present_days FROM Attendance WHERE EmpID = eid AND Status = 'Present';
    RETURN IFNULL((present_days / total_days) * 100,0);
END$$
DELIMITER ;

-- 7. Get highest salary in a department
DELIMITER $$
CREATE FUNCTION highest_salary_department(dept VARCHAR(50))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE high_sal DECIMAL(10,2);
    SELECT MAX(Salary) INTO high_sal FROM Employees WHERE Department = dept;
    RETURN IFNULL(high_sal,0);
END$$
DELIMITER ;

-- 8. Check if employee exists
DELIMITER $$
CREATE FUNCTION employee_exists(eid INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE cnt INT;
    SELECT COUNT(*) INTO cnt FROM Employees WHERE EmpID = eid;
    RETURN cnt > 0;
END$$
DELIMITER ;

-- 9. Get employees who joined after a specific date
DELIMITER $$
CREATE FUNCTION employees_joined_after(join_date DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cnt INT;
    SELECT COUNT(*) INTO cnt FROM Employees WHERE JoinDate > join_date;
    RETURN cnt;
END$$
DELIMITER ;

-- 10. Get department name by employee ID
DELIMITER $$
CREATE FUNCTION get_department_by_emp(eid INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE dept VARCHAR(50);
    SELECT Department INTO dept FROM Employees WHERE EmpID = eid;
    RETURN dept;
END$$
DELIMITER ;

