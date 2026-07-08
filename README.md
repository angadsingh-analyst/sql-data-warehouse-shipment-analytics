# SQL Data Warehouse and Shipment Analytics

## Project Overview

This project builds a small Oracle SQL data warehouse for shipment analytics using a dimensional modelling approach. It demonstrates how fact and dimension tables can be designed, populated, constrained and queried to answer business questions about shipment volume, shipment value, product performance, shipper performance and customer value.

The project was originally developed as a Business Intelligence and Analytics coursework task. This repository is a cleaned portfolio version with personal identifiers, assignment cover sheets and private submission material removed.

## Business Problem

The business requires a structured data warehouse to analyse shipment activity across customers, products, shippers and dates. The model supports questions such as:

- Which shipper completed the most shipments in 2024?
- What was the monthly shipment value in 2024?
- Which product generated the highest shipment value in May 2024?
- Which shipper performed best by month?
- Which customer generated the highest shipment value?

## Data Warehouse Design

The warehouse follows a star-schema structure:

- `SHIP_FACT` - shipment-level fact table
- `DIM_CUSTOMER` - customer dimension
- `DIM_PRODUCT` - product dimension
- `DIM_SHIPPER` - shipper dimension
- `DIM_DATE` - date dimension

The fact table uses shipment-level grain: each row represents one product shipment to one customer on one date through one shipper.

## Methods

- Created dimension and fact tables in Oracle SQL.
- Populated lookup dimensions and generated shipment facts.
- Added product names and sample business records.
- Added primary key and foreign key constraints.
- Wrote analytical SQL queries using joins, aggregation, date extraction, ordering and ranking.
- Prepared a clean report summarising the design, SQL logic and key outputs.

## Key Outputs

- Dimensional model for shipment analytics.
- Oracle SQL schema creation and population scripts.
- Constraint and enrichment script for warehouse integrity.
- Analytical query script for shipment performance reporting.
- Clean portfolio report documenting the project.

## Tools and Skills

- Oracle SQL
- Oracle APEX / SQL Workshop
- Data warehousing
- Dimensional modelling
- Star schema design
- Primary and foreign key constraints
- Analytical SQL queries
- Business intelligence reporting

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

## How to Run

1. Open Oracle APEX SQL Workshop or another Oracle SQL environment.
2. Run `sql/01_create_and_populate_warehouse.sql`.
3. Run `sql/02_constraints_and_enrichment.sql`.
4. Run selected queries from `sql/03_analysis_queries.sql`.

The scripts are intended for Oracle SQL. Some syntax, such as identity columns, `CONNECT BY`, `DBMS_RANDOM`, `FETCH FIRST`, and `EXTRACT`, is Oracle-specific.

## Portfolio Note

This repository is a cleaned portfolio version. Personal identifiers, assignment cover sheets, AI declaration text, screenshots containing private schema details and submission-style filenames have been excluded.
