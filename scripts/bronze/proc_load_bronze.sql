/*
---------------------------------------------------------
BRONZE LAYER: Bulk Data Import (Prototype)
---------------------------------------------------------
Script Purpose:
	This script describes the process of ERP, MES, IOT, and QMS raw datasets loading from CSV files to PostgreSQL 'bronze' schema using DBeaver Import Data.
	
WARNING:
	This script assumes FIRST import run. For subsequent runs: use TRUNCATE before each import to avoid data duplicates.
----------------------------------------------------	
Files & Targets:
	| CSV File                  | Target Table                 | Delimiter | Encoding |
	|---------------------------|------------------------------|-----------|----------|
	| erp_bom.csv               | bronze.erp_bom               |     ,     |   utf-8  |  
	| erp_products.csv          | bronze.erp_products          |     ,     |   utf-8  | 
	| erp_customers.csv         | bronze.erp_customers         |     ,     |   utf-8  | 
	| mes_production_orders.csv | bronze.mes_production_orders |     ,     |   utf-8  | 
	| mes_plants.csv            | bronze.mes_plants            |     ,     |   utf-8  | 
	| mes_lines.csv             | bronze.mes_lines             |     ,     |   utf-8  | 
    | mes_machines.csv          | bronze.mes_machines          |     ,     |   utf-8  | 
 	| mes_processes.csv         | bronze.mes_processes         |     ,     |   utf-8  | 
	| mes_shifts.csv            | bronze.mes_shifts            |     ,     |   utf-8  | 
	| iot_process_data.csv      | bronze.iot_process_data      |     ,     |   utf-8  | 
	| qms_inspections.csv       | bronze.qms_inspections       |     ,     |   utf-8  | 
	| qms_defect_catalog.csv    | bronze.qms_defect_catalog    |     ,     |   utf-8  | 
----------------------------------------------------
Bulk Import Procedure (repeat for each table):
	For each CSV file, execute DBeaver Import Data operation:
	1. Right-click 'bronze' schema -> Import Data -> CSV.
	2. Select data source path.
	3. Confirm Importer settings.
	4. Verify column mapping (auto-detect).
	5. Confirm Data load settings and proceed. If it is not the first loading select 'Truncate target table(s) before load' to avoid duplicates.
	
	After the import sample data from each table and validate.
*/

-- ERP: 
	-- Products:
	select * from bronze.erp_products
	limit 5;
	-- BOM:
	select * from bronze.erp_bom
	limit 5;
	-- Customers:
	-- Products
	select * from bronze.erp_customers
	limit 5;
--MES:
	-- Production orders:
	select * from bronze.mes_production_orders
	limit 5;
	-- Plants:
	select * from bronze.mes_plants
	limit 5;
	-- Lines:
	select * from bronze.mes_lines
	limit 5;
	-- Machines:
	select * from bronze.mes_machines
	limit 5;
	-- Processes:
	select * from bronze.mes_processes
	limit 5;
	-- Shifts:
	select * from bronze.mes_shifts
	limit 5;
-- IOT:
	-- Process parameters:
	select * from bronze.iot_process_data
	limit 5;
-- QMS:
	-- Inspections:
	select * from bronze.qms_inspections
	limit 5;
	-- Defect Catalog:
	select * from bronze.qms_defect_catalog
	limit 5;
