import pandas as pd
from offsprings_project import SQL_Operation

data = pd.read_csv('../Data/Penempatan_Sekolah.csv')

SQL_Operation.insert_data_no_duplicate(table_name='Penempatan_Sekolah', df=data)
