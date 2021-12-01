/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.13;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
SELECT MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- What animals belong to Melody Pond?
SELECT animals.name FROM animals INNER JOIN owners ON animals.owner_id = owners.id
  WHERE full_name = 'Melody Pond';
-- List of all animals that are pokemon 
SELECT animals.name FROM animals INNER JOIN species ON animals.species_id = species.id
  WHERE species.name = 'Pokemon';
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT name, full_name FROM animals RIGHT JOIN owners 
  ON animals.owner_id = owners.id;
-- How many animals are there per species?
SELECT species.name, COUNT(*) FROM animals INNER JOIN species 
  ON animals.species_id = species.id GROUP BY species.id;
-- List all Digimon owned by Jennifer Orwell.
SELECT full_name, animals.name FROM animals 
  INNER JOIN owners ON animals.owner_id = owners.id
  INNER JOIN species ON animals.species_id = species.id 
  WHERE full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name FROM animals 
  INNER JOIN owners ON animals.owner_id = owners.id
  WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;
-- Who owns the most animals?
SELECT full_name, COUNT(*) AS amount FROM animals 
  INNER JOIN owners ON animals.owner_id = owners.id
  GROUP BY owners.id
  ORDER BY amount DESC LIMIT 1;