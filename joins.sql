SELECT * FROM employees;
SELECT * FROM departments;

SELECT e.name, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

SELECT e.name, d.dept_name
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id;

SELECT d.dept_name, COUNT(e.emp_id) AS employees
FROM departments d
LEFT JOIN employees e ON e.dept_id = d.dept_id
GROUP BY d.dept_name;