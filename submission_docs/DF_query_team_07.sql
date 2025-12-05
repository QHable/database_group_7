-- revenue in specific month
SELECT 
	'appointment' AS "type", 
	ap.id, ap.appointment_date AS "date",
	CASE
		WHEN pre.prescription_amount IS NULL THEN ap.appointment_cost
		ELSE (ap.appointment_cost + (pre.prescription_amount * pro.product_price)) 
	END AS "money earnd" 
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

SELECT p.product_name || ': ' || p.product_category AS product, SUM(cop.order_amount) AS amount_ordered
FROM group_7.client_orders_product as cop
	INNER JOIN group_7.products as p
	ON cop.product_id = p.id
GROUP BY product
ORDER BY amount_ordered DESC
LIMIT 10;

-- top performer through metric of number of apppointments

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


-- week overvieuw for workers
SELECT app.appointment_date, wo.employee_name, room.id as "room", (app.start_time || '-'|| app.end_time) as "time", app.appointment_type, app.description, app.patient_id as "patient", app.id 
FROM group_7.appointment app
LEFT JOIN group_7.vet_has_appointment  vet_app ON (app.id = vet_app.appointment_id)
LEFT JOIN group_7.animal_carer_has_appointment an_app ON(app.id = an_app.appointment_id)
INNER JOIN group_7.worker wo ON (vet_app.worker_id = wo.id or an_app.worker_id = wo.id)
LEFT JOIN group_7.room ON (app.room_number = room.id)

WHERE  EXTRACT(year from app.appointment_date) = '2025' AND EXTRACT(month from app.appointment_date) = '01' 
AND EXTRACT(day from app.appointment_date) IN ('06', '07', '08', '09', '10', '11', '12')
ORDER BY app.appointment_date, wo.id, app.start_time;
