CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS stock (
    product_id INTEGER PRIMARY KEY REFERENCES products(id),
    quantity INTEGER NOT NULL CHECK (quantity >= 0)
);

CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL REFERENCES products(id),
    quantity INTEGER NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO products (name, price) VALUES
    ('Keyboard', 4500.00),
    ('Mouse', 1800.00),
    ('Monitor', 32000.00)
ON CONFLICT (name) DO NOTHING;

INSERT INTO stock (product_id, quantity)
SELECT id, 20 FROM products WHERE name = 'Keyboard'
ON CONFLICT (product_id) DO NOTHING;

INSERT INTO stock (product_id, quantity)
SELECT id, 50 FROM products WHERE name = 'Mouse'
ON CONFLICT (product_id) DO NOTHING;

INSERT INTO stock (product_id, quantity)
SELECT id, 5 FROM products WHERE name = 'Monitor'
ON CONFLICT (product_id) DO NOTHING;