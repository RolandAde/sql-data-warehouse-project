/*
===========================================================================================
Script Purpose:
    This script defines the structure of raw data tables within the 'bronze' schema (layer)
    of a Data Warehouse built for CRM and ERP integration.

Overview:
    The bronze layer acts as the staging area where raw, untransformed data from 
    various source systems is initially loaded. These tables represent different 
    entities such as customer information, product details, sales transactions, 
    customer demographics, location mappings, and product categories.

Tables Created:
    - bronze.crm_cust_info       : Stores basic CRM customer data
    - bronze.crm_prd_info        : Contains product-related metadata from CRM
    - bronze.crm_sales_details   : Sales order details at the line-item level
    - bronze.erp_cust_az12       : ERP customer birthdates and gender
    - bronze.erp_loc_a101        : Country-level location information for customers
    - bronze.erp_px_cat_g1v2     : Product category and subcategory metadata

Note:
    Existing tables are dropped before creation to ensure a clean refresh during development. 
    This should be handled carefully or excluded in production environments.
===========================================================================================
*/


IF OBJECT_ID ('bronze.crm_cust_info', 'U') IS NOT NULL                                                                                                                            
	DROP TABLE bronze.crm_cust_info;

CREATE TABLE bronze.crm_cust_info (
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(50),                                                                                       
	cst_gndr NVARCHAR(50),
	cst_create_date DATE
);

IF OBJECT_ID ('bronze.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;

CREATE TABLE bronze.crm_prd_info (
	prd_id	INT,
	prd_key	NVARCHAR(50),
	prd_nm	NVARCHAR(50),
	prd_cost INT,	
	prd_line NVARCHAR(50),
	prd_start_dt DATETIME,             
);     
                                                                                                           
IF OBJECT_ID ('bronze.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;

CREATE TABLE bronze.crm_sales_details (
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT
);

IF OBJECT_ID ('bronze.erp_cust_az12', 'U') IS NOT NULL
	DROP TABLE bronze.erp_cust_az12;

CREATE TABLE bronze.erp_cust_az12 (
	cid NVARCHAR(50),
	bdate DATE,
	gen NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_loc_a101', 'U') IS NOT NULL
	DROP TABLE bronze.erp_loc_a101;

CREATE TABLE bronze.erp_loc_a101 (
	cid NVARCHAR(50),
	cntry NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_g1v2;

CREATE TABLE bronze.erp_px_cat_g1v2 (
	id NVARCHAR(50),
	cat NVARCHAR(50),
	subcat NVARCHAR(50),
	maintenance NVARCHAR(50)
);


                                                         
