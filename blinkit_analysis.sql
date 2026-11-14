USE BlinkitDB;

SELECT COUNT(*) AS Total_Rows FROM blinkit_sales;

-- 1. OVERALL KPIs (Total Sales, Average Sales, Total Items, Average Rating)
SELECT 
    CAST(SUM(Sales) / 1000000.0 AS DECIMAL(10,2)) AS Total_Sales_Millions,
    CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_sales;

-- 2. TOTAL SALES BY FAT CONTENT (Low Fat vs Regular)
SELECT 
    Item_Fat_Content,
    CAST(SUM(Sales) / 1000.0 AS DECIMAL(10,2)) AS Total_Sales_Thousands,
    CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_sales
GROUP BY Item_Fat_Content
ORDER BY Total_Sales_Thousands DESC;

-- 3. TOP 5 ITEM TYPES BY TOTAL SALES
SELECT TOP 5
    Item_Type,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items
FROM blinkit_sales
GROUP BY Item_Type
ORDER BY Total_Sales DESC;

-- 4. FAT CONTENT SALES ACROSS OUTLET TIERS (Conditional Aggregation)
SELECT 
    Outlet_Location_Type,
    CAST(SUM(CASE WHEN Item_Fat_Content = 'Low Fat' THEN Sales ELSE 0 END) AS DECIMAL(10,2)) AS Low_Fat_Sales,
    CAST(SUM(CASE WHEN Item_Fat_Content = 'Regular' THEN Sales ELSE 0 END) AS DECIMAL(10,2)) AS Regular_Sales
FROM blinkit_sales
GROUP BY Outlet_Location_Type
ORDER BY Outlet_Location_Type;

-- 5. TOTAL SALES BY OUTLET ESTABLISHMENT YEAR (Trend Over Time)
SELECT 
    Outlet_Establishment_Year,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items
FROM blinkit_sales
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year ASC;

-- 6. PERCENTAGE OF SALES BY OUTLET SIZE (Window Function)
SELECT 
    Outlet_Size,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_sales
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

-- 7. SALES BY OUTLET LOCATION TIER (Tier 1, Tier 2, Tier 3)
SELECT 
    Outlet_Location_Type,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_sales
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

-- 8. COMPLETE METRICS BY OUTLET TYPE (Supermarket Type1/2/3 vs Grocery Store)
SELECT 
    Outlet_Type,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
    CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_sales
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;
