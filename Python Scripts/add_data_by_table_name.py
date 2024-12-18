import pandas as pd
from offsprings_project import SQL_Operation


data = pd.read_csv('../Data/Person.csv')


SQL_Operation.insert_data_no_duplicate(table_name='Person', df=data)
