-- revenue in specific month
SELECT 
	'appointment' AS "type", 
	ap.id, ap.appointment_date AS "date", 
	(ap.appointment_cost + (pre.prescription_amount * pro.product_price)) AS "money earnd" 
FROM group_7.appointment ap 
	LEFT JOIN group_7.prescribes pre ON (ap.id = pre.appointment_id) 
	INNER JOIN group_7.products pro ON (pre.product_id = pro.id) 
WHERE EXTRACT(year from ap.appointment_date) = '2025' 
	AND EXTRACT(month from ap.appointment_date) = '01' 
ORDER BY ap.appointment_date, ap.start_time;

SELECT 'order' AS "type", (c_or_p.product_id || ' ' || c_or_p.client_id) AS "id", c_or_p.order_date AS "date", (c_or_p.order_amount * pro.product_price) AS "money earned"
FROM group_7.client_orders_product c_or_p
INNER JOIN group_7.products pro ON (c_or_p.product_id = pro.id)
WHERE EXTRACT(year from c_or_p.order_date) = '2025' AND EXTRACT(month from c_or_p.order_date) = '01'
ORDER BY date;

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
