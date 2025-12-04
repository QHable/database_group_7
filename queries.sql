-- revenue in specific month

-- most popular products:
--  Useful for practice to identify which products to keep stocked/which areas they may want to expand product selection

SELECT p.product_name || ': ' || p.product_category AS product, SUM(cop.order_amount) AS amount_ordered
FROM group_7.client_orders_product as cop
	INNER JOIN group_7.products as p
	ON cop.product_id = p.id
GROUP BY product
ORDER BY amount_ordered DESC
LIMIT 10;

-- overview for specific animal's appointments 

-- top performer through metric of number of apppointments

-- percentage of animals in practice / breed 