CREATE DATABASE test2;
USE test2;

CREATE TABLE students(id integer PRIMARY KEY AUTO_INCREMENT, name VARCHAR(64),
address VARCHAR(256), city VARCHAR(256), state VARCHAR(32), post_code VARCHAR(32));

INSERT INTO students(name, address, city, state, post_code) VALUES
('Frodo', 'Bag End', 'Shire', 'Middle Earth', '123456'), 
('Bilbo', 'Bag End', 'Shire', 'Middle Earth', '123456'),
('Drogo', 'Brandy Hall', 'Shire', 'Middle Earth', '123456');

CREATE TABLE test2(id integer PRIMARY KEY AUTO_INCREMENT, name VARCHAR(64));

INSERT INTO test2(name) VALUES 
('Gandalf'),
('Peregrin Took');