# 📊 [Project Name: Retail Sales Data Analysis]

## 🎯 Project Objective
The main objective of this project is to analyze retail transaction data to extract actionable business insights. This includes tracking performance trends, understanding customer purchasing behavior across different times of the day (shifts), and identifying top-performing product categories.

---

## 🗄️ Database Structure & Dataset
The dataset consists of a `Retail_sales` table with the following key columns:
*   `transactions_id` (INT): Unique identifier for each sale.
*   `sale_date` (DATE): Date of the transaction.
*   `sale_time` (TIME): Time of the transaction.
*   'customer_id' (INT):  Unique identifier assigned to each customer.
*   'gender' (VARCHAR(15)): Demographic data representing the customer's gender (e.g., Male, Female).
*   'age' (INT): The age of the customer.
*   `category` (VARCHAR): Product category (e.g.,Beauty, Clothing, Electronics).
*   `quantity` (INT): Number of items sold.
*   'price per unit' (FLOAT): The selling price of a single item/product unit, stored with decimal precision.
*   'cogs' (FLOAT): Cost of Goods Sold.
*   'total_sale' (FLOAT): Total Gross Revenue generated from the transaction.

---

## 💡 Business Problems & SQL Solutions

### 1. write a sql query to retrieve all customers for sales made on '11/5/2022'.
**SQL Query:**
```sql
select *
from retail_sales
where sale_date = '2022-11-05';
'''

---

### 2. retrieve all transactions where the category is 'clothing' and the quantity sold is more than is in the month of nov-2022.
**SQL Query:**
```sql
select * from retail_sales
where category like '%Clothing%' 
and quantiy > 3
and sale_date between '2022-11-01' and '2022-11-30';
'''

---

### 3.  write a sql query to calculate the total sales for each category.
**SQL Query:**
```sql
select category, sum(total_sale) as total_sale 
from retail_sales
group by category;
'''

---

### 4.  write a sql query to find the average age of customers who purchased items from the 'beauty' category.
**SQL Query:**
```sql
select  round(avg(age), 2) as average_age
from  retail_sales
where category = 'beauty'
group by category;
'''

---

### 5.  write a sql query to find all transactions where the total sales is greater than 1000.
**SQL Query:**
```sql
select *
from retail_sales
where total_sale > '1000' ;
'''

---

### 6.  write a sql query to find the total number of transactions made by each gender to each category.
**SQL Query:**
```sql
select 
    category, gender, count(*) as total_transaction
from retail_sales
group by category, gender
order by 1;
'''

---

### 7. write a sql query to calculate the average sale for each month. find out best selling month in each year.
**SQL Query:**
```sql
select 
    year(sale_date) as year, 
    month(sale_date) as month, 
    round(avg(total_sale), 2) as avg_sale
from retail_sales
group by 1,2 
order by 1,3 desc ;
'''

---

### 8. write a sql query to find the top 5 customers bassed on the biggest total sale.
**SQL Query:**
```sql
select customer_id,
   sum(total_sale) as total_sale
from retail_sales
group by 1
order by 2 desc
limit 5;
'''

---

### 9.  write a sql query to find the number of unique customers who purchased items from each category.
**SQL Query:**
```sql
select category,
      count(distinct customer_id) as total_customers
from retail_sales
group by category;
'''

---

### 10. write a sql query to create each shift and number of orders(example morning <=12, afternoon between 12 &17, evening >17).
**SQL Query:**
```sql
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
'''

---

## 📈 Key Insights & Findings
Based on the SQL analysis of the retail sales dataset, here are the major business insights discovered:

1. **Peak Sales Activity (Shift Analysis):** 
   * The majority of customer orders are placed during the **Afternoon shift** (12 PM - 5 PM). 
   * *Business Recommendation:* The operations team should increase staffing and customer support during these peak hours to handle the high volume.

2. **Customer Segmentation & Demographics:**
   * High-value transactions (where total sales > 1000) are heavily driven by specific customer age groups and product categories like **Beauty and Clothing**.
   * *Business Recommendation:* Marketing campaigns for the 'Beauty' category should be targeted precisely towards the average age group identified in the analysis.

3. **Seasonality & High-Volume Trends:**
   * November 2022 showed a significant surge in the **Clothing** category, specifically with bulk purchases (quantities greater than 3). This indicates a strong holiday shopping trend or seasonal promotional success.

4. **Customer Loyalty & Revenue Drivers:**
   * A small segment of top customers (Top 5) contributes significantly to the total gross revenue.
   * *Business Recommendation:* Implementing a loyalty rewards program for these high-spending customers can help maximize customer retention.
---

## 🛠️ Tech Stack & Tools Used
*   **Database Engine:** MySQL 8.0
*   **Tool:** MySQL Workbench / DBeaver
*   **Language:** SQL (Structured Query Language)
