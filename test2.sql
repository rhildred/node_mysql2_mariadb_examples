CREATE DATABASE IF NOT EXISTS test2;
USE test2;

CREATE TABLE IF NOT EXISTS students(id integer PRIMARY KEY AUTO_INCREMENT, name VARCHAR(64),
address VARCHAR(256), city VARCHAR(256), state VARCHAR(32), post_code VARCHAR(32));

INSERT IGNORE INTO students(id, name, address, city, state, post_code) VALUES
(1, 'Frodo', 'Bag End', 'Shire', 'Middle Earth', '123456'), 
(2, 'Bilbo', 'Bag End', 'Shire', 'Middle Earth', '123456'),
(3, 'Drogo', 'Brandy Hall', 'Shire', 'Middle Earth', '123456');


CREATE TABLE IF NOT EXISTS test2(id integer PRIMARY KEY AUTO_INCREMENT, name VARCHAR(64));

INSERT IGNORE INTO test2(id, name) VALUES 
(1, 'Gandalf'),
(2, 'Peregrin Took');