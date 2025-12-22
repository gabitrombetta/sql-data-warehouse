/*
Stored Procedure respons�vel por carregar dados na camada Bronze
a partir de arquivos CSV externos.

Ações:
- Trunca as tabelas do schema 'bronze'.
- Carrega os dados via BULK INSERT.

Exemplo de uso:
EXEC bronze.load_bronze;
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_batch DATETIME, @end_batch DATETIME, @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY
		SET @start_batch = GETDATE();
		-- Tabelas CRM
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info;

		BULK INSERT bronze.crm_cust_info
		FROM '$(DATA_PATH)\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Dura��o do Carregamento: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;

		BULK INSERT bronze.crm_prd_info
		FROM '$(DATA_PATH)\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Dura��o do Carregamento: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;

		BULK INSERT bronze.crm_sales_details
		FROM '$(DATA_PATH)\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Dura��o do Carregamento: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';

		-- Tabelas ERP
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;

		BULK INSERT bronze.erp_cust_az12
		FROM '$(DATA_PATH)\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Dura��o do Carregamento: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;

		BULK INSERT bronze.erp_loc_a101
		FROM '$(DATA_PATH)\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Dura��o do Carregamento: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM '$(DATA_PATH)\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Dura��o do Carregamento: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';

		SET @end_batch = GETDATE();
		PRINT '>> Dura��o total do Carregamento: ' + CAST (DATEDIFF(second, @start_batch, @end_batch) AS NVARCHAR) + ' segundos';
	END TRY
	BEGIN CATCH
		RAISERROR ('Erro na carga Bronze', 0, 1) WITH NOWAIT;
		THROW;
	END CATCH;
END