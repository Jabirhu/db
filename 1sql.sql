CREATE TABLE PUBLISHER(
NAME VARCHAR(18) PRIMARY KEY,
ADDRESS VARCHAR(10),
PHONE VARCHAR(10));

INSERT INTO PUBLISHER VALUES('PEARSON','BANGALORE','9875462530');
INSERT INTO PUBLISHER VALUES('MCGRAW','NEWDELHI','7845691234');
INSERT INTO PUBLISHER VALUES('SAPNA','BANGALORE','7845963210');

CREATE TABLE BOOK(
BOOK_ID INTEGER PRIMARY KEY,
TITLE VARCHAR(20),
PUBLISHER_NAME VARCHAR(20),
FOREIGN KEY(PUBLISHER_NAME) REFERENCES PUBLISHER(NAME)ON DELETE
CASCADE,
PUB_YEAR integer(4));


INSERT INTO BOOK VALUES(1111,'SE','PEARSON',2005);
INSERT INTO BOOK VALUES(2222,'DBMS','MCGRAW',2004);
INSERT INTO BOOK VALUES(3333,'ANOTOMY','PEARSON',2010);
INSERT INTO BOOK VALUES(4444,'ENCYCLOPEDIA','SAPNA',2010);

CREATE TABLE BOOK_AUTHORS(
BOOK_ID INTEGER,
FOREIGN KEY(BOOK_ID) references BOOK(BOOK_ID) ON DELETE CASCADE,
AUTHOR_NAME VARCHAR(20));

INSERT INTO BOOK_AUTHORS VALUES(1111,'SOMMERVILLE');
INSERT INTO BOOK_AUTHORS VALUES(2222,'NAVATHE');
INSERT INTO BOOK_AUTHORS VALUES(3333,'HENRY GRAY');
INSERT INTO BOOK_AUTHORS VALUES(4444,'THOMAS');

CREATE TABLE LIBRARY_BRANCH(
BRANCH_ID INTEGER PRIMARY KEY,
BRANCH_NAME VARCHAR(18),
ADDRESS VARCHAR(15));

INSERT INTO LIBRARY_BRANCH VALUES(11,'CENTRAL TECHNICAL','MG ROAD');
INSERT INTO LIBRARY_BRANCH VALUES(22,'MEDICAL','BH ROAD');
INSERT INTO LIBRARY_BRANCH VALUES(33,'CHILDREN','SS PURAM');
INSERT INTO LIBRARY_BRANCH VALUES(44,'SECRETARIAT','SIRAGATE');
INSERT INTO LIBRARY_BRANCH VALUES(55,'GENERAL','JAYANAGAR');

CREATE TABLE BOOK_COPIES(
BOOK_ID INTEGER,
FOREIGN KEY(BOOK_ID) REFERENCES BOOK(BOOK_ID) ON DELETE CASCADE,
BRANCH_ID INTEGER,
FOREIGN KEY(BRANCH_ID) REFERENCES LIBRARY_BRANCH(BRANCH_ID) ON DELETE
CASCADE,
NO_OF_COPIES INTEGER);

INSERT INTO BOOK_COPIES VALUES(1111,11,5);
INSERT INTO BOOK_COPIES VALUES(3333,22,6);
INSERT INTO BOOK_COPIES VALUES(4444,33,10);
INSERT INTO BOOK_COPIES VALUES(2222,11,12);
INSERT INTO BOOK_COPIES VALUES(4444,55,3);

CREATE TABLE BOOK_LENDING(
BOOK_ID INTEGER,
FOREIGN KEY(BOOK_ID) REFERENCES BOOK(BOOK_ID) ON DELETE CASCADE,
BRANCH_ID INTEGER,
FOREIGN KEY(BRANCH_ID) REFERENCES LIBRARY_BRANCH(BRANCH_ID) ON DELETE
CASCADE,
CARD_NO INTEGER,
DATE_OUT DATE,
DUE_DATE DATE);

INSERT INTO BOOK_LENDING VALUES(2222,11,1,'17-01-10','17-08-20');
INSERT INTO BOOK_LENDING VALUES(3333,22,2,'17-07-09','17-08-12');
INSERT INTO BOOK_LENDING VALUES(4444,55,1,'17-04-11','17-08-09');
INSERT INTO BOOK_LENDING VALUES(2222,11,5,'17-08-29','17-08-19');
INSERT INTO BOOK_LENDING VALUES(4444,33,1,'17-06-10','17-08-15');
INSERT INTO BOOK_LENDING VALUES(1111,11,1,'17-05-12','17-06-10');
INSERT INTO BOOK_LENDING VALUES(3333,22,1,'17-07-10','17-07-15');
INSERT INTO BOOK_LENDING VALUES(2222,11,1,'17-01-10','17-08-20');

-- QUERY 1
SELECT LB.BRANCH_NAME,B.BOOK_ID,TITLE,PUBLISHER_NAME,PUB_YEAR
FROM BOOK B,BOOK_AUTHORS BA, BOOK_COPIES BC, LIBRARY_BRANCH LB
WHERE B.BOOK_ID=BA.BOOK_ID AND B.BOOK_ID=BC.BOOK_ID AND LB.BRANCH_ID=BC.BRANCH_ID
GROUP BY LB.BRANCH_NAME,B.BOOK_ID,TITLE,PUBLISHER_NAME,PUB_YEAR;

-- QUERY 2
SELECT CARD_NO
FROM BOOK_LENDING
WHERE DATE_OUT BETWEEN '17-01-01' AND '17-06-01'
GROUP BY CARD_NO
HAVING COUNT(*)>3;

-- QUERY 3
DELETE FROM BOOK
WHERE BOOK_ID=3333;

select * FROM BOOK;
select * FROM BOOK_COPIES;
select * FROM BOOK_LENDING;

SET FOREIGN_KEY_CHECKS=1;

-- QUERY 4
SELECT BOOK_ID,TITLE,PUBLISHER_NAME,PUB_YEAR
FROM BOOK
GROUP BY PUB_YEAR,BOOK_ID,TITLE, PUBLISHER_NAME;

-- QUERY 5
CREATE VIEW AVAIL_BOOKS AS
SELECT B.BOOK_ID,TITLE,NO_OF_COPIES
FROM BOOK B,BOOK_COPIES BC
WHERE B.BOOK_ID=BC.BOOK_ID;

SELECT * FROM AVAIL_BOOKS;