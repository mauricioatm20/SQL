CREATE TABLE `empleados` (
  `idempleado` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`idempleado`),
  UNIQUE KEY `idempleado_UNIQUE` (`idempleado`)
);


CREATE TABLE `moviles` (
  `id_movil` int NOT NULL auto_increment,
  `descripcion` varchar(45) NOT NULL,
  `fk_empleado` int NOT NULL,
  PRIMARY KEY (`id_movil`),
  UNIQUE KEY `fk_empleado_UNIQUE` (`fk_empleado`),
  CONSTRAINT `moviles_empleaods` FOREIGN KEY (`fk_empleado`) REFERENCES `empleados` (`idempleado`)
);
