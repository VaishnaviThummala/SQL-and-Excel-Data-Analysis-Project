-- KPI's
-- 1. Total Revenue
select sum(total_price) as TotalRevenue
from sales

-- 2.Average Order Value
select sum(total_price)/ count(distinct(order_id)) as AvgOrderValue
from sales 

--3.Total Pizzas sold
select sum(quantity) as TotalPizzasSold
from sales

--4.Total Orders
select count(distinct(order_id)) as TotalOrders
from sales

--5.Avereage Pizzas per order
select sum(quantity)/count(distinct(order_id)) as AvgpizzasperOrder
from sales

--Daily trend for Total Orders
select DATENAME(DW, order_date) as OrderDay, Count(distinct(order_id)) as TotalOrders
from sales
group by DATENAME(DW, order_date)
order by DATENAME(DW, order_date)

--Hourly Trend for total Orders
select DATEPART(hour, order_time) as orderhours,Count(distinct(order_id)) as TotalOrders
from sales
group by DATEPART(hour, order_time)
order by DATEPART(hour, order_time)

--Sales Percentage by Pizza Category
select pizza_category, sum(total_price) as TotalSales, sum(total_price)*100/(select sum(total_price) from sales) as TotalSalesPercentage
from sales
group by pizza_category

--Sales Percentage by Pizza Category per month
select pizza_category, sum(total_price) as TotalSales, sum(total_price)*100/(select sum(total_price) from sales where month(order_date)=1) as TotalSalesPercentage
from sales
where month(order_date)=1
group by pizza_category

--Sales Percentage by Pizza Category per quater
select pizza_category, sum(total_price) as TotalSales, sum(total_price)*100/(select sum(total_price) from sales where DATEPART(quarter,order_date)=1) as TotalSalesPercentage
from sales
where datepart(QUARTER,order_date)=1
group by pizza_category

--sales percentage by pizza size
select pizza_size, sum(total_price) as TotalSales, cast(sum(total_price)*100/(select sum(total_price) from sales) as decimal (10,2)) as TotalSalesPercentage
from sales
group by pizza_size
order by TotalSalesPercentage desc

--Pizzas Sold by Each Category
select pizza_category, sum(quantity) as PizzasSold
from sales
group by pizza_category

--Top 5 Sellers
select top 5 pizza_name, sum(quantity) as PizzasSold
from sales
group by pizza_name
order by PizzasSold desc

--Bottom  5 Sellers
select top 5 pizza_name, sum(quantity) as PizzasSold
from sales
group by pizza_name
order by PizzasSold 