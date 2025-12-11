USE ecommerce_dataset;

SELECT * FROM customers
ORDER BY created_at DESC
LIMIT 20;

SELECT p.name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id
ORDER BY total_sold DESC
LIMIT 10;

SELECT customer_id, first_name, last_name, city
FROM customers
WHERE city = 'Bengaluru';

SELECT o.order_id, o.order_date, c.first_name, c.last_name, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC
LIMIT 20;

SELECT o.order_id, o.status, p.payment_date, p.amount
FROM orders o
LEFT JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_id IS NULL;

SELECT c.customer_id, c.first_name, o.order_id, o.order_date
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;

SELECT SUM(total_amount) AS total_revenue
FROM orders;

SELECT AVG(total_amount) AS average_order_value
FROM orders;

SELECT COUNT(order_id) AS completed_orders
FROM orders
WHERE status = 'Completed';

SELECT MIN(price) AS lowest_price
FROM products;

SELECT MAX(price) AS highest_price
FROM products;

SHOW INDEXES FROM orders;
SHOW INDEXES FROM order_items;
SHOW INDEXES FROM products;
SHOW INDEXES FROM payments;

CREATE OR REPLACE VIEW vw_completed_orders AS
SELECT o.order_id, o.order_date, o.customer_id, c.first_name, c.last_name, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.status = 'Completed';

SELECT * 
FROM vw_completed_orders
ORDER BY order_date DESC
LIMIT 20;

SELECT c.customer_id, c.first_name, c.last_name,
       SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING total_spent > (
    SELECT AVG(total_amount) 
    FROM orders
);








