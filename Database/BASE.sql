CREATE TABLE users (
    id serial PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at date NOT NULL
);

CREATE TABLE universities (
    id serial PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    city VARCHAR(100),
    requirements TEXT,
    application_deadline DATE,
    contact_info TEXT
);

CREATE TABLE specialties (
    id serial PRIMARY KEY,
    university_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    min_ege_score INT NOT NULL,
    FOREIGN KEY (university_id) REFERENCES universities(id) ON DELETE CASCADE
);

CREATE TABLE applications (
    id serial PRIMARY KEY,
    user_id INT NOT NULL,
    university_id INT NOT NULL,
    specialty_id INT NOT NULL,
    application_date DATE DEFAULT CURRENT_DATE,
    status text NOT NULL,
    ege_score INT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (university_id) REFERENCES universities(id) ON DELETE CASCADE,
    FOREIGN KEY (specialty_id) REFERENCES specialties(id) ON DELETE CASCADE
);
