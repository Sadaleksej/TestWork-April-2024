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