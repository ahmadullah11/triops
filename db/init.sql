-- db/init.sql
-- ShopLite Database Initialization Script (PostgreSQL 17)

CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS stock (
    product_id INTEGER PRIMARY KEY REFERENCES products(id) ON DELETE CASCADE,
    quantity INTEGER NOT NULL CHECK (quantity >= 0),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL REFERENCES products(id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) NOT NULL,
    total_price NUMERIC(12, 2) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'CONFIRMED',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Seed Initial Products
INSERT INTO products (name, price) VALUES
    ('Keyboard', 4500.00),
    ('Mouse', 1800.00),
    ('Monitor', 32000.00)
ON CONFLICT (name) DO NOTHING;

-- Seed Initial Stock matching seeded products
INSERT INTO stock (product_id, quantity)
SELECT id, 20 FROM products WHERE name = 'Keyboard'
ON CONFLICT (product_id) DO NOTHING;

INSERT INTO stock (product_id, quantity)
SELECT id, 50 FROM products WHERE name = 'Mouse'
ON CONFLICT (product_id) DO NOTHING;

INSERT INTO stock (product_id, quantity)
SELECT id, 5 FROM products WHERE name = 'Monitor'
ON CONFLICT (product_id) DO NOTHING;