-- revenue in specific month
SELECT 
	'appointment' AS "type", 
	ap.id, ap.appointment_date AS "date", 
	(ap.appointment_cost + (pre.prescription_amount * pro.product_price)) AS "money earnd" 
FROM group_7.appointment ap 
	LEFT JOIN group_7.prescribes pre ON (ap.id = pre.appointment_id) 
	LEFT JOIN group_7.products pro ON (pre.product_id = pro.id) 
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
-- currently shows lowest performer, highest is made by changing order by to desc
SELECT w.employee_name, COUNT(v.worker_id) AS no_appointments
FROM group_7.appointment AS a
	INNER JOIN group_7.vet_has_appointment AS v
	ON v.appointment_id = a.id
	INNER JOIN group_7.worker AS w
	ON w.id = v.worker_id
GROUP BY w.id
ORDER BY no_appointments
LIMIT 1;

-- percentage of animals in practice / breed 
SELECT p.animal_breed, COUNT(p.animal_species) AS no_appointments
FROM group_7.appointment AS a
	INNER JOIN group_7.patient AS p
	ON a.patient_id = p.id
GROUP BY p.animal_species, p.animal_breed
HAVING lower(p.animal_species) = 'dog'
ORDER BY no_appointments DESC;

