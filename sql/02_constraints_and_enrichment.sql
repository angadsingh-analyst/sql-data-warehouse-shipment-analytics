-- 02_constraints_and_enrichment.sql
-- Adds product names, keys, relationships and one sample business record.

ALTER TABLE dim_product ADD product_name VARCHAR2(100);

UPDATE dim_product SET product_name = 'Body Wash'        WHERE product_id = 1;
UPDATE dim_product SET product_name = 'Body Lotion'      WHERE product_id = 2;
UPDATE dim_product SET product_name = 'Fragrance'        WHERE product_id = 3;
UPDATE dim_product SET product_name = 'LED Light Strips' WHERE product_id = 4;
UPDATE dim_product SET product_name = 'Pillow Case'      WHERE product_id = 5;

ALTER TABLE dim_customer ADD CONSTRAINT pk_dim_customer PRIMARY KEY (customer_id);
ALTER TABLE dim_product  ADD CONSTRAINT pk_dim_product  PRIMARY KEY (product_id);
ALTER TABLE dim_date     ADD CONSTRAINT pk_dim_date     PRIMARY KEY (date_id);
ALTER TABLE dim_shipper  ADD CONSTRAINT pk_dim_shipper  PRIMARY KEY (shipper_id);
ALTER TABLE ship_fact    ADD CONSTRAINT pk_ship_fact    PRIMARY KEY (shipment_id);

ALTER TABLE ship_fact ADD CONSTRAINT fk_ship_fact_customer
    FOREIGN KEY (customer_id) REFERENCES dim_customer (customer_id);

ALTER TABLE ship_fact ADD CONSTRAINT fk_ship_fact_product
    FOREIGN KEY (product_id) REFERENCES dim_product (product_id);

ALTER TABLE ship_fact ADD CONSTRAINT fk_ship_fact_date
    FOREIGN KEY (date_id) REFERENCES dim_date (date_id);

ALTER TABLE ship_fact ADD CONSTRAINT fk_ship_fact_shipper
    FOREIGN KEY (shipper_id) REFERENCES dim_shipper (shipper_id);

-- Sample additional business records
INSERT INTO dim_customer (customer_id, customer_name, customer_city, customer_state)
VALUES (20, 'Customer 20', 'Kalgoorlie', 'WA');

INSERT INTO dim_shipper (shipper_id, ship_name, ship_city, ship_state)
VALUES (30, 'Regional Shipper', 'Welshpool', 'WA');

INSERT INTO dim_product (product_id, product_name, product_cost)
VALUES (10, 'Novelty Glasses', 25);

INSERT INTO ship_fact (date_id, customer_id, shipper_id, product_id, quantity, shipment_wgt, ship_cost)
VALUES (83, 20, 30, 10, 25, 2, 47);

COMMIT;
