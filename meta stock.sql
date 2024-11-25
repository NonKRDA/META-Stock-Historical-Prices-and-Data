SELECT * FROM meta_stock.meta_data;

SELECT Date, Closing_price FROM meta_data;

-- total num of record
SELECT COUNT(*) AS Total_Records FROM meta_data;

-- Retrieve records for a specific date
SELECT * 
FROM meta_stock 
WHERE Date = '03 01 2018';

-- Sort records by Closing_price in descending order:
SELECT Date, Closing_price 
FROM meta_data 
ORDER BY Closing_price DESC;

-- Filter data by price range 
SELECT Date, Closing_price 
FROM meta_data 
WHERE Closing_price BETWEEN 180 AND 190;

-- Calculate the average Closing_price
SELECT ROUND(AVG(Closing_price),2) AS Average_Closing_Price 
FROM meta_data;

-- Find the highest and lowest Closing_price
SELECT MAX(Closing_price) AS Highest_Closing_Price, 
       MIN(Closing_price) AS Lowest_Closing_Price 
FROM meta_data;

-- Count the days when the trading volume was above 10 million
SELECT COUNT(*) AS High_Volume_Days 
FROM meta_data 
WHERE Volume_stock_trade > 10000000;

-- Group data by year and calculate average Closing_price

SELECT SUBSTRING(Date, -4) AS Year, 
       ROUND(AVG(Closing_price),2) AS Avg_Closing_Price 
FROM meta_data 
GROUP BY Year;

-- Find the top 5 days with the highest Closing_price

SELECT Date, Closing_price 
FROM meta_data 
ORDER BY Closing_price DESC
LIMIT 5;

-- Calculate daily price fluctuation and find the top 10 volatile days

SELECT Date, ROUND((Highest_price - Lowest_price),2) AS Price_Fluctuation 
FROM meta_data 
ORDER BY Price_Fluctuation DESC 
LIMIT 10;

-- Calculate the percentage change in Closing_price between consecutive days

SELECT Date, 
       Closing_price, 
       LAG(Closing_price) OVER (ORDER BY Date) AS Previous_Closing_Price, 
       ((Closing_price - LAG(Closing_price) OVER (ORDER BY Date)) / LAG(Closing_price) OVER (ORDER BY Date)) * 100 AS Percentage_Change
FROM meta_data;

-- Previous_Closing_Price: Retrieves the closing price from the previous row based on the Date column (in order).

-- Find the moving average of the Closing_price over the last 7 days

SELECT Date, Closing_price, 
       AVG(Closing_price) OVER (ORDER BY Date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS Seven_Day_Moving_Avg 
FROM meta_data;

-- 6 PRECEDING: Includes the 6 previous rows in the window (if available).
-- CURRENT ROW: Includes the current row in the window.
-- The query calculates the 7-day moving average by taking the average of the Closing_price values from the current row and the 6 rows before it.
-- If there are fewer than 7 rows (e.g., for the first few rows), it calculates the average with the available rows.

-- Find the highest trading volume for each month

SELECT SUBSTRING(Date, 4, 2) AS Month, 
       MAX(Volume_stock_trade) AS Max_Volume 
FROM meta_data 
GROUP BY Month 
ORDER BY Month;

-- Find the cumulative trading volume over time

SELECT Date, 
       Volume_stock_trade, 
       SUM(Volume_stock_trade) OVER (ORDER BY Date) AS Cumulative_Trading_Volume 
FROM meta_data;

-- Analyze monthly average price trends:
SELECT  SUBSTRING(Date, 4, 2) AS Month, ROUND(AVG(Closing_price), 2) AS Avg_Closing_Price 
FROM meta_data 
GROUP BY Month 
ORDER BY Month;



