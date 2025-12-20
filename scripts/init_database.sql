/*
Este script realiza a criação de um novo banco de dados chamado 'DataWarehouse' após checar se o mesmo já existe. Caso exista, o banco de dados é excluído e recriado.
Após, o script realiza a criação de três schemas no banco de dados: bronze, silver, gold.
*/

USE master;
GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO