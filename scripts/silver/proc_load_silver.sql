/*
---------------------------------------------------------
SILVER LAYER: Load Tables
---------------------------------------------------------
Script Purpose:
	This script handles the loading and transformation of ERP, MES, IOT, and QMS data from the 'bronze' layer to the 'silver' layer of 'AutomotiveDataWarehouse' using the sotred procedure.
	If the target table already exists, it is truncated before loading the new dataset.
*/

call silver.load_silver();

create or replace procedure silver.load_silver()
language plpgsql
as $$
begin


	-- ERP: Customers
	truncate table silver.erp_customers;
	insert into silver.erp_customers (customer_code, customer_name, valid_from, valid_to)
	select
	upper(trim(customer_code)) as customer_code,
	upper(trim(customer_name)) as customer_name,
	case when valid_from < '2001-01-01' then null
		else valid_from
	end as valid_from,
	valid_to
	from (select 
		*,
		row_number() over (partition by customer_code order by valid_to desc) as flag_last
	from bronze.erp_customers)t where flag_last = 1;
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	-- ERP: Products
	truncate table silver.erp_products;
	insert into silver.erp_products (product_code, product_base, customer_specific, standard_cycle_time_sec)
	select 
		upper(trim(product_code)) as product_code,
		upper(trim(product_base)) as product_base,
		upper(trim(customer_specific)) as customer_specific,
		standard_cycle_time_sec
	from bronze.erp_products;
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	-- ERP: BOM
	truncate table silver.erp_bom;
	insert into silver.erp_bom (product_code, component_code, component_qty, unit)
	select 
		upper(trim(product_code)) as product_code,
		upper(trim(component_code)) as component_code,
		component_qty ,
		upper(trim(unit)) as unit
	from bronze.erp_bom;
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	-- IOT: Process parameters
	truncate table silver.iot_process_data;
	insert into silver.iot_process_data (iot_id, mes_id, date_hour, temperature_c, pressure_bar, humidity_pct, flow_rate_lpm, stage)
	select
		iot_id,
		mes_id,
		date_hour,
		temperature_c,
		pressure_bar,
		humidity_pct,
		flow_rate_lpm,
		stage
	from bronze.iot_process_data; 
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	-- MES: Lines
	truncate table silver.mes_lines;
	insert into silver.mes_lines (line_code, line_name, plant, production_area)
	select 
		upper(trim(line_code)) as line_code,
		upper(trim(line_name)) as line_name,
		upper(trim(plant)) as plant,
		upper(trim(production_area)) as production_area
	from bronze.mes_lines;
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	-- MES: Machines
	truncate table silver.mes_machines;
	insert into silver.mes_machines (machine_code, machine_name, line_code, process_code, is_active)
	select 
		upper(trim(machine_code)) as machine_code,
		upper(trim(machine_name)) as machine_name,
		upper(trim(line_code)) as line_code,
		upper(trim(process_code)) as process_code,
		case when is_active = 'True' then 'ACTIVE'
			when is_active = 'False' then 'INACTIVE'
		else 'N/A' end as is_active
	from bronze.mes_machines;
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	-- MES: Plants
	truncate table silver.mes_plants;
	insert into silver.mes_plants (plant_code, plant_name, city, country, region)
	select
		upper(trim(plant_code)) as plant_code,
		upper(trim(plant_name)) as plant_name,
		upper(trim(city)) as city,
		upper(trim(country)) as country,
		upper(trim(region)) as region
	from bronze.mes_plants;
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	-- MES: Processes
	truncate table silver.mes_processes;
	insert into silver.mes_processes (process_code, process_name, department, technology_group)
	select 
		upper(trim(process_code)) as process_code,
		upper(trim(process_name)) as process_name,
		upper(trim(department)) as department,
		upper(trim(technology_group)) as technology_group 
	from bronze.mes_processes;
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	-- MES: Production Orders
	truncate table silver.mes_production_orders;
	insert into silver.mes_production_orders (mes_id, production_order, product_code, customer_code, production_line, start_time, end_time, shift,
												planned_qty, produced_qty, produced_pass_qty, scrap_qty, cycle_time_sec)
	select 
		mes_id,
		upper(trim(production_order)) as production_order,
		upper(trim(product_code)) as product_code,
		upper(trim(customer_code)) as customer_code,
		case when upper(trim(production_line)) in ('L2', 'LINE_2') then 'LINE_2'
			when upper(trim(production_line)) in ('L4', 'LINE_4') then 'LINE_4'
			when upper(trim(production_line)) in ('L1', 'LINE_1') then 'LINE_1'
			when upper(trim(production_line)) in ('L3', 'LINE_3') then 'LINE_3'
			else 'UNKNOWN'
		end as production_line,
		start_time,
		end_time,
		case when upper(trim(shift)) in ('2', 'NIGHT') then 'NIGHT_2'
			when upper(trim(shift)) in ('1', 'DAY') then 'DAY_1'
			else 'UNKNOWN'
		end as shift,
		planned_qty,
		produced_qty,
		produced_pass_qty,
		scrap_qty,
		cycle_time_sec
	from bronze.mes_production_orders;
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	-- MES: Shifts
	truncate table silver.mes_shifts;
	insert into silver.mes_shifts (shift_code, shift_name, shift_start_time, shift_end_time, shift_duration_hours)
	select 
		upper(trim(shift_code)) as shift_code,
		upper(trim(shift_name)) as shift_name,
		shift_start_time,
		shift_end_time,
		shift_duration_hours
	from bronze.mes_shifts;
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	-- QMS: Defect Catalog
	truncate table silver.qms_defect_catalog;
	insert into silver.qms_defect_catalog (defect_type, defect_category, defect_code, stage)
	select 
		upper(trim(defect_type)) as defect_type,
		upper(trim(defect_category)) as defect_category,
		upper(trim(defect_code)) as defect_code,
		upper(trim(stage)) as stage
	from bronze.qms_defect_catalog;
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	-- QMS: Inspections
	truncate table silver.qms_inspections;
	insert into silver.qms_inspections (qms_id, production_order, product_code, customer_code, inspection_time, shift, defect_type, defect_code, defect_qty)
	select 
		qms_id,
		upper(trim(production_order)) as production_order,
		upper(trim(product_code)) as product_code,
		upper(trim(customer_code)) as customer_code,
		inspection_time,
		case when upper(trim(shift)) in ('1', 'DAY') then 'DAY_1'
			when upper(trim(shift)) in ('2', 'NIGHT') then 'NIGHT_2'
			else 'UNKNOWN'
		end as shift,
		case when defect_qty = 0 then 'PRODUCT OK'
			when upper(trim(defect_type)) = 'SINK-MARK' then 'SINK_MARK'
			else upper(trim(defect_type))
		end as defect_type,
		case when defect_qty = 0 then 'OK'
			when upper(trim(defect_type)) = 'THIN_COATING' then 'P1'
			when upper(trim(defect_type)) = 'ADHESION_FAILURE' and product_code not like 'DB%' then 'P2'
			when upper(trim(defect_type)) = 'ORANGE_PEEL' then 'P3'
			when upper(trim(defect_type)) = 'DUST_INCLUSION' then 'P4'
			when upper(trim(defect_type)) = 'DELAMINATION' then 'S1'
			when upper(trim(defect_type)) = 'COLOR_VARIATION' then 'S2'
			when upper(trim(defect_type)) = 'ADHESION_FAILURE' and product_code like 'DB%' then 'S3'
			when upper(trim(defect_type)) = 'UNEVEN_SURFACE' then 'S4'
			when upper(trim(defect_type)) = 'SHORT_SHOT' then 'I1'
			when upper(trim(defect_type)) = 'FLASH' then 'I2'
			when upper(trim(defect_type)) = 'WARPING' then 'I3'
			when upper(trim(defect_type)) = 'SINK-MARK' then 'I4'
			when upper(trim(defect_type)) = 'BUBBLE' then 'I5'
			else 'UNKNOWN'
		end as defect_code,
		defect_qty
	from bronze.qms_inspections;
	
end;
$$;