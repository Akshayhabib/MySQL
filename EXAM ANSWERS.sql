create database exam;
use `exam`;
select* from bank_customer;
select* from orders;
select* from salesman;
select* from customer;
# #	1. Write a SQL query which will sort out the customer and their grade who made an order. 
#	Every customer must have a grade and be served by at least one seller, who belongs to a region.
SELECT 
    customer.cust_name AS 'Customer', 
    customer.grade AS 'Grade'
FROM
    orders,
    salesman,
    customer
WHERE
    orders.customer_id =customer.custemor_id
        AND orders.salesman_id = salesman.salesman_id
        AND salesman.city IS NOT NULL
        AND customer.grade IS NOT NULL;

#2. Write a query for extracting the data from the order table for the salesman who earned the maximum commission.
#rough work.
SELECT 
                    MAX(commision)
                FROM
                    salesman;
SELECT 
    ord_no, purch_amt, ord_date, salesman_id
FROM
    orders
WHERE
    salesman_id IN (SELECT 
            salesman_id
        FROM
            salesman
        WHERE
            commision = (SELECT 
                    MAX(commision)
                FROM
                    salesman));
                    
# 3. From orders retrieve only ord_no, purch_amt, ord_date, ord_date, salesman_id where salesman’s city is Nagpur
#	(Note salesman_id of orders table must be other than the list within the IN operator.)
SELECT 
    orders.ord_no,
    orders.purch_amt,
    orders.ord_date,
    orders.salesman_id,
    salesman.city
FROM
    orders
        INNER JOIN
    salesman ON orders.salesman_id = salesman.salesman_id
WHERE
    salesman.city = 'nagpur'; 
    #	4. Write a query to create a report with the order date in such a way that the latest order date will come 
#	last along with the total purchase amount and the total commission for that date is (15 % for all sellers).

SELECT 
    ord_date, SUM(purch_amt), SUM(purch_amt) * .15
FROM
    orders
GROUP BY ord_date
ORDER BY ord_date; 

#5. Retrieve ord_no, purch_amt, ord_date, ord_date, salesman_id from Orders table and 
#display only those sellers whose purch_amt is greater than average purch_amt.

SELECT *
FROM orders
WHERE purch_amt >
    (SELECT  AVG(purch_amt) 
     FROM orders);
     
     # 6. Write a query to determine the Nth (Say N=5) highest purch_amt from Orders table.  
     
 SELECT 
    *
FROM
    orders;
    
 SELECT 
 purch_amt
FROM
 orders
ORDER BY ROUND(purch_amt) DESC
LIMIT 4 , 1;

#	7. What are Entities and Relationships?
# ANSWER :ENTITIES : An entity is an object that exists. It doesn't have to do anything; it just has to exist.
# In database administration, an entity can be a single thing, person, place, or object.
# Data can be stored about such entities.
# Relationship:A Relationship is a type of association that can exist between two different (or same) entity types.
# For example, Two different or same ,entities or tables can be related.

 #8. Print customer_id, account_number and balance_amount, condition that if balance_amount is 
# nil then assign transaction_amount for account_type = "Credit Card"    
SELECT*FROM bank_account_details;
SELECT 
 bd.Customer_id,
 bd.Account_Number,
 CASE
 WHEN
 bd.Balance_amount = 0
 AND bd.Account_type = 'credit card'
 THEN
 bt.Transaction_amount
 WHEN bd.Balance_amount != 0 THEN bd.Balance_amount
 END AS New_balance_amount
FROM
 bank_account_details bd
 LEFT JOIN
 bank_account_transaction bt ON bd.Account_Number = bt.Account_Number;
 
 # 9. Print customer_id, account_number, balance_amount, conPrint account_number, 
# balance_amount, transaction_amount from Bank_Account_Details and bank_account_transaction 
# for all the transactions occurred during march, 2020 and april, 2020.
SELECT*FROM bank_account_details;
SELECT 
    ba.customer_id,
    ba.account_number,
    ba.balance_amount,
    bt.transaction_amount,
    bt.transaction_date
FROM
    Bank_Account_Details ba
        JOIN
    bank_account_transaction bt ON ba.Account_Number = bt.Account_Number
WHERE
    bt.Transaction_Date BETWEEN '2020-03-01' AND '2020-04-30';
 
 # 10. Print all of the customer id, account number, balance_amount, transaction_amount from 
# bank_cutomer, bank_account_details and bank_account_transactions tables where excluding all of 
# their transactions in march, 2020 month .
# 10. Print all of the customer id, account number, balance_amount, transaction_amount from 
# bank_cutomer, bank_account_details and bank_account_transactions tables where excluding all of 
# their transactions in march, 2020 month .
SELECT 
bd.Account_Number,
 bd.Customer_id,bt.Transaction_Date,
 bt.Transaction_amount,
 bd.Balance_amount
 
 
FROM
 bank_account_details bd
 JOIN
 bank_customer bc ON bd.Customer_id = bc.customer_id
 JOIN
 bank_account_transaction bt ON bd.Account_Number = bt.Account_Number
WHERE
 bt.Transaction_Date NOT BETWEEN '2020-03-01' AND '2020-03-31';