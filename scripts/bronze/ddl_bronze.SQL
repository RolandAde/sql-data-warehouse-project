/*
=============================================================================================
Script Name:     bronze.load_bronze
Script Type:     Stored Procedure
Layer:           Bronze (Raw Data Ingestion)
---------------------------------------------------------------------------------------------
Purpose:
    This stored procedure automates the ingestion of raw data into the Bronze layer of the 
    Data Warehouse using SQL Server's BULK INSERT.

Overview:
    The Bronze layer is the initial landing zone for raw, untransformed data from various 
    source systems including CRM and ERP platforms. This script performs the following tasks:

        • Truncates each staging table in the 'bronze' schema to clear old data.
        • Loads fresh data from structured CSV files using efficient BULK INSERT operations.
        • Logs the duration of each data load step for monitoring purposes.
        • Captures and prints error messages in case of failure.

Source Systems & Files:
    - CRM:
        ▪ cust_info.csv       → Customer master data
        ▪ prd_info.csv        → Product catalog
        ▪ sales_details.csv   → Sales transactions

    - ERP:
        ▪ CUST_AZ12.csv       → Customer demographics
        ▪ LOC_A101.csv        → Customer location info
        ▪ PX_CAT_G1V2.csv     → Product category metadata
		
Key Notes:
    - BULK INSERT improves performance for large file ingestion.
    - TRUNCATE TABLE ensures clean reloads and is faster than DELETE.
    - `TABLOCK` hints optimize bulk loading speed.
    - File paths must be accessible to the SQL Server instance (consider UNC paths if remote).
    - Suitable for development or batch refresh processes; should be adapted for production.
=============================================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		PRINT '===================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '===================================================';

		PRINT '---------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '---------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\HP\Desktop\My Data Science Journey\SQL\Microsoft SQL Server\Queries\Portfolio Project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2, --Table has headers
			FIELDTERMINATOR = ',', --Delimiter
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'second';
		PRINT '>> -------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\HP\Desktop\My Data Science Journey\SQL\Microsoft SQL Server\Queries\Portfolio Project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2, --Table has headers
			FIELDTERMINATOR = ',', --Delimiter
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'second';
		PRINT '>> -------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\HP\Desktop\My Data Science Journey\SQL\Microsoft SQL Server\Queries\Portfolio Project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2, --Table has headers
			FIELDTERMINATOR = ',', --Delimiter
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'second';
		PRINT '>> -------------';

		PRINT '---------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '---------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_CUST_AZ12';
		TRUNCATE TABLE bronze.erp_CUST_AZ12;

		PRINT '>> Inserting Data Into: bronze.erp_CUST_AZ12';
		BULK INSERT bronze.erp_CUST_AZ12
		FROM 'C:\Users\HP\Desktop\My Data Science Journey\SQL\Microsoft SQL Server\Queries\Portfolio Project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2, --Table has headers
			FIELDTERMINATOR = ',', --Delimiter
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'second';
		PRINT '>> -------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_LOC_A101';
		TRUNCATE TABLE bronze.erp_LOC_A101;

		PRINT '>> Inserting Data Into: bronze.erp_LOC_A101';
		BULK INSERT bronze.erp_LOC_A101
		FROM 'C:\Users\HP\Desktop\My Data Science Journey\SQL\Microsoft SQL Server\Queries\Portfolio Project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2, --Table has headers
			FIELDTERMINATOR = ',', --Delimiter
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'second';
		PRINT '>> -------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_PX_CAT_G1V2';
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;

		PRINT '>> Inserting Data Into: bronze.erp_PX_CAT_G1V2';
		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM 'C:\Users\HP\Desktop\My Data Science Journey\SQL\Microsoft SQL Server\Queries\Portfolio Project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2, --Table has headers
			FIELDTERMINATOR = ',', --Delimiter
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> -------------';

		SET @batch_end_time = GETDATE();
		PRINT '========================================================';
		PRINT 'Loading Bronze Layer is Completed';
		PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';
		PRINT '========================================================';
	END TRY
	BEGIN CATCH
		PRINT '========================================================';
		PRINT '	ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT '	ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT '	ERROR MESSAGE' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT '	ERROR MESSAGE' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '========================================================';
	END CATCH
END
