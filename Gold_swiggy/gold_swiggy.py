import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

## total sales by city
df = pd.read_csv(r"H:\Project\SQL\Swiggy\Silver\silver_swiggy.csv", encoding='utf-8')
df = df.dropna()
plt.figure(figsize=(12, 6))
sns.barplot(x='city', y='quantity', data=df, palette='viridis')
plt.title('Total Sales by City')        
plt.xlabel('City')
plt.ylabel('Total Sales')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig(r"H:\Project\SQL\Swiggy\Gold\total_sales_by_city.png")
plt.show()



## total sales by month

# --- Ensure correct types for plotting ---
df['order_date'] = pd.to_datetime(df['order_date'], format='%Y-%m-%d', errors='coerce')
df = df.dropna(subset=['order_date', 'quantity'])
df['month'] = df['order_date'].dt.to_period('M').astype(str)
df['quantity'] = pd.to_numeric(df['quantity'], errors='coerce')
df = df.dropna(subset=['quantity'])
monthly_sales = df.groupby('month', as_index=False)['quantity'].sum()

print('monthly_sales dtypes:')
print(monthly_sales.dtypes)
print(monthly_sales.head())

plt.figure(figsize=(12, 6))
sns.lineplot(x='month', y='quantity', data=monthly_sales, marker='o', color='blue')
plt.title('Total Sales by Month')
plt.xlabel('Month')
plt.ylabel('Total Sales')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig(r"H:\Project\SQL\Swiggy\Gold\total_sales_by_month.png")
plt.show()

## total sales by food item
top_food_items = df.groupby('cuisine_type')['quantity'].sum().reset_index().sort_values(by='quantity', ascending=False)
plt.figure(figsize=(12, 6))
sns.barplot(x='cuisine_type', y='quantity', data=top_food_items, palette='magma')
plt.title('Total Sales by Food Item')   
plt.xlabel('Food Item')
plt.ylabel('Total Sales')
plt.xticks(rotation=45)
plt.tight_layout()  
plt.savefig(r"H:\Project\SQL\Swiggy\Gold\total_sales_by_food_item.png")
plt.show()




## revenue by city
city_revenue = df.groupby('city')['total_amount'].sum().reset_index()
plt.figure(figsize=(12, 6))
sns.barplot(x='city', y='total_amount', data=city_revenue, palette='coolwarm')
plt.title('Revenue by City')    
plt.xlabel('City')
plt.ylabel('Total Revenue') 
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig(r"H:\Project\SQL\Swiggy\Gold\revenue_by_city.png")
plt.show()


## revenue by month
monthly_revenue = df.groupby('month')['total_amount'].sum().reset_index()
plt.figure(figsize=(12, 6))
sns.lineplot(x='month', y='total_amount', data=monthly_revenue, marker='o', color='green')
plt.title('Revenue by Month')
plt.xlabel('Month')
plt.ylabel('Total Revenue')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig(r"H:\Project\SQL\Swiggy\Gold\revenue_by_month.png")
plt.show()

## revenue by food item
top_food_revenue = df.groupby('cuisine_type')['total_amount'].sum().reset_index().sort_values(by='total_amount', ascending=False)
plt.figure(figsize=(12, 6))
sns.barplot(x='cuisine_type', y='total_amount', data=top_food_revenue, palette='plasma')
plt.title('Revenue by Food Item')
plt.xlabel('Food Item')
plt.ylabel('Total Revenue')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig(r"H:\Project\SQL\Swiggy\Gold\revenue_by_food_item.png")
plt.show()


## pie chart of loyalty_status
loyalty_counts = df['loyalty_status'].value_counts()
plt.figure(figsize=(8, 8))  
plt.pie(loyalty_counts, labels=loyalty_counts.index, autopct='%1.1f%%', startangle=140, colors=sns.color_palette('pastel'))
plt.title('Loyalty Status Distribution')
plt.axis('equal')
plt.tight_layout()
plt.savefig(r"H:\Project\SQL\Swiggy\Gold\loyalty_status_distribution.png")
plt.show()

## distribution of payment methods
payment_counts = df['payment_method'].value_counts()
plt.figure(figsize=(8, 6))  
sns.barplot(x=payment_counts.index, y=payment_counts.values, palette='Set2')
plt.title('Distribution of Payment Methods')    
plt.xlabel('Payment Method')
plt.ylabel('Count')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig(r"H:\Project\SQL\Swiggy\Gold\payment_method_distribution.png")
plt.show()

## order_status distribution
order_status_counts = df['order_status'].value_counts()
plt.figure(figsize=(8, 6))
sns.barplot(x=order_status_counts.index, y=order_status_counts.values, palette='Set1')
plt.title('Order Status Distribution')
plt.xlabel('Order Status')
plt.ylabel('Count')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig(r"H:\Project\SQL\Swiggy\Gold\order_status_distribution.png")
plt.show()

## item_name distribution
item_counts = df['item_name'].value_counts().head(10)  # Top 10 items
plt.figure(figsize=(12, 6)) 
sns.barplot(x=item_counts.index, y=item_counts.values, palette='cool')
plt.title('Top 10 Food Items Ordered')
plt.xlabel('Food Item')
plt.ylabel('Count')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig(r"H:\Project\SQL\Swiggy\Gold\top_food_items.png")
plt.show()


## avg delivery time by city
avg_delivery_time = df.groupby('city')['delivery_time_mins'].mean().reset_index()
plt.figure(figsize=(12, 6))
sns.barplot(x='city', y='delivery_time_mins', data=avg_delivery_time, palette='rocket')
plt.title('Average Delivery Time by City')  
plt.xlabel('City')
plt.ylabel('Average Delivery Time (mins)')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig(r"H:\Project\SQL\Swiggy\Gold\avg_delivery_time_by_city.png")
plt.show()

## veg or non-veg distribution
veg_counts = df['is_veg'].value_counts()
plt.figure(figsize=(8, 6))
sns.barplot(x=veg_counts.index, y=veg_counts.values, palette='Set3')
plt.title('Vegetarian vs Non-Vegetarian Orders')
plt.xlabel('Vegetarian Status')
plt.ylabel('Count')
plt.xticks(rotation=0)
plt.tight_layout()
plt.savefig(r"H:\Project\SQL\Swiggy\Gold\veg_nonveg_distribution.png")
plt.show()

## restaurant ratings distribution
plt.figure(figsize=(8, 6))  
sns.histplot(df['restaurant_rating'], bins=10, kde=True, color='purple')
plt.title('Distribution of Restaurant Ratings')
plt.xlabel('Restaurant Rating')
plt.ylabel('Frequency')
plt.tight_layout()
plt.savefig(r"H:\Project\SQL\Swiggy\Gold\restaurant_rating_distribution.png")
plt.show()