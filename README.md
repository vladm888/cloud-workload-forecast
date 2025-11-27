# Cloud Workload Forecasting — CPU Usage Analysis & 10-Year Prediction
This project implements an enterprise-grade, end-to-end data pipeline for analyzing and forecasting cloud CPU usage using Python, SQL, feature engineering, visualization, and machine learning.

## Executive Summary
This solution demonstrates a full cloud workload analytics workflow: ingestion, cleaning, relational storage, SQL analytics, ML feature engineering, regression modeling, and long-term capacity forecasting. It is designed with enterprise best practices for reproducibility, governance, and scalability.

## Architecture Overview
Raw CSV → Data Cleaning (pandas) → SQLite Database (SQLAlchemy) → SQL Analytics → Feature Engineering → ML Model → 10-Year Forecast → Visual Reports
## Dataset & Schema
The dataset contains:
- CPU usage (MHz)
- CPU capacity provisioned (MHz)
- Memory usage (KB)
- Disk throughput (KB/s)
- Network throughput (KB/s)
- Timestamps

Normalized schema:
date, cpu_usage_mhz, cpu_capacity_provisioned_mhz, memory_usage_kb, disk_read_throughput_kbs, disk_write_throughput_kbs, network_received_throughput_kbs, network_transmitted_throughput_kbs, label, count

## SQL Analytics Layer
Examples:
SELECT DATE(date) AS day, ROUND(AVG(cpu_usage_mhz),2) AS avg_cpu FROM workload GROUP BY day ORDER BY day;

SELECT ROUND(AVG(cpu_usage_mhz),2), ROUND(AVG(memory_usage_kb),2) FROM workload;

Full SQL library provided in queries.sql.

## Machine Learning Pipeline
Features engineered:
- day (day-of-year)
- hour (hour-of-day)
- lag_cpu (previous CPU reading)
- cpu_capacity_provisioned_mhz

Trained using Linear Regression. Evaluated using MAE & R². Supports extension to RandomForest, GBM, LSTM, Prophet.

## Forecasting Engine
Generates a recursive 10-year projection. Outputs:
- cpu_forecast_10_years_yearly.csv
- cpu_usage_forecast_10years.png

## Project Structure
cloud-workload-forecast/
- cloud_usage_forecast.ipynb
- cloud_workload.csv
- cloud_workload.db
- cpu_usage.png
- cpu_usage_forecast_100points.png
- cpu_usage_forecast_10years.png
- cpu_forecast_10_years_yearly.csv
- queries.sql
- requirements.txt
- README.md

## Installation
pip install -r requirements.txt  
jupyter notebook cloud_usage_forecast.ipynb
## Governance & Data Quality
- schema normalization
- timestamp validation
- deduplication
- missing value cleanup
- type enforcement
- consistent naming conventions

## Dependencies
pandas, sqlalchemy, matplotlib, seaborn, scikit-learn, jupyter

## Author
Vlad — Cloud Data & Machine Learning Engineering Enthusiast
