DROP DATABASE IF EXISTS human_friends;
CREATE DATABASE human_friends;
USE human_friends;

CREATE TABLE animal (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	class_name VARCHAR(30)
);

INSERT INTO
	animal (class_name)
VALUES 
	('Pack_Animal'),
	('Pet');  

CREATE TABLE pack_animal (
	id INT AUTO_INCREMENT PRIMARY KEY,
    subclass_name VARCHAR (30),
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES animal (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO 
	pack_animal (subclass_name, class_id)
VALUES
	('Horse', 1),
	('Camel', 1),  
	('Donkey', 1); 
    
CREATE TABLE pet (
	id INT AUTO_INCREMENT PRIMARY KEY,
    subclass_name VARCHAR (30),
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES animal (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO 
	pet (subclass_name, class_id)
VALUES 
	('Dog', 2),
	('Cat', 2),  
	('Hamster', 2); 

CREATE TABLE dog (       
    id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(30), 
    type_id INT, 
    birthday DATE,
    commands VARCHAR(60),
    Foreign KEY (type_id) REFERENCES pet (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE cat (       
    id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(30), 
    type_id INT, 
    birthday DATE,
    commands VARCHAR(60),
    Foreign KEY (type_id) REFERENCES pet (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE hamster (       
    id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(30), 
    type_id INT, 
    birthday DATE,
    commands VARCHAR(60),
    Foreign KEY (type_id) REFERENCES pet (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE horse (       
    id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(30), 
    type_id INT, 
    birthday DATE,
    commands VARCHAR(50),
    Foreign KEY (type_id) REFERENCES pack_animal (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE camel (       
    id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(30), 
    type_id INT, 
    birthday DATE,
    commands VARCHAR(60),
    Foreign KEY (type_id) REFERENCES pack_animal (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE donkey (       
    id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(30), 
    type_id INT, 
    birthday DATE,
    commands VARCHAR(60),
    Foreign KEY (type_id) REFERENCES pack_animal (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO 
	dog (name, type_id, birthday, commands)
VALUES 
	('Fido', 1, '2020-01-01', 'Sit, Stay, Fetch'),
	('Buddy', 1, '2018-12-10', 'Sit, Paw, Bark'),  
	('Bella', 1, '2019-11-11', 'Sit, Stay, Roll'); 

INSERT INTO 
	cat (name, type_id, birthday, commands)
VALUES 
	('Whiskers', 2, '2019-05-15', 'Sit, Pounce'),
	('Smudge', 2, '2020-02-20', 'Sit, Pounce, Scratch'),  
	('Oliver', 2, '2020-06-30', 'Meow, Scratch, Jump'); 

INSERT INTO 
	hamster (name, type_id, birthday, commands)
VALUES 
	('Hammy', 3, '2021-03-10', 'Roll, Hide'),
	('Peanut', 3, '2021-08-01', 'Roll, Spin'); 

INSERT INTO 
	horse (name, type_id, birthday, commands)
VALUES 
	('Thunder', 1, '2015-07-21', 'Trot, Canter, Gallop'),
	('Storm', 1, '2014-05-05', 'Trot, Canter'),  
	('Blaze', 1, '2016-02-29', 'Trot, Jump, Gallop'); 

INSERT INTO 
	camel (name, type_id, birthday, commands)
VALUES 
	('Sandy', 2, '2016-11-03', 'Walk, Carry Load'),
	('Dune', 2, '2018-12-12', 'Walk, Sit'), 
	('Sahara', 2, '2015-08-14', 'Walk, Run'); 

INSERT INTO 
	donkey (name, type_id, birthday, commands)
VALUES 
	('Eeyore', 3, '2017-09-18', 'Walk, Carry Load, Bray'), 
	('Burro', 3, '2019-01-23', 'Walk, Bray, Kick'); 

DELETE FROM camel WHERE type_id>1;

CREATE TABLE horse_with_donkey 
SELECT * FROM horse
	UNION 
SELECT * FROM donkey;


DROP TABLE IF EXISTS animal_temporary;
CREATE TEMPORARY TABLE animal_temporary AS
SELECT * FROM dog
UNION
SELECT * FROM cat
UNION
SELECT * FROM hamster
UNION
SELECT * FROM horse_with_donkey;

DROP TABLE IF EXISTS animal_below_3;
CREATE TABLE animal_below_3
SELECT
	name, type_id, birthday, commands, TIMESTAMPDIFF(MONTH, birthday, CURDATE()) AS month_age
FROM 
	animal_temporary
WHERE birthday BETWEEN ADDDATE(CURDATE(), INTERVAL -3 YEAR) AND ADDDATE(CURDATE(), INTERVAL -1 YEAR);



DROP TABLE IF EXISTS animal_total;
CREATE TABLE animal_total

SELECT 
	dogs.name,
	pets.subclass_name, 
	dogs.birthday, 
	dogs.commands,
	animals.class_name
FROM dog dogs
LEFT JOIN pet pets ON pets.id = dogs.type_id
LEFT JOIN animal animals ON animals.id = pets.class_id
UNION
SELECT 
	cats.name,
	pets.subclass_name, 
	cats.birthday, 
	cats.commands,
	animals.class_name
FROM cat cats
LEFT JOIN pet pets ON pets.id = cats.type_id
LEFT JOIN animal animals ON animals.id = pets.class_id
UNION
SELECT 
	hamsters.name,
	pets.subclass_name, 
	hamsters.birthday, 
	hamsters.commands,
	animals.class_name
FROM hamster hamsters
LEFT JOIN pet pets ON pets.id = hamsters.type_id
LEFT JOIN animal animals ON animals.id = pets.class_id
UNION
SELECT 
	horses.name,
	packanimals.subclass_name, 
	horses.birthday, 
	horses.commands,
	animals.class_name
FROM horse horses
LEFT JOIN pack_animal packanimals ON packanimals.id = horses.type_id
LEFT JOIN animal animals ON animals.id = packanimals.class_id
UNION
SELECT 
	donkeys.name,
	packanimals.subclass_name, 
	donkeys.birthday, 
	donkeys.commands,
	animals.class_name
FROM donkey donkeys
LEFT JOIN pack_animal packanimals ON packanimals.id = donkeys.type_id
LEFT JOIN animal animals ON animals.id = packanimals.class_id;

SELECT * FROM animal_total;