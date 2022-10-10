select * from sales;

SELECT 
    SaleDate, Amount, Customers
FROM
    sales;

#calculations in queries

select SaleDate,Amount,Boxes,Amount/Boxes from sales;

select SaleDate,Amount,Boxes,Amount/Boxes as'Amount per boxes' from sales;


#where clause

select * from sales
where Amount > 10000;


#order by clause
select * from sales
where Amount > 10000
order by Amount desc;


select * from sales
where GeoID='g1'

order by PID,Amount desc;

# so where clause is like filtering in excel &  order by is like sorting the data in excel

# Q. we want see all the results all the sales where the value is more than 10000  and year should be 2022

select * from sales
where amount >1000 and SaleDate >='2022-01-01';

select SaleDate,Amount from sales
where amount>10000 and year(SaleDate)=2022
order by Amount desc;

#Q find out all the sales where the number of boxes is between 0 to 50

select * from sales
where boxes >0 and boxes <=50;


select * from sales 
where boxes between 0 and 50;

#  We want to see all the sales or all the shipments are happening on the fridays

select SaleDate,Amount,Boxes, weekday(SaleDate) as  'Day of week'
 from sales 
 where weekday(SaleDate)=4;
 
 
 select * from people
where team='delish' or team='jucies';
 
 # In clause
 select * from people
 where team in ('delish','jucies');
 
 
 #pattern matching
 
 select * from people
 where Salesperson like '%B%';
 
 
 #case operator
 # instead of seeing all the sales and the amount  values i want to add an amount category as a column 
 # where any amount upto  1000 dollars will have an extra label here that says under 1000 dollars 
 #and between 1000 to 5000 we will have label that says under 5000 dollars and so on
 
 select * from sales;
 
 
SELECT 
    SaleDate,
    Amount,
    CASE
        WHEN amount < 1000 THEN 'under 1k'
        WHEN amount < 5000 THEN 'under 5k'
        WHEN amount < 10000 THEN 'under 10k'
        ELSE '10k or more'
    END AS 'amount category'
FROM
    sales; 
    
#this is very helpful especially when you're trying to build some categorization based on your data
#either using numeric values like above example  or text values so that you could then either display it ine screen
# or use it to build where condition or map it out to another table 

#==============================================================================================================


 
 
 
 
 
 



