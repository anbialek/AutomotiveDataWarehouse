/*
---------------------------------------------------------
Create Database and Schemas
---------------------------------------------------------
Script Purpose:
	This script creates a new database named 'AutomotiveDataWarehouse' after checking if it already exists.
	If the database exists, it is dropped and recreated. 
	Additionally, the script sets up three schemas within the database" 'bronze', 'silver', and 'gold'.
	
WARNING:
	This script assumes you are manually connected to the 'postgres' database and have the privileges to drop/create databases and schemas.
	It drops the 'AutomotiveDataWarehouse' database if it exists.
	All data in the database will be permanently delated. 
	Proceed with caution and ensure you have proper backups before running this script.
*/

-- Drop the 'AutomotiveDataWarehouse' database if it exists and then create it.
drop database if exists  "AutomotiveDataWarehouse";
create database "AutomotiveDataWarehouse";


-- Connect to the new database (manual step in most of the PostgreSQL tools).
-- Switch to the 'AutomotiveDataWarehouse' database to execute the following.
-- Create schemas.

drop schema if exists bronze cascade;
create schema bronze;

drop schema if exists silver cascade;
create schema silver;

drop schema if exists gold cascade;
create schema gold;