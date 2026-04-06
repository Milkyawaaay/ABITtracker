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

INSERT INTO users (first_name, last_name, middle_name, email, password_hash) VALUES
('Иван', 'Петров', 'Сергеевич', 'ivan.petrov@mail.ru', 'hash123'),
('Мария', 'Сидорова', 'Александровна', 'maria.sidorova@gmail.com', 'hash456'),
('Алексей', 'Козлов', 'Дмитриевич', 'alex.kozlov@yandex.ru', 'hash789'),
('Елена', 'Волкова', 'Игоревна', 'elena.volkova@mail.ru', 'hash321');

INSERT INTO universities (name, city, requirements, application_deadline, contact_info) VALUES
('Московский государственный университет', 'Москва', 'ЕГЭ: русский, математика, физика/информатика. Минимум 220 баллов.', '2024-07-25', 'тел: +7 (495) 123-45-67, email: priem@msu.ru'),
('Санкт‑Петербургский политехнический университет', 'Санкт‑Петербург', 'ЕГЭ: русский, математика, физика. Минимум 210 баллов.', '2024-07-20', 'тел: +7 (812) 234-56-78, email: abiturient@spbpu.ru'),
('Новосибирский государственный университет', 'Новосибирск', 'ЕГЭ: русский, математика, химия/биология. Минимум 200 баллов.', '2024-07-15', 'тел: +7 (383) 345-67-89, email: admission@nsu.ru');

INSERT INTO specialities(university_id, name, min_ege_score) VALUES
(1, 'Прикладная математика и информатика', 240),
(1, 'Физика', 235),
(2, 'Машиностроение', 220),
(2, 'Информационные системы и технологии', 230),
(3, 'Биология', 215),
(3, 'Химия', 225);

INSERT INTO applications (user_id, university_id, specialty_id, application_date, status, ege_score) VALUES
(1, 1, 1, '2024-06-10', 'на рассмотрении', 245),
(1, 2, 4, '2024-06-12', 'подано', 245),
(2, 1, 2, '2024-06-05', 'принято', 250),
(3, 2, 3, '2024-06-08', 'отклонено', 210),
(4, 3, 5, '2024-06-15', 'на рассмотрении', 220);


    
