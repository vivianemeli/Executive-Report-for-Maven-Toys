# Maven Toys Executive Report


## Introduction
I’ve just been hired as a data analyst by Maven Toys, a company looking to expand its business by opening new stores. My role is to analyze data to identify interesting patterns and trends, providing executives with a comprehensive overview of high-level metrics to support informed decision-making. My task is to create a single-page visual dashboard that outlines a potential expansion plan, complete with supporting data from my analysis.

![Toystorephotos](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Toystorephotos.png)

## Problem Statement
The first step is to define the problem. The business objectives that I have to tackle are

1. What are the high-level metrics and key performance indicators (KPIs)?
2. Which locations drive the biggest profits, revenue?
3. What cities have the highest inventory turnover rate?
4. How close are we to our target revenue of 10 million naira?


## Data Sourcing
In this project, the dataset used is the Maven Toys Dataset from Maven Analytics. This dataset contains 4 tables, in CSV format:

- The Products table contains the 35 products sold at Maven Toys (each record represents one product), with fields containing details about the product category, cost, and retail price
- The Stores table contains the 50 Maven Toys store locations (each record represents one store), with fields containing details about the store location, type, and date it opened
- The Sales table contains the units sold in over 800,000 sales transactions from January 2017 to October 2018 (each record represents the purchase of a specific product at a specific store on a specific date)
- The Inventory table contains over 1,500 records that represent the stock on hand of each product in each store at the current point in time (Oct 1, 2018)

## Data Importation
The dataset was downloaded in CSV format. I am working on this project with PostgreSQL. The database, schema and the 4 different tables were created in PostgreSQL and the data was imported to the tables created using the COPY statement.

![Screenshot79](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot79.png)

The data has been successfully imported and we now have the four CSV files in PostgreSQL. Next, the data needs to be processed and cleaned to get accurate results. Using messy, inconsistent data leads to inaccurate insights.

## Data Transformation and Cleaning

Data cleaning is a very important step in data analysis. The four tables were checked for duplicates, inconsistencies and other form of impurities. There were no duplicates, missing values or inconsistencies in all 4 tables. The data types and constraints were included in the creation of the tables to ensure correct data types of the data. The store table had mavens toy attached all store name,
![Screenshot80](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot80.png)

This was adjusted with the code below to reduce redundancy as all the stores are already known to be a maven toy store.

![Screenshot99](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot99.png)

After adjustment, maven toys was removed from all store name and the photo below show the new store table.

![Screenshot81](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot81.png)

The dataset is clean and ready for analysis!!!

## Data Analysis
The first question this analysis aims to solve is “What are the important KPIs for executives?”

Executive stakeholders aim to see important KPIs and the summary of the overall growth and information of the company at that period of time. To obtain the total revenue, cost and gross profit, the product table and sales table were joined to obtain information on quantity sold and their respective cost and prices. These information are needed for subsequent analysis hence a temporary table was created to hold these data.

![Screenshot100](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot100.png)

The total revenue, total cost, gross profit and YOY (year over year) growth on revenue are obtained from this table.

![Screenshot82](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot82.png)

![Screenshot86](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot86.png)

![Screenshot83](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot83.png)

To obtain the YOY growth on revenue, a common table expression was use to extract year and month and revenue from the table and a self join used to join the table to itself and YOY was calculated.

![Screenshot101](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot101.png)

![Screenshot85](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot85.png)

Other KPIs obtained are total units sold, number of categories, number of products, number of cities, number of stores and total stodk at hand.

![Screenshot87](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot87.png)

![Screenshot88](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot88.png)

![Screenshot89](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot89.png)

![Screenshot90](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot90.png)

![Screenshot91](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot91.png)

![Screenshot92](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot92.png)

Another question this analysis aims to solve is “Which locations drives the biggest profits, revenue?”

Maven Toys has different numbers of stores in various cities and locations, which means some places naturally bring in more money just because they have more stores. Hence, average was used instead of total profit and revenue to derive cities and locations driving the biggest revenue and profit.

![Screenshot93](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot93.png)

![Screenshot94](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot94.png)

![Screenshot95](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot95.png)

![Screenshot96](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot96.png)

From the analysis above, stores in airport drove more revenues and profit. Further analysis was carried out to show top 5 cities by revenue and profit with locations in airport as this would serve as an insight on exactly where to open new stores.

![Screenshot97](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot97.png)

You can interact with the full SQL code used in this work [here](https://github.com/vivianemeli/Executive-Report-for-MavenToys/blob/main/Documentation/Maven%20Toys%20sql.sql)

## Dashboard/Report
After completing the analysis and calculating the KPIs, the cleaned data was imported into PowerBI by connecting it to PostgreSQL, allowing to create the single-page visual dashboard.

![MavenToysDashboard](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/MavenToysDashboard.png)

The inventory turnover rate for each city was calculated to identify the top five cities that restock their inventory the fastest. This metric helps us understand which locations have the most efficient inventory management and highest product demand, providing valuable insights for making strategic decisions about where to open new stores.

You can interact with this report, click [here](https://app.powerbi.com/groups/me/reports/fdc4a2cc-89e0-40a2-be00-5e2c7b8b9721/5a4dd5e0413710da003a?experience=power-bi)

## Key Insights
1. Year to Date revenue for 2018 is greater that 2017.
2. We are pretty close to the target revenue of 10 million naira which was not achieved in 2017.
3. Stores in airport generates higher revenue and profits on an average.
4. Toys category generates the highest revenue and profit.

## Recommendations
1. --Business Expansion--: News store should be opened in top performing cities without locations in airports as locations in airport has shown to generate more revenue and profit.
2. Also, on business expansion, discount sales or referral bonus should be offered on poor performing categories to improve sales on those categories.
3. Seasonal sales: We’ll need more data over the years to confirm if we have seasonal sales.

![Thankyou](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Thankyou.png)
