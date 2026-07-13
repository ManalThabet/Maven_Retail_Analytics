CREATE DATABASE RETAIL_Graduation_Project;
USE RETAIL_Graduation_Project;

CREATE TABLE Products (
    product_id int primary key,
    product_brand nvarchar(255),
    product_name nvarchar(255),
    product_sku nvarchar(50),
    product_retail_price decimal(10,2),
    product_cost decimal(10,2),
    product_weight decimal(10,2),
    recyclable BIT,
    low_fat BIT
    
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_acct_num  bigint,
    first_name NVARCHAR(100),
    last_name NVARCHAR(100),
    customer_address nvarchar(255),
    customer_city nvarchar(100),
    customer_state_province nvarchar(100),
    customer_postal_code nvarchar(50),
    customer_country nvarchar(100),
    birthdate date,
    marital_status char(1),
    yearly_income nvarchar(50),
    gender char(1),
    total_children int,
    num_children_at_home int,
    education nvarchar(100),
    acct_open_date date,
    member_card nvarchar(50),
    occupation nvarchar(100),
    homeowner char(1)
);

CREATE TABLE Region (
    region_id int primary key,
    sales_district nvarchar(MAX),
    sales_region nvarchar(MAX)
);

CREATE TABLE Stores (
    store_id int primary key,
    region_id int,
    store_type nvarchar(100),
    store_name nvarchar(100),
    store_street_address nvarchar(255),
    store_city nvarchar(100),
    store_state nvarchar(100),
    store_country nvarchar(100),
    store_phone nvarchar(50),
    first_opened_date date,
    last_remodel_date date,
    total_sqft int,
    grocery_sqft int,
    FOREIGN KEY (region_id) REFERENCES Region(region_id)
);
CREATE TABLE Sales (
    transaction_date date,
    stock_date date,
    product_id int,
    customer_id int,
    store_id int,
    quantity int,
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id)
);
CREATE TABLE Returns(
    return_date date,
    product_id int,
    store_id int,
    quantity int,
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id)
);
CREATE TABLE Calendar (
    date DATE PRIMARY KEY
);
DROP TABLE IF EXISTS Sales, Returns, Stores, Customers, Products,Product, Region, Calendar;
