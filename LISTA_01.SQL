CREATE DATABASE IF NOT EXISTS ecommerce_22B;
use ecommerce_22B;

-- Criação da tabela Customers
CREATE TABLE IF NOT EXISTS Customers (
   customer_id INT PRIMARY KEY,
   first_name VARCHAR(50),
   last_name VARCHAR(50),
   email VARCHAR(100)
);

-- Criação da tabela Orders
CREATE TABLE IF NOT EXISTS Orders (
   order_id INT PRIMARY KEY,
   customer_id INT,
   order_date DATE,
   FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Criação da tabela Products
CREATE TABLE IF NOT EXISTS Products (
   product_id INT PRIMARY KEY,
   product_name VARCHAR(100),
   price DECIMAL(10, 2)
);

-- Criação da tabela Order_Items
CREATE TABLE IF NOT EXISTS Order_Items (
   order_item_id INT PRIMARY KEY,
   order_id INT,
   product_id INT,
   quantity INT,
   FOREIGN KEY (order_id) REFERENCES Orders(order_id),
   FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Inserção de dados na tabela Customers
INSERT INTO Customers (customer_id, first_name, last_name, email) VALUES
(1, 'Ana', 'Silva', 'ana.silva@example.com'),
(2, 'Bruno', 'Santos', 'bruno.santos@example.com'),
(3, 'Carlos', 'Pereira', 'carlos.pereira@example.com'),
(4, 'Daniela', 'Oliveira', 'daniela.oliveira@example.com');

-- Inserção de dados na tabela Orders
INSERT INTO Orders (order_id, customer_id, order_date) VALUES
(1, 1, '2023-07-01'),
(2, 2, '2023-07-02'),
(3, 1, '2023-07-03'),
(4, 3, '2023-07-04');

-- Inserção de dados na tabela Products
INSERT INTO Products (product_id, product_name, price) VALUES
(1, 'Notebook', 2500.00),
(2, 'Mouse', 50.00),
(3, 'Teclado', 100.00),
(4, 'Monitor', 600.00);

-- Inserção de dados na tabela Order_Items
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity) VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 2, 1),
(4, 2, 3, 1),
(5, 3, 1, 2),
(6, 4, 4, 1);




-- EXERCICIOS--
-- Exercício 1: Listar todos os pedidos com detalhes do cliente --
 
SELECT 
    o.order_id,
    o.order_date,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    c.email 
FROM 
    Orders o
JOIN 
    Customers c ON o.customer_id = c.customer_id;
    
-- Exercício 2: Encontrar todos os produtos pedidos por um cliente específico --
 
SELECT
	o.product_name,
    o.quantify
FROM 
	order_item o
JOIN 
	Orders o ON o.order_id = o.order_id
JOIN 
	products p ON o.product_id = o.product_id
WHERE 
	o.customer_id = 1;

-- Exercício 3: Calcular o total gasto por cada cliente --
 
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    SUM(oi.quantity * p.price) AS total_spent
FROM 
    Customers c
JOIN 
    Orders o ON c.customer_id = o.customer_id
JOIN 
    Order_Items oi ON o.order_id = oi.order_id
JOIN 
    Products p ON oi.product_id = p.product_id
GROUP BY 
    c.customer_id;
    
-- Exercício 4: Encontrar os clientes que nunca fizeram um pedido --
 
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.customer_id = o.customer_id
WHERE 
    o.order_id IS NULL;
    

-- Exercício 5: Listar os produtos mais vendidos --
 
SELECT
	p.product_name,
    SUM(o.quantify) AS total_sold
FROM
	order_items
JOIN
	products p ON o.products_id = p.products_id
GROUP BY
	p.products_id
ORDER BY
	total_sold DESC;