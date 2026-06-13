-- 1. OPERATIONS CUSTOMERS
CREATE TABLE operations.customers ( 
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    city VARCHAR(50) NOT NULL
);

-- 2. FLEET TABLES
CREATE TABLE fleet.drivers (
    driver_id SERIAL PRIMARY KEY,
    driver_name VARCHAR(100) NOT NULL,
    license_number VARCHAR(50) UNIQUE NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Available', 'Unavailable', 'On Delivery'))
);

CREATE TABLE fleet.vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    vehicle_type VARCHAR(50) NOT NULL,
    plate_number VARCHAR(20) UNIQUE NOT NULL,
    capacity INTEGER CHECK (capacity > 0)
);

-- 3. WAREHOUSE TABLE
CREATE TABLE warehouse.warehouses (
    warehouse_id SERIAL PRIMARY KEY,
    warehouse_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL
);

-- 4. ORDERS
CREATE TABLE operations.orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    delivery_address TEXT NOT NULL,
    total_amount DECIMAL(10,2) CHECK (total_amount >= 0),
    FOREIGN KEY (customer_id) REFERENCES operations.customers(customer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 5. DELIVERIES
CREATE TABLE operations.deliveries (
    delivery_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    driver_id INTEGER NOT NULL,
    vehicle_id INTEGER NOT NULL,
    delivery_status VARCHAR(30) CHECK (delivery_status IN ('Pending', 'In Transit', 'Delivered', 'Cancelled')),
    FOREIGN KEY (order_id) REFERENCES operations.orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (driver_id) REFERENCES fleet.drivers(driver_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (vehicle_id) REFERENCES fleet.vehicles(vehicle_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 6. INVENTORY
CREATE TABLE warehouse.inventory (
    inventory_id SERIAL PRIMARY KEY,
    warehouse_id INTEGER NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    quantity INTEGER CHECK (quantity >= 0),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse.warehouses(warehouse_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 7. PAYMENTS
CREATE TABLE finance.payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(30) CHECK (payment_status IN ('Paid', 'Pending', 'Failed')),
    FOREIGN KEY (order_id) REFERENCES operations.orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE
); 
