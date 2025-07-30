-- Join the necessary tables to find the total quantity of each
-- pizza category ordered.

SELECT 
    pizza_types.category, 
    SUM(orders_details.quantity) AS total_quantity
FROM 
    orders_details
    JOIN pizzas ON orders_details.pizza_id = pizzas.pizza_id
    JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY 
    pizza_types.category
ORDER BY 
    total_quantity DESC;


-- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) AS hour, 
    COUNT(order_id)
FROM 
    orders
GROUP BY 
    hour;


-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT
    pizza_types.category,
    COUNT(DISTINCT pizzas.pizza_id) AS total_pizzas
FROM
    pizzas
    JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category
ORDER BY total_pizzas DESC;

-- Group the orders by date and calculate the average number
-- of pizzas ordered per day.

SELECT
    AVG(quantity) AS avg_pizza_per_day
FROM
    (SELECT
        orders.order_date, SUM(orders_details.quantity) AS quantity
     FROM
        orders
     JOIN orders_details ON orders.order_id = orders_details.order_id
     GROUP BY orders.order_date) AS order_quantity;


-- Determine the top 3 most ordered pizza types based on revenue.

SELECT
    pizza_types.name,
    SUM(orders_details.quantity * pizzas.price) AS total_revenue
FROM
    orders_details
    JOIN pizzas ON orders_details.pizza_id = pizzas.pizza_id
    JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
ORDER BY total_revenue DESC
LIMIT 3;
