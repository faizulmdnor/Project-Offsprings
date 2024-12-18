"""
This script is designed to interact with a SQL database for managing
data efficiently without allowing duplicates.
Key functionalities include:
- Connecting to the database.
- Inserting data from a pandas DataFrame with duplicate-checking logic.

Author: Faizul
email: faizul.mdnoor@gmail.com
"""

import pandas as pd
import pyodbc

SERVER = 'FAIZULONXY\\SQLEXPRESS'
DATABASE = 'offsprings'


conn = pyodbc.connect(f'DRIVER={{SQL Server}};SERVER={SERVER};DATABASE={DATABASE};Trusted_Connection=yes;')
cursor = conn.cursor()
# Removed this global cursor initialization as it is now handled in the class object

class SQL_Operation:
    """
    Manages project-related operations focused on handling table data in a 
    database, with features for ensuring data integrity and avoiding duplicates.

    :ivar conn: The database connection object established through `pyodbc`.
    :type conn: pyodbc.Connection
    :ivar cursor: The database cursor object for executing SQL commands.
    :type cursor: pyodbc.Cursor
    """
    @staticmethod
    def insert_data_no_duplicate(table_name: str, df: pd.DataFrame) -> None:
        """
        Insert data into a table without duplicates in a database.

        This method takes a DataFrame and a target table name and inserts the data
        present in the DataFrame into the specified table in the database. Before
        inserting, it checks whether the record already exists in the table by
        matching all columns. If the record exists, it skips the insertion. If an
        error occurs during the operation, it rolls back the changes and ensures 
        that database connections and cursors are closed properly.

        :param tablename: The name of the table in the database where data 
            should be inserted.
        :type tablename: str
        :param df: A pandas DataFrame that contains the data to be inserted into
            the specified table. Each row of the DataFrame represents a record.
        :type df: pandas.DataFrame
        :return: None
        """
        columns = ', '.join(df.columns)
        placeholder = ', '.join('?' * len(df.columns))

        columns_check = ' AND '.join([f"{col}=?" for col in df.columns])

        sql_check = f'''
            SELECT COUNT(*)
            FROM {table_name}
            WHERE 
            {columns_check}
        '''

        sql_insert = f'''
            INSERT INTO {table_name} ({columns}) VALUES ({placeholder})
        '''

        try:
            for index, row in df.iterrows():
                cursor.execute(sql_check, tuple(row))
                exists = cursor.fetchone()[0] > 0
                if not exists:
                    cursor.execute(sql_insert, tuple(row))
                    conn.commit()
                    print(f"Insert data {tuple(row)} into {table_name} successfully")
                else:
                    print(f"Record already exists in {table_name}: {tuple(row)}")
        except Exception as e:
            conn.rollback()
            print(f"Error: {e}")

        finally:
            if cursor:
                cursor.close()
            if conn:
                conn.close()
