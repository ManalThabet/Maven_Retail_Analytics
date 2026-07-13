# Dataset — Maven Retail Analytics

Raw source data used to build the `RETAIL_Graduation_Project` SQL database and the Power BI Star Schema model. Data covers retail transactions across **3 countries (USA, Mexico, Canada)** over **1997–1998**.

## Files

| File | Table Type | Rows | Description |
|---|---|---|---|
| `Sales_2017.csv` | Fact | 86,838 | 1997 transactions |
| `Sales_2018.csv` | Fact | 182,884 | 1998 transactions |
| `Returns.csv` | Fact | 7,087 | Product returns |
| `Products.csv` | Dimension | 1,560 | Product catalog |
| `Customers.csv` | Dimension | 10,281 | Customer profiles |
| `Stores.csv` | Dimension | 24 | Store locations |
| `Region.csv` | Dimension | 109 | Sales districts & regions |
| `Calendar.csv` / `Calendar_1_.xlsx` | Dimension | 999 | Date table (1997–1998 monthly) |

> **Note:** `Sales_2017.csv` and `Sales_2018.csv` are named by upload year but contain **1997** and **1998** transaction data respectively (see `transaction_date` column) — matching the presentation's "Sales 1997 / Sales 1998" phase description.

---

## Schema Details

### `Sales_2017.csv` / `Sales_2018.csv` (Fact — Sales)
| Column | Type | Description |
|---|---|---|
| `transaction_date` | Date | Date of sale |
| `stock_date` | Date | Date product was stocked |
| `product_id` | Int (FK) | → `Products.product_id` |
| `customer_id` | Int (FK) | → `Customers.customer_id` |
| `store_id` | Int (FK) | → `Stores.store_id` |
| `quantity` | Int | Units sold |

### `Returns.csv` (Fact — Returns)
| Column | Type | Description |
|---|---|---|
| `return_date` | Date | Date of return |
| `product_id` | Int (FK) | → `Products.product_id` |
| `store_id` | Int (FK) | → `Stores.store_id` |
| `quantity` | Int | Units returned |

### `Products.csv` (Dimension)
| Column | Type | Description |
|---|---|---|
| `product_id` | Int (PK) | Unique product identifier |
| `product_brand` | Text | Brand name |
| `product_name` | Text | Product name |
| `product_sku` | Text | SKU code |
| `product_retail_price` | Decimal | Retail price |
| `product_cost` | Decimal | Cost price |
| `product_weight` | Decimal | Weight |
| `recyclable` | Bool | Recyclable packaging flag |
| `low_fat` | Bool | Low-fat flag |

### `Customers.csv` (Dimension)
| Column | Type | Description |
|---|---|---|
| `customer_id` | Int (PK) | Unique customer identifier |
| `customer_acct_num` | Text | Account number |
| `first_name`, `last_name` | Text | Customer name |
| `customer_address`, `customer_city`, `customer_state_province`, `customer_postal_code`, `customer_country` | Text | Address details |
| `birthdate` | Date | Date of birth |
| `marital_status` | Text | M / S |
| `yearly_income` | Text | Income bracket |
| `gender` | Text | M / F |
| `total_children`, `num_children_at_home` | Int | Household details |
| `education` | Text | Education level |
| `acct_open_date` | Date | Account opening date |
| `member_card` | Text | Loyalty tier (Bronze/Silver/Gold) |
| `occupation` | Text | Occupation |
| `homeowner` | Text | Y / N |

### `Stores.csv` (Dimension)
| Column | Type | Description |
|---|---|---|
| `store_id` | Int (PK) | Unique store identifier |
| `region_id` | Int (FK) | → `Region.region_id` |
| `store_type` | Text | e.g. Supermarket, Small Grocery |
| `store_name` | Text | Store name |
| `store_street_address`, `store_city`, `store_state`, `store_country` | Text | Location |
| `store_phone` | Text | Contact number |
| `first_opened_date`, `last_remodel_date` | Date | Store lifecycle dates |
| `total_sqft`, `grocery_sqft` | Int | Store size |

### `Region.csv` (Dimension)
| Column | Type | Description |
|---|---|---|
| `region_id` | Int (PK) | Unique region identifier |
| `sales_district` | Text | District (e.g. San Francisco) |
| `sales_region` | Text | Region grouping (e.g. Central West) |

### `Calendar.csv` (Dimension)
| Column | Type | Description |
|---|---|---|
| `date` | Date | One row per calendar date, used for time intelligence (YoY/MoM DAX measures) |

---

## Relationships (Star Schema)

```
Sales ─────┬── Products (product_id)
           ├── Customers (customer_id)
           ├── Stores (store_id)
           └── Calendar (transaction_date)

Returns ───┬── Products (product_id)
           └── Stores (store_id)

Stores ────── Region (region_id)
```

## Source

This dataset is a variant of the publicly available **Maven Retail / Foodmart-style retail sample dataset** used for training and portfolio data analysis projects. All figures were processed and modeled by the author as part of the Route Academy Data Analysis Diploma graduation project.
