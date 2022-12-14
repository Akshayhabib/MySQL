
 
# WHERE CLAUSE --------------------------------------

/*
The following shows the syntax of the WHERE clause:

SELECT 
    select_list
FROM
    table_name
WHERE
    search_condition;
    
    
# Operator Description

=	Equal to. You can use it with almost any data types.
<> or !=	Not equal to ==
<	Less than. You typically use it with numeric and date/time data types.
>	Greater than.
<=	Less than or equal to
>=	Greater than or equal to

# filtering cluase 

1. AND
2. OR
3. LIKE
4. IN 
5. BETWEEN 
6. LIMIT
7. IS NULL 

*/

# 1. find all employees whose job titles are Sales Rep:
select * from employees;

SELECT 
    lastname, 
    firstname, 
    jobtitle
FROM
    employees
WHERE
    jobtitle = 'Sales Rep';
    
# 2. find employees whose job titles 
# are Sales Rep and office codes 1


SELECT 
    lastname, 
    firstname, 
    jobtitle,
    officeCode
FROM
    employees
WHERE
    jobtitle = 'Sales Rep' AND 
    officeCode = 1;
    


# 3. finds employees whose job title is Sales Rep or employees who locate
# the office with office code 1:
SELECT 
    lastName, 
    firstName, 
    jobTitle, 
    officeCode
FROM
    employees
WHERE
    jobtitle = 'Sales Rep' OR 
    officeCode = 1
ORDER BY 
    officeCode , 
    jobTitle;

# 4. finds employees whose last names end with the string 'son':

# 5 To find employees whose first names start with  T, 
# end with m, and contain any single character between e.g., Tom , Tim T%m

# 6. find all employees whose last names contain on
# 1 %
# 2. _

SELECT 
    firstName, 
    lastName
FROM
    employees
WHERE
    lastName LIKE 'son%'
ORDER BY firstName;

# 5 To find employees whose first names start with  T, 
# end with m, and contain any single character between e.g., Tom , Tim T%m

SELECT 
    employeeNumber, 
    lastName, 
    firstName
FROM
    employees
WHERE
    firstname LIKE 'T__m';
    
# 6. find all employees whose last names contain on
SELECT 
    employeeNumber, 
    lastName, 
    firstName
FROM
    employees
WHERE
    lastname LIKE '%on%';

# 7. finds customers who locate in 
# California, USA, and have the credit limit greater than 100K.

SELECT    
	customername, 
	country, 
	state, 
	creditlimit
FROM    
	customers
WHERE country = 'USA'
	and state = 'CA'
	AND creditlimit > 100000;

    
# 8. finds customers who locate in 
# California or USA, and have the credit limit greater than 10K.
select * from customers;

SELECT 
    customername, country, creditLimit
FROM
    customers
WHERE
    country = 'USA'
        or country = 'France'
        AND creditlimit > 10000;
        
        
# 9. select orders from givin order number (10165,10287,10310) ;
select * from orders; 
 SELECT 
    orderNumber, 
    customerNumber, 
    status, 
    shippedDate
FROM
    orders
WHERE
    orderNumber IN (10165,10287,10310);       
# 10. find products whose buy prices us between  90 and 100:
SELECT 
    productCode, 
    productName, 
    buyPrice
FROM
    products
WHERE
    buyPrice BETWEEN 90 AND 100;  

 -- buyPrice >= 90 AND buyPrice <= 100;
 
 ## DAY_2 END 28/08/2021