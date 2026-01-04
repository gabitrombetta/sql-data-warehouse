# Data Catalog para camada Gold

A Camada Gold é a representação dos dados no nível de negócio, estruturada para dar suporte a casos de uso analíticos e de relatórios. Ela é composta por **tabelas de dimensão** e **tabelas fato** para métricas específicas do negócio.

---

### 1. **gold.dim_customers**
Armazena os dados dos clientes, enriquecidos com informações demográficas e geográficas.

| Nome da Coluna   | Tipo de Dado     | Descrição                                                                                   |
|------------------|---------------|-----------------------------------------------------------------------------------------------|
| customer_key     | INT           | Surrogate key que identifica de forma única cada registro de cliente na tabela.               |
| customer_id      | INT           | Identificador numérico único atribuído a cada cliente.                                        |
| customer_number  | NVARCHAR(50)  | Identificador alfanumérico que representa o cliente, usado para rastreamento e referência.         |
| first_name       | NVARCHAR(50)  | Primeiro nome do cliente, conforme registrado no sistema.                                         |
| last_name        | NVARCHAR(50)  | Sobrenome do cliente, conforme registrado no sistema.                                                     |
| country          | NVARCHAR(50)  | País de residência do cliente.                               |
| marital_status   | NVARCHAR(50)  | Estado civil do cliente.                              |
| gender           | NVARCHAR(50)  | Gênero do cliente.                                  |
| birthdate        | DATE          | Data de nascimento do cliente, formatado como YYYY-MM-DD.               |
| create_date      | DATE          | Data e hora em que o registro do cliente foi criado no sistema.

---

### 2. **gold.dim_products**
Armazena Informações sobre os produtos e seus atributos.

| Nome da Coluna         | Tipo de Dado     | Descrição                                                                                   |
|---------------------|---------------|-----------------------------------------------------------------------------------------------|
| product_key         | INT           | Surrogate key que identifica de forma única cada registro de produto na tabela.         |
| product_id          | INT           | Um identificador único atribuído ao produto para rastreamento e referência internos.            |
| product_number      | NVARCHAR(50)  | Código alfanumérico que representa o produto, frequentemente usado para categorização ou controle de inventário. |
| product_name        | NVARCHAR(50)  | Nome descritivo do produto, incluindo detalhes principais como tipo, cor e tamanho.         |
| category_id         | NVARCHAR(50)  | Um identificador único para a categoria do produto.     |
| category            | NVARCHAR(50)  | Classificação mais genérica do produto (por exemplo, Bicicletas, Componentes) para agrupar itens relacionados.  |
| subcategory         | NVARCHAR(50)  | Classificação mais detalhada do produto dentro da categoria, como o tipo de produto.      |
| maintenance_required| NVARCHAR(50)  | Indica se o produto requer manutenção.                       |
| cost                | INT           | O custo ou preço base do produto, medido em unidades monetárias.                            |
| product_line        | NVARCHAR(50)  | A linha ou série específica do produto à qual ele pertence.      |
| start_date          | DATE          | A data em que o produto se tornou disponível para venda ou uso|

---

### 3. **gold.fact_sales**
Armazena dados transacionais de vendas para fins analíticos.

| Column Name     | Data Type     | Description                                                                                   |
|-----------------|---------------|-----------------------------------------------------------------------------------------------|
| order_number    | NVARCHAR(50)  | Identificador alfanumérico único para cada pedido.                      |
| product_key     | INT           | Surrogate key que vincula o pedido à tabela de dimensão de produtos.                               |
| customer_key    | INT           | Surrogate key que vincula o pedido à tabela de dimensão de clientes.                              |
| order_date      | DATE          | Data em que o pedido foi realizado.                                                           |
| shipping_date   | DATE          | Data em que o pedido foi enviado para o cliente.                                          |
| due_date        | DATE          | Data em que o pagamento do pedido era devido..                                                      |
| sales_amount    | INT           | Valor total da venda para o item da linha   |
| quantity        | INT           | Número de unidades do produto encomendadas.                       |
| price           | INT           | Preço por unidade do produto para o item.      |
