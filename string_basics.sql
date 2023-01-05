SELECT COUNT(*) FROM books;
SELECT COUNT(author_fname) FROM books;
SELECT COUNT(DISTINCT author_fname) FROM books;

SELECT COUNT(*) FROM books
WHERE title LIKE '% the %';

SELECT author_lname FROM books
GROUP BY author_lname;

SELECT author_lname, COUNT(*) as count_of_books FROM books
GROUP BY author_lname
ORDER BY count_of_books DESC;

SELECT MIN(released_year) FROM books;

SELECT MAX(pages) FROM books;

SELECT MIN(author_lname) FROM books;

-- What is the title of the longest book?
SELECT title, pages FROM books ORDER BY pages DESC LIMIT 1;

SELECT * FROM books
WHERE pages = (SELECT MAX(pages) FROM books);

-- Title of the book released earliest
SELECT title, released_year FROM books
WHERE released_year = (SELECT MIN(released_year) FROM books);

-- Multi Group By
SELECT author_fname, author_lname, COUNT(*)
FROM books
GROUP BY author_lname, author_fname;

SELECT CONCAT(author_fname, ' ', author_lname) as author_full_name, COUNT(*) as count_of_books FROM books
GROUP BY author_full_name;

-- MIN and MAX with GROUP BY
-- Find the year each author published their first book

SELECT author_fname, author_lname, MIN(released_year) as first_book_year FROM books
GROUP BY author_fname, author_lname;

SELECT SUM(pages) FROM books;

SELECT author_lname, COUNT(*), SUM(pages)
FROM books
GROUP BY author_lname;