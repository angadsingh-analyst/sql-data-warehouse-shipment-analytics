-- 01_create_and_populate_warehouse.sql
-- Clean Oracle SQL setup script for a shipment analytics data warehouse.
-- Run in Oracle APEX SQL Workshop or another Oracle SQL environment.

-- Optional cleanup for reruns
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ship_fact PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE dim_date PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE dim_product PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE dim_shipper PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE dim_customer PURGE';
EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

CREATE TABLE dim_customer (
    customer_id    NUMBER,
    customer_name  VARCHAR2(30),
    customer_city  VARCHAR2(30),
    customer_state VARCHAR2(10)
);

INSERT INTO dim_customer VALUES (1, 'Customer 01', 'Willetton',  'WA');
INSERT INTO dim_customer VALUES (2, 'Customer 02', 'Ludlow',     'WA');
INSERT INTO dim_customer VALUES (3, 'Customer 03', 'Nowergup',   'WA');
INSERT INTO dim_customer VALUES (4, 'Customer 04', 'Clifton',    'WA');
INSERT INTO dim_customer VALUES (5, 'Customer 05', 'Talgomine',  'WA');

CREATE TABLE dim_shipper (
    shipper_id   NUMBER,
    ship_name    VARCHAR2(30),
    ship_city    VARCHAR2(30),
    ship_state   VARCHAR2(10)
);

INSERT INTO dim_shipper VALUES (1, 'Shipping Novelty', 'Welshpool',  'WA');
INSERT INTO dim_shipper VALUES (2, 'Shipping Experts', 'Bayswater',  'WA');
INSERT INTO dim_shipper VALUES (3, 'Happy Shipping',   'Cannington', 'WA');
INSERT INTO dim_shipper VALUES (4, 'Cutesy Shipping',  'Byford',     'WA');
INSERT INTO dim_shipper VALUES (5, 'Shipping Success', 'Bentley',    'WA');

CREATE TABLE dim_product (
    product_id   NUMBER,
    product_cost NUMBER
);

INSERT INTO dim_product VALUES (1, 55);
INSERT INTO dim_product VALUES (2, 65);
INSERT INTO dim_product VALUES (3, 25);
INSERT INTO dim_product VALUES (4, 30);
INSERT INTO dim_product VALUES (5, 15);

CREATE TABLE dim_date (
    date_id   NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    ship_date DATE
);

INSERT INTO dim_date (ship_date)
SELECT DATE '2024-01-01' + LEVEL - 1 AS ship_date
FROM dual
CONNECT BY LEVEL <= (DATE '2024-12-31' - DATE '2024-01-01' + 1);

CREATE TABLE ship_fact (
    shipment_id  NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    date_id      NUMBER NOT NULL,
    customer_id  NUMBER NOT NULL,
    shipper_id   NUMBER NOT NULL,
    product_id   NUMBER NOT NULL,
    quantity     NUMBER,
    shipment_wgt NUMBER,
    ship_cost    NUMBER
);

BEGIN
    DBMS_RANDOM.SEED(2025);
END;
/

INSERT INTO ship_fact (
    date_id,
    customer_id,
    shipper_id,
    product_id,
    quantity,
    shipment_wgt,
    ship_cost
)
SELECT
    TRUNC(DBMS_RANDOM.VALUE(low => 1, high => 366)) AS date_id,
    TRUNC(DBMS_RANDOM.VALUE(low => 1, high => 6)) AS customer_id,
    TRUNC(DBMS_RANDOM.VALUE(low => 1, high => 6)) AS shipper_id,
    TRUNC(DBMS_RANDOM.VALUE(low => 1, high => 6)) AS product_id,
    ROUND(DBMS_RANDOM.VALUE(low => 1, high => 100), 2) AS quantity,
    ROUND(DBMS_RANDOM.VALUE(low => 1, high => 100), 2) AS shipment_wgt,
    ROUND(DBMS_RANDOM.VALUE(low => 1, high => 100), 2) AS ship_cost
FROM dual
CONNECT BY LEVEL <= 10000;

COMMIT;
