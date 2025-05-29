/*
=============================================================================================
Script Purpose:
    This script creates structured tables in the 'silver' schema of the Data Warehouse. 
    The silver layer is responsible for storing cleansed, standardized, and enriched data 
    derived from the raw source data loaded into the bronze layer.

Overview:
    - This script checks if each table already exists in the 'silver' schema.
    - If a table exists, it is dropped and recreated to ensure consistency.
    - Each table includes a 'dwh_create_date' column which captures the load timestamp 
      into the silver layer using GETDATE() as a default value.

Context:
    - The silver layer represents the second stage in the Data Warehouse pipeline, where 
      business rules and transformations can be applied before serving data to reporting 
      or analytics tools in the gold layer.

Tables Created:
    • silver.crm_cust_info       → Cleaned CRM customer data
    • silver.crm_prd_info        → Cleaned CRM product catalog
    • silver.crm_sales_details   → Standardized CRM sales transactions
    • silver.erp_cust_az12       → Parsed ERP customer demographics
    • silver.erp_loc_a101        → Standardized ERP customer locations
    • silver.erp_px_cat_g1v2     → Structured ERP product category data

Notes:
    - Use of `DATETIME2` for the `dwh_create_date` column allows higher precision.
    - Default values ensure that each row is automatically timestamped during insert.
    - This layer serves as the foundation for analytical modeling and reporting.

=============================================================================================
*/

IF OBJECT_ID ('silver.crm_cust_info', 'U') IS NOT NULL                                                                                                                            
	DROP TABLE silver.crm_cust_info;

CREATE TABLE silver.crm_cust_info (
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(50),                                                                                       
	cst_gndr NVARCHAR(50),
	cst_create_date DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID ('silver.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE silver.crm_prd_info;

CREATE TABLE silver.crm_prd_info (
	prd_id	INT,
	cat_id	NVARCHAR(50),
	prd_key	NVARCHAR(50),
	prd_nm	NVARCHAR(50),
	prd_cost INT,	
	prd_line NVARCHAR(50),
	prd_start_dt DATE, 
	prd_end_dt DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);     
                                                                                                           
IF OBJECT_ID ('silver.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE silver.crm_sales_details;

CREATE TABLE silver.crm_sales_details (
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt DATE,
	sls_ship_dt DATE,
	sls_due_dt DATE,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID ('silver.erp_cust_az12', 'U') IS NOT NULL
	DROP TABLE silver.erp_cust_az12;

CREATE TABLE silver.erp_cust_az12 (
	cid NVARCHAR(50),
	bdate DATE,
	gen NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID ('silver.erp_loc_a101', 'U') IS NOT NULL
	DROP TABLE silver.erp_loc_a101;

CREATE TABLE silver.erp_loc_a101 (
	cid NVARCHAR(50),
	cntry NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID ('silver.erp_px_cat_g1v2', 'U') IS NOT NULL
	DROP TABLE silver.erp_px_cat_g1v2;

CREATE TABLE silver.erp_px_cat_g1v2 (
	id NVARCHAR(50),
	cat NVARCHAR(50),
	subcat NVARCHAR(50),
	maintenance NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
