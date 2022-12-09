-- VIEW to find all seeds that when planted, the resulting crop will have no positive profit
SELECT * FROM less_Profit_From_Seed AS `No Profit Crop`;

-- FUNCTION to find the total amount of profit if all quantity of a certain crop is sold
SELECT total_Profit_From_Crop(55) AS `Total profit from Crop`;

-- PROCEDURE that takes as input crop_ID and quantity to sell and updates 
-- the Farmer table and Crop table accordingly. 
CALL updateFarmerGold(1, 1, @myOutput);
SELECT @myOutput;

-- Query 1: Uses the Joining of 3 tables and Where clause with multiple condition
-- Find out which farmer bought seeds and have not had them planted by their respective farmer (quantity 0 in Crops)

SELECT X.farmer, X.crop_ID, Y.quality, Y.type_of_crop
FROM Farmer_Buys_Seeds AS X
JOIN Crops AS Y
ON X.crop_ID = Y.crop_ID
JOIN Farmer_Plants AS Z
ON X.crop_ID = Z.crop_ID
WHERE Y.quantity = 0 AND X.farmer = Z.farmer
ORDER BY farmer;

-- Query 2: Uses the Update clause
-- Updates the quantity attribute in the Crops table. This can be seen as an insert of a duplicate crop.
-- In this example, we are adding another Normal quality Melon to our database. 

UPDATE Crops
SET quantity = quantity + 1
WHERE crop_ID = 1;


-- Query 3: Uses Group By and Having
-- Shows a table of animal species that produce 3 or more products

SELECT farm_building_id AS "Farm Building",  animal_species AS "Produces 3 or more products" 
FROM Cattle_Produces
GROUP BY farm_building_id, animal_species
HAVING COUNT(produces) >= 3;


-- Query 4: Uses DISTINCT and WHERE NOT EXISTS
-- Shows a table of crops that are stored in the database that have not yet had seeds bought for them yet

SELECT DISTINCT type_of_crop AS "Crop", 
season AS "Season", growth_time_days AS "Growth Time", quantity AS "Quantity"
FROM Crops AS X
WHERE NOT EXISTS 
(SELECT crop_ID FROM Farmer_Buys_Seeds WHERE X.crop_ID = Farmer_Buys_Seeds.crop_ID);



-- Query 5: Uses WHERE IN 
-- Shows a table of which animals are somewhere on the farm that do not produce something of value

SELECT animal_species FROM Cattle
WHERE animal_species IN 
(SELECT animal_species FROM Cattle_Produces WHERE produces = 'nothing');

-- Query 6: Uses OUTER JOIN and UNION
-- Prints a table of all crop_ID's and associated farmers that have bought
-- seeds and planted seeds.

SELECT X.farmer, X.crop_ID FROM Farmer_Buys_Seeds AS X
LEFT JOIN Farmer_Plants AS Y ON X.crop_ID = Y.crop_ID
UNION
SELECT Z.farmer, Z.crop_ID FROM Farmer_Buys_Seeds AS Z
RIGHT JOIN Farmer_Plants AS W ON Z.crop_ID = W.crop_ID;

						