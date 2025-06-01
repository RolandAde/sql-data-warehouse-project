/*
==========================================================================================
Script: Create Gold Layer Views (dim_customers, dim_products, fact_sales)

Purpose:
    Defines the star schema for analytical workloads by transforming curated Silver Layer 
    data into dimensional views for reporting and BI consumption.

Views Created:
    1. gold.dim_customers - Customer dimension with personal, demographic, and location info
    2. gold.dim_products  - Product dimension enriched with category and maintenance data
    3. gold.fact_sales    - Sales fact table linked to customers and products

Key Transformations:
    - Surrogate keys via ROW_NUMBER for star schema compatibility
    - Enrichment via joins with ERP reference data
    - Gender, country, and category normalization
    - Filtering active product records only (prd_end_dt IS NULL)

Dependencies:
    - silver.crm_cust_info, silver.erp_cust_az12, silver.erp_loc_a101
    - silver.crm_prd_info, silver.erp_px_cat_g1v2
    - silver.crm_sales_details

Usage:
    These views are designed for analytical queries and can serve as source tables for 
    Power BI, Tableau, or reporting tools.
==========================================================================================
*/



CREATE VIEW gold.dim_customers AS
SELECT
	ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
	ci.cst_id AS customer_id,
	ci.cst_key  AS customer_number,
	ci.cst_firstname AS first_name,
    ci.cst_lastname AS last_name,
	la.cntry AS country,
    ci.cst_marital_status As marital_status,
    CASE
		WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr -- CRM is the master for gender info
		ElSE COALESCE(ca.gen, 'n/a')
	END AS gender,
	ca.bdate AS birthdate,
    ci.cst_create_date AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON ci.cst_key = la.cid


CREATE VIEW gold.dim_products AS
SELECT
	ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,
	pn.prd_id AS product_id,
	pn.prd_key AS product_number,
	pn.prd_nm AS product_name,
    pn.cat_id AS category_id,
	pc.cat AS category,
	pc.subcat AS subcategory,
	pc.maintenance,
    pn.prd_cost AS cost,
    pn.prd_line AS product_line,
    pn.prd_start_dt AS start_date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL


CREATE VIEW gold.fact_sales AS
SELECT
	sd.sls_ord_num AS order_number,
	pr.product_key,
	cu.customer_key,
    sd.sls_order_dt AS order_date,
    sd.sls_ship_dt AS shipping_date,
    sd.sls_due_dt AS due_date,
    sd.sls_sales AS sales_amount,
    sd.sls_quantity AS quantity,
    sd.sls_price As price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
ON sd.sls_cust_id = cu.customer_id
