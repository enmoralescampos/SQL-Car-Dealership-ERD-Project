-- ERD Project Estefany Morales Campos

-- create Customer table
CREATE TABLE "Customer" (
  "customer_id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(45),
  "last_name" VARCHAR(45),
  "email" VARCHAR(50),
  "address" VARCHAR(100)
);

-- create Car table
CREATE TABLE "Car" (
  "car_id" SERIAL PRIMARY KEY,
  "serial_number" INTEGER UNIQUE,
  "year" INTEGER,
  "model" VARCHAR(50),
  "make" VARCHAR(50),
  "new" BOOL,
  "color" VARCHAR(150),
  "price" DECIMAL,
  "mileage" INTEGER,
  "last_update" TIMESTAMP
);

-- create Mechanic table
CREATE TABLE "Mechanic" (
  "mechanic_id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(45),
  "last_name" VARCHAR(45),
  "email" VARCHAR(50),
  "address" VARCHAR(100)
);

-- create Salesperson table
CREATE TABLE "Salesperson" (
  "sales_id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(45),
  "last_name" VARCHAR(45),
  "email" VARCHAR(50),
  "address" VARCHAR(100),
  "username" VARCHAR(16),
  "password" VARCHAR(40)
);

-- create ServiceTicket table
CREATE TABLE "ServiceTicket" (
  "serial_number" SERIAL PRIMARY KEY,
  "repair_type" VARCHAR(150),
  "amount" DECIMAL,
  "mileage" INTEGER,
  "mechanic_id" INTEGER,
  "car_id" INTEGER,
  "customer_id" INTEGER,
  FOREIGN KEY ("mechanic_id") REFERENCES "Mechanic"("mechanic_id"),
  FOREIGN KEY ("car_id") REFERENCES "Car"("car_id"),
  FOREIGN KEY ("customer_id") REFERENCES "Customer"("customer_id")
);

-- create Invoice table
CREATE TABLE "Invoice" (
  "invoice_id" SERIAL PRIMARY KEY,
  "amount" DECIMAL,
  "sale_date" TIMESTAMP,
  "customer_id" INTEGER,
  "sales_id" INTEGER,
  "car_id" INTEGER,
  FOREIGN KEY ("customer_id") REFERENCES "Customer"("customer_id"),
  FOREIGN KEY ("sales_id") REFERENCES "Salesperson"("sales_id"),
  FOREIGN KEY ("car_id") REFERENCES "Car"("car_id")
);

-- add foreign key in Customer table to reference Car
ALTER TABLE "Customer"
ADD CONSTRAINT "FK_Customer_Car"
FOREIGN KEY ("car_id") REFERENCES "Car"("car_id");



-- function to add a customer
CREATE OR REPLACE FUNCTION add_customer(
    first_name VARCHAR,
    last_name VARCHAR,
    email VARCHAR,
    address VARCHAR,
    car_id INTEGER DEFAULT NULL
) RETURNS VOID AS $$
BEGIN
    INSERT INTO "Customer" (first_name, last_name, email, address, car_id)
    VALUES (first_name, last_name, email, address, car_id);
END;
$$ LANGUAGE plpgsql;


-- function to add a car
CREATE OR REPLACE FUNCTION add_car(
    serial_number INTEGER,
    year INTEGER,
    model VARCHAR,
    make VARCHAR,
    is_new BOOL,
    color VARCHAR,
    price DECIMAL,
    mileage INTEGER,
    last_update TIMESTAMP
) RETURNS VOID AS $$
BEGIN
    INSERT INTO "Car" (serial_number, year, model, make, new, color, price, mileage, last_update)
    VALUES (serial_number, year, model, make, is_new, color, price, mileage, last_update);
END;
$$ LANGUAGE plpgsql;


-- function to add a mechanic
CREATE OR REPLACE FUNCTION add_mechanic(
    first_name VARCHAR,
    last_name VARCHAR,
    email VARCHAR,
    address VARCHAR
) RETURNS VOID AS $$
BEGIN
    INSERT INTO "Mechanic" (first_name, last_name, email, address)
    VALUES (first_name, last_name, email, address);
END;
$$ LANGUAGE plpgsql;


-- function to add a salesperson
CREATE OR REPLACE FUNCTION add_salesperson(
    first_name VARCHAR,
    last_name VARCHAR,
    email VARCHAR,
    address VARCHAR,
    username VARCHAR,
    password VARCHAR
) RETURNS VOID AS $$
BEGIN
    INSERT INTO "Salesperson" (first_name, last_name, email, address, username, password)
    VALUES (first_name, last_name, email, address, username, password);
END;
$$ LANGUAGE plpgsql;


-- function to add a service ticket
CREATE OR REPLACE FUNCTION add_service_ticket(
    repair_type VARCHAR,
    amount DECIMAL,
    mileage INTEGER,
    mechanic_id INTEGER,
    car_id INTEGER,
    customer_id INTEGER
) RETURNS VOID AS $$
BEGIN
    INSERT INTO "ServiceTicket" (repair_type, amount, mileage, mechanic_id, car_id, customer_id)
    VALUES (repair_type, amount, mileage, mechanic_id, car_id, customer_id);
END;
$$ LANGUAGE plpgsql;


-- function to add an invoice
CREATE OR REPLACE FUNCTION add_invoice(
    amount DECIMAL,
    sale_date TIMESTAMP,
    customer_id INTEGER,
    sales_id INTEGER,
    car_id INTEGER
) RETURNS VOID AS $$
BEGIN
    INSERT INTO "Invoice" (amount, sale_date, customer_id, sales_id, car_id)
    VALUES (amount, sale_date, customer_id, sales_id, car_id);
END;
$$ LANGUAGE plpgsql;


-- first addition into database
-- Add a customer
SELECT add_customer('John', 'Doe', 'john.doe@example.com', '123 Main St', 1);

-- Add a car
SELECT add_car(123456, 2023, 'Model S', 'Tesla', TRUE, 'Red', 79999.99, 0, CURRENT_TIMESTAMP);

-- Add a mechanic
SELECT add_mechanic('Jane', 'Smith', 'jane.smith@example.com', '456 Elm St');

-- Add a salesperson
SELECT add_salesperson('Tom', 'Brown', 'tom.brown@example.com', '789 Oak St', 'tombrown', 'securepassword');

-- Add a service ticket
SELECT add_service_ticket('Oil Change', 99.99, 15000, 1, 1, 1);

-- Add an invoice
SELECT add_invoice(79999.99, CURRENT_TIMESTAMP, 1, 1, 1);


-- Second addition to the database

--Add a customer
SELECT add_customer('Alice', 'Johnson', 'alice.johnson@example.com', '789 Pine St');

-- Add a car
SELECT add_car(654321, 2022, 'Camry', 'Toyota', TRUE, 'Blue', 30000.00, 0, CURRENT_TIMESTAMP);

-- Add a mechanic
SELECT add_mechanic('Robert', 'Green', 'robert.green@example.com', '123 Willow St');

-- Add a salesperson
SELECT add_salesperson('Emma', 'White', 'emma.white@example.com', '456 Birch St', 'emmawhite', 'password123');

-- Add a service ticket
SELECT add_service_ticket('Tire Replacement', 200.00, 30000, 2, 2, 2);

-- Add an invoice
SELECT add_invoice(30000.00, CURRENT_TIMESTAMP, 2, 2, 2);

