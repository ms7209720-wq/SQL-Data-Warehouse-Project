/*
USE master;
This sets the current database context to `master`, which is the system database used for server-level tasks.

CREATE DATABASE DataWarehouse;  
This creates a new database named `DataWarehouse`.

USE DataWarehouse;  
This switches the current database context to the newly created `DataWarehouse` database.

CREATE SCHEMA Bronze;  
This creates the `Bronze` schema, typically used to store raw data as it arrives from source systems.

CREATE SCHEMA Silver 
This creates the `Silver` schema, typically used for cleaned and standardized data.

CREATE SCHEMA Gold;
This creates the `Gold` schema, typically used for refined data prepared for reporting and analysis.
*/

use master;

create database DataWarehouse;

use DataWarehouse;

create schema Bronze;
GO
create schema Silver;
Go
create schema Gold;
