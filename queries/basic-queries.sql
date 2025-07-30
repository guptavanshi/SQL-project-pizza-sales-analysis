-- Retrieve the total number of orders placed.

SELECT COUNT(DISTINCT order_id) AS total_orders FROM orders;

-- Calculate the total revenue generated from pizza sales.

SELECT 
    SUM(orders_details.quantity * pizzas.price) AS total_revenue
FROM 
    orders_details
    JOIN pizzas ON orders_details.pizza_id = pizzas.pizza_id;

-- Identify the highest-priced pizza.

SELECT 
    pizza_types.name, pizzas.size, pizzas.price
FROM 
    pizzas
    JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;


-- Identify the most common pizza size ordered.

SELECT 
    pizzas.size, 
    SUM(orders_details.quantity) AS total_ordered
FROM 
    orders_details
    JOIN pizzas ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY 
    pizzas.size
ORDER BY 
    total_ordered DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name, 
    SUM(orders_details.quantity) AS total_quantity
FROM 
    orders_details
    JOIN pizzas ON orders_details.pizza_id = pizzas.pizza_id
    JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY 
    pizza_types.name
ORDER BY 
    total_quantity DESC
LIMIT 5;
