-- Calculate the percentage contribution of each pizza
-- type to total revenue.

SELECT
    pizza_types.category,
    ROUND(SUM(orders_details.quantity * pizzas.price) * 100.0 / 
        (SELECT
            SUM(orders_details.quantity * pizzas.price)
         FROM
            orders_details
            JOIN pizzas ON orders_details.pizza_id = pizzas.pizza_id), 2)
    AS percentage_contribution
FROM
    orders_details
    JOIN pizzas ON orders_details.pizza_id = pizzas.pizza_id
    JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category
ORDER BY percentage_contribution DESC;


-- Analyze the cumulative revenue generated over time.

SELECT order_date,
    SUM(revenue) OVER (ORDER BY order_date) AS comulative_revenue
FROM
    (SELECT orders.order_date,
        SUM(orders_details.quantity * pizzas.price) AS revenue
     FROM orders_details
     JOIN pizzas ON pizzas.pizza_id = orders_details.pizza_id
     JOIN orders ON orders.order_id = orders_details.order_id
     GROUP BY orders.order_date) AS sales;


-- Determine the top 3 most ordered pizza types based on revenue for
-- each pizza category.

SELECT category, name, total_revenue
FROM (
    SELECT
        pizza_types.category,
        pizza_types.name,
        SUM(orders_details.quantity * pizzas.price) AS total_revenue,
        RANK() OVER (
            PARTITION BY pizza_types.category
            ORDER BY SUM(orders_details.quantity * pizzas.price) DESC
        ) AS revenue_rank
    FROM orders_details
    JOIN pizzas ON orders_details.pizza_id = pizzas.pizza_id
    JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
    GROUP BY pizza_types.category, pizza_types.name
) ranked
WHERE revenue_rank <= 3
ORDER BY category, revenue_rank;
