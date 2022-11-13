import pandas as pd
import pyodbc

data = pd.read_csv (r'C:\Users\Guest123\Desktop\Jobs_Database\outputtweet.csv')
df = pd.DataFrame(data)

conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=;LAPTOP-S7VAF7BC\SQLEXPRESS'
                      'Database=twitterdata;'
                      'Trusted_Connection=yes;')
cursor = conn.cursor()
cursor.execute('''CREATE TABLE twitterdata(SNO int, ID int NOT NULL IDENTITY(1, 1), Tweet varchar(255), location varchar(255), statuses int, PRIMARY KEY(ID));''')
conn.commit()

for index, row in df.iterrows():
     cursor.execute("INSERT INTO twitterdata (SNO, ID, Tweet, location, statuses) values(?,?,?,?,?)", row.SNO, row.ID, row.Tweet, row.location, row.statuses)
conn.commit()
cursor.close()
print()