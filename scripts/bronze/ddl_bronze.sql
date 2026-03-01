/*
---------------------------------------------------------
BRONZE LAYER: Create Tables
---------------------------------------------------------
Script Purpose:
	This script creates empty tables in the 'bronze' layer of the 'AutomotiveDataWarehouse' database, defining the expected data type for each column.
    If a table already exists, it is dropped and recreated.
*/

drop table if exists bronze.erp_products;
create table bronze.erp_products (
	product_code varchar(10),
	product_base varchar(50),
	customer_specific varchar(10),
	standard_cycle_time_sec numeric(10,1)
);

drop table if exists bronze.erp_bom;
create table bronze.erp_bom (
	product_code varchar(10),
	component_code varchar(50),
	component_qty numeric(10,3),
	unit varchar(10)
);

drop table if exists bronze.erp_customers;
create table bronze.erp_customers (
	customer_code varchar(10),
	customer_name varchar(50),
	valid_from date,
	valid_to date
);

drop table if exists bronze.mes_production_orders;
create table bronze.mes_production_orders (
	mes_id int,
	production_order varchar(10),
	product_code varchar(10),
	customer_code varchar(10),
	production_line varchar(10),
	start_time timestamp,
	end_time timestamp,
	shift varchar(10),
	planned_qty int,
	produced_qty int,
	produced_pass_qty int,
	scrap_qty int,
	cycle_time_sec numeric(10,1)
);

drop table if exists bronze.mes_plants;
create table bronze.mes_plants(
	plant_code varchar(10),
	plant_name varchar(10),
	city varchar(50),
	country varchar(50),
	region varchar(50)
);

drop table if exists bronze.mes_lines;
create table bronze.mes_lines (
	line_code varchar(10),
	line_name varchar(50),
	plant varchar(10),
	production_area varchar(50)
);

drop table if exists bronze.mes_machines;
create table bronze.mes_machines (
	machine_code varchar(10),
	machine_name varchar(50),
	line_code varchar(10),
	process_code varchar(10),
	is_active varchar(10)
);

drop table if exists bronze.mes_processes;
create table bronze.mes_processes (
	process_code varchar(10),
	process_name varchar(50),
	department varchar(50),
	technology_group varchar(50)
);

drop table if exists bronze.mes_shifts;
create table bronze.mes_shifts (
	shift_code varchar(10),
	shift_name varchar(50),
	shift_start_time varchar(50),
	shift_end_time varchar(50),
	shift_duration_hours numeric(10,1)
);

drop table if exists bronze.iot_process_data;
create table bronze.iot_process_data (
	iot_id int,
	mes_id int,
	date_hour timestamp,
	temperature_c numeric(10,1),
	pressure_bar numeric(10,2),
	humidity_pct numeric(10,2),
	flow_rate_lpm numeric(10,2),
	stage varchar(10)
);

drop table if exists bronze.qms_inspections;
create table bronze.qms_inspections (
	qms_id int,
	production_order varchar(10),
	product_code varchar(10),
	customer_code varchar(10),
	inspection_time timestamp,
	shift varchar(10),
	defect_type varchar(50),
	defect_qty int
);

drop table if exists bronze.qms_defect_catalog;
create table bronze.qms_defect_catalog (
	defect_type varchar(50),
	defect_category varchar(10),
	defect_code varchar(10),
	stage varchar(50)
);