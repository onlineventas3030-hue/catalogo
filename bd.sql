-- 1. Tabla de Categorías
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 2. Tabla de Productos (Inventario)
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price NUMERIC(12, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    category_id INT REFERENCES categories(id) ON DELETE SET NULL,
    image_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 3. Tabla de Pedidos
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR(150) NOT NULL,
    customer_phone VARCHAR(50) NOT NULL,
    delivery_address TEXT NOT NULL,
    total_amount NUMERIC(12, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'Pendiente', -- Pendiente, Completsdo, Cancelado
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- 4. Tabla de Detalle del Pedido
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(id) ON DELETE CASCADE,
    product_id INT REFERENCES products(id) ON DELETE SET NULL,
    quantity INT NOT NULL,
    price NUMERIC(12, 2) NOT NULL
);

-- 5. Habilitar Realtime para las tablas clave
ALTER PUBLICATION supabase_realtime ADD TABLE products;
ALTER PUBLICATION supabase_realtime ADD TABLE orders;

-- 6. Insertar Datos de Ejemplo (Opcional)
INSERT INTO categories (name) VALUES ('Tecnología'), ('Víveres'), ('Moda');

INSERT INTO products (name, description, price, stock, category_id, image_url) VALUES 
('Harina Pan (Blanca)', 'Harina de maíz precocida 1kg', 45.00, 50, 2, 'https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=500&q=80'),
('Queso Llanero', 'Queso blanco semiduro pasteurizado (1kg)', 180.00, 20, 2, 'https://images.unsplash.com/photo-1452195100486-9cc805987862?auto=format&fit=crop&w=500&q=80'),
('Audífonos Inalámbricos TWS', 'Bluetooth 5.3 con estuche de carga', 350.00, 15, 1, 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?auto=format&fit=crop&w=500&q=80');