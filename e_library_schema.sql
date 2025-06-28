-- users
CREATE TABLE users (
    user_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--libraries
CREATE TABLE libraries (
    library_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(225)
);


-- for categories
CREATE TABLE categories (
    category_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);


--books
CREATE TABLE books (
    book_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    category_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);


--library_books
CREATE TABLE library_books (
    library_id VARCHAR(10),
    book_id VARCHAR(10),
    quantity INTEGER NOT NULL CHECK (quantity >= 0),
    PRIMARY KEY (library_id, book_id),
    FOREIGN KEY (library_id) REFERENCES libraries(library_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);


-- loans
CREATE TABLE loans (
    loan_id VARCHAR(10) PRIMARY KEY,
    user_id VARCHAR(10) NOT NULL,
    book_id VARCHAR(10) NOT NULL,
    library_id VARCHAR(10) NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'returned', 'overdue')),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (library_id) REFERENCES libraries(library_id)
);

-- holds
CREATE TABLE holds (
    hold_id VARCHAR(10) PRIMARY KEY,
    user_id VARCHAR(10) NOT NULL,
    book_id VARCHAR(10) NOT NULL,
    library_id VARCHAR(10) NOT NULL,
    hold_date DATE NOT NULL,
    expire_date DATE NOT NULL,
    queue_position INTEGER NOT NULL CHECK (queue_position >= 1),
    fulfilled BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (library_id) REFERENCES libraries(library_id)
);

