/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id INT,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

ALTER TABLE animals ADD COLUMN species VARCHAR(50);

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    age INT
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

-- Make sure that id is set as autoincremented PRIMARY KEY
CREATE SEQUENCE animals_id_seq;
ALTER TABLE animals ALTER COLUMN id SET DEFAULT nextval('animals_id_seq');
ALTER TABLE animals ALTER COLUMN id SET NOT NULL;
ALTER SEQUENCE animals_id_seq OWNED BY animals.id;
SELECT setval('animals_id_seq', 10);
ALTER TABLE animals ADD PRIMARY KEY (id);

-- Remove column species
ALTER TABLE animals DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals 
  ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals 
  ADD CONSTRAINT fk_owners FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    vet_id INT,
    species_id INT,
    PRIMARY KEY (vet_id, species_id),
    CONSTRAINT fk_vet FOREIGN KEY(vet_id) REFERENCES vets(id),
    CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id)
);

CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    vet_id INT,
    animal_id INT,
    visit_date DATE,
    CONSTRAINT fk_vet FOREIGN KEY(vet_id) REFERENCES vets(id),
    CONSTRAINT fk_animal FOREIGN KEY(animal_id) REFERENCES animals(id)
);

-- Performance audit
-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Optimization to first query.
CREATE INDEX ON visits (animal_id);

-- Optimization to second query.
CREATE INDEX ON visits (vet_id);

-- Optimization to third query.
CREATE INDEX ON OWNERS (email);