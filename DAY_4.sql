
## MySQL constraints --------------

/*
1. NOT NULL constraint
2. Primary Key
3. Foreign key
4. UNIQUE constraint
5. CHECK Constraint

*/

# Not Null 

CREATE TABLE tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE
);




INSERT INTO tasks(title ,start_date, end_date)
VALUES('Learn MySQL NOT NULL constraint', '2017-02-01','2017-02-02'),
      ('Check and update NOT NULL consttasksraint to your database', '2017-02-01',NULL);

SELECT * 
FROM tasks
WHERE end_date IS NULL;  


UPDATE tasks 
SET 
    end_date = start_date + 7
WHERE
    end_date IS NULL;

SELECT * FROM tasks;


ALTER TABLE tasks 
CHANGE 
    end_date 
    end_date DATE NOT NULL;

DESCRIBE tasks;

# primary key 

CREATE TABLE users(
   user_id INT AUTO_INCREMENT PRIMARY KEY,
   username VARCHAR(40),
   password VARCHAR(255),
   email VARCHAR(255)
);


CREATE TABLE pkdemos(
   id INT,
   title VARCHAR(255) NOT NULL
);

DESCRIBE pkdemos;

ALTER TABLE pkdemos
ADD PRIMARY KEY(id);

## Foreign key

/*
MySQL has five reference options: CASCADE, SET NULL, NO ACTION, RESTRICT, and SET DEFAULT.

CASCADE: if a row from the parent table is deleted or updated, the values of the matching 
rows in the child table automatically deleted or updated.

SET NULL:  if a row from the parent table is deleted or updated, the values of the 
foreign key column (or columns) in the child table are set to NULL.

RESTRICT:  if a row from the parent table has a matching row in the child table, 
MySQL rejects deleting or updating rows in the parent table.

NO ACTION: is the same as RESTRICT.

SET DEFAULT: is recognized by the MySQL parser. However, this action is rejected by 
both InnoDB and NDB tables.
*/

CREATE DATABASE fkdemo;
USE fkdemo;

CREATE TABLE categories(
    categoryId INT AUTO_INCREMENT PRIMARY KEY,
    categoryName VARCHAR(100) NOT NULL
) ;

CREATE TABLE products(
    productId INT AUTO_INCREMENT PRIMARY KEY,
    productName varchar(100) not null,
    categoryId INT,
    CONSTRAINT fk_category
    FOREIGN KEY (categoryId) 
        REFERENCES categories(categoryId)
) ENGINE=INNODB;

INSERT INTO categories(categoryName)
VALUES
    ('Smartphone'),
    ('Smartwatch');
    
INSERT INTO products(productName, categoryId)
VALUES('iPhone',1);

select * from categories;
select * from products;

#  Attempt to insert a new row into the products table with a categoryId  
# value does not exist in the categories table

INSERT INTO products(productName, categoryId)
VALUES('iPad',3);

# Update the value in the categoryId column in the categories table to 100

UPDATE categories
SET categoryId = 100
WHERE categoryId = 1;

# Note: Because of the RESTRICT option, you cannot delete or 
# update categoryId 1 since it is referenced by the productId 1 in the products table.

DROP TABLE products;

CREATE TABLE products(
    productId INT AUTO_INCREMENT PRIMARY KEY,
    productName varchar(100) not null,
    categoryId INT NOT NULL,
    CONSTRAINT fk_category
    FOREIGN KEY (categoryId) 
    REFERENCES categories(categoryId)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=INNODB;

## Unique Constraint 

CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    PRIMARY KEY (supplier_id),
    CONSTRAINT uc_name_address UNIQUE (name , address)
);

INSERT INTO suppliers(name, phone, address) 
VALUES( 'ABC Inc1', 
       '(408)-908-24761',
       '4000 North 1st Street1');

#  insert a different supplier but has the 
# phone number that already exists in the suppliers table

select * from suppliers;

INSERT INTO suppliers(name, phone, address) 
VALUES( 'XYZ Corporation','(408)-908-2476','3000 North 1st Street');

# change the phone number to a different one and execute the insert statement again

INSERT INTO suppliers(name, phone, address) 
VALUES( 'XYZ Corporation','(408)-908-3333','3000 North 1st Street');


##  CHECK CONSTRAINT

CREATE TABLE parts (
    part_no VARCHAR(18) PRIMARY KEY,
    description VARCHAR(40),
    cost DECIMAL(10,2 ) NOT NULL CHECK (cost >= 0),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    age int Not null check (age >=0 and age<=100)
    
);

INSERT INTO parts(part_no, description,cost,price, age) 
VALUES('A-001','Cooler',0,100, 350);


# new clause defines a table CHECK 
# constraint that ensures the price is always greater than or equal to cost

CREATE TABLE parts (
    part_no VARCHAR(18) PRIMARY KEY,
    description VARCHAR(40),
    cost DECIMAL(10,2 ) NOT NULL CHECK (cost >= 0),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    CONSTRAINT parts_chk_price_gt_cost 
        CHECK(price >= cost)
);

INSERT INTO parts(part_no, description,cost,price) 
VALUES('A-001','Cooler',200,100);

## STORED PROCEDURE -----------------------------------------------------

/*
If you want to save this query on the database server for execution later, 
one way to do it is to use a stored procedure.

By definition, a stored procedure is a segment of declarative SQL statements 
stored inside the MySQL Server.

Advantages:
1. Reduce network traffic
2. Centralize business logic in the database
3. Make database more secure

Disadvantages :
1. Resource usages
2. Troubleshooting
3. Maintenances

# General Syntax 

DELIMITER $$

CREATE PROCEDURE sp_name()
BEGIN
  -- statements
END $$

DELIMITER ;

*/

# SELECT statement returns all rows in the table customers from the sample database

SELECT 
    customerName, 
    city, 
    state, 
    postalCode, 
    country
FROM
    customers
ORDER BY customerName;


# CREATE PROCEDURE statement creates a new stored procedure that wraps the query above



DELIMITER $$

CREATE PROCEDURE stp_GetCustomers()
BEGIN
	SELECT 
		customerName, 
		city, 
		state, 
		postalCode, 
		country
	FROM
		customers
	ORDER BY customerName;    
     
END$$
DELIMITER ;

#  invoke it by using the CALL statement
CALL stp_GetCustomers(idd, time);

 # 1 . create a new stored procedure that returns employee and office information for one user:


DELIMITER $$

CREATE PROCEDURE GetEmployees()
BEGIN
    SELECT 
        firstName, 
        lastName, 
        city, 
        state, 
        country
    FROM employees
    INNER JOIN offices using (officeCode);
    
END$$

DELIMITER ;

# 2. Call procedure 

CALL GetEmployees();

# 3. DROP PROCEDURE to delete the GetEmployees() stored procedure:

DROP PROCEDURE GetEmployees;
DROP PROCEDURE IF EXISTS GetEmployees;

# Stored Procedure Variables ----------------------------
/*
variables in stored procedures to hold immediate results. 
These variables are local to the stored procedure.

Syntax: 
DECLARE variable_name datatype(size) [DEFAULT default_value];
*/

# declares a variable named totalSale with the data type DEC(10,2) and default value 0.0
# DECLARE totalSale DEC(10,2) DEFAULT 0.0;
# DECLARE x, y INT DEFAULT 0;

# Once a variable is declared, it is ready to use. To assign a variable a value, 
# you use the SET statement
SET variable_name = value;

# EG.
# DECLARE total INT DEFAULT 0;
SET @total2 = 10;
select @total2


DELIMITER $$

CREATE PROCEDURE GetTotalOrder()
BEGIN
	DECLARE totalOrder INT DEFAULT 0;
    
    SELECT COUNT(*) 
    INTO totalOrder
    FROM orders;
    
    SELECT totalOrder;
END$$

DELIMITER ;

CALL GetTotalOrder();

SELECT COUNT(*) 
    FROM orders;

# stored procedure parameters ------------------------

/*
A parameter in a stored procedure has one of three modes: IN,OUT, or INOUT.

1. IN :  is the default mode. When you define an IN parameter in a stored procedure, 
		 the calling program has to pass an argument to the stored procedure.

2. OUT : The value of an OUT parameter can be changed inside the stored procedure 
		 and its new value is passed back to the calling program. 


3. INOUT : An INOUT  parameter is a combination of IN and OUT parameters. 
			It means that the calling program may pass the argument, and the stored 
            procedure can modify the INOUT parameter, and pass the new value back to the calling program.

syntax of defining a parameter in stored procedures:
[IN | OUT | INOUT] parameter_name datatype[(length)]

*/

# 1. creates a stored procedure that finds all offices 
# that locate in a country specified by the input parameter
SELECT * 
 	FROM offices
	WHERE country = "USA";


DELIMITER //

CREATE PROCEDURE GetOfficeByCountry(
	IN countryName VARCHAR(255)
)
BEGIN
	SELECT * 
 	FROM offices
	WHERE country = countryName;
END //

DELIMITER ;


CALL GetOfficeByCountry();
CALL GetOfficeByCountry('USA');
CALL GetOfficeByCountry('France')

# 2. returns the number of orders by order status


DELIMITER $$

CREATE PROCEDURE GetOrderCountByStatus (
	IN  orderStatus VARCHAR(25),
	OUT total INT
)
BEGIN
	SELECT COUNT(orderNumber)
	INTO total
	FROM orders
	WHERE status = orderStatus;
END$$

DELIMITER ;

CALL GetOrderCountByStatus('Shipped', @total);
SELECT @total; # Session Variables

# 3. INOUT STP

DELIMITER $$

CREATE PROCEDURE SetCounter(
	INOUT counter INT,
    IN inc INT
)
BEGIN
	SET counter = counter + inc;
END$$

DELIMITER ;

SET @counter = 1;
CALL SetCounter(@counter,1); -- 2
CALL SetCounter(@counter,1); -- 3
CALL SetCounter(@counter,5); -- 8
SELECT @counter; -- 8

#  Alter Stored Procedures --------------

/*
Sometimes, you may want to alter a stored procedure by adding or 
removing parameters or even changing its body.
Fortunately, MySQL does not have any statement that allows you to 
directly modify the parameters and body of the stored procedure.
To make such changes, you must drop ad re-create the 
stored procedure using the DROP PROCEDURE and 
CREATE PROCEDURE statements.


*/

# 1.  create a stored procedure that returns the total amount of all sales orders
 
DELIMITER $$

CREATE PROCEDURE GetOrderAmount()
BEGIN
    SELECT 
        SUM(quantityOrdered * priceEach) 
    FROM orderDetails;
END$$

DELIMITER ;

# Alter STP by get the total amount by a given sales order
# Note: Second, right-click the stored procedure that you want 
# to change and select Alter Stored Procedure… 

DELIMITER $$

CREATE PROCEDURE GetOrderAmount(
	IN pOrderNumber INT
)
BEGIN
    SELECT 
        SUM(quantityOrdered * priceEach) 
    FROM orderDetails
    WHERE orderNumber = pOrderNumber;
END$$

DELIMITER ;

call GetOrderAmount(1001);

# MySQL IF Statement -------------------------------

/*

The IF-THEN statement allows you to execute a set of SQL 
statements based on a specified condition. 
The following illustrates the syntax of the IF-THEN statement:

IF condition THEN 
   statements;
END IF;

*/

##################### STP_1 ##########################

DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
    IN  pCustomerNumber INT, 
    OUT pCustomerLevel  VARCHAR(20))
BEGIN
    DECLARE credit DECIMAL(10,2) DEFAULT 0;

    SELECT creditLimit 
    INTO credit
    FROM customers
    WHERE customerNumber = pCustomerNumber;

    IF credit > 50000 THEN
        SET pCustomerLevel = 'PLATINUM';
    END IF;
END$$

DELIMITER ;

CALL GetCustomerLevel(181, @level);
SELECT @level;

###################### STP_2  ########################

DROP PROCEDURE GetCustomerLevel;

DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
    IN  pCustomerNumber INT, 
    OUT pCustomerLevel  VARCHAR(20))
BEGIN
    DECLARE credit DECIMAL DEFAULT 0;

    SELECT creditLimit 
    INTO credit
    FROM customers
    WHERE customerNumber = pCustomerNumber;

    IF credit > 50000 THEN
        SET pCustomerLevel = 'PLATINUM';
    ELSE
        SET pCustomerLevel = 'NOT PLATINUM';
    END IF;
END$$

DELIMITER ;


CALL GetCustomerLevel(447, @level);
SELECT @level;

###################### STP_3  ########################

DROP PROCEDURE GetCustomerLevel;

DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
    IN  pCustomerNumber INT, 
    OUT pCustomerLevel  VARCHAR(20))
BEGIN
    DECLARE credit DECIMAL DEFAULT 0;

    SELECT creditLimit 
    INTO credit
    FROM customers
    WHERE customerNumber = pCustomerNumber;

    IF credit > 50000 THEN
        SET pCustomerLevel = 'PLATINUM';
    ELSEIF credit <= 50000 AND credit > 10000 THEN
        SET pCustomerLevel = 'GOLD';
    ELSE
        SET pCustomerLevel = 'SILVER';
    END IF;
END $$

DELIMITER ;

CALL GetCustomerLevel(547, @level); 
SELECT @level;


# MySQL CASE Statement ---------------------------------
/*
Besides the IF statement, MySQL provides an alternative 
conditional statement called the CASE statement for constructing 
conditional statements in stored procedures. The CASE statements 
make the code more readable and efficient.


CASE case_value
   WHEN when_value1 THEN statements
   WHEN when_value2 THEN statements
   ...
   [ELSE else-statements]
END CASE;

*/

###################### STP_1  ########################

DELIMITER $$

CREATE PROCEDURE GetCustomerShipping(
	IN  pCustomerNUmber INT, 
	OUT pShipping       VARCHAR(50)
)
BEGIN
    DECLARE customerCountry VARCHAR(100);

SELECT 
    country
INTO customerCountry FROM
    customers
WHERE
    customerNumber = pCustomerNUmber;

    CASE customerCountry
		WHEN  'USA' THEN
		   SET pShipping = '2-day Shipping';
		WHEN 'Canada' THEN
		   SET pShipping = '3-day Shipping';
		ELSE
		   SET pShipping = '5-day Shipping';
	END CASE;
END$$


###################### STP_2  ########################

DELIMITER ;

CALL GetCustomerShipping(412,@shipping);
SELECT @shipping;


DELIMITER $$

CREATE PROCEDURE GetDeliveryStatus(
	IN pOrderNumber INT,
    OUT pDeliveryStatus VARCHAR(100)
)
BEGIN
	DECLARE waitingDay INT DEFAULT 0;
    SELECT 
		DATEDIFF(requiredDate, shippedDate)
	INTO waitingDay
	FROM orders
    WHERE orderNumber = pOrderNumber;
    
    CASE 
		WHEN waitingDay = 0 THEN 
			SET pDeliveryStatus = 'On Time';
        WHEN waitingDay >= 1 AND waitingDay < 5 THEN
			SET pDeliveryStatus = 'Late';
		WHEN waitingDay >= 5 THEN
			SET pDeliveryStatus = 'Very Late';
		ELSE
			SET pDeliveryStatus = 'No Information';
	END CASE;	
END$$
DELIMITER ;

CALL GetDeliveryStatus(10100,@delivery);
select @delivery;

################################## DAY 5 ####################################

# Introduction to MySQL LOOP statement

/*
The LOOP statement allows you to execute one or more statements repeatedly.

Here is the basic syntax of the LOOP statement:

[begin_label:] LOOP
    statement_list
END LOOP [end_label]

or 

[label]: LOOP
    ...
    -- terminate the loop
    IF condition THEN
        LEAVE [label];
    END IF;
    ...
END LOOP;
*/

###################### STP_1  ########################


DROP PROCEDURE LoopDemo;

DELIMITER $$
CREATE PROCEDURE LoopDemo()
BEGIN
	DECLARE x  INT;
	DECLARE str  VARCHAR(255);
        
	SET x = 1;
	SET str =  '';
        
	loop_label:  LOOP
		IF  x > 10 THEN 
			LEAVE  loop_label;
		END  IF;
            
		SET  x = x + 1;
		IF  (x mod 2) THEN
			ITERATE  loop_label;
		ELSE
			SET  str = CONCAT(str,x,',');
		END  IF;
	END LOOP;
	SELECT str;
END$$

DELIMITER ;

CALL LoopDemo();

# MySQL WHILE loop statement ----------------------

/*
The WHILE loop is a loop statement that executes 
a block of code repeatedly as long as a condition is true.

Here is the basic syntax of the WHILE statement:

[begin_label:] WHILE search_condition DO
    statement_list
END WHILE [end_label]

*/

CREATE TABLE calendars(
    id INT AUTO_INCREMENT,
    fulldate DATE UNIQUE,
    day TINYINT NOT NULL,
    month TINYINT NOT NULL,
    quarter TINYINT NOT NULL,
    year INT NOT NULL,
    PRIMARY KEY(id)
);

select * from calendars;

###################### STP_1  ########################

DELIMITER $$

CREATE PROCEDURE InsertCalendar(dt DATE)
BEGIN
    INSERT INTO calendars(
        fulldate,
        day,
        month,
        quarter,
        year
    )
    VALUES(
        dt, 
        EXTRACT(DAY FROM dt),
        EXTRACT(MONTH FROM dt),
        EXTRACT(QUARTER FROM dt),
        EXTRACT(YEAR FROM dt)
    );
END$$

DELIMITER ;


###################### STP_2  ########################

DELIMITER $$

CREATE PROCEDURE LoadCalendars(
    startDate DATE, 
    day INT
)
BEGIN
    
    DECLARE counter INT DEFAULT 1;
    DECLARE dt DATE DEFAULT startDate;

    WHILE counter <= day DO
        CALL InsertCalendar(dt);
        SET counter = counter + 1;
        SET dt = DATE_ADD(dt,INTERVAL 1 day);
    END WHILE;

END$$

DELIMITER ;

call LoadCalendars(curdate(), 30)

select curdate()

# MySQL REPEAT Loop -----------------

/*
The REPEAT statement executes one or more statements until a 
search condition is true.

Here is the basic syntax of the REPEAT loop statement:

[begin_label:] REPEAT
    statement
UNTIL search_condition
END REPEAT [end_label]

*/

DELIMITER $$

CREATE PROCEDURE RepeatDemo()
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE result VARCHAR(100) DEFAULT '';
    
    REPEAT
        SET result = CONCAT(result,counter,',');
        SET counter = counter + 1;
    UNTIL counter >= 10
    END REPEAT;
    
    -- display result
    SELECT result;
END$$

DELIMITER ;


CALL RepeatDemo();


# MySQL LEAVE statement

/*

The LEAVE statement exits the flow control that has a given label.

The following shows the basic syntax of the LEAVE statement:
LEAVE label;


If the label is the outermost of the stored procedure  or 
function block, LEAVE terminates the stored procedure or function.
The following statement shows how to use the LEAVE statement 
to exit a stored procedure:

CREATE PROCEDURE sp_name()
sp: BEGIN
    IF condition THEN
        LEAVE sp;
    END IF;
    -- other statement
END$$
*/


DELIMITER $$

CREATE PROCEDURE CheckCredit(
    inCustomerNumber int
)
sp: BEGIN
    
    DECLARE customerCount INT;

    -- check if the customer exists
    SELECT 
        COUNT(*)
    INTO customerCount 
    FROM
        customers
    WHERE
        customerNumber = inCustomerNumber;
    
    -- if the customer does not exist, terminate
    -- the stored procedure
    IF customerCount = 0 THEN
        LEAVE sp;
    END IF;
    
    -- other logic
    -- ...
END$$

DELIMITER ;

# MySQL Stored Function  ----------


/*
The following illustrates the basic syntax for creating a new stored function:

DELIMITER $$

CREATE FUNCTION function_name(
    param1,
    param2,…
)
RETURNS datatype
[NOT] DETERMINISTIC
BEGIN
 -- statements
END $$

DELIMITER ;


A deterministic function always returns 
the same result for the same input parameters whereas 
a non-deterministic function returns different results for the same 
input parameters.

If you don’t use DETERMINISTIC or NOT DETERMINISTIC, 
MySQL uses the NOT DETERMINISTIC option by default.

*/


###################### Functioni_1  ########################

DELIMITER $$

CREATE FUNCTION CustomerLevel(
	credit DECIMAL(10,2)
) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE customerLevel VARCHAR(20);

    IF credit > 50000 THEN
		SET customerLevel = 'PLATINUM';
    ELSEIF (credit >= 50000 AND 
			credit <= 10000) THEN
        SET customerLevel = 'GOLD';
    ELSEIF credit < 10000 THEN
        SET customerLevel = 'SILVER';
    END IF;
	-- return the customer level
	RETURN (customerLevel);
END$$
DELIMITER ;


SELECT 
    customerName, 
    CustomerLevel(creditLimit)
FROM
    customers
ORDER BY 
    customerName;

# creates a new stored procedure that calls the CustomerLevel() stored function:

DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
    IN  customerNo INT,  
    OUT customerLevel VARCHAR(20)
)
BEGIN

	DECLARE credit DEC(10,2) DEFAULT 0;
    
    -- get credit limit of a customer
    SELECT 
		creditLimit 
	INTO credit
    FROM customers
    WHERE 
		customerNumber = customerNo;
    
    -- call the function 
    SET customerLevel = CustomerLevel(credit);
END$$

DELIMITER ;


CALL GetCustomerLevel(-131,@customerLevel);
SELECT @customerLevel;

# MySQL DROP FUNCTION ----------

# DROP FUNCTION [IF EXISTS] function_name;


###########################  Mysql Triggers ###########################

/*

 MySQL, a trigger is a stored program invoked automatically in response 
 To an event such as insert, update, or delete that occurs in the associated table. 
 For example, you can define a trigger that is invoked automatically before a new row 
 is inserted into a table.

MySQL supports triggers that are invoked in response to the
INSERT, UPDATE or DELETE event.


TYPES OF TRIGGER 
1. BEFORE INSERT trigger
2. BEFORE UPDATE trigger 
3. BEFORE DELETE trigger 

4. AFTER INSERT trigger
5. AFTER UPDATE trigger 
6. AFTER DELETE trigger




The trigger body can access the values of the column being affected by the DML statement.
To distinguish between the value of the columns BEFORE and AFTER the DML has fired, 
you use the NEW and OLD modifiers.
For example, if you update the column description, in the trigger body,
you can access the value of the description before the update 
OLD.description and the new value NEW.description.

The following table illustrates the availability of the OLD and NEW modifiers:

Trigger Event	| OLD	| 	NEW   | 
INSERT			| No	| 	Yes   | 
UPDATE			| Yes	| 	Yes   | 
DELETE			| Yes	| 	No    | 


Here is the basic syntax of the CREATE TRIGGER statement:

CREATE TRIGGER trigger_name
{BEFORE | AFTER} {INSERT | UPDATE| DELETE }
ON table_name FOR EACH ROW
trigger_body;

*/


############################# Trigger  1 ###################################

# create table for trigger logs
CREATE TABLE employees_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

# create trigger
CREATE TRIGGER before_employee_update 
    BEFORE UPDATE ON employees
    FOR EACH ROW 
 INSERT INTO employees_audit
 SET action = 'update',
     employeeNumber = OLD.employeeNumber,
     lastname = OLD.lastname,
     changedat = NOW();
     
SHOW TRIGGERS;

select * from employees where employeeNumber = 1056; 
select * from employees_audit;


# update the employees table 
UPDATE employees 
SET 
    lastName = 'Phan'
WHERE
    employeeNumber = 1002;
    
    
SELECT * FROM employees_audit;

############################# 1. MySQL BEFORE INSERT Trigger ###################################
/*

We will create a BEFORE INSERT trigger to maintain a summary table from another table.
*/

# First, create a new table called WorkCenters:
DROP TABLE IF EXISTS WorkCenters;

CREATE TABLE WorkCenters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    capacity INT NOT NULL
);

# Second, create another table called WorkCenterStats that stores the summary of the capacity of the work centers:

DROP TABLE IF EXISTS WorkCenterStats;

CREATE TABLE WorkCenterStats(
    totalCapacity INT NOT NULL
);

DELIMITER $$

CREATE TRIGGER before_workcenters_insert
BEFORE INSERT
ON WorkCenters FOR EACH ROW
BEGIN
    DECLARE rowcount INT;
    
    SELECT COUNT(*) 
    INTO rowcount
    FROM WorkCenterStats;
    
    IF rowcount > 0 THEN
        UPDATE WorkCenterStats
        SET totalCapacity = totalCapacity + new.capacity;
    ELSE
        INSERT INTO WorkCenterStats(totalCapacity)
        VALUES(new.capacity);
    END IF; 

END $$

DELIMITER ;


# First, insert a new row into the WorkCenter table:
INSERT INTO WorkCenters(name, capacity)
VALUES('Mold Machine',100);

# Second, query data from the WorkCenterStats table:
SELECT * FROM WorkCenters;
SELECT * FROM WorkCenterStats;    

INSERT INTO WorkCenters(name, capacity)
VALUES('Packing',200);

SELECT * FROM WorkCenterStats;

############################# 2. MySQL BEFORE UPDATE triggers ###################################

# First, create a new table called sales to store sales volumes:
DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    id INT AUTO_INCREMENT,
    product VARCHAR(100) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    fiscalYear SMALLINT NOT NULL,
    fiscalMonth TINYINT NOT NULL,
    CHECK(fiscalMonth >= 1 AND fiscalMonth <= 12),
    CHECK(fiscalYear BETWEEN 2000 and 2050),
    CHECK (quantity >=0),
    UNIQUE(product, fiscalYear, fiscalMonth),
    PRIMARY KEY(id)
);

# Second, insert some rows into the sales table:
INSERT INTO sales(product, quantity, fiscalYear, fiscalMonth)
VALUES
    ('2003 Harley-Davidson Eagle Drag Bike',120, 2020,1),
    ('1969 Corvair Monza', 150,2020,1),
    ('1970 Plymouth Hemi Cuda', 200,2020,1);
    
# Third, query data from the sales table to verify the insert:
SELECT * FROM sales;

# The following statement creates a BEFORE UPDATE trigger on the sales table.
DELIMITER $$

CREATE TRIGGER before_sales_update
BEFORE UPDATE
ON sales FOR EACH ROW
BEGIN
    DECLARE errorMessage VARCHAR(255);
    SET errorMessage = CONCAT('The new quantity ',
                        NEW.quantity,
                        ' cannot be 3 times greater than the current quantity ',
                        OLD.quantity);
                        
    IF new.quantity > old.quantity * 3 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = errorMessage;
    END IF;
END $$

DELIMITER ;


# First, update the quantity of the row with id 1 to 150:
UPDATE sales 
SET quantity = 150
WHERE id = 1;

# It worked because the new quantity does not violate the rule.
# Second, query data from the sales table to verify the update:
SELECT * FROM sales;

# Third, update the quantity of the row with id 1 to 500:
UPDATE sales 
SET quantity = 500
WHERE id = 1;

SHOW ERRORS;

############################# 3. MySQL BEFORE DELETE Trigger###################################
# First, create a new table called Salaries that stores salary information of employees

DROP TABLE IF EXISTS Salaries;

CREATE TABLE Salaries (
    employeeNumber INT PRIMARY KEY,
    validFrom DATE NOT NULL,
    amount DEC(12 , 2 ) NOT NULL DEFAULT 0
);

# Second, insert some rows into the Salaries table:
INSERT INTO salaries(employeeNumber,validFrom,amount)
VALUES
    (1002,'2000-01-01',50000),
    (1056,'2000-01-01',60000),
    (1076,'2000-01-01',70000);


# Third, create a table that stores the deleted salary:
DROP TABLE IF EXISTS SalaryArchives;    

CREATE TABLE SalaryArchives (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employeeNumber INT,
    validFrom DATE NOT NULL,
    amount DEC(12 , 2 ) NOT NULL DEFAULT 0,
    deletedAt TIMESTAMP DEFAULT NOW()
);

# The following BEFORE DELETE trigger inserts a new row 
# into the SalaryArchives table before a row from the Salaries table is deleted.

DELIMITER $$

CREATE TRIGGER before_salaries_delete
BEFORE DELETE
ON salaries FOR EACH ROW
BEGIN
    INSERT INTO SalaryArchives(employeeNumber,validFrom,amount)
    VALUES(OLD.employeeNumber,OLD.validFrom,OLD.amount);
END$$    

DELIMITER ;

# First, delete a row from the Salaries table:
DELETE FROM salaries 
WHERE employeeNumber = 1002;

# Third, delete all rows from the Salaries table:
DELETE FROM salaries;

select * from salaries;
SELECT * FROM SalaryArchives;

###################################### MySQL Views ######################################
/*
MySQL allows you to create a view based on a SELECT statement that retrieves 
data from one or more tables. 

*/

##################### View 1 ##################################

# This statement uses the CREATE VIEW statement to create a view 
# that represents total sales per order.

CREATE VIEW salePerOrder AS
    SELECT 
        orderNumber, 
        SUM(quantityOrdered * priceEach) total
    FROM
        orderDetails
        
    GROUP by orderNumber
    ORDER BY total DESC;

 # execute a simple SELECT  statement against the SalePerOrder  view as follows:
SELECT * FROM salePerOrder;

##################### View 2 ##################################

# Creating a view based on another view example

# you can create a view called bigSalesOrder based on the 
# salesPerOrder view to show every sales order whose total is 
# greater than 60,000 as follows:

CREATE VIEW bigSalesOrder AS
    SELECT 
        orderNumber, 
        ROUND(total,2) as total
    FROM
        salePerOrder
    WHERE
        total > 60000;
        
# Now, you can query the data from the bigSalesOrder view as follows:
SELECT 
   *
FROM
    bigSalesOrder;
    
##################### View 3 ##################################
    
# Creating a view with join example    


 # CREATE VIEW statement to create a view based on multiple tables. 
 # It uses the INNER JOIN clauses to join tables.

CREATE OR REPLACE VIEW customerOrders AS
SELECT 
    orderNumber,
    customerName,
    SUM(quantityOrdered * priceEach) total
FROM
    orderDetails
INNER JOIN orders o USING (orderNumber)
INNER JOIN customers USING (customerNumber)
GROUP BY orderNumber;


# This statement selects data from the customerOrders view:
SELECT * FROM customerOrders 
ORDER BY total DESC;

##################### View 4 ##################################
# Creating a view with a subquery example

# The view contains products whose buy prices are higher than the 
# average price of all products.

CREATE VIEW aboveAvgProducts AS
    SELECT 
        productCode, 
        productName, 
        buyPrice
    FROM
        products
    WHERE
        buyPrice > (
            SELECT 
                AVG(buyPrice)
            FROM
                products)
    ORDER BY buyPrice DESC;

# This query data from the aboveAvgProducts is simple as follows:

SELECT * FROM aboveAvgProducts;




