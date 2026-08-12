import pandas as pd
import sqlite3

csv_path = "../data/processed/diabetic_data_preprocessed.csv"
db_path = "../data/processed/healthcare_readmissions.db"

df = pd.read_csv(csv_path)

conn = sqlite3.connect(db_path)

df.to_sql(
    "diabetic_readmissions",
    conn,
    if_exists="replace",
    index=False
)

conn.close()

print("Data loaded into SQLite database successfully.")