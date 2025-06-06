﻿/*
Deployment script for Pokedex

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Pokedex"
:setvar DefaultFilePrefix "Pokedex"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO

  CREATE PROCEDURE [dbo].[SeedTable_Types] AS
BEGIN

    PRINT 'Populating records in [dbo].[Types]';

    IF OBJECT_ID('tempdb.dbo.#dbo_SeedTypes') IS NOT NULL DROP TABLE #dbo_SeedTypes;

    SELECT 
        [Id], [Name] 
    INTO #dbo_SeedTypes 
    FROM [dbo].[Types] 
    WHERE 0 = 1;

    INSERT INTO #dbo_SeedTypes 
        ( [Id], [Name] )
    SELECT 
          [Id], [Name] 
    FROM 
    (  VALUES
            (0, 'Fire')
          , (1, 'Water')
          , (2, 'Flying')
          , (3, 'Fighting')
          , (4, 'Steel')
          , (5, 'Ground')
          , (6, 'Psychic')
          , (7, 'Rock')
          , (8, 'Grass')
          , (9, 'Electric')
          , (10, 'Ice')
          , (11, 'Bug')
          , (12, 'Poison')
          , (13, 'Ghost')
          , (14, 'Dark')
          , (15, 'Dragon')
          , (16, 'Fairy')
          , (17, 'Normal')
          


    ) AS v ( [Id], [Name] );

    WITH cte_data as 
        (SELECT 
            [Id], [Name] 
        FROM #dbo_SeedTypes)
    MERGE [dbo].[Types] as t
        USING cte_data as s ON t.[Id] = s.[Id]
        WHEN NOT MATCHED BY TARGET THEN
            INSERT 
                ([Id], [Name])
            VALUES 
                (s.[Id], s.[Name])
        WHEN MATCHED 
            THEN UPDATE SET 
                [Name] = s.[Name]
    ;

    DROP TABLE #dbo_SeedTypes;

    PRINT 'Finished Populating records in [dbo].[Types]'
END
GO

EXEC [dbo].[SeedTable_Types];

DROP PROCEDURE IF EXISTS [dbo].[SeedTable_Types] 
GO

CREATE PROCEDURE [dbo].[SeedTable_Pokemon]
AS
BEGIN
    SET NOCOUNT ON;
    
    IF OBJECT_ID('tempdb.dbo.#SeedPokemon') IS NOT NULL
        DROP TABLE #SeedPokemon;


    -- Create a temporary table
    CREATE TABLE #SeedPokemon (
        [PokemonId] INT,
        [Name] NVARCHAR(50),
        [HP] INT,
        [Attack] INT,
        [Defense] INT,
        [Speed] INT,
        [Ability] NVARCHAR(50),
        [Legendary] BIT,
        [Region] NVARCHAR(50)
    );

    -- Insert Pokémon data into temp table
    INSERT INTO #SeedPokemon
    VALUES
    
        (1, 'Bulbasaur', 45, 49, 49, 45, 'Overgrow', 0, 'Kanto'),
        (2, 'Ivysaur', 60, 62, 63, 60, 'Overgrow', 0, 'Kanto'),
        (3, 'Venusaur', 80, 82, 83, 80, 'Overgrow', 0, 'Kanto'),
        (4, 'Charmander', 39, 52, 43, 65, 'Blaze', 0, 'Kanto'),
        (5, 'Charmeleon', 58, 64, 58, 80, 'Blaze', 0, 'Kanto'),
        (6, 'Charizard', 78, 84, 78, 100, 'Blaze', 0, 'Kanto'),
        (7, 'Squirtle', 44, 48, 65, 43, 'Torrent', 0, 'Kanto'),
        (8, 'Wartortle', 59, 63, 80, 58, 'Torrent', 0, 'Kanto'),
        (9, 'Blastoise', 79, 83, 100, 78, 'Torrent', 0, 'Kanto'),
        (10, 'Caterpie', 45, 30, 35, 45, 'Shield Dust', 0, 'Kanto'),
        (11, 'Metapod', 50, 20, 55, 30, 'Shed Skin', 0, 'Kanto'),
        (12, 'Butterfree', 60, 45, 50, 70, 'Compound Eyes', 0, 'Kanto'),
        (13, 'Weedle', 40, 35, 30, 50, 'Shield Dust', 0, 'Kanto'),
        (14, 'Kakuna', 45, 25, 50, 35, 'Shed Skin', 0, 'Kanto'),
        (15, 'Beedrill', 65, 90, 40, 75, 'Swarm', 0, 'Kanto'),
        (16, 'Pidgey', 40, 45, 40, 56, 'Keen Eye', 0, 'Kanto'),
        (17, 'Pidgeotto', 63, 60, 55, 71, 'Keen Eye', 0, 'Kanto'),
        (18, 'Pidgeot', 83, 80, 75, 101, 'Keen Eye', 0, 'Kanto'),
        (19, 'Rattata', 30, 56, 35, 72, 'Run Away', 0, 'Kanto'),
        (20, 'Raticate', 55, 81, 60, 97, 'Run Away', 0, 'Kanto'),
        (21, 'Spearow', 40, 60, 30, 70, 'Keen Eye', 0, 'Kanto'),
        (22, 'Fearow', 65, 90, 65, 100, 'Keen Eye', 0, 'Kanto'),
        (23, 'Ekans', 35, 60, 44, 55, 'Intimidate', 0, 'Kanto'),
        (24, 'Arbok', 60, 85, 69, 80, 'Intimidate', 0, 'Kanto'),
        (25, 'Pikachu', 35, 55, 40, 90, 'Static', 0, 'Kanto'),
        (26, 'Raichu', 60, 90, 55, 110, 'Static', 0, 'Kanto'),
        (27, 'Sandshrew', 50, 75, 85, 40, 'Sand Veil', 0, 'Kanto'),
        (28, 'Sandslash', 75, 100, 110, 65, 'Sand Veil', 0, 'Kanto'),
        (29, 'Nidoran♀', 55, 47, 52, 41, 'Poison Point', 0, 'Kanto'),
        (30, 'Nidorina', 70, 62, 67, 56, 'Poison Point', 0, 'Kanto'),
        (31, 'Nidoqueen', 90, 92, 87, 76, 'Poison Point', 0, 'Kanto'),
        (32, 'Nidoran♂', 46, 57, 40, 50, 'Poison Point', 0, 'Kanto'),
        (33, 'Nidorino', 61, 72, 57, 65, 'Poison Point', 0, 'Kanto'),
        (34, 'Nidoking', 81, 102, 77, 85, 'Poison Point', 0, 'Kanto'),
        (35, 'Clefairy', 70, 45, 48, 35, 'Cute Charm', 0, 'Kanto'),
        (36, 'Clefable', 95, 70, 73, 60, 'Cute Charm', 0, 'Kanto'),
        (37, 'Vulpix', 38, 41, 40, 65, 'Flash Fire', 0, 'Kanto'),
        (38, 'Ninetales', 73, 76, 75, 100, 'Flash Fire', 0, 'Kanto'),
        (39, 'Jigglypuff', 115, 45, 20, 20, 'Cute Charm', 0, 'Kanto'),
        (40, 'Wigglytuff', 140, 70, 45, 45, 'Cute Charm', 0, 'Kanto'),
        (41, 'Zubat', 40, 45, 35, 55, 'Inner Focus', 0, 'Kanto'),
        (42, 'Golbat', 75, 80, 70, 90, 'Inner Focus', 0, 'Kanto'),
        (43, 'Oddish', 45, 50, 55, 30, 'Chlorophyll', 0, 'Kanto'),
        (44, 'Gloom', 60, 65, 70, 40, 'Chlorophyll', 0, 'Kanto'),
        (45, 'Vileplume', 75, 80, 85, 50, 'Chlorophyll', 0, 'Kanto'),
        (46, 'Paras', 35, 70, 55, 25, 'Effect Spore', 0, 'Kanto'),
        (47, 'Parasect', 60, 95, 80, 30, 'Effect Spore', 0, 'Kanto'),
        (48, 'Venonat', 60, 55, 50, 45, 'Compound Eyes', 0, 'Kanto'),
        (49, 'Venomoth', 70, 65, 60, 90, 'Shield Dust', 0, 'Kanto'),
        (50, 'Diglett', 10, 55, 25, 95, 'Sand Veil', 0, 'Kanto'),
        (51, 'Dugtrio', 35, 80, 50, 120, 'Sand Veil', 0, 'Kanto'),
        (52, 'Meowth', 40, 45, 35, 90, 'Pickup', 0, 'Kanto'),
        (53, 'Persian', 65, 70, 60, 115, 'Limber', 0, 'Kanto'),
        (54, 'Psyduck', 50, 52, 48, 55, 'Damp', 0, 'Kanto'),
        (55, 'Golduck', 80, 82, 78, 85, 'Damp', 0, 'Kanto'),
        (56, 'Mankey', 40, 80, 35, 70, 'Vital Spirit', 0, 'Kanto'),
        (57, 'Primeape', 65, 105, 60, 95, 'Vital Spirit', 0, 'Kanto'),
        (58, 'Growlithe', 55, 70, 45, 60, 'Intimidate', 0, 'Kanto'),
        (59, 'Arcanine', 90, 110, 80, 95, 'Intimidate', 0, 'Kanto'),
        (60, 'Poliwag', 40, 50, 40, 90, 'Water Absorb', 0, 'Kanto'),
        (61, 'Poliwhirl', 65, 65, 65, 90, 'Water Absorb', 0, 'Kanto'),
        (62, 'Poliwrath', 90, 85, 95, 70, 'Water Absorb', 0, 'Kanto'),
        (63, 'Abra', 25, 20, 15, 90, 'Synchronize', 0, 'Kanto'),
        (64, 'Kadabra', 40, 35, 30, 105, 'Synchronize', 0, 'Kanto'),
        (65, 'Alakazam', 55, 50, 45, 120, 'Synchronize', 0, 'Kanto'),
        (66, 'Machop', 70, 80, 50, 35, 'Guts', 0, 'Kanto'),
        (67, 'Machoke', 80, 100, 70, 45, 'Guts', 0, 'Kanto'),
        (68, 'Machamp', 90, 130, 80, 55, 'Guts', 0, 'Kanto'),
        (69, 'Bellsprout', 50, 75, 35, 40, 'Chlorophyll', 0, 'Kanto'),
        (70, 'Weepinbell', 65, 90, 50, 55, 'Chlorophyll', 0, 'Kanto'),
        (71, 'Victreebel', 80, 105, 65, 70, 'Chlorophyll', 0, 'Kanto'),
        (72, 'Tentacool', 40, 40, 35, 70, 'Clear Body', 0, 'Kanto'),
        (73, 'Tentacruel', 80, 70, 65, 100, 'Clear Body', 0, 'Kanto'),
        (74, 'Geodude', 40, 80, 100, 20, 'Rock Head', 0, 'Kanto'),
        (75, 'Graveler', 55, 95, 115, 35, 'Rock Head', 0, 'Kanto'),
        (76, 'Golem', 80, 110, 130, 45, 'Rock Head', 0, 'Kanto'),
        (77, 'Ponyta', 50, 85, 55, 90, 'Run Away', 0, 'Kanto'),
        (78, 'Rapidash', 65, 100, 70, 105, 'Run Away', 0, 'Kanto'),
        (79, 'Slowpoke', 90, 65, 65, 15, 'Oblivious', 0, 'Kanto'),
        (80, 'Slowbro', 95, 75, 110, 30, 'Oblivious', 0, 'Kanto'),
        (81, 'Magnemite', 25, 35, 70, 45, 'Magnet Pull', 0, 'Kanto'),
        (82, 'Magneton', 50, 60, 95, 70, 'Magnet Pull', 0, 'Kanto'),
        (83, 'Farfetch’d', 52, 65, 55, 60, 'Keen Eye', 0, 'Kanto'),
        (84, 'Doduo', 35, 85, 45, 75, 'Run Away', 0, 'Kanto'),
        (85, 'Dodrio', 60, 110, 70, 100, 'Run Away', 0, 'Kanto'),
        (86, 'Seel', 65, 45, 55, 45, 'Thick Fat', 0, 'Kanto'),
        (87, 'Dewgong', 90, 70, 80, 70, 'Thick Fat', 0, 'Kanto'),
        (88, 'Grimer', 80, 80, 50, 25, 'Stench', 0, 'Kanto'),
        (89, 'Muk', 105, 105, 75, 50, 'Stench', 0, 'Kanto'),
        (90, 'Shellder', 30, 65, 100, 40, 'Shell Armor', 0, 'Kanto'),
        (91, 'Cloyster', 50, 95, 180, 70, 'Shell Armor', 0, 'Kanto'),
        (92, 'Gastly', 30, 35, 30, 80, 'Levitate', 0, 'Kanto'),
        (93, 'Haunter', 45, 50, 45, 95, 'Levitate', 0, 'Kanto'),
        (94, 'Gengar', 60, 65, 60, 110, 'Levitate', 0, 'Kanto'),
        (95, 'Onix', 35, 45, 160, 70, 'Rock Head', 0, 'Kanto'),
        (96, 'Drowzee', 60, 48, 45, 42, 'Insomnia', 0, 'Kanto'),
        (97, 'Hypno', 85, 73, 70, 67, 'Insomnia', 0, 'Kanto'),
        (98, 'Krabby', 30, 105, 90, 50, 'Hyper Cutter', 0, 'Kanto'),
        (99, 'Kingler', 55, 130, 115, 75, 'Hyper Cutter', 0, 'Kanto'),
        (100, 'Voltorb', 40, 30, 50, 100, 'Soundproof', 0, 'Kanto'),
        (101, 'Electrode', 60, 50, 70, 140, 'Soundproof', 0, 'Kanto'),
        (102, 'Exeggcute', 60, 40, 80, 40, 'Chlorophyll', 0, 'Kanto'),
        (103, 'Exeggutor', 95, 95, 85, 55, 'Chlorophyll', 0, 'Kanto'),
        (104, 'Cubone', 50, 50, 95, 35, 'Rock Head', 0, 'Kanto'),
        (105, 'Marowak', 60, 80, 110, 45, 'Rock Head', 0, 'Kanto'),
        (106, 'Hitmonlee', 50, 120, 53, 87, 'Limber', 0, 'Kanto'),
        (107, 'Hitmonchan', 50, 105, 79, 76, 'Inner Focus', 0, 'Kanto'),
        (108, 'Lickitung', 90, 55, 75, 30, 'Own Tempo', 0, 'Kanto'),
        (109, 'Koffing', 40, 65, 95, 35, 'Levitate', 0, 'Kanto'),
        (110, 'Weezing', 65, 90, 120, 60, 'Levitate', 0, 'Kanto'),
        (111, 'Rhyhorn', 80, 85, 95, 25, 'Lightning Rod', 0, 'Kanto'),
        (112, 'Rhydon', 105, 130, 120, 40, 'Lightning Rod', 0, 'Kanto'),
        (113, 'Chansey', 250, 5, 5, 50, 'Natural Cure', 0, 'Kanto'),
        (114, 'Tangela', 65, 55, 115, 60, 'Chlorophyll', 0, 'Kanto'),
        (115, 'Kangaskhan', 105, 95, 80, 90, 'Early Bird', 0, 'Kanto'),
        (116, 'Horsea', 30, 40, 70, 60, 'Swift Swim', 0, 'Kanto'),
        (117, 'Seadra', 55, 65, 95, 85, 'Poison Point', 0, 'Kanto'),
        (118, 'Goldeen', 45, 67, 60, 63, 'Swift Swim', 0, 'Kanto'),
        (119, 'Seaking', 80, 92, 65, 68, 'Swift Swim', 0, 'Kanto'),
        (120, 'Staryu', 30, 45, 55, 85, 'Illuminate', 0, 'Kanto'),
        (121, 'Starmie', 60, 75, 85, 115, 'Illuminate', 0, 'Kanto'),
        (122, 'Mr. Mime', 40, 45, 65, 90, 'Soundproof', 0, 'Kanto'),
        (123, 'Scyther', 70, 110, 80, 105, 'Swarm', 0, 'Kanto'),
        (124, 'Jynx', 65, 50, 35, 95, 'Oblivious', 0, 'Kanto'),
        (125, 'Electabuzz', 65, 83, 57, 105, 'Static', 0, 'Kanto'),
        (126, 'Magmar', 65, 95, 57, 93, 'Flame Body', 0, 'Kanto'),
        (127, 'Pinsir', 65, 125, 100, 85, 'Hyper Cutter', 0, 'Kanto'),
        (128, 'Tauros', 75, 100, 95, 110, 'Intimidate', 0, 'Kanto'),
        (129, 'Magikarp', 20, 10, 55, 80, 'Swift Swim', 0, 'Kanto'),
        (130, 'Gyarados', 95, 125, 79, 81, 'Intimidate', 0, 'Kanto'),
        (131, 'Lapras', 130, 85, 80, 60, 'Water Absorb', 0, 'Kanto'),
        (132, 'Ditto', 48, 48, 48, 48, 'Limber', 0, 'Kanto'),
        (133, 'Eevee', 55, 55, 50, 55, 'Run Away', 0, 'Kanto'),
        (134, 'Vaporeon', 130, 65, 60, 65, 'Water Absorb', 0, 'Kanto'),
        (135, 'Jolteon', 65, 65, 60, 130, 'Volt Absorb', 0, 'Kanto'),
        (136, 'Flareon', 65, 130, 60, 65, 'Flash Fire', 0, 'Kanto'),
        (137, 'Porygon', 65, 60, 70, 40, 'Trace', 0, 'Kanto'),
        (138, 'Omanyte', 35, 40, 100, 35, 'Swift Swim', 0, 'Kanto'),
        (139, 'Omastar', 70, 60, 125, 55, 'Swift Swim', 0, 'Kanto'),
        (140, 'Kabuto', 30, 80, 90, 55, 'Swift Swim', 0, 'Kanto'),
        (141, 'Kabutops', 60, 115, 105, 80, 'Swift Swim', 0, 'Kanto'),
        (142, 'Aerodactyl', 80, 105, 65, 130, 'Pressure', 0, 'Kanto'),
        (143, 'Snorlax', 160, 110, 65, 30, 'Immunity', 0, 'Kanto'),
        (144, 'Articuno', 90, 85, 100, 85, 'Pressure', 1, 'Kanto'),
        (145, 'Zapdos', 90, 90, 85, 100, 'Pressure', 1, 'Kanto'),
        (146, 'Moltres', 90, 100, 90, 90, 'Pressure', 1, 'Kanto'),
        (147, 'Dratini', 41, 64, 45, 50, 'Shed Skin', 0, 'Kanto'),
        (148, 'Dragonair', 61, 84, 65, 70, 'Shed Skin', 0, 'Kanto'),
        (149, 'Dragonite', 91, 134, 95, 80, 'Inner Focus', 0, 'Kanto'),
        (150, 'Mewtwo', 106, 110, 90, 130, 'Pressure', 1, 'Kanto'),
        (151, 'Mew', 100, 100, 100, 100, 'Synchronize', 1, 'Kanto')

  INSERT INTO Pokemon ([PokemonId], [Name], [HP], [Attack], [Defense], [Speed], [Ability], [Legendary], [Region])
    SELECT * FROM #SeedPokemon;

    -- Drop the temporary table
    DROP TABLE #SeedPokemon;

       DROP TABLE #SeedPokemon;
END;


GO

GO
PRINT N'Update complete.';


GO
