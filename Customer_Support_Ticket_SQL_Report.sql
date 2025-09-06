-- Assignment 1: •	Mini Project: “Customer Support Ticket SQL Report”
-- Example: Avg. resolution time by agent, top 5 issues.


CREATE DATABASE IF NOT EXISTS support;
USE support;

CREATE TABLE IF NOT EXISTS tickets( 
ticket_id INT PRIMARY KEY, 
agent_email VARCHAR(50) CHECK(agent_email LIKE '%_@__%._%'), 
subject VARCHAR(100), 
created_at DATETIME NOT NULL, 
resolved_at DATETIME, 
sla_due_at DATETIME, 
status ENUM('New', 'Pending', 'Waiting on Client', 'Resolved') DEFAULT 'New',
CONSTRAINT valid_resolve_time CHECK(resolved_at >= created_at) 
); 

-- Q1. To retrieve the average resolution time by an Agent:
SELECT agent_email, AVG(TIMESTAMPDIFF(HOUR, created_at, resolved_at)) AS average_time
FROM tickets
GROUP BY agent_email
ORDER BY average_time ASC;

-- Q2. To retrieve the top 5 issues:
SELECT subject, COUNT(subject) AS total_count
FROM tickets
GROUP BY subject
ORDER BY total_count DESC
LIMIT 5;