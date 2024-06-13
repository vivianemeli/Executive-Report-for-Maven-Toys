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
The dataset was downloaded in CSV format. I am working on this project with PostgreSQL. The database, schema and the 4 different tables were created in PostgreSQL using the code below and the data was imported to the tables created using the COPY statement.

![Screenshot79](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot79.png)

The data has been successfully imported and we now have the four CSV files in PostgreSQL. Next, the data needs to be processed and cleaned to get accurate results. Using messy, inconsistent data leads to inaccurate insights.

## Data Transformation and Cleaning

Data cleaning is a very important step in data analysis. The four tables were checked for duplicates, inconsistencies and other form of impurities. There were no duplicates, missing values or inconsistencies in all 4 tables. The data types and constraints were included in the creation of the tables to ensure correct data types of the data. The store table had mavens toy attached all store name,
![Screenshot80](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot80.png)

This was adjusted with the code below to reduce redundancy as all the stores are already known to be a maven toy store.

After adjustment, maven toys was removed from all store name and the photo below show the new store table.

![Screenshot81](https://github.com/vivianemeli/Executive-Report-for-Maven-Toys/blob/main/Documentation/Screenshot81.png)

The dataset is clean and ready for analysis!!!

## Data Analysis
The first question this analysis aims to solve is “What are the important KPIs for executives?”

Executive stakeholders aim to see important KPIs and the summary of the overall growth and information of the company at that period of time. To obtain the total revenue, cost and gross profit, the product table and sales table were joined to obtain information on quantity sold and their respective cost and prices. These information are needed for subsequent analysis hence a temporary table was created to hold these data.

