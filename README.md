# Data Warehouse and Analytics Project repository
This portfolio project showcases a complete end-to-end data warehousing and analytics solution — from building a data warehouse to delivering actionable business insights. I designed and implemented this project to reflect industry best practices in data engineering, ETL development, data modeling, and analytical reporting.

---

## Data Architecture

This project implements the **Medallion Architecture** pattern, consisting of **Bronze**, **Silver**, and **Gold** layers:

1 **Bronze Layer**:
  Raw data ingested as-is from source systems (CSV files) into SQL Server tables.

2 **Silver Layer**:
  Data cleansing, transformation, and normalization are performed to prepare the data for analysis.

3 **Gold Layer**:
  Business-ready data is structured into a **star schema**, enabling efficient reporting and analytics.
  
---

## Project Overview

This project includes the following key components:

* **Data Architecture**:
  Designing a modern data warehouse using the Medallion Architecture pattern.

* **ETL Pipelines**:
  Building Extract, Transform, Load (ETL) workflows to move and process data from source files into the warehouse.

* **Data Modeling**:
  Creating **fact** and **dimension** tables optimized for performance and analytical queries.

* **Analytics & Reporting**:
  Generating **SQL-based reports** and dashboards to deliver business insights.

---

## Ideal For

This repository is a great resource for professionals and students aiming to showcase or build expertise in:

* SQL Development
* Data Architecture
* Data Engineering
* ETL Pipeline Development
* Data Modeling
* Data Analytics

---

## Project Requirements

### Part 1: Building the Data Warehouse (Data Engineering)

**Objective**:
Develop a modern data warehouse in **SQL Server** to consolidate sales-related data and support analytical reporting.

**Specifications**:

* **Data Sources**: Two systems — ERP and CRM — provided as CSV files.
* **Data Quality**: Cleanse and standardize data before analysis.
* **Integration**: Merge both sources into a unified, user-friendly data model.
* **Scope**: Work with the most recent dataset only (no historization required).
* **Documentation**: Provide clear and concise documentation for both business and technical stakeholders.

---

### Part 2: Analytics & Reporting (Data Analysis)

**Objective**:
Develop analytics using **T-SQL** to uncover key business insights, such as:

* Customer Behavior
* Product Performance
* Sales Trends

These insights are designed to empower stakeholders with data-driven decision-making capabilities.

---
