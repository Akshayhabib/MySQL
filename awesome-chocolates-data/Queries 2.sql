select * from sales;

select * from people;

# we are going to join sales table with people tables

select s.SaleDate,s.Amount,p.Salesperson,s.SPID,p.SPID
from sales as s
join people p on p.SPID= s.SPID;


SELECT 
    s.SaleDate, s.Amount, s.SPID, pr.product
FROM
    sales s
        LEFT JOIN
    products pr ON pr.pid = s.pid;
    
select s.SaleDate,s.Amount,p.Salesperson,pr.product,p.team
from sales as s
join people p on p.SPID= s.SPID
join products pr on pr.pid =s.pid;

select s.SaleDate,s.Amount,p.Salesperson,pr.product,p.team
from sales as s
join people p on p.SPID= s.SPID
join products pr on pr.pid =s.pid
where s.Amount <500
and p.team='Delish';

select s.SaleDate,s.Amount,p.Salesperson,pr.product,p.team
from sales as s
join people p on p.SPID= s.SPID
join products pr on pr.pid =s.pid
where s.Amount <500
and p.team ='';


#people from india or newzealand

select s.SaleDate,s.Amount,p.Salesperson,pr.product,p.team
from sales as s
join people p on p.SPID= s.SPID
join products pr on pr.pid =s.pid
join geo g on g.GeoID= s.GeoID
where s.Amount <500
and p.team =''
and g.Geo in ('New Zealand', 'India')
order by SaleDate;
#=================================================================================================================================================

## Group by

select GeoID,sum(amount),avg(amount),sum(Boxes)
from sales
group by GeoID;

select g.Geo,sum(amount),avg(amount),sum(Boxes)
from sales s
join geo g on s.GeoID=g.GeoID
group by g.Geo;

#############################################

select pr.category,p.team ,sum(boxes),sum(amount)
from sales s
join people p on p.spid=s.spid
join products pr on pr.pid=s.pid
where p.team <> ''
group by pr.Category,p.team
order by pr.Category,p.team;


#total amounts by top 10 products

select pr.Product,sum(s.Amount) as 'Total Amount'
from sales s 
join products pr on pr.pid=s.pid
group by pr.product
order by 'Total Amount ' desc;

select pr.Product,sum(s.Amount) as 'Total Amount'
from sales s 
join products pr on pr.pid=s.pid
group by pr.product
order by 'Total Amount ' desc
limit 10;