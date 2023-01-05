SELECT CONCAT(SUBSTRING(title,1,10),'...') as short_title FROM books;

SELECT CONCAT(SUBSTR(author_fname, 1,1),'.', SUBSTR(author_lname, 1, 1),'.') as author_initials FROM books;

SELECT REPLACE('Hellow World', 'Hell', '%$#&');

SELECT REPLACE('cheese bread coffee milk', ' ', ' and ');

SELECT REPLACE(title, ' ', '-') FROM books;

SELECT REVERSE('Hello World!');

SELECT CHAR_LENGTH('Hello World!');

SELECT UPPER('Hello World!');

SELECT TRIM(' pickle ');