-- Creación de la base de datos
CREATE DATABASE tienda;
USE tienda;

-- Creación de la tabla products
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Creación de la tabla orders
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    user_id INT NOT NULL,
    quantity INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Índices recomendados para optimización
CREATE INDEX idx_orders_product_id ON orders(product_id);
CREATE INDEX idx_orders_order_date ON orders(order_date);

-- Inserción de datos de ejemplo en products
INSERT INTO products (name, description, price) VALUES
('Laptop', 'Laptop de última generación', 1200.00),
('Smartphone', 'Teléfono con pantalla OLED', 800.00),
('Tablet', 'Tablet con pantalla HD', 400.00),
('Monitor', 'Monitor 4K de 27 pulgadas', 350.00),
('Teclado', 'Teclado mecánico RGB', 120.00);

-- Inserción de datos de ejemplo en orders
INSERT INTO orders (product_id, user_id, quantity) VALUES
(1, 101, 20),
(1, 102, 40),
(1, 103, 10),
(2, 104, 30),
(2, 105, 25),
(3, 106, 60),
(3, 107, 10),
(4, 108, 70),
(5, 109, 15),
(5, 110, 40);

-- Consulta para obtener la cantidad total de pedidos para productos vendidos más de 50 veces
SELECT p.id, p.name, SUM(o.quantity) AS total_ventas
FROM products p
JOIN orders o ON p.id = o.product_id
GROUP BY p.id, p.name
HAVING total_ventas > 50;

-- Consulta para obtener el precio promedio de productos vendidos más de 50 veces
SELECT p.id, p.name, p.price, AVG(p.price) AS precio_promedio
FROM products p
JOIN orders o ON p.id = o.product_id
GROUP BY p.id, p.name, p.price
HAVING SUM(o.quantity) > 50;

-- Consulta para obtener los productos que han generado el mayor ingreso total (precio * cantidad)
SELECT p.id, p.name, SUM(p.price * o.quantity) AS ingreso_total
FROM products p
JOIN orders o ON p.id = o.product_id
GROUP BY p.id, p.name
ORDER BY ingreso_total DESC;
