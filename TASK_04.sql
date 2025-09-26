BASIC SELECT QUERIES 

# 1. Total number of orders per customer
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC;

# 2. Orders placed after 1st Jan 2024
SELECT * FROM orders
WHERE order_date > '2024-01-01'
ORDER BY order_date ASC;

JOINS QUERIES

# 3. Join orders with customer names
SELECT o.order_id, c.customer_name, o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_id

# 4. Items ordered with restaurant name
SELECT od.order_id, mi.item_name, r.rest_name, od.quantity
FROM order_details od
LEFT JOIN menu_item mi ON od.item_id = mi.item_id
LEFT JOIN restaurant r ON mi.reataurant_id = r.reataurant_id;

SUBQURIES

# 6. Customers who placed more orders than the average
SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > (
  SELECT AVG(order_count)
  FROM (
    SELECT COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
  ) AS subquery
);


Aggregate Functions (SUM, AVG)

# 7. Total revenue per restaurant
SELECT r.rest_name, SUM(mi.price * od.quantity) AS revenue
FROM restaurant r
JOIN orders o ON r.reataurant_id = o.reataurant_id
JOIN order_details od ON o.order_id = od.order_id
JOIN menu_item mi ON od.item_id = mi.item_id
GROUP BY r.rest_name
ORDER BY revenue DESC;


# 8. Average item price per restaurant
SELECT r.rest_name, AVG(mi.price) AS avg_price
FROM restaurant r
JOIN menu_item mi ON r.reataurant_id = mi.reataurant_id
GROUP BY r.rest_name;

VIEWS

# 9. View for monthly revenue
CREATE VIEW monthly_revenue AS
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       SUM(mi.price * od.quantity) AS revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN menu_item mi ON od.item_id = mi.item_id
GROUP BY month;

CREATED SUCCESFULLY 

INDEXES
# 10. Index on customer_id for faster filtering
CREATE INDEX idx_customer_id ON orders(customer_id);

# 11. Index on item_id for faster joins
CREATE INDEX idx_item_id ON order_details(item_id);

CREATED SUCCESFULLY 









