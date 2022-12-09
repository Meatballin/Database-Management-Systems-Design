USE aavola_cs355fa22;

DROP TABLE IF EXISTS Cattle_Produces;
DROP TABLE IF EXISTS Farmer_Tends_Cattle;
DROP TABLE IF EXISTS Farmer_Plants;
DROP TABLE IF EXISTS Farmer_Buys_Seeds;
DROP TABLE IF EXISTS Tools;
DROP TABLE IF EXISTS Cattle;
DROP TABLE IF EXISTS Crops;
DROP TABLE IF EXISTS Farmer;

create table Farmer
(player_ID              varchar(16) not null, 
 address                varchar(50),
 cabin_number           tinyint UNIQUE,
 dob                    date,
 gender                 char(1),
 gold					int DEFAULT 0,
 primary key(player_ID)
);

create table Crops
(crop_ID				int,
 quality                ENUM('Normal','Silver','Gold','Iridium'),
 type_of_crop           varchar(30),
 season                 varchar(50),
 growth_time_days       tinyint,
 price_each             smallint,  
 quantity	            int,
 primary key(crop_ID, quality)
 );

create table Cattle
(farm_building_id       varchar(20),
 animal_species         varchar(20),
 time_to_mature_days    tinyint,
 primary key(farm_building_id, animal_species) 
);

-- Weak Entity
create table Tools
(tool_type              varchar(15),
 quality                ENUM('Normal','Copper','Silver','Gold','Iridium','Training'
                             ,'Bamboo', 'Fiber Glass'),
 farmer                 varchar(16),
 upgrade_cost           int,
 primary key(tool_type, quality, farmer),
 foreign key(farmer) references Farmer (player_ID) on delete cascade
);

create table Farmer_Buys_Seeds
(farmer                 varchar(16),
 crop_ID				int,
 quality                ENUM('Normal','Silver','Gold','Iridium'),
 price_of_seed          int,
 primary key(farmer, crop_ID, quality),
 foreign key(farmer) references Farmer (player_ID) on delete cascade,
 foreign key(crop_ID, quality) references Crops (crop_ID, quality) on delete cascade
);

create table Farmer_Plants
(farmer				    varchar(16),
 crop_ID				int,
 quality				ENUM('Normal','Silver','Gold','Iridium'),
 primary key(farmer, crop_ID, quality),
 foreign key(farmer) references Farmer (player_ID) on delete cascade,
 foreign key(crop_ID, quality) references Crops (crop_ID, quality) on delete cascade
);

create table Farmer_Tends_Cattle
(farmer                 varchar(16),
 farm_building_id       varchar(20),
 animal_species         varchar(20),
 primary key(farmer, farm_building_id, animal_species),
 foreign key(farmer) references Farmer (player_ID) on delete cascade,
 foreign key(farm_building_id, animal_species) references Cattle (farm_building_id, animal_species) on delete cascade
);

create table Cattle_Produces
(farm_building_id       varchar(20),
 animal_species         varchar(20),
 produces               varchar(60),
 primary key(farm_building_id, animal_species, produces),
 foreign key(farm_building_id, animal_species) references Cattle (farm_building_id, animal_species) on delete cascade

);
-- ===============================================================================


-- Insertion begins here==========================================================
delete from Farmer;
delete from Crops;
delete from Cattle;
delete from Tools;
delete from Farmer_Buys_Seeds;
delete from Farmer_Plants;
delete from Farmer_Tends_Cattle;
delete from Cattle_Produces;

-- Insertion for Farmer
insert into Farmer values ('Andy', 'Stardew Valley Farm', 1, '1996-07-07', 'M', 0);
insert into Farmer values ('Holland','Stardew Valley Farm', 2, '1986-02-08', 'F', 0);

-- Insertion for Crops S-F-Spring

insert into Crops values (1, 1, 'Melon', 'Summer', 12, 250, 6);
insert into Crops values (2, 2, 'Melon', 'Summer', 12, 312, 3);
insert into Crops values (3, 3, 'Melon', 'Summer', 12, 375, 4);
insert into Crops values (4, 4, 'Melon', 'Summer', 12, 500, 2);

insert into Crops values (5, 1, 'Blueberry', 'Summer', 13, 50, 17);
insert into Crops values (6, 2, 'Blueberry', 'Summer', 13, 62, 0);
insert into Crops values (7, 3, 'Blueberry', 'Summer', 13, 75, 3);
insert into Crops values (8, 4, 'Blueberry', 'Summer', 13, 100, 1);

insert into Crops values (9, 1, 'Potato', 'Spring', 6, 80, 0);
insert into Crops values (10, 2, 'Potato', 'Spring', 6, 100, 2);
insert into Crops values (11, 3, 'Potato', 'Spring', 6, 120, 12);
insert into Crops values (12, 4, 'Potato', 'Spring', 6, 160, 13);

insert into Crops values (13, 1, 'Artichoke', 'Fall', 8, 160, 3);
insert into Crops values (14, 2, 'Artichoke', 'Fall', 8, 200, 27);
insert into Crops values (15, 3, 'Artichoke', 'Fall', 8, 240, 0);
insert into Crops values (16, 4, 'Artichoke', 'Fall', 8, 320, 0);

insert into Crops values (17, 1, 'Strawberry', 'Spring', 8, 120, 10);
insert into Crops values (18, 2, 'Strawberry', 'Spring', 8, 150, 10);
insert into Crops values (19, 3, 'Strawberry', 'Spring', 8, 180, 20);
insert into Crops values (20, 4, 'Strawberry', 'Spring', 8, 240, 90);

insert into Crops values (21, 1, 'Tomato', 'Summer', 11, 60, 70);
insert into Crops values (22, 2, 'Tomato', 'Summer', 11, 75, 0);
insert into Crops values (23, 3, 'Tomato', 'Summer', 11, 90, 20);
insert into Crops values (24, 4, 'Tomato', 'Summer', 11, 120, 21);

insert into Crops values (25, 1, 'Radish', 'Summer', 6, 90, 5);
insert into Crops values (26, 2, 'Radish', 'Summer', 6, 112, 0);
insert into Crops values (27, 3, 'Radish', 'Summer', 6, 135, 0);
insert into Crops values (28, 4, 'Radish', 'Summer', 6, 180, 2);

insert into Crops values (29, 1, 'Wheat', 'Summer & Fall', 4, 25, 101);
insert into Crops values (30, 2, 'Wheat', 'Summer & Fall', 4, 31, 100);
insert into Crops values (31, 3, 'Wheat', 'Summer & Fall', 4, 37, 13);
insert into Crops values (32, 4, 'Wheat', 'Summer & Fall', 4, 50, 0);

insert into Crops values (33, 1, 'Sunflower', 'Summer & Fall', 8, 80, 4);
insert into Crops values (34, 2, 'Sunflower', 'Summer & Fall', 8, 100, 10);
insert into Crops values (35, 3, 'Sunflower', 'Summer & Fall', 8, 120, 19);
insert into Crops values (36, 4, 'Sunflower', 'Summer & Fall', 8, 160, 12);

insert into Crops values (37, 1, 'Eggplant', 'Fall', 5, 60, 12);
insert into Crops values (38, 2, 'Eggplant', 'Fall', 5, 75, 40);
insert into Crops values (39, 3, 'Eggplant', 'Fall', 5, 90, 29);
insert into Crops values (40, 4, 'Eggplant', 'Fall', 5, 120, 1);

insert into Crops values (41, 1, 'Corn', 'Summer & Fall', 14, 50, 3);
insert into Crops values (42, 2, 'Corn', 'Summer & Fall', 14, 62, 2);
insert into Crops values (43, 3, 'Corn', 'Summer & Fall', 14, 75, 4);
insert into Crops values (44, 4, 'Corn', 'Summer & Fall', 14, 100, 4);

insert into Crops values (45, 1, 'Pumpkin', 'Fall', 13, 320, 98);
insert into Crops values (46, 2, 'Pumpkin', 'Fall', 13, 400, 15);
insert into Crops values (47, 3, 'Pumpkin', 'Fall', 13, 480, 21);
insert into Crops values (48, 4, 'Pumpkin', 'Fall', 13, 640, 17);

insert into Crops values (49, 1, 'Yam', 'Fall', 10, 160, 100);
insert into Crops values (50, 2, 'Yam', 'Fall', 10, 200, 12);
insert into Crops values (51, 3, 'Yam', 'Fall', 10, 240, 37);
insert into Crops values (52, 4, 'Yam', 'Fall', 10, 320, 20);

insert into Crops values (53, 1, 'Cranberry', 'Fall', 7, 75, 10);
insert into Crops values (54, 2, 'Cranberry', 'Fall', 7, 93, 29);
insert into Crops values (55, 3, 'Cranberry', 'Fall', 7, 112, 1);
insert into Crops values (56, 4, 'Cranberry', 'Fall', 7, 150, 2);

insert into Crops values (57, 1, 'Pepper', 'Summer', 5, 40, 1);
insert into Crops values (58, 2, 'Pepper', 'Summer', 5, 50, 2);
insert into Crops values (59, 3, 'Pepper', 'Summer', 5, 60, 3);
insert into Crops values (60, 4, 'Pepper', 'Summer', 5, 80, 4);

insert into Crops values (61, 1, 'Poppy', 'Summer', 7, 140, 12);
insert into Crops values (62, 2, 'Poppy', 'Summer', 7, 175, 16);
insert into Crops values (63, 3, 'Poppy', 'Summer', 7, 210, 0);
insert into Crops values (64, 4, 'Poppy', 'Summer', 7, 280, 4);

insert into Crops values (65, 1, 'Red Cabbage', 'Summer', 9, 260, 0);
insert into Crops values (66, 2, 'Red Cabbage', 'Summer', 9, 325, 14);
insert into Crops values (67, 3, 'Red Cabbage', 'Summer', 9, 390, 15);
insert into Crops values (68, 4, 'Red Cabbage', 'Summer', 9, 520, 3); 

insert into Crops values (69, 1, 'Cauliflower', 'Spring', 12, 175, 0);
insert into Crops values (70, 2, 'Cauliflower', 'Spring', 12, 218, 0);
insert into Crops values (71, 3, 'Cauliflower', 'Spring', 12, 262, 0);
insert into Crops values (72, 4, 'Cauliflower', 'Spring', 12, 350, 0);

insert into Crops values (73, 1, 'Coffee Bean', 'Spring & Summer', 10, 15, 0);
insert into Crops values (74, 2, 'Coffee Bean', 'Spring & Summer', 10, 18, 0);
insert into Crops values (75, 3, 'Coffee Bean', 'Spring & Summer', 10, 22, 0);
insert into Crops values (76, 4, 'Coffee Bean', 'Spring & Summer', 10, 30, 0);

insert into Crops values (77, 1, 'Garlic', 'Spring', 10, 60, 0);
insert into Crops values (78, 2, 'Garlic', 'Spring', 10, 75, 0);
insert into Crops values (79, 3, 'Garlic', 'Spring', 10, 90, 0);
insert into Crops values (80, 4, 'Garlic', 'Spring', 10, 120, 0);

insert into Crops values (81, 1, 'Starfruit', 'Summer', 10, 750, 0);
insert into Crops values (82, 2, 'Starfruit', 'Summer', 10, 937, 0);
insert into Crops values (83, 3, 'Starfruit', 'Summer', 10, 1125, 0);
insert into Crops values (84, 4, 'Starfruit', 'Summer', 10, 1500, 0);




-- Cattle
insert into Cattle values ('Barn', 'Cow', 5);
insert into Cattle values ('Barn', 'Goat', 5);
insert into Cattle values ('Barn', 'Sheep', 4);
insert into Cattle values ('Barn', 'Pig', 10);
insert into Cattle values ('Coop', 'Chicken', 6);
insert into Cattle values ('Coop', 'Rabbit', 6);
insert into Cattle values ('Coop', 'Dinosaur', 11);
insert into Cattle values ('Stable', 'Horse', 0);
insert into Cattle values ('Farm', 'Cat', 0);
insert into Cattle values ('Farm', 'Dog', 0);

-- Tools
insert into Tools values ('Hoe', 1, 'Andy', null);
insert into Tools values ('Hoe', 2, 'Andy', 2000);
insert into Tools values ('Hoe', 3, 'Andy', 5000);
insert into Tools values ('Hoe', 4, 'Andy', 10000);
insert into Tools values ('Hoe', 5, 'Andy', 25000);
insert into Tools values ('Hoe', 1, 'Holland', null);
insert into Tools values ('Hoe', 2, 'Holland', 2000);
insert into Tools values ('Hoe', 3, 'Holland', 5000);
insert into Tools values ('Hoe', 4, 'Holland', 10000);
insert into Tools values ('Hoe', 5, 'Holland', 25000);

insert into Tools values ('Pickaxe', 1, 'Andy', null);
insert into Tools values ('Pickaxe', 2, 'Andy', 2000);
insert into Tools values ('Pickaxe', 3, 'Andy', 5000);
insert into Tools values ('Pickaxe', 4, 'Andy', 10000);
insert into Tools values ('Pickaxe', 5, 'Andy', 25000);
insert into Tools values ('Pickaxe', 1, 'Holland', null);
insert into Tools values ('Pickaxe', 2, 'Holland', 2000);
insert into Tools values ('Pickaxe', 3, 'Holland', 5000);
insert into Tools values ('Pickaxe', 4, 'Holland', 10000);
insert into Tools values ('Pickaxe', 5, 'Holland', 25000);

insert into Tools values ('Axe', 1, 'Andy', null);
insert into Tools values ('Axe', 2, 'Andy', 2000);
insert into Tools values ('Axe', 3, 'Andy', 5000);
insert into Tools values ('Axe', 4, 'Andy', 10000);
insert into Tools values ('Axe', 5, 'Andy', 25000);
insert into Tools values ('Axe', 1, 'Holland', null);
insert into Tools values ('Axe', 2, 'Holland', 2000);
insert into Tools values ('Axe', 3, 'Holland', 5000);
insert into Tools values ('Axe', 4, 'Holland', 10000);
insert into Tools values ('Axe', 5, 'Holland', 25000);

insert into Tools values ('Watering Can', 1, 'Andy', null);
insert into Tools values ('Watering Can', 2, 'Andy', 2000);
insert into Tools values ('Watering Can', 3, 'Andy', 5000);
insert into Tools values ('Watering Can', 4, 'Andy', 10000);
insert into Tools values ('Watering Can', 5, 'Andy', 25000);
insert into Tools values ('Watering Can', 1, 'Holland', null);
insert into Tools values ('Watering Can', 2, 'Holland', 2000);
insert into Tools values ('Watering Can', 3, 'Holland', 5000);
insert into Tools values ('Watering Can', 4, 'Holland', 10000);
insert into Tools values ('Watering Can', 5, 'Holland', 25000);

insert into Tools values ('Fishing Rod', 6, 'Andy', 25);
insert into Tools values ('Fishing Rod', 7, 'Andy', 500);
insert into Tools values ('Fishing Rod', 8, 'Andy', 1800);
insert into Tools values ('Fishing Rod', 5, 'Andy', 7500);

insert into Tools values ('Rusty Sword', 1, 'Holland', 0);
insert into Tools values ('Silver Saber', 1, 'Holland', 750);
insert into Tools values ('Obsidian Edge', 1, 'Holland', 0);
insert into Tools values ('Lava Katana', 1, 'Holland', 25000);
insert into Tools values ('Galaxy Sword', 1, 'Holland', 50000);

-- Farmer_Buys_Seeds
insert into Farmer_Buys_Seeds values ('Andy', 1, 1, 80);
insert into Farmer_Buys_Seeds values ('Andy', 2, 2, 120);
insert into Farmer_Buys_Seeds values ('Andy', 3, 3, 200);
insert into Farmer_Buys_Seeds values ('Andy', 4, 4, 300);

insert into Farmer_Buys_Seeds values ('Holland', 5, 1, 24);
insert into Farmer_Buys_Seeds values ('Holland', 6, 2, 32);
insert into Farmer_Buys_Seeds values ('Holland', 7, 3, 43);
insert into Farmer_Buys_Seeds values ('Holland', 8, 4, 50);

insert into Farmer_Buys_Seeds values ('Andy', 9, 1, 50);
insert into Farmer_Buys_Seeds values ('Andy', 10, 2, 65);
insert into Farmer_Buys_Seeds values ('Holland', 11, 3, 78);
insert into Farmer_Buys_Seeds values ('Holland', 12, 4, 100);

insert into Farmer_Buys_Seeds values ('Andy', 13, 1, 80);
insert into Farmer_Buys_Seeds values ('Holland', 14, 2, 90);
insert into Farmer_Buys_Seeds values ('Holland', 15, 3, 130);
insert into Farmer_Buys_Seeds values ('Andy', 16, 4, 150);

insert into Farmer_Buys_Seeds values ('Holland', 17, 1, 70);
insert into Farmer_Buys_Seeds values ('Holland', 18, 2, 80);
insert into Farmer_Buys_Seeds values ('Holland', 19, 3, 90);
insert into Farmer_Buys_Seeds values ('Holland', 20, 4, 100);

insert into Farmer_Buys_Seeds values ('Andy', 21, 1, 30);
insert into Farmer_Buys_Seeds values ('Andy', 22, 2, 40);
insert into Farmer_Buys_Seeds values ('Andy', 23, 3, 50);
insert into Farmer_Buys_Seeds values ('Andy', 24, 4, 60);

insert into Farmer_Buys_Seeds values ('Andy', 25, 1, 30);
insert into Farmer_Buys_Seeds values ('Holland', 26, 2, 50);
insert into Farmer_Buys_Seeds values ('Holland', 27, 3, 55);
insert into Farmer_Buys_Seeds values ('Holland', 28, 4, 70);

insert into Farmer_Buys_Seeds values ('Holland', 29, 1, 10);
insert into Farmer_Buys_Seeds values ('Holland', 30, 2, 15);
insert into Farmer_Buys_Seeds values ('Holland', 31, 3, 20);
insert into Farmer_Buys_Seeds values ('Holland', 32, 4, 25);

insert into Farmer_Buys_Seeds values ('Andy', 33, 1, 50);
insert into Farmer_Buys_Seeds values ('Andy', 34, 2, 65);
insert into Farmer_Buys_Seeds values ('Andy', 35, 3, 75);
insert into Farmer_Buys_Seeds values ('Andy', 36, 4, 85);

insert into Farmer_Buys_Seeds values ('Andy', 37, 1, 30);
insert into Farmer_Buys_Seeds values ('Holland', 38, 2, 40);
insert into Farmer_Buys_Seeds values ('Andy', 39, 3, 50);
insert into Farmer_Buys_Seeds values ('Holland', 40, 4, 60);

insert into Farmer_Buys_Seeds values ('Andy', 41, 1, 20);
insert into Farmer_Buys_Seeds values ('Holland', 42, 2, 26);
insert into Farmer_Buys_Seeds values ('Holland', 43, 3, 35);
insert into Farmer_Buys_Seeds values ('Holland', 44, 4, 55);

insert into Farmer_Buys_Seeds values ('Holland', 45, 1, 170);
insert into Farmer_Buys_Seeds values ('Holland', 46, 2, 270);
insert into Farmer_Buys_Seeds values ('Holland', 47, 3, 360);
insert into Farmer_Buys_Seeds values ('Holland', 48, 4, 400);

insert into Farmer_Buys_Seeds values ('Andy', 49, 1, 55);
insert into Farmer_Buys_Seeds values ('Andy', 50, 2, 100);
insert into Farmer_Buys_Seeds values ('Andy', 51, 3, 150);
insert into Farmer_Buys_Seeds values ('Andy', 52, 4, 240);

insert into Farmer_Buys_Seeds values ('Holland', 53, 1, 30);
insert into Farmer_Buys_Seeds values ('Andy', 54, 2, 45);
insert into Farmer_Buys_Seeds values ('Andy', 55, 3, 64);
insert into Farmer_Buys_Seeds values ('Holland', 56, 4, 70);

insert into Farmer_Buys_Seeds values ('Holland', 57, 1, 12);
insert into Farmer_Buys_Seeds values ('Holland', 58, 2, 16);
insert into Farmer_Buys_Seeds values ('Holland', 59, 3, 24);
insert into Farmer_Buys_Seeds values ('Holland', 60, 4, 32);

insert into Farmer_Buys_Seeds values ('Andy', 61, 1, 50);
insert into Farmer_Buys_Seeds values ('Andy', 62, 2, 70);
insert into Farmer_Buys_Seeds values ('Andy', 63, 3, 140);
insert into Farmer_Buys_Seeds values ('Andy', 64, 4, 170);

insert into Farmer_Buys_Seeds values ('Holland', 65, 1, 140);
insert into Farmer_Buys_Seeds values ('Holland', 66, 2, 240);
insert into Farmer_Buys_Seeds values ('Holland', 67, 3, 270);
insert into Farmer_Buys_Seeds values ('Holland', 68, 4, 350);



-- Farmer_Plants
insert into Farmer_Plants values ('Andy', 1, 1);
insert into Farmer_Plants values ('Andy', 2, 2);
insert into Farmer_Plants values ('Holland', 3, 3);
insert into Farmer_Plants values ('Andy', 4, 4);

insert into Farmer_Plants values ('Holland', 5, 1);
insert into Farmer_Plants values ('Holland', 6, 2);
insert into Farmer_Plants values ('Andy', 7, 3);
insert into Farmer_Plants values ('Andy', 8, 4);

insert into Farmer_Plants values ('Andy', 9, 1);
insert into Farmer_Plants values ('Andy', 10, 2);
insert into Farmer_Plants values ('Holland', 11, 3);
insert into Farmer_Plants values ('Holland', 12, 4);

insert into Farmer_Plants values ('Andy', 13, 1);
insert into Farmer_Plants values ('Holland', 14, 2);
insert into Farmer_Plants values ('Holland', 15, 3);
insert into Farmer_Plants values ('Holland', 16, 4);

insert into Farmer_Plants values ('Holland', 17, 1);
insert into Farmer_Plants values ('Holland', 18, 2);
insert into Farmer_Plants values ('Holland', 19, 3);
insert into Farmer_Plants values ('Holland', 20, 4);

insert into Farmer_Plants values ('Andy', 21, 1);
insert into Farmer_Plants values ('Andy', 22, 2);
insert into Farmer_Plants values ('Andy', 23, 3);
insert into Farmer_Plants values ('Holland', 24, 4);

insert into Farmer_Plants values ('Andy', 25, 1);
insert into Farmer_Plants values ('Holland', 26, 2);
insert into Farmer_Plants values ('Holland', 27, 3);
insert into Farmer_Plants values ('Holland', 28, 4);

insert into Farmer_Plants values ('Holland', 29, 1);
insert into Farmer_Plants values ('Holland', 30, 2);
insert into Farmer_Plants values ('Holland', 31, 3);
insert into Farmer_Plants values ('Holland', 32, 4);

insert into Farmer_Plants values ('Holland', 33, 1);
insert into Farmer_Plants values ('Holland', 34, 2);
insert into Farmer_Plants values ('Andy', 35, 3);
insert into Farmer_Plants values ('Holland', 36, 4);

insert into Farmer_Plants values ('Andy', 37, 1);
insert into Farmer_Plants values ('Holland', 38, 2);
insert into Farmer_Plants values ('Andy', 39, 3);
insert into Farmer_Plants values ('Holland', 40, 4);

insert into Farmer_Plants values ('Andy', 41, 1);
insert into Farmer_Plants values ('Andy', 42, 2);
insert into Farmer_Plants values ('Holland', 43, 3);
insert into Farmer_Plants values ('Andy', 44, 4);

insert into Farmer_Plants values ('Holland', 45, 1);
insert into Farmer_Plants values ('Andy', 46, 2);
insert into Farmer_Plants values ('Andy', 47, 3);
insert into Farmer_Plants values ('Holland', 48, 4);

insert into Farmer_Plants values ('Andy', 49, 1);
insert into Farmer_Plants values ('Andy', 50, 2);
insert into Farmer_Plants values ('Andy', 51, 3);
insert into Farmer_Plants values ('Andy', 52, 4);

insert into Farmer_Plants values ('Holland', 53, 1);
insert into Farmer_Plants values ('Andy', 54, 2);
insert into Farmer_Plants values ('Holland', 55, 3);
insert into Farmer_Plants values ('Holland', 56, 4);

insert into Farmer_Plants values ('Holland', 57, 1);
insert into Farmer_Plants values ('Holland', 58, 2);
insert into Farmer_Plants values ('Holland', 59, 3);
insert into Farmer_Plants values ('Holland', 60, 4);

insert into Farmer_Plants values ('Andy', 61, 1);
insert into Farmer_Plants values ('Holland', 62, 2);
insert into Farmer_Plants values ('Holland', 63, 3);
insert into Farmer_Plants values ('Andy', 64, 4);

insert into Farmer_Plants values ('Andy', 65, 1);
insert into Farmer_Plants values ('Andy', 66, 2);
insert into Farmer_Plants values ('Andy', 67, 3);
insert into Farmer_Plants values ('Andy', 68, 4);

-- Farmer_Tends_Cattle
insert into Farmer_Tends_Cattle values ('Andy', 'Barn', 'Cow');
insert into Farmer_Tends_Cattle values ('Holland', 'Barn', 'Cow');
insert into Farmer_Tends_Cattle  values ('Andy', 'Barn', 'Goat');
insert into Farmer_Tends_Cattle values ('Holland', 'Barn', 'Sheep');
insert into Farmer_Tends_Cattle values ('Andy', 'Barn', 'Pig');
insert into Farmer_Tends_Cattle values ('Holland', 'Barn', 'Pig');
insert into Farmer_Tends_Cattle values ('Andy', 'Coop', 'Chicken');
insert into Farmer_Tends_Cattle values ('Holland', 'Coop', 'Rabbit');
insert into Farmer_Tends_Cattle values ('Andy', 'Coop', 'Dinosaur');
insert into Farmer_Tends_Cattle values ('Holland', 'Coop', 'Dinosaur');


-- Cattle Produces
insert into Cattle_Produces values ('Barn', 'Cow', 'Small Milk');
insert into Cattle_Produces values ('Barn', 'Cow', 'Milk');
insert into Cattle_Produces values ('Barn', 'Cow', 'Large Milk');
insert into Cattle_Produces values ('Barn', 'Goat', 'Small Goat Milk');
insert into Cattle_Produces values ('Barn', 'Goat', 'Goat Milk');
insert into Cattle_Produces values ('Barn', 'Goat', 'Large Goat Milk');
insert into Cattle_Produces values ('Barn', 'Sheep', 'Sheep Milk');
insert into Cattle_Produces values ('Barn', 'Sheep', 'Wool');
insert into Cattle_Produces values ('Barn', 'Pig', 'Truffle');
insert into Cattle_Produces values ('Barn', 'Pig', 'Bacon');
insert into Cattle_Produces values ('Coop', 'Chicken', 'Small Egg');
insert into Cattle_Produces values ('Coop', 'Chicken', 'Egg');
insert into Cattle_Produces values ('Coop', 'Chicken', 'Large Egg');
insert into Cattle_Produces values ('Coop', 'Rabbit', 'Rabbit Foot');
insert into Cattle_Produces values ('Coop', 'Rabbit', 'Fur');
insert into Cattle_Produces values ('Coop', 'Dinosaur', 'Dinosaur Egg');
insert into Cattle_Produces values ('Coop', 'Dinosaur', 'Large Dinosaur Egg');
insert into Cattle_Produces values ('Stable', 'Horse', 'nothing');
insert into Cattle_Produces values ('Farm', 'Cat', 'nothing');
insert into Cattle_Produces values ('Farm', 'Dog', 'nothing');

DROP VIEW IF EXISTS less_Profit_From_Seed;
DROP FUNCTION IF EXISTS total_Profit_From_Crop;
DROP PROCEDURE IF EXISTS updateFarmerGold;

-- View for finding which purchased seed produces no profit for farmer
CREATE VIEW less_Profit_From_Seed AS
SELECT X.crop_ID, quality AS "Quality", type_of_crop AS "No Profit Crop"
FROM Crops X
WHERE X.crop_ID IN (SELECT crop_ID FROM Farmer_Buys_Seeds WHERE price_of_seed > X.price_each - price_of_seed);

-- Obtains total profit if we were to sell certain crop that is passed as an argument
DELIMITER //
CREATE FUNCTION total_Profit_From_Crop
(
	-- Id of crop
	checkingCrop	int
)
RETURNS int 
BEGIN
	-- returning this value
	DECLARE expectedProfit	int DEFAULT 0;
    
    SELECT SUM(quantity * price_each)
    INTO expectedProfit
	FROM Crops
	WHERE crop_ID = checkingCrop;
    
    return expectedProfit;
END //
DELIMITER ;

-- Procedure to update farmer table based on what crops are sold
DELIMITER //
CREATE PROCEDURE updateFarmerGold
(
	IN cropIdentification	int,
    IN quantityToSell		int,
    OUT outputText			varchar(200)
)
BEGIN
	DECLARE	whichFarmerIsSelling	varchar(16);
    DECLARE profitMade				int;
    DECLARE isValid					int;
    DECLARE priceOfCrop				int;
    DECLARE cropName				varchar(30);
    DECLARE qualityType				varchar(30);
    
    Set qualityType = (SELECT quality FROM Crops WHERE cropIdentification = crop_ID);
    SET isValid = (SELECT quantity FROM Crops WHERE cropIdentification = crop_ID);
    SET cropName = (SELECT type_of_crop FROM Crops WHERE crop_ID = cropIdentification);
    
    -- Find and set which farmer is assigned to sell certain crop
    IF (quantityToSell <=  isValid) THEN 
		SET whichFarmerIsSelling = (SELECT farmer FROM Farmer_Plants WHERE cropIdentification = crop_ID);
        SET priceOfCrop = (SELECT price_each FROM Crops WHERE cropIdentification = crop_ID);
        Set profitMade = (priceOfCrop * quantityToSell);
        
        -- Update the Farmer's Profit
        UPDATE Farmer
        SET gold = profitMade
        WHERE player_ID = whichFarmerIsSelling;
        
        -- Update the crops quantity column
        UPDATE Crops
        SET quantity = (quantity - quantityToSell)
        WHERE crop_ID = cropIdentification;
        SET outputText = CONCAT(whichFarmerIsSelling , " has successfully sold: ", profitMade, 
								" gold worth of ", qualityType, " " ,cropName); 
        
	ELSE 
		SET outputText = CONCAT('You are trying to sell more quantity than you currently own...');
	END IF;
    
END //
DELIMITER ;
    