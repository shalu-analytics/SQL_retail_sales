# 📊 [Project Name: Retail Sales Data Analysis]

## 🎯 Project Objective
The primary goals of this project are:
1. **Data Cleaning & Exploration:** Identify and handle missing or null values in the retail dataset to ensure data integrity.
2. **Sales Performance Analysis:** Track revenue trends over time, calculate total sales across different product categories, and pinpoint peak selling periods (months/years).
3. **Customer Demographics Insights:** Segment customers based on age and gender to understand their purchasing behavior and preferences (e.g., top categories by demographic groups).
4. **Operational Efficiency (Shift Analysis):** Categorize sales into hourly shifts (Morning, Afternoon, Evening) to analyze order volume patterns and help optimize store staffing.
5. **High-Value Customer Identification:** Identify top-spending customers to help the marketing team design targeted loyalty programs.

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

## 💡 SQL Query Solutions

### 1. write a sql query to retrieve all customers for sales made on '11/5/2022'

```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

---

### 2. retrieve all transactions where the category is 'clothing' and the quantity sold is more than is in the month of nov-2022 

```sql
SELECT * 
FROM retail_sales
WHERE category = 'clothing' 
  AND quantity > 3
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';
```

---

### 3. Write a SQL query to calculate the total sales for each category.

```sql
SELECT 
    category, 
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;
```

---

### 4.  Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

```sql
SELECT 
    ROUND(AVG(age), 2) AS average_age
FROM retail_sales
WHER category = 'beauty';
```

---

### 5. Write a SQL query to find all transactions where the total sales amount is greater than 1000.

```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

---

### 6. Write a SQL query to find the total number of transactions made by each gender to each category.

```sql
SELECT 
    category, 
    gender, 
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY category ASC;
```

---

### 7. Write a SQL query to calculate the average sale for each month and find out the best-selling month in each year.

```sql
WITH monthly_sales AS (
    SELECT 
        YEAR(sale_date) AS sale_year, 
        MONTH(sale_date) AS sale_month, 
        ROUND(AVG(total_sale), 2) AS avg_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY SUM(total_sale) DESC) as ranking
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
)
SELECT 
    sale_year, 
    sale_month, 
    avg_sale
FROM monthly_sales
WHERE ranking = 1;
```

---

### 8. Write a SQL query to find the top 5 customers based on the highest total sales.

```sql
SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

---

### 9. Write a SQL query to find the number of unique customers who purchased items from each category.

```sql
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales
GROUP BY category
ORDER BY total_customers DESC;
```

---

### 10. Write a SQL query to create each shift and count the number of orders (Morning ≤ 12, Afternoon between 12 & 17, Evening > 17).

```sql
WITH hourly_sales AS (
    SELECT *,
        CASE
            WHEN HOUR(sale_time) <= 12 THEN 'Morning'
            WHEN HOUR(sale_time) > 12 AND HOUR(sale_time) <= 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift
ORDER BY total_orders DESC;
```

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
*   **Tool:** MySQL Workbench 
*   **Language:** SQL (Structured Query Language)
