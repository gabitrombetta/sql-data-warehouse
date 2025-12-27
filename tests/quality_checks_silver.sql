/*
Script responsável por realizar verificações de qualidade para consistência, precisão e
padronização de dados na camada 'prata'.
Ele inclui verificações para:
- Chaves primárias nulas ou duplicadas.
- Espaços indesejados em campos de texto.
- Padronização e consistência de dados.
- Intervalos de datas e ordens inválidos.
- Consistência de dados entre campos relacionados.
*/

-- silver.crm_cust_info
-- Verificação de valores nulos ou duplicados na chave primária
SELECT 
    cst_id,
    COUNT(*) 
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Verificação de espaços indesejados
SELECT 
    cst_key 
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Padronização e consistência dos dados
SELECT DISTINCT 
    cst_marital_status 
FROM silver.crm_cust_info;

-- silver.crm_prd_info
-- Verificação de valores nulos ou duplicados na chave primária
SELECT 
    prd_id,
    COUNT(*) 
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Verificação de espaços indesejados
SELECT 
    prd_nm 
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Padronização e consistência dos dados
SELECT 
    prd_cost 
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Padronização e consistência dos dados
SELECT DISTINCT 
    prd_line 
FROM silver.crm_prd_info;

-- Verificação de pedidos com datas inválidas (Data de início > Data de término)
SELECT 
    * 
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- silver.crm_sales_details
-- Verificação de datas inválidas
SELECT 
    NULLIF(sls_due_dt, 0) AS sls_due_dt 
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0 
    OR LEN(sls_due_dt) != 8 
    OR sls_due_dt > 20500101 
    OR sls_due_dt < 19000101;

-- Identificação de pedidos com datas inválidas (Data do pedido > Datas de envio/prazo de entrega)
SELECT 
    * 
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt 
   OR sls_order_dt > sls_due_dt;

-- Verificação da consistência dos dados: Sales = Quantity * Price
SELECT DISTINCT 
    sls_sales,
    sls_quantity,
    sls_price 
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL 
   OR sls_quantity IS NULL 
   OR sls_price IS NULL
   OR sls_sales <= 0 
   OR sls_quantity <= 0 
   OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

-- silver.erp_cust_az12
-- Identificação de datas fora do intervalo (1924-01-01 e Hoje)
SELECT DISTINCT 
    bdate 
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' 
   OR bdate > GETDATE();

-- Padronização e consistência dos dados
SELECT DISTINCT 
    gen 
FROM silver.erp_cust_az12;

-- silver.erp_loc_a101
-- Padronização e consistência dos dados
SELECT DISTINCT 
    cntry 
FROM silver.erp_loc_a101
ORDER BY cntry;

-- silver.erp_px_cat_g1v2
-- Verificação de espaços indesejados
SELECT 
    * 
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
   OR subcat != TRIM(subcat) 
   OR maintenance != TRIM(maintenance);

-- Padronização e consistência dos dados
SELECT DISTINCT 
    maintenance 
FROM silver.erp_px_cat_g1v2;
