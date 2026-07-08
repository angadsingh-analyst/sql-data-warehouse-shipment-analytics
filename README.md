# SQL Data Warehouse and Shipment Analytics

This project develops and analyses a small dimensional data warehouse using Oracle SQL. It demonstrates star schema design, table creation, data population, primary and foreign key constraints, SQL querying and analytical reporting for shipment performance.

The project is designed as a portfolio example of SQL-based business intelligence and data warehousing.

---

## Project Overview

A data warehouse enables organisations to structure operational data for reporting and decision-making. This project focuses on shipment analytics, where shipment records are modelled using a fact table and supporting dimension tables.

The warehouse supports analysis of shipments by customer, product, date and shipping company. Analytical SQL queries are then used to answer business questions such as identifying top shippers, monthly shipment values, high-value products and valuable customers.

---

## Objectives

- Design a dimensional data warehouse using a star schema
- Create customer, product, shipper and date dimensions
- Create a shipment fact table
- Add primary and foreign key constraints
- Populate the warehouse with sample shipment data
- Run analytical SQL queries for business insights
- Document the schema, logic and query outputs

---

## Data Warehouse Design

The project uses a star schema with one central fact table and four dimension tables.

### Fact Table

```text
SHIP_FACT
```

The shipment fact table captures shipment-level measures such as:

- Shipment ID
- Date ID
- Customer ID
- Product ID
- Shipper ID
- Quantity
- Shipment weight
- Shipping cost

### Dimension Tables

```text
DIM_CUSTOMER
DIM_PRODUCT
DIM_DATE
DIM_SHIPPER
```

These dimensions provide descriptive context for analysing shipments by customer, product, date and shipper.

---

## Methods

The workflow included:

- Creating dimension tables
- Creating the shipment fact table
- Populating tables with sample shipment data
- Adding product names and enrichment fields
- Applying primary key constraints
- Applying foreign key constraints between fact and dimension tables
- Writing SQL queries to answer analytical business questions
- Summarising the query logic and results in a report

---

## Example Business Questions

The SQL analysis answers questions such as:

- Which shipping company completed the most shipments in 2024?
- What was the total shipment value by month?
- Which product generated the highest shipment value in May 2024?
- Which shipping company performed best in each month?
- Who was the most valuable customer in 2024?

---

## Skills Demonstrated

- Oracle SQL
- Data warehouse design
- Dimensional modelling
- Star schema design
- Fact and dimension tables
- Primary and foreign key constraints
- SQL joins
- Aggregation queries
- Date-based filtering
- Business intelligence reporting

---

## Repository Structure

```text
.
├── README.md
├── CLEANING_NOTES.md
├── requirements.txt
├── .gitignore
├── sql/
│   ├── 01_create_and_populate_warehouse.sql
│   ├── 02_constraints_and_enrichment.sql
│   └── 03_analysis_queries.sql
└── report/
    ├── Data_Warehouse_SQL_Analysis_Report_Clean.docx
    └── Data_Warehouse_SQL_Analysis_Report_Clean.pdf
```

---

## How to Run

Run the SQL scripts in order using Oracle SQL Developer, Oracle APEX SQL Workshop or another Oracle-compatible SQL environment.

```text
1. sql/01_create_and_populate_warehouse.sql
2. sql/02_constraints_and_enrichment.sql
3. sql/03_analysis_queries.sql
```

The first script creates and populates the warehouse.  
The second script applies constraints and enrichment updates.  
The third script runs the analytical queries.

---

## Tools

- Oracle SQL
- Oracle APEX
- SQL Developer
- Microsoft Word

---

## Data Availability

This repository includes a cleaned Oracle SQL data warehouse project with table creation scripts, constraint scripts and analytical queries.

Assignment cover pages, student identifiers and submission-specific materials have been removed.

---

## Portfolio Note

This repository is shared as a public portfolio example of SQL data warehousing, dimensional modelling and analytical querying for business intelligence.

---

## Author

Angad Singh  
Master of Predictive Analytics  
Perth, Western Australia
