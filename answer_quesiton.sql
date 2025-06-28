-- Q.1
SELECT u.name, COUNT(l.*)
FROM users u
JOIN loans l USING (user_id)
GROUP BY 1
ORDER BY 2 DESC;

-- Q.2
SELECT b.title, COUNT(l.*) AS total_borrowed
FROM books b
JOIN loans l USING(book_id)
GROUP BY 1
ORDER BY 2 DESC;


-- Q.3
SELECT 
    c.name AS category,
    ROUND(AVG(l.return_date - l.loan_date),2) AS avg_days_borrowed
FROM loans l
JOIN books b ON l.book_id = b.book_id
JOIN categories c ON b.category_id = c.category_id
WHERE return_date IS NOT NULL
GROUP BY c.name
ORDER BY 2 DESC;

-- Q.4
SELECT DISTINCT u.name, u.email
FROM users u
JOIN holds h ON u.user_id = h.user_id
WHERE u.user_id NOT IN (
    SELECT DISTINCT user_id FROM loans
);


-- Q.5
SELECT 
    b.title,
    total_stock,
    COALESCE(l.total_loans, 0) AS total_loans
FROM (
    SELECT book_id, SUM(quantity) AS total_stock
    FROM library_books
    GROUP BY book_id
) lb
JOIN books b ON lb.book_id = b.book_id
LEFT JOIN (
    SELECT book_id, COUNT(*) AS total_loans
    FROM loans
    GROUP BY book_id
) l ON b.book_id = l.book_id
WHERE lb.total_stock > 10 AND COALESCE(l.total_loans, 0) < 3;



