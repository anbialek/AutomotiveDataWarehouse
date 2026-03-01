/*
---------------------------------------------------------
GOLD LAYER: Create Views
---------------------------------------------------------
Script Purpose:
	This script creates and manages views in the 'gold' layer of the 'AutomotiveDataWarehouse'.
	The views are built based on ERP, MES, IoT, and QMS data from the 'silver' layer of Data Warehouse.

	If a view already exists, it will be replaced.
*/

-- ERP: Products
create or replace view gold.dim_products as 
select 
	product_code as product_id,
	replace (product_base, '_', ' ') as product_category,
	customer_specific as customer_id,
	standard_cycle_time_sec as sv_cycle_time_sec
from silver.erp_products;

------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
-- ERP: Components
create or replace view gold.dim_components as 
select 
	row_number () over (order by product_code, component_code) as component_id,
	product_code as product_id,
	replace (component_code, '_', ' ') as material_name,
	unit,
	component_qty as material_qty
from silver.erp_bom;
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
-- ERP: Customers 
create or replace view gold.dim_customers as 
select 
	customer_code as customer_id,
	customer_name,
	valid_from,
	valid_to
from silver.erp_customers;
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
-- MES: Processes
create or replace view gold.dim_processes as 
select 
	process_code as process_id,
	process_name,
	department,
	technology_group 
from silver.mes_processes;
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
-- MES: Machines
create or replace view gold.dim_machines as 
select 
	machine_code as machine_id,
	machine_name,
	line_code as line_id,
	is_active as status
from silver.mes_machines;
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
-- MES: Plants
create or replace view gold.dim_plants as 
select 
	plant_code as plant_id,
	plant_name,
	city,
	country,
	region 
from silver.mes_plants;
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
-- MES: Lines
create or replace view gold.dim_lines as 
select 
	line_code as line_id,
	line_name,
	plant as plant_id,
	production_area 
from silver.mes_lines;
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
-- MES: Shifts
create or replace view gold.dim_shifts as 
select 
	shift_code as shift_id,
	shift_name,
	shift_start_time,
	shift_end_time,
	shift_duration_hours
from silver.mes_shifts;
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
-- MES: Production Orders
create or replace view gold.fact_production as 
select 
	mes_id,
	production_order,
	product_code as product_id,
	customer_code as customer_id,
	production_line as line_id,
	shift as shift_id,
	start_time as production_start_time,
	end_time as production_end_time,
	planned_qty,
	produced_qty,
	scrap_qty,
	cycle_time_sec as mv_cycle_time_sec
from silver.mes_production_orders
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
-- QMS: Defect Catalog
create or replace view gold.dim_defect_catalog as 
select 
	defect_code as defect_id,
	stage as process_id,
	replace(defect_type, '_', ' ') as defect_name,
	defect_category as defect_level
from silver.qms_defect_catalog
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
-- QMS: Inspections
create or replace view gold.fact_quality as 
select 
	qms_id,
	production_order,
	product_code as product_id,
	customer_code as customer_id,
	shift as shift_id,
	inspection_time,
	defect_code as defect_id,
	defect_qty
from silver.qms_inspections;
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
-- IOT: Process Data
create or replace view gold.fact_process as 
select 
	iot_id,
	mes_id,
	stage as process_id,
	date_hour as reading_time,
	temperature_c,
	pressure_bar,
	humidity_pct,
	flow_rate_lpm 
from silver.iot_process_data;
