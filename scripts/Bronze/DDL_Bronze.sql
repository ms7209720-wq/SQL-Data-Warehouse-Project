
/*
===============================================================================
Bronze Layer: Create Tables and Load Raw Data
===============================================================================
Purpose:
    This script builds the Bronze layer of the data warehouse.
    The Bronze layer holds raw data exactly as it comes from the source
    systems (CRM and ERP), with no cleaning or transformation.

What it does:
    1. Creates 6 Bronze tables (3 from CRM, 3 from ERP).
       If a table already exists, it is dropped and recreated.
    2. Creates a stored procedure (Bronze.loade_Bronze) that empties each
       table and reloads it from a CSV file using BULK INSERT.

Usage:
    EXEC Bronze.loade_Bronze;

Note:
    Update the file paths (E:\Data Warehouse\crm_erp_dataset\) to match
    where the CSV files are stored on your machine.
===============================================================================
*/


-- Create Tables


if OBJECT_ID ('Bronze.crm_cust_info', 'U') is not null
	drop table Bronze.crm_cust_info;

Create table Bronze.crm_cust_info(
	
	cst_id             int,
	cst_key            nvarchar(50),
	cst_firstname      nvarchar(50),
	cst_lastname       nvarchar(50),
	cst_marital_status nvarchar(50),
	cst_gndr           nvarchar(50),
	cst_create_date    date
)
--------------------------------------------------------------------
  
if OBJECT_ID ('Bronze.crm_prd_info', 'U') is not null
	drop table Bronze.crm_prd_info;

create table Bronze.crm_prd_info (

	prd_id       int,
	prd_key      nvarchar(50),
	prd_nm       nvarchar(50),
	prd_cost     int,
	prd_line     nvarchar(50),
	prd_start_dt date,
	prd_end_dt   date
)
--------------------------------------------------------------------
  
if OBJECT_ID ('Bronze.crm_sales_details', 'U') is not null
	drop table Bronze.crm_sales_details;

create table Bronze.crm_sales_details (

	sls_ord_num  varchar(50),
	sls_prd_key  varchar(50),
	sls_cust_id  int,
	sls_order_dt date,
	sls_ship_dt  date,
	sls_due_dt   date,
	sls_sales    decimal(12,2),
	sls_quantity int,
	sls_price    decimal(12,2)
)
----------------------------------------------------------------------
  
if OBJECT_ID ('Bronze.erp_cust_az12', 'U') is not null
	drop table Bronze.erp_cust_az12;

create table Bronze.erp_cust_az12 (

	cid          varchar(50),
	bdate        date,
	gen          varchar(50)
)
----------------------------------------------------------------------

if OBJECT_ID ('Bronze.erp_loc_a101', 'U') is not null
	drop table Bronze.erp_loc_a101;

create table Bronze.erp_loc_a101 (

	cid          varchar(50),
	cntry        varchar(50)
)
----------------------------------------------------------------------

if OBJECT_ID ('Bronze.erp_px_cat_g1v2', 'U') is not null
	drop table Bronze.erp_px_cat_g1v2;

create table Bronze.erp_px_cat_g1v2 (

	id           varchar(50),
	cat          varchar(50),
	aubcat       varchar(50),
	maintenance  varchar(50)          
)

----------------------------------------------------------------------------------------------

-- insertion  

create or alter procedure Bronze.loade_Bronze as
begin
	begin try

			truncate table Bronze.crm_cust_info;


			BULK INSERT Bronze.crm_cust_info
			FROM 'E:\Data Warehouse\crm_erp_dataset\crm_cust_info.csv'
			WITH (
				FORMAT = 'CSV',
				FIRSTROW = 2,
				FIELDQUOTE = '"',
				CODEPAGE = '65001',  -- UTF-8
				TABLOCK
			);


			----------------------------------------------------------

			truncate table Bronze.crm_prd_info;


			BULK INSERT Bronze.crm_prd_info
			FROM 'E:\Data Warehouse\crm_erp_dataset\crm_prd_info.csv'
			WITH (
				FORMAT = 'CSV',
				FIRSTROW = 2,
				FIELDQUOTE = '"',
				fieldterminator = ',',
				CODEPAGE = '65001',  -- UTF-8
				TABLOCK
			);


			-----------------------------------------------------------

			truncate table Bronze.crm_sales_details;

			BULK INSERT Bronze.crm_sales_details
			FROM 'E:\Data Warehouse\crm_erp_dataset\crm_sales_details.csv'
			WITH (
				FORMAT = 'CSV',
				FIRSTROW = 2,
				FIELDQUOTE = '"',
				fieldterminator = ',',
				CODEPAGE = '65001',  -- UTF-8
				TABLOCK
			);


			------------------------------------------------------------

			truncate table Bronze.erp_cust_az12;

			BULK INSERT Bronze.erp_cust_az12
			FROM 'E:\Data Warehouse\crm_erp_dataset\erp_cust_az12.CSV'
			WITH (
				FORMAT = 'CSV',
				FIRSTROW = 2,
				FIELDQUOTE = '"',
				fieldterminator = ',',
				CODEPAGE = '65001',  -- UTF-8
				TABLOCK
			);


			------------------------------------------------------------

			truncate table Bronze.erp_loc_a101;

			BULK INSERT Bronze.erp_loc_a101
			FROM 'E:\Data Warehouse\crm_erp_dataset\erp_loc_a101.CSV'
			WITH (
				FORMAT = 'CSV',
				FIRSTROW = 2,
				FIELDQUOTE = '"',
				fieldterminator = ',',
				CODEPAGE = '65001',  -- UTF-8
				TABLOCK
			);


			-------------------------------------------------------------

			truncate table Bronze.erp_px_cat_g1v2;

			BULK INSERT Bronze.erp_px_cat_g1v2
			FROM 'E:\Data Warehouse\crm_erp_dataset\erp_px_cat_g1v2.CSV'
			WITH (
				FORMAT = 'CSV',
				FIRSTROW = 2,
				FIELDQUOTE = '"',
				fieldterminator = ',',
				CODEPAGE = '65001',  -- UTF-8
				TABLOCK
			);

	end try

	begin catch 
	end catch

end;
----------------------------------
