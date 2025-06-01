# Data Catalog for Gold Layer

## Overview
The **Gold Layer** is the business-level data representation, structured to support analytical and reporting use cases. It consists of **dimension tables** and **fact tables** for specific business metrics.

---

## 1. `gold.dim_customers`

**Purpose:**  
Stores customer details enriched with demographic and geographic data.

**Columns:**

| Column Name      | Data Type      | Description                                                                 |
|------------------|----------------|-----------------------------------------------------------------------------|
| `customer_key`   | INT            | Surrogate key uniquely identifying each customer record in the dimension.  |
| `customer_id`    | INT            | Unique numerical identifier assigned to each customer.                     |
| `customer_number`| NVARCHAR(50)   | Alphanumeric identifier used for tracking and referencing the customer.    |
| `first_name`     | NVARCHAR(50)   | The customer's first name.                                                 |
| `last_name`      | NVARCHAR(50)   | The customer's last name or family name.                                   |
| `country`        | NVARCHAR(50)   | Country of residence (e.g., 'Australia').                                  |
| `marital_status` | NVARCHAR(50)   | Marital status (e.g., 'Married', 'Single').                                |
| `gender`         | NVARCHAR(50)   | Gender of the customer (e.g., 'Male', 'Female', 'n/a').                    |
| `birthdate`      | DATE           | Date of birth (format: YYYY-MM-DD, e.g., 1971-10-06).                       |
| `create_date`    | DATE           | Date and time when the customer record was created in the system.          |

---

## 2. `gold.dim_products`

**Purpose:**  
Provides information about the products and their attributes.

**Columns:**

| Column Name         | Data Type    | Description                                                                 |
|---------------------|--------------|-----------------------------------------------------------------------------|
| `product_key`       | INT          | Surrogate key uniquely identifying each product record.                     |
| `product_id`        | INT          | Unique identifier for internal tracking and referencing.                    |
| `product_number`    | NVARCHAR(50) | Alphanumeric code representing the product.                                 |
| `product_name`      | NVARCHAR(50) | Descriptive name including type, color, and size.                           |
| `category_id`       | NVARCHAR(50) | Unique identifier for the product's category.                               |
| `category`          | NVARCHAR(50) | Broad classification (e.g., Bikes, Components).                            |
| `subcategory`       | NVARCHAR(50) | Detailed classification within the category.                                |
| `maintenance_required` | NVARCHAR(50) | Indicates if maintenance is required (e.g., 'Yes', 'No').                |
| `cost`              | INT          | Cost or base price of the product.                                          |
| `product_line`      | NVARCHAR(50) | Specific product line or series (e.g., Road, Mountain).                     |
| `start_date`        | DATE         | Date the product became available for sale or use.                          |

---

## 3. `gold.fact_sales`

**Purpose:**  
Stores transactional sales data for analytical purposes.

**Columns:**

| Column Name    | Data Type    | Description                                                                 |
|----------------|--------------|-----------------------------------------------------------------------------|
| `order_number` | NVARCHAR(50) | Unique alphanumeric identifier for each sales order (e.g., 'SO54496').      |
| `product_key`  | INT          | Surrogate key linking to the product dimension.                             |
| `customer_key` | INT          | Surrogate key linking to the customer dimension.                            |
| `order_date`   | DATE         | Date when the order was placed.                                             |
| `shipping_date`| DATE         | Date when the order was shipped.                                            |
| `due_date`     | DATE         | Date when the payment for the order was due.                                |
| `sales_amount` | INT          | Total monetary value of the sale (e.g., 25).                                |
| `quantity`     | INT          | Number of units ordered.                                                    |
| `price`        | INT          | Price per unit of the product.                                              |

---
