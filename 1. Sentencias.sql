CREATE TABLE Cliente ( 
    ID_cliente integer AUTO_INCREMENT,
    nombre Varchar(50) NOT NULL,
    apellido Varchar(50) NOT NULL,
    correo_electronico Varchar(100),
    numero_telefono Varchar(15),
    CONSTRAINT pk_cliente PRIMARY KEY (ID_cliente)
);
-- He creado la tabla cliente con los atributos indicados en el enunciados. Hacemos el id autoincremental.


CREATE TABLE Vehiculo ( 
    ID_vehiculo integer AUTO_INCREMENT,
    marca Varchar(50) NOT NULL,
    modelo Varchar(50) NOT NULL,
    anio integer CHECK (anio BETWEEN 1000 AND 9999),
    categoria ENUM ('economico', 'estandar', 'lujo') not null,
    estaAlquilado boolean not null,
    CONSTRAINT pk_vehiculo PRIMARY KEY (ID_vehiculo)
);
--He creado la tabla Vehiculo que tiene un tipo enum para el atributo categoria. Si la categoria
--fuera un atributo que vaya a modificarse con el tiempo ( añadiendo otras categorias), sería mas correcto
-- crear otra tabla maestra de categorias, que incluyera a cada categoria, un id, y unirla mediante FK a la
-- tabla vehiculo. He considerado que eso no pasaría en este caso. Además, he añadido el atributo extra "estaAlquilado" que no 
--está en el enunciado. Este será un atributo calculado para comprobar, de manera mas sencilla,
-- si un coche esta disponible para alquilar o no. Se deberia estar pendiente de actualizar este campo. He restringido
--el ingreso de datos en el atributo "anio" a numeros de 4 digitos.

CREATE TABLE Alquiler (
    ID_cliente INTEGER,
    ID_vehiculo INTEGER,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    coste DECIMAL(8,2) NOT NULL CHECK (coste >= 0),
    CONSTRAINT pk_alquiler PRIMARY KEY (ID_cliente, ID_vehiculo, fecha_inicio),
    CONSTRAINT fk_alquiler_cliente FOREIGN KEY (ID_cliente) REFERENCES Cliente(ID_cliente) ON DELETE CASCADE,
    CONSTRAINT fk_alquiler_vehiculo FOREIGN KEY (ID_vehiculo) REFERENCES Vehiculo(ID_vehiculo) ON DELETE CASCADE,
    CONSTRAINT chk_fechas CHECK (fecha_fin > fecha_inicio)
);
--He creado la tabla alquiler utilizando como clave primaria tanto el id_cliente, el id_vehiculo como la fecha_inicio, para que
--un cliente pueda alquiler el mismo coche mas de una vez. He incluido dos restricciones, el coste siempre tiene que ser 0 o mayor de 0
-- y la fecha de fin de un alquiler no puede ser anterior a la fecha inicio. 
