
IF NOT EXISTS (SELECT * FROM sys.key_constraints WHERE type = 'PK' AND parent_object_id = OBJECT_ID('Customers'))
BEGIN
    ALTER TABLE Customers ALTER COLUMN customer_id INT NOT NULL;
    ALTER TABLE Customers ADD PRIMARY KEY (customer_id);
END

IF NOT EXISTS (SELECT * FROM sys.key_constraints WHERE type = 'PK' AND parent_object_id = OBJECT_ID('Stores'))
BEGIN
    ALTER TABLE Stores ALTER COLUMN store_id INT NOT NULL;
    ALTER TABLE Stores ADD PRIMARY KEY (store_id);
END


IF NOT EXISTS (SELECT * FROM sys.key_constraints WHERE type = 'PK' AND parent_object_id = OBJECT_ID('Region'))
BEGIN
    ALTER TABLE Region ALTER COLUMN region_id TINYINT NOT NULL;
    ALTER TABLE Region ADD PRIMARY KEY (region_id);
END