import pandas as pd
import numpy as np  

df = pd.read_csv(r"H:\Project\SQL\Swiggy\Silver\silver_swiggy.csv", encoding='utf-8')
df = df.dropna()    
print(df.head())

df['order_date'] = pd.to_datetime(df['order_date'], format='%Y-%m-%d')
df['order_date'] = df['order_date'].dt.strftime('%Y-%m-%d')

print(df.isnull().sum())