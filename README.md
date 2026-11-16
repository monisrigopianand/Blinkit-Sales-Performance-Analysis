# Blinkit Sales & Outlet Performance Analysis

An end-to-end retail analytics project using **Excel, SQL Server and Power BI** to analyze product and outlet sales performance.

![Blinkit Sales Dashboard](dashboard_preview.png)

## Project Overview

This project analyzes 8,523 product-outlet sales records (12 columns) to understand how sales vary across product categories, fat content, outlet types, outlet sizes and outlet establishment years. The findings are presented in an interactive Power BI dashboard.

## Tools and Technologies

- **Microsoft Excel / WPS Office:** data inspection and cleaning
- **SQL Server (SSMS) and T-SQL:** database storage and exploratory analysis
- **Power BI and DAX:** measures, KPIs and interactive dashboard

## Workflow

1. **Data cleaning (Excel):** standardized inconsistent Item_Fat_Content labels (LF, low fat, reg), kept records with missing Item_Weight, and checked for fully duplicated rows across all 12 columns (none found).
2. **Database loading (SQL Server):** imported the cleaned CSV into a `blinkit_sales` table and verified the row count.
3. **Exploratory analysis (SQL):** wrote 8 T-SQL queries (1 row-count validation and 7 analytical queries) using aggregation, GROUP BY, PIVOT and window functions.
4. **Dashboard (Power BI):** created 4 explicit DAX measures, KPI cards, slicers and 4 analytical visuals.

## DAX Measures

| Measure | Expression |
|---|---|
| Total Sales | `SUM(blinkit_sales[Sales])` |
| Average Sales | `AVERAGE(blinkit_sales[Sales])` |
| Number of Records | `COUNTROWS(blinkit_sales)` |
| Average Rating | `AVERAGE(blinkit_sales[Rating])` |

## Dashboard

- **KPI cards:** Total Sales, Average Sales, Number of Records, Average Rating
- **Slicers:** Outlet Location Type, Outlet Size, Item Type
- **Visuals:** donut chart (sales by fat content), bar chart (sales by item type), line chart (sales by outlet establishment year), matrix (outlet performance)

## Key Findings

| Metric | Result |
|---|---:|
| Total Sales | 1.20 Million |
| Average Sales per Record | 140.99 |
| Number of Records | 8,523 |
| Average Rating | 3.97 |

- **Fat content:** Low Fat products contributed 64.60% of total sales and Regular products 35.40%.
- **Product categories:** Fruits and Vegetables (178.12K), Snack Foods (175.43K) and Household (135.98K) were the top three by sales.
- **Outlet type:** Supermarket Type1 generated the highest sales (787,549.89, or 65.54% of the total). Grocery Stores had the highest average rating, at about 3.99.
- **Outlet size:** Medium outlets contributed 42.27% of sales, Small 37.01% and High 20.72%.
- **Establishment year:** outlets established in 2018 recorded the highest sales (204,522.26 across 1,463 records).

These are observed patterns in the dataset and do not establish cause and effect.

## Limitations

- The establishment-year chart groups sales by the year an outlet opened. It is not a time-series sales trend.
- "Number of Records" counts product-outlet rows, not distinct products.
- The dataset has no transaction dates, cost data, customer details or delivery data, so profit, seasonality and customer analysis are not possible.

## Repository Contents

- `blinkit_cleaned.csv` – cleaned dataset
- `blinkit_analysis.sql` – SQL queries
- `Blinkit_Dashboard.pbix` – Power BI report
- `dashboard_preview.png` – dashboard screenshot
- `README.md` – this file
