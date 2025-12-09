
# COVID-19 DATA ANALYSIS

A complete end-to-end data analysis project covering data cleaning, SQL analytics, Power BI dashboarding, and machine-learning prediction.
The project analyzes 829M COVID cases, 388M recoveries, 43M deaths, covering 187 countries, 6 WHO regions, and 188 days.

## PROJECT OVERVIEW


This project provides a complete analysis of worldwide COVID-19 trends using:

•	SQL → Data cleaning, transformation & analytics

•	Power BI → Interactive dashboard & visual insights

•	Python (ML) → Predictive modeling using Linear Regression

•	R-value = 0.54 → Medium correlation, model captures partial trend but affected by global variability.

The dashboard highlights trends in confirmed cases, deaths, recoveries, active cases, and regional comparisons.

## TOOLS

Database - MySQL

Data Analysis - SQL

Visualization - Power BI

Language - Python, Pandas, Numpy, Scikit-learn, Matplotlib, Linear Regression (R = 0.54)

## SQL Data Cleaning

•	Removed duplicates

•	Standardized date formats

•	Handled NULL values

•	Filled missing unemployment / region data

•	Joined WHO region + country + case dataset

•	Created daily, weekly, monthly aggregations

## Python Machine Learning Prediction

Model Used: Linear Regression

Target Variable: New Cases

Independent Variables:
Date, Confirmed, Recovered, Deaths, Region (encoded), Country (encoded), etc.

📉 Model Performance

•	R-Value: 0.54

•	Indicates medium correlation

•	COVID data has high randomness → perfect prediction is not possible

•	Model captures basic upward/downward trends


## Run Locally

1. SQL
Import the dataset → Run the cleaning queries → Execute analysis queries.

2. Python
Install dependencies:

pip install pandas numpy scikit-learn matplotlib

Run the ML script to train the model and generate predictions.

3. Power BI

Open .pbix file → Refresh → Interact with visuals.


