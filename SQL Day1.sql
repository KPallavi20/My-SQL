In MySQL, Data Definition Language (DDL) commands are used to define, modify, or manage the structure of database objects such as tables, indexes, and views. Here are the common DDL commands in MySQL with their syntax:

1. **CREATE TABLE**:
   - Syntax:
     ```sql
     CREATE TABLE table_name (
         column1 datatype [optional_constraints],
         column2 datatype [optional_constraints],
         ...
     );
     ```

2. **ALTER TABLE**:
   - Syntax (for adding a new column):
     ```sql
     ALTER TABLE table_name
     ADD column_name datatype [optional_constraints];
     ```
   - Syntax (for modifying an existing column):
     ```sql
     ALTER TABLE table_name
     MODIFY column_name datatype [optional_constraints];
     ```
   - Syntax (for dropping a column):
     ```sql
     ALTER TABLE table_name
     DROP COLUMN column_name;
     ```

3. **DROP TABLE**:
   - Syntax:
     ```sql
     DROP TABLE table_name;
     ```

4. **CREATE INDEX**:
   - Syntax:
     ```sql
     CREATE INDEX index_name
     ON table_name (column1, column2, ...);
     ```

5. **DROP INDEX**:
   - Syntax:
     ```sql
     DROP INDEX index_name ON table_name;
     ```

6. **CREATE VIEW**:
   - Syntax:
     ```sql
     CREATE VIEW view_name AS
     SELECT column1, column2, ...
     FROM table_name
     WHERE condition;
     ```

7. **DROP VIEW**:
   - Syntax:
     ```sql
     DROP VIEW view_name;
     ```

8. **CREATE DATABASE**:
   - Syntax:
     ```sql
     CREATE DATABASE database_name;
     ```

9. **DROP DATABASE**:
   - Syntax:
     ```sql
     DROP DATABASE database_name;
     ```

10. **USE DATABASE**:
    - Syntax:
      ```sql
      USE database_name;
      ```

11. **RENAME TABLE** (as of MySQL 8.0):
    - Syntax:
      ```sql
      RENAME TABLE old_table TO new_table;
      ```

12. **TRUNCATE TABLE**:
    - Syntax:
      ```sql
      TRUNCATE TABLE table_name;
      ```


Details of Data Types 

1. Numeric Data Types:
   - INT or INTEGER: Signed integer.
   - TINYINT: Very small integer.
   - SMALLINT: Small integer.
   - MEDIUMINT: Medium-sized integer.
   - BIGINT: Large integer.
   - DECIMAL or NUMERIC: Exact numeric values with a specified number of decimal places.
   - FLOAT: Single-precision floating-point number.
   - DOUBLE or REAL: Double-precision floating-point number.

2. Date and Time Data Types:
   - DATE: Date (YYYY-MM-DD).
   - TIME: Time (HH:MM:SS).
   - DATETIME: Date and time (YYYY-MM-DD HH:MM:SS).
   - TIMESTAMP: Automatic timestamp that updates on record modification.
   - YEAR: Year in 2-digit or 4-digit format.

3. String Data Types:
   - CHAR: Fixed-length character string.
   - VARCHAR: Variable-length character string.
   - TINYTEXT: Very small text.
   - TEXT: Variable-length text.
   - MEDIUMTEXT: Medium-length text.
   - LONGTEXT: Long text.
   - ENUM: Enumeration of possible values.
   - SET: Set of possible values.

4. Binary Data Types:
   - BINARY: Fixed-length binary string.
   - VARBINARY: Variable-length binary string.
   - TINYBLOB: Very small binary object.
   - BLOB: Variable-length binary object.
   - MEDIUMBLOB: Medium-length binary object.
   - LONGBLOB: Long binary object.

5. Spatial Data Types:
   - GEOMETRY: Spatial data type for representing geometric shapes.
   - POINT: A single point in space.
   - LINESTRING: A collection of connected line segments.
   - POLYGON: A closed shape defined by a series of connected points.
   - GEOMETRYCOLLECTION: A collection of one or more geometric objects.
   - MULTILINESTRING: A collection of line strings.
   - MULTIPOINT: A collection of points.
   - MULTIPOLYGON: A collection of polygons.

6. JSON Data Type:
   - JSON: Stores JSON data.

7. Miscellaneous Data Types:
   - BIT: A fixed-length bit field.
   - BOOLEAN: Synonymous with TINYINT(1), used to represent true/false values.
   - SERIAL: An auto-incrementing integer, typically used as a primary key.
   - AUTO_INCREMENT: Auto-incrementing integer, often used as a primary key.

Commands used in class 
-- DDL - create , alter , truncate , drop 

create database pwskills;

use pwskills;



create table pwStudents1 (
studentid int,
student_name char(50), 
student_email varchar(100),
joining_date date,
short_desc text,
marks decimal(3,2) -- 000.00
);

select * from pwstudents;

describe pwstudents;

drop table pwStudents;

drop database pwskills;

alter table pwstudents1 add weight float;

alter table pwstudents drop column short_desc;

alter table pwstudents modify weight int;

alter table pwstudents rename column weight to mass;

describe pwstudents;

select * from pwstudents;

insert into pwstudents value (1,"deepak suneja", "deepak123@gmail.com", "2023-11-11", 8.4 ,67);

select * from pwstudents;

truncate pwstudents;

select * from insurance_data;

truncate insurance_data;

drop table insurance_data;

