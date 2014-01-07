DELIMITER $$
CREATE PROCEDURE addQueuedItem(IN in_id BIGINT, IN in_interaction CHAR(8))
BEGIN
	    INSERT INTO QueuedItems(id, interaction, creation) VALUES(in_id, in_interaction, NOW());
END$$
DELIMITER ;

DELIMITER //
CREATE TRIGGER upd_description BEFORE UPDATE ON Descriptions
FOR EACH ROW
BEGIN
        CALL addQueuedItem(NEW.id, 'universe');
END//
DELIMITER ;
CREATE TABLE IF NOT EXISTS `QueuedItems` (
  `id` bigint(20) NOT NULL,
  `interaction` char(8) COLLATE utf8_bin NOT NULL,
  `inuse` char(1) COLLATE utf8_bin NOT NULL DEFAULT 'N',
  `startinuse` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creation` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`,`interaction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='used to hold a queue of items';
	
DELIMITER //
CREATE TRIGGER upd_student BEFORE UPDATE ON students
FOR EACH ROW
BEGIN
        CALL addQueuedItem(NEW.id, 'universe');
END//
DELIMITER ;
