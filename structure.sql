#
# Structure for the `categories` table : 
#

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT '0',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_id` (`category_id`)
) ;

#
# Definition for the `CatHierarchyView` view : 
# NOTE THIS IS UP TO LEVEL 4 Category Just Adjust it if you want to add more
#

CREATE VIEW CatHierarchyView AS 
  select 
    `lvl4`.`category_id` AS `CatID`,
    (case when (ifnull(`lvl1`.`category_id`,'NULL') <> 'NULL') then 4 when (ifnull(`lvl2`.`category_id`,'NULL') <> 'NULL') then 3 when (ifnull(`lvl3`.`category_id`,'NULL') <> 'NULL') then 2 when (ifnull(`lvl4`.`category_id`,'NULL') <> 'NULL') then 1 end) AS `CatLevel`,
    (case when (ifnull(`lvl1`.`category_id`,'NULL') <> 'NULL') then concat(`lvl1`.`category`,' > ',`lvl2`.`category`,' > ',`lvl3`.`category`,' > ',`lvl4`.`category`) when (ifnull(`lvl2`.`category_id`,'NULL') <> 'NULL') then concat(`lvl2`.`category`,' > ',`lvl3`.`category`,' > ',`lvl4`.`category`) when (ifnull(`lvl3`.`category_id`,'NULL') <> 'NULL') then concat(`lvl3`.`category`,' > ',`lvl4`.`category`) when (ifnull(`lvl4`.`category_id`,'NULL') <> 'NULL') then `lvl4`.`category` end) AS `CatCaption`,
    `lvl4`.`category` AS `CatName`,
    `lvl4`.`parent_id` AS `ParentID`,
    `lvl4`.`description` AS `Description`,
    `lvl1`.`category` AS `cat1`,
    `lvl2`.`category` AS `cat2`,
    `lvl3`.`category` AS `cat3`,
    `lvl4`.`category` AS `cat4` 
  from 
    (`categories` `lvl4` left join (`categories` `lvl3` left join (`categories` `lvl2` left join `categories` `lvl1` on((`lvl1`.`category_id` = `lvl2`.`parent_id`))) on((`lvl2`.`category_id` = `lvl3`.`parent_id`))) on((`lvl3`.`category_id` = `lvl4`.`parent_id`))) 
  order by 
    (case when (ifnull(`lvl1`.`category_id`,'NULL') <> 'NULL') then concat(`lvl1`.`category`,' > ',`lvl2`.`category`,' > ',`lvl3`.`category`,' > ',`lvl4`.`category`,' > ') when (ifnull(`lvl2`.`category_id`,'NULL') <> 'NULL') then concat(`lvl2`.`category`,' > ',`lvl3`.`category`,' > ',`lvl4`.`category`) when (ifnull(`lvl3`.`category_id`,'NULL') <> 'NULL') then concat(`lvl3`.`category`,' > ',`lvl4`.`category`) when (ifnull(`lvl4`.`category_id`,'NULL') <> 'NULL') then `lvl4`.`category` end);

#
# Data for the `categories` table  
#

INSERT INTO `categories` (`category_id`, `category`, `description`, `parent_id`) VALUES 
  (1,'Asia',NULL,0),
  (2,'North America',NULL,0),
  (3,'Philippines',NULL,1),
  (4,'Singapore',NULL,1),
  (5,'Korea',NULL,1),
  (6,'United States',NULL,2),
  (7,'Mexico',NULL,2),
  (8,'New York',NULL,6),
  (9,'Colorado',NULL,6),
  (10,'Manila',NULL,3),
  (11,'Pampanga',NULL,3),
  (12,'Angeles City',NULL,11),
  (13,'San Fernando',NULL,11),
  (14,'Kingston',NULL,8),
  (15,'Poughkeepsie–Newburgh',NULL,8);
  
