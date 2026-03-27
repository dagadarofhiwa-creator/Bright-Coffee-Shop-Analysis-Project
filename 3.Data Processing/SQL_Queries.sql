--1---Running the entire table
select *
FROM `casestudy`.`brightcoffee`.`bright_coffee_shop1`
--2----checking Date range---- duration is 6 Months
SELECT MIN(transaction_date) AS Min_date,
       MAX(transaction_date) AS Max_date
FROM `casestudy`.`brightcoffee`.`bright_coffee_shop1`

--3---checking different store locations ---------  3 store locations
SELECT DISTINCT store_location
FROM `casestudy`.`brightcoffee`.`bright_coffee_shop1`

--4---Checking different product sold at our stores ----9 product sold
SELECT DISTINCT product_category
FROM `casestudy`.`brightcoffee`.`bright_coffee_shop1`

--5----Checking different types of products sold at our stores  --------- 29 different product
SELECT DISTINCT product_type
FROM `casestudy`.`brightcoffee`.`bright_coffee_shop1`

--6--checking product detail sold at our stores  ----80 product details

SELECT DISTINCT product_detail
FROM `casestudy`.`brightcoffee`.`bright_coffee_shop1`

--7--checking for NULLS
SELECT *
FROM `casestudy`.`brightcoffee`.`bright_coffee_shop1`
WHERE unit_price IS NULL 
OR transaction_qty IS NULL
OR transaction_date  IS NULL

--8---Checking Minimum and Maximum unit price

SELECT MAX(unit_price)  AS Max_price,
      MIN(unit_price)  AS Min_price
FROM `casestudy`.`brightcoffee`.`bright_coffee_shop1`

--9--EXtracting Day,Month and Day of Month
SELECT 
transaction_date,
Dayname(transaction_date) AS Day_name,
monthname(transaction_date) AS Month_name,
Dayofmonth(transaction_date) AS Day_of_month
FROM `casestudy`.`brightcoffee`.`bright_coffee_shop1`
---10--Calcluate Revenue
SELECT unit_price,
       transaction_qty,
       (transaction_qty*unit_price) AS Revenue
FROM `casestudy`.`brightcoffee`.`bright_coffee_shop1`
--11  Combining functions to get a clean dataset 
SELECT 
transaction_id,
transaction_date,
transaction_time,
transaction_qty,
store_id,
store_location,
product_id,
unit_price,
product_category,
product_type,
product_detail,
----EXtracting by Day,Month and Day_of_Month
Dayname(transaction_date) AS Day_name,
Monthname(transaction_date) AS Month_name,
Dayofmonth(transaction_date) AS Day_of_Month,

----Day Classification 
CASE 
  WHEN Dayname(transaction_date) IN ('Sun','Sat') THEN 'Weekend'
  ELSE 'Weekday'
  END AS Day_classification,
-----Time Classification
CASE
 WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN  '06:00:00' AND '11:59:59' THEN '01 Morning'
 WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN  '12:00:00' AND '16:59:59' THEN '02 Afternoon'
 WHEN date_format(transaction_time,'HH:mm:ss') >= '17:00:00'  THEN '03.Evening'
   END AS time_Classification,
   
--spend busket
CASE
WHEN (transaction_qty*unit_price)<=50 THEN '01.Low Spender'
WHEN (transaction_qty*unit_price) BETWEEN 51 AND 200 THEN '02.Medium Spender'
WHEN (transaction_qty*unit_price) BETWEEN 201 AND 300 THEN '03.Big Spender'
ELSE  '04.Biggest Spender'
END AS Spend_busket,

   ------Revenue
(transaction_qty*unit_price) AS Revenue

FROM `casestudy`.`brightcoffee`.`bright_coffee_shop1`
GROUP BY ALL
ORDER BY Revenue DESC;