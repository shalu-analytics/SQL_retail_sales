-- sql sales database analysis--
create database sql_project_retail_sales;

-- create table--
use sql_project_retail_sales;

create table retail_sales
	(
         transactions_id int primary key,
         sale_date	date,
         sale_time time,
		 customer_id int,
         gender	varchar(15),
         age int,
         category varchar(15),	
         quantiy int,
         price_per_unit	float,
         cogs	float,
         total_sale float
	);

select * from retail_sales;

select 
     count(*)
from retail_sales;

-- Data Exploration --

-- 1) HOW MANY SALES WE HAVE --

SELECT COUNT(*) as total_sales from  retail_sales;

-- 2) how many unique customers we have? --

select COUNT(distinct customer_id) as total_customer from  retail_sales;

-- 3) how many category we have? --

select distinct category as total_category from  retail_sales;

-- Data Analysis -- 

-- 1) write a sql query to retrieve all customers for sales made on '11/5/2022' --

select *
from retail_sales
where sale_date = '2022-11-05';

-- 2) retrieve all transactions where the category is 'clothing' and the quantity sold is more than is
--     in the month of nov- 2022 --

select * from retail_sales
where category like '%Clothing%' 
and quantiy > 3
and sale_date between '2022-11-01' and '2022-11-30'
 ;

-- 3) to calculate the total sales for each category. --

select category, sum(total_sale) as total_sale 
from retail_sales
group by category;

-- 4) to find the average age of customers who purchased items from the 'beauty' category.

select  round(avg(age), 2) as average_age
from  retail_sales
where category = 'beauty'
group by category;

-- 5) to find all transactions where the total sales is greater than 1000.

select *
from retail_sales
where total_sale > '1000' ;

-- 6) to find the total number of transactions made by each gender to each category.

select 
    category, gender, count(*) as total_transaction
from retail_sales
group by category, gender
order by 1;

-- 7) to calculate the average sale for each month. find out best selling month in each year.

select 
    year(sale_date) as year, 
    month(sale_date) as month, 
    round(avg(total_sale), 2) as avg_sale
from retail_sales
group by 1,2 
order by 1,3 desc ;

-- 8) to find the top 5 customers bassed on the biggest total sale.

select customer_id,
   sum(total_sale) as total_sale
from retail_sales
group by 1
order by 2 desc
limit 5;

-- 9) find the number of unique customers who purchased items from each category.

select category,
      count(distinct customer_id) as total_customers
from retail_sales
group by category;

-- 10) to create each shift and number of orders(example morning <=12, afternoon between 12 &17, evening >17)

with hourly_sale
as 
(
select *,
   case
      when hour(sale_time) <12 then 'morning'
	  when hour(sale_time) between 12 and 17 then 'afternoon'
      else 'evening'
   end as shift
from retail_sales
)
select shift,
       count(transactions_id) as total_orders
from hourly_sale
group by shift
order by 2 asc;