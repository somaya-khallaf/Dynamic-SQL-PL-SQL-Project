# PL/SQL Dynamic DDL Project
This project provides PL/SQL scripts for dynamically generating and managing DDL statements. The main focus is on creating sequence-trigger pairs for all tables in a schema using loops, ensuring proper sequence initialization, and avoiding conflicts with existing triggers.
## **The project includes:**
  1. Dropping existing sequences.
  2. Replacing existing triggers (if any).
  3. Creating new sequences starting with MAX(ID) + 1 for each table.
  4. Handling primary key columns and ignoring non-numeric or composite keys.

## **Key Features:**
  1. **Dynamic SQL Execution:** DDL statements written inside PL/SQL code.
  2. **Automation:** Loops through all tables in the schema to create sequences and triggers.
  3. **Error Handling:** Ignores tables with non-numeric or composite primary keys.
  4. **Flexibility:** Sequences are set to start with MAX(ID) + 1 for each table.

 ## **Installation & Setup:**
  **Prerequisites:**
      - Oracle Database.
      - SQL*Plus, SQLcl, or any PL/SQL execution tool.
    
  **Steps to Run:**
      1. Clone the repository:
        - git clone [https://github.com/yourusername/plsql-dynamic-ddl.git](https://github.com/somaya-khallaf/Dynamic-SQL-PL-SQL-Project.git)
        - cd plsql-dynamic-ddl
      2. Connect to the database using SQL*Plus or an equivalent tool.
      3. Run the scripts in the following order:
        - @package_spec.sql;
        - @package_body.sql;
        - @anonymous_block.sql;
      4. Verify that sequences and triggers are created successfully.
