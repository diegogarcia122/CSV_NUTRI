import pyodbc
import Data as D
import pandas as pd

server = D.server
database = D.database
username = D.user
password = D.password

connectionString = f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}'
conn = pyodbc.connect(connectionString, autocommit=True)
cursor = conn.cursor()

def executeScriptsFromFile(filename):
    fd = open(filename, 'r')
    sqlFile = fd.read()
    fd.close()
    sqlCommands = sqlFile.split(';')
    for command in sqlCommands:
        try:
            cursor.execute(command)
        except Exception as e:
            print("Command skipped: ", e)

sqlfile = open('query.sql', 'r')
queryfile = sqlfile.read()
sqlfile.close()
splitQueries = queryfile.split(';')

with open('query.sql', 'r') as file:
    query = file.read()

df = pd.read_sql_query(query,conn)

df = df.fillna(value=0)

executeScriptsFromFile('NewTable.sql')

with open('insert.sql', 'r') as file:
    query = file.read()

for index, row in df.iterrows():
     cursor.execute(query, 
                    row.YearStart, row.YearEnd, row.LocationAbbr, row.LocationDesc, row.Datasource, row.Class, row.Topic, row.Question, row.Data_Value_Unit, 
                    row.Data_Value_Type, row.Data_Value, row.Data_Value_Alt, row.Data_Value_Footnote_Symbol, row.Data_Value_Footnote, row.Low_Confidence_Limit, 
                    row.High_Confidence_Limit, row.Sample_Size, row.Total, row.Age_years, row.Education, row.Gender, row.Income, row.Race_Ethnicity, row.GeoLocation, 
                    row.ClassID, row.TopicID, row.QuestionID, row.DataValueTypeID, row.LocationID, row.StratificationCategory1, row.Stratification1, row.StratificationCategoryId1, 
                    row.StratificationID1)

with open('DBCreate.sql', 'r') as file:
    query = file.read()

cursor.execute(query)

executeScriptsFromFile('create_dimensional_model.sql')

