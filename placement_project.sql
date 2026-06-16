mysql> CREATE VIEW selected_students AS
    -> SELECT s.student_name, c.company_name, p.package_lpa
    -> FROM placements p
    -> JOIN students s ON p.student_id = s.student_id
    -> JOIN companies c ON p.company_id = c.company_id;
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE VIEW high_cgpa_students AS
    -> SELECT *
    -> FROM students
    -> WHERE cgpa > 8;
Query OK, 0 rows affected (0.02 sec)

mysql> SELECT * FROM high_cgpa_students;
+------------+--------------+------------------+------------+------+---------+
| student_id | student_name | email            | phone      | cgpa | dept_id |
+------------+--------------+------------------+------------+------+---------+
|          1 | Saran        | saran@gmail.com  | 9876543210 | 8.50 |     101 |
|          2 | Priya        | priya@gmail.com  | 9876543211 | 9.00 |     102 |
|          4 | Deepa        | deepa@gmail.com  | 9876543213 | 8.90 |     103 |
|          5 | Anjali       | anjali@gmail.com | 9876543214 | 8.20 |     102 |
|          7 | Sneha        | sneha@gmail.com  | 9876543216 | 9.10 |     101 |
|         10 | Harsha       | harsha@gmail.com | 9876543219 | 8.70 |     101 |
+------------+--------------+------------------+------------+------+---------+
6 rows in set (0.01 sec)

mysql> DELIMITER //
mysql> CREATE PROCEDURE show_students()
    -> BEGIN
    ->     SELECT * FROM students;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> DELIMITER ;
mysql> CALL show_students();
+------------+--------------+------------------+------------+------+---------+
| student_id | student_name | email            | phone      | cgpa | dept_id |
+------------+--------------+------------------+------------+------+---------+
|          1 | Saran        | saran@gmail.com  | 9876543210 | 8.50 |     101 |
|          2 | Priya        | priya@gmail.com  | 9876543211 | 9.00 |     102 |
|          3 | Rahul        | rahul@gmail.com  | 9876543212 | 7.80 |     101 |
|          4 | Deepa        | deepa@gmail.com  | 9876543213 | 8.90 |     103 |
|          5 | Anjali       | anjali@gmail.com | 9876543214 | 8.20 |     102 |
|          6 | Kumar        | kumar@gmail.com  | 9876543215 | 7.50 |     104 |
|          7 | Sneha        | sneha@gmail.com  | 9876543216 | 9.10 |     101 |
|          8 | Varun        | varun@gmail.com  | 9876543217 | 8.00 |     105 |
|          9 | Charan       | charan@gmail.com | 9876543218 | 7.20 |     104 |
|         10 | Harsha       | harsha@gmail.com | 9876543219 | 8.70 |     101 |
+------------+--------------+------------------+------------+------+---------+
10 rows in set (0.00 sec)

Query OK, 0 rows affected (0.09 sec)

mysql> DELIMITER //
mysql> CREATE PROCEDURE get_students_by_dept(IN dept INT)
    -> BEGIN
    ->     SELECT * FROM students
    ->     WHERE dept_id = dept;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> DELIMITER ;
mysql> CALL get_students_by_dept(101);
+------------+--------------+------------------+------------+------+---------+
| student_id | student_name | email            | phone      | cgpa | dept_id |
+------------+--------------+------------------+------------+------+---------+
|          1 | Saran        | saran@gmail.com  | 9876543210 | 8.50 |     101 |
|          3 | Rahul        | rahul@gmail.com  | 9876543212 | 7.80 |     101 |
|          7 | Sneha        | sneha@gmail.com  | 9876543216 | 9.10 |     101 |
|         10 | Harsha       | harsha@gmail.com | 9876543219 | 8.70 |     101 |
+------------+--------------+------------------+------------+------+---------+
4 rows in set (0.00 sec)

Query OK, 0 rows affected (0.05 sec)

mysql> DELIMITER //
mysql> CREATE PROCEDURE show_placed_students()
    -> BEGIN
    ->     SELECT s.student_name, c.company_name, p.package_lpa
    ->     FROM placements p
    ->     JOIN students s ON p.student_id = s.student_id
    ->     JOIN companies c ON p.company_id = c.company_id;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> DELIMITER ;
mysql> CALL show_placed_students();
+--------------+--------------+-------------+
| student_name | company_name | package_lpa |
+--------------+--------------+-------------+
| Priya        | Accenture    |        6.00 |
| Harsha       | Accenture    |        6.00 |
| Anjali       | Cognizant    |        5.80 |
| Sneha        | Cognizant    |        5.80 |
| Deepa        | Infosys      |        5.20 |
| Varun        | Infosys      |        5.20 |
| Saran        | TCS          |        4.50 |
+--------------+--------------+-------------+
7 rows in set (0.00 sec)

Query OK, 0 rows affected (0.07 sec)

mysql> DELIMITER //
mysql> CREATE PROCEDURE add_student(
    ->     IN sname VARCHAR(100),
    ->     IN semail VARCHAR(100),
    ->     IN sphone VARCHAR(15),
    ->     IN scgpa DECIMAL(3,2),
    ->     IN sdept INT
    -> )
    -> BEGIN
    ->     INSERT INTO students(student_name,email,phone,cgpa,dept_id)
    ->     VALUES(sname, semail, sphone, scgpa, sdept);
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> DELIMITER ;
mysql> CALL add_student('Ramesh','ramesh@gmail.com','9876543299',8.6,101);
Query OK, 1 row affected (0.01 sec)

mysql> DELIMITER //
mysql> CREATE PROCEDURE update_student_cgpa(
    ->     IN sid INT,
    ->     IN new_cgpa DECIMAL(3,2)
    -> )
    -> BEGIN
    ->     UPDATE students
    ->     SET cgpa = new_cgpa
    ->     WHERE student_id = sid;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> DELIMITER ;
mysql> CALL update_student_cgpa(1,9.2);
Query OK, 1 row affected (0.01 sec)

mysql> DELIMITER //
mysql> CREATE TRIGGER auto_status
    -> BEFORE INSERT ON applications
    -> FOR EACH ROW
    -> BEGIN
    ->     SET NEW.status = 'Applied';
    -> END //
Query OK, 0 rows affected (0.02 sec)

mysql> DELIMITER ;
mysql> INSERT INTO applications(application_id,student_id,job_id)
    -> VALUES(6,6,4);
ERROR 1062 (23000): Duplicate entry '6' for key 'applications.PRIMARY'
mysql> VALUES(12,6,4);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '(12,6,4)' at line 1
mysql> INSERT INTO applications(application_id,student_id,job_id)
    -> VALUES(12,6,4);
Query OK, 1 row affected (0.01 sec)

mysql> DELIMITER //
mysql> CREATE TRIGGER check_student_cgpa
    -> BEFORE INSERT ON students
    -> FOR EACH ROW
    -> BEGIN
    ->     IF NEW.cgpa < 6 THEN
    ->         SIGNAL SQLSTATE '45000'
    ->         SET MESSAGE_TEXT = 'CGPA below 6 not allowed';
    ->     END IF;
    -> END //
Query OK, 0 rows affected (0.02 sec)

mysql> DELIMITER ;
mysql> CREATE TABLE student_backup (
    ->     student_id INT,
    ->     student_name VARCHAR(100),
    ->     email VARCHAR(100),
    ->     phone VARCHAR(15),
    ->     cgpa DECIMAL(3,2),
    ->     dept_id INT
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> DELIMITER //
mysql> CREATE TRIGGER backup_deleted_students
    -> BEFORE DELETE ON students
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO student_backup
    ->     VALUES(
    ->         OLD.student_id,
    ->         OLD.student_name,
    ->         OLD.email,
    ->         OLD.phone,
    ->         OLD.cgpa,
    ->         OLD.dept_id
    ->     );
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> DELIMITER ;
mysql> DELETE FROM students WHERE student_id = 3;
ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`projectsql`.`applications`, CONSTRAINT `applications_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`))
mysql> SELECT * FROM student_backup;
Empty set (0.00 sec)

mysql> c:\Users\KARTHI\Desktop
ERROR: 
Unknown command '\U'.
ERROR: 
Unknown command '\K'.
ERROR: 
Unknown command '\D'.
    -> C
    -> \c
mysql> C:\Users\karth\Desktop
ERROR: 
Unknown command '\U'.
ERROR: 
Unknown command '\k'.
ERROR: 
Unknown command '\D'.
    -> \c
mysql> exit
