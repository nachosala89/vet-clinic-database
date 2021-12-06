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


-- Who was the last animal seen by William Tatcher?
SELECT animals.name FROM animals 
  INNER JOIN visits ON animals.id = visits.animal_id
  INNER JOIN vets ON vets.id = visits.vet_id
  WHERE vets.name = 'William Tatcher'
  ORDER BY visit_date DESC LIMIT 1;
-- How many different animals did Stephanie Mendez see?
SELECT COUNT(*) FROM animals 
  INNER JOIN visits ON animals.id = visits.animal_id
  INNER JOIN vets ON vets.id = visits.vet_id
  WHERE vets.name = 'Stephanie Mendez'
  GROUP BY animals.id;
--List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM vets
  LEFT JOIN specializations ON specializations.vet_id = vets.id
  LEFT JOIN species ON specializations.species_id = species.id;
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name FROM animals 
  INNER JOIN visits ON animals.id = visits.animal_id
  INNER JOIN vets ON vets.id = visits.vet_id
  WHERE vets.name = 'Stephanie Mendez'
  AND visit_date BETWEEN '2020-04-01' AND '2020-08-30';
-- What animal has the most visits to vets?
SELECT animals.name FROM animals 
  INNER JOIN visits ON animals.id = visits.animal_id
  INNER JOIN vets ON vets.id = visits.vet_id
  GROUP BY animals.name
  ORDER BY COUNT(*) DESC LIMIT 1;
-- Who was Maisy Smith's first visit?  
SELECT animals.name FROM animals 
  INNER JOIN visits ON animals.id = visits.animal_id
  INNER JOIN vets ON vets.id = visits.vet_id
  WHERE vets.name = 'Maisy Smith'
  ORDER BY visit_date LIMIT 1;
-- Details for most recent visit: animal information, vet information, and date of visit.
  SELECT * FROM animals 
    INNER JOIN visits ON animals.id = visits.animal_id
    INNER JOIN vets ON vets.id = visits.vet_id
    ORDER BY visit_date DESC LIMIT 1;
-- How many visits were with a vet that did not specialize in that animal's species? 13
SELECT COUNT(*) FROM animals 
  INNER JOIN visits ON animals.id = visits.animal_id
  INNER JOIN vets ON vets.id = visits.vet_id
  INNER JOIN species ON animals.species_id = species.id
  LEFT JOIN specializations ON specializations.vet_id = vets.id
  WHERE specializations.species_id != species.id OR specializations.species_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name FROM animals 
  INNER JOIN species ON animals.species_id = species.id
  INNER JOIN visits ON animals.id = visits.animal_id
  INNER JOIN vets ON vets.id = visits.vet_id
  WHERE vets.name = 'Maisy Smith'
  GROUP BY species.name
  ORDER BY COUNT(*) DESC LIMIT 1;

-- Perfomance audit queries:
SELECT COUNT(*) FROM visits where animal_id = 4;
SELECT * FROM visits where vet_id = 2;
SELECT * FROM owners where email = 'owner_18327@mail.com';