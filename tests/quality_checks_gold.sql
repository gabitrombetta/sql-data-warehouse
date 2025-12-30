/*
Script responsável por realizar verificações de qualidade para consistência, precisão e
padronização de dados na camada 'gold'.
Ele inclui verificações para:
- Unicidade das surrogate keys nas tabelas de dimensão.
- Integridade referencial entre as tabelas de fatos e dimensões.
- Validação dos relacionamentos no modelo de dados para fins analíticos.
*/

-- gold.dim_customers
-- Verificação a unicidade da chave de cliente
SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- gold.product_key
-- Verificação a unicidade da chave de produto
SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- gold.fact_sales
-- Verificação da conectividade entre a tabela fato e as dimensões
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL  