-- 7/09/2023 14:55

Drop database if exists kicine;
Create database Kicine;
use Kicine;

-- Se registran los usuarios, esta se usará solo en el login y para agregar usuarios, solo se maneja por usuario normal.
-- Con el ícono de ajustes vamos a hacer que pueda eliminar su usuario y actualizarlo.
-- Quiyuch
Create table Usuario(
  idUsuario int auto_increment not null,
  nombre varchar(255) not null,
  apellido varchar(255) not null,
  correo_electronico varchar(255) not null,
  contrasena varchar(255) not null,
  foto LONGBLOB,
  primary key PK_idUsuario(idUsuario) 
);

select *from usuario;


insert into Usuario(nombre, apellido, correo_electronico, contrasena)
values("Juan Pablo", "Gonzalez Gregorio", "jpgonzalez123@gmail.com", "123");
select * from usuario;

-- Se agregan peliculas por el usuario master, tiene que tener crud completo.
Create table Pelicula(
  idPelicula int auto_increment,
  titulo varchar(255) not null,
  genero varchar(255) not null,
  director varchar(255) not null,
  duracion int not null, -- //////////////////////////// TIME?
  sinopsis text not null, -- dato que almacena 65000 caracteres
  lanzamiento date not null,
  calificacion varchar(50) not null,
  idioma varchar(50) not null,
  foto LONGBLOB,
  primary key PK_idPelicula(idPelicula)
);

select * from pelicula;
-- select * from Entrada;


insert into Pelicula (titulo, genero, director, duracion, sinopsis, lanzamiento, calificacion, idioma)
	 values ("El patito feo", "comedia", "Guillermo del toro", 180, "Un pato  es brutalmente asesinado a manos de un ganzo", "2018-05-20", "4.3/5", "Polaco" );
     
insert into Pelicula (titulo, genero, director, duracion, sinopsis, lanzamiento, calificacion, idioma)
	 values ("Jason", "Miedo", "Juancho", 120, "Jason bien cabron", "2022-05-20", "4.3/5", "Español" );

select * from Pelicula;

-- Brandon
-- Cuando el usuario quiera entrar en preventa se muestran las péliculas que se pueden adquirir en linea y comprar sus boletos.
-- Esto lo hace el master, debe de tener el crud completo.
Create table Preventa(
	idPreventa int not null auto_increment,
    descripcion varchar(255) not null,
    precioPreventa decimal(10, 2) not null,
    pelicula_id int not null,
    primary key PK_idPreventa(idPreventa),
    foreign key (pelicula_id) references Pelicula(idPelicula) on delete cascade
);

insert into Preventa (descripcion, precioPreventa, pelicula_id)
	values("Estreno: El patito feo", 20.55, 1);
    
insert into Preventa (descripcion, precioPreventa, pelicula_id)
	values("Estreno: Jason", 34.55, 2);
    
-- insert into Preventa (descripcion, precioPreventa, pelicula_id)
	-- values("Estreno: Jason 3", 150.0, 2);

select * from Preventa;


-- Las ubicaciones y cine que vamos a tener. Podemos registrarlos de una vez. Crud completo igual
-- Luis michu
Create table Cine(
  idCine int auto_increment not null,
  nombre varchar(255) not null,
  ubicacion varchar(255) not null,
  telefono varchar(50) not null,
  primary key PK_idCine(idCine)
);


Insert into Cine (nombre,ubicacion, telefono)
	values ("KicineCayala", "Ciudad Cayala", "17787");
    
Insert into Cine (nombre,ubicacion, telefono)
	values ("Miraflores", "Zona 11", "5345");
    
Insert into Cine (nombre,ubicacion, telefono)
	values ("SancrisCine", "San Cristobal", "123412");
select * from Cine;
    
-- Se ingresan los datos por el master, crud completo para esta entidad.
-- Acá vamos a saber donde se debe de ubicar el usuario cuando compre su entrada y vaya al cine.
-- También para saber en que cine está.
-- carlos juarez
Create table SalaCine(
  idSalacine int auto_increment not null,
  numeroSala int not null,
  capacidad int not null,
  tipoSala varchar(50) not null,
  cine_id int not null,
  primary key PK_idSalaCine(idSalaCine),
  foreign key (cine_id) references Cine(idCine) on delete cascade
);

select * from SalaCine where cine_id = 1;

insert into SalaCine(numeroSala, capacidad, tipoSala, cine_id)
	values(7,100,"IMAX", 1);
    
insert into SalaCine(numeroSala, capacidad, tipoSala, cine_id)
	values(2,45,"IMAX", 3);
select * from SalaCine;

-- Esto se agrega por el master, acá aparecerán todos los horarios en que se puede ver la película, CRUD completo.
-- Con la disponibilidad de asientos tenemos que actualizar desde java cuantos asientos se compraron y restar en mysql.
-- Palma
Create table HorarioP(
  idHorarioP int auto_increment not null,
  horario varchar(50) not null,
  fecha date not null,  
  disponibilidadAsientos int not null,
  sala_id int not null,
  pelicula_id int not null,
  primary key PK_idHorarioP(idHorarioP),
  foreign key (sala_id) references SalaCine(idSalacine) on delete cascade,
  foreign key (pelicula_id) references Preventa(idPreventa) on delete cascade
);
alter table HorarioP modify fecha varchar(50);

insert into HorarioP(horario, fecha, disponibilidadAsientos, sala_id, pelicula_id)
	values("20:30","2023-12-20", 100, 1,1);
    
insert into HorarioP(horario, fecha, disponibilidadAsientos, sala_id, pelicula_id)
	values("23:30","2023-12-20", 50, 1,1);
    
insert into HorarioP(horario, fecha, disponibilidadAsientos, sala_id, pelicula_id)
	values("23:30","2023-12-20", 50, 1,1);
    
insert into HorarioP(horario, fecha, disponibilidadAsientos, sala_id, pelicula_id)
	values("23:30","2023-12-20", 50, 2,2);
    
select * from HorarioP where pelicula_id = 1;
    
-- insert into HorarioP(horario, fecha, disponibilidadAsientos, sala_id, pelicula_id)
-- values("12:00","2023-12-21", 100, 1,2);
    
-- insert into HorarioP(horario, fecha, disponibilidadAsientos, sala_id, pelicula_id)
	-- values("12:00","2023-12-22", 100, 1,2);
    
-- insert into HorarioP(horario, fecha, disponibilidadAsientos, sala_id, pelicula_id)
	-- values("12:00","2023-12-23", 100, 1,2);
    
    Select * from HorarioP as h inner join SalaCine as s on h.sala_id = s.idSalacine inner join Cine as c on s.cine_id = c.idCine;
    
   -- Select c.nombre, p.duracion, sc.numeroSala, sc.capacidad,  

select * from HorarioP where pelicula_id = 2;   

select * from HorarioP where idHorarioP = 2;
 
Select pe.titulo, c.nombre, sc.numeroSala, sc.capacidad, h.pelicula_id from Cine as c inner join SalaCine as sc on c.idCine = sc.cine_id inner join HorarioP as h on sc.idSalaCine = h.sala_id inner join Preventa p on h.pelicula_id = p.idPreventa inner join Pelicula as pe on p.pelicula_id = pe.idPelicula;

Select c.idCine, c.nombre, sc.idSalaCine, sc.numeroSala, sc.capacidad, h.idHorarioP, h.fecha, h.horario, p.idPreventa, pe.titulo from Cine as c inner join SalaCine as sc on c.idCine = sc.cine_id inner join HorarioP as h on sc.idSalaCine = h.sala_id inner join Preventa p on h.pelicula_id = p.idPreventa inner join Pelicula as pe on p.pelicula_id = pe.idPelicula;


-- Sebastian
Create table Promocion(
  idPromocion int auto_increment not null,
  nombrePromocion varchar(255) not null,
  descripcion text not null,
  fechasValidez varchar(255) not null, -- //////////////////////////// DATE?
  precio decimal(10,2) not null,
  pelicula_id int not null,
  primary key PK_idPromocion(idPromocion),
  foreign key (pelicula_id) references Pelicula(idPelicula) on delete cascade
);
insert Promocion (nombrePromocion, descripcion, fechasValidez, precio, pelicula_id)
	values("2x1 Navidad", "Obten esta promocion en la compra de una entrada para la pelicula: El patito feo", "Miercoles 20 de Dicimebre", 30.00, 1);
    
-- insert Promocion (nombrePromocion, descripcion, fechasValidez, precio, pelicula_id)
	-- values("2x1 Navidad", "Obten esta promocion en la compra de una entrada para la pelicula: Jason", "Miercoles 20 de Dicimebre", 30.00, 2);
select * from Promocion;


SELECT
    Pr.descripcion,
    Pr.fechasValidez,
    Pr.precio,
    P.titulo,
    P.foto
FROM
    Pelicula AS P
INNER JOIN
    Promocion AS Pr
ON
    P.idPelicula = Pr.pelicula_id;



-- Beto
Create table FuncionEspecial (
  idFuncionEspecial int auto_increment not null,
  tipoFuncion varchar(255) not null,
  descripcion text not null,
  pelicula_id int not null,
  precio decimal(10,2),
  primary key PK_idFuncionEspecial(idFuncionEspecial),
  foreign key (pelicula_id) references Pelicula(idPelicula) on delete cascade
);
insert FuncionEspecial(tipoFuncion, descripcion, pelicula_id, precio)
	values("Funcion Navideña", "Obten un combo en la compra de una entrada para: El patito feo", 1, 40.50);

-- insert FuncionEspecial(tipoFuncion, descripcion, pelicula_id, precio)
	-- values("Funcion Navideña", "Obten un combo en la compra de una entrada para: Jason 3", 2, 40.50);

select * from FuncionEspecial;
-- La información que se va a poner para que el usuario sepa lo que compró
-- Estos datos los debe de llenar el usuario.
-- Diego
Create table Entrada(
  idEntrada int auto_increment not null,
  horarioP_id int not null,
  cine_id int not null,
  preventa_id int,
  cantidadEntradas int not null,
  pagoTotal decimal(10,2) not null,
  primary key PK_idEntrada(idEntrada),
  foreign key (horarioP_id) references HorarioP(idHorarioP) on delete cascade,
  foreign key (cine_id) references Cine(idCine) on delete cascade,
  foreign key (preventa_id) references Preventa(idPreventa) on delete cascade
);
insert Entrada(horarioP_id, cine_id, preventa_id, cantidadEntradas, pagoTotal) 
	values(1, 1, 1,2,30);
    
    select * from Entrada where horarioP_id = 4;
select * from Entrada;

select * from Entrada where horarioP_id = 1 AND cine_id = 1 AND preventa_id = 1;
-- Factura
-- La factura que se va a generar cuando reserven alguna película.
-- Quezada

Create table Factura(
  idFactura int auto_increment not null,
  fechaEmision date not null,
  usuario_id int not null,
  subTotal decimal(10,2) not null, -- Falta conectar con los precios de las entradas.
  primary key PK_idFactura(idFactura),
  foreign key (usuario_id) references Usuario(idUsuario) on delete cascade
  
);
insert Factura(fechaEmision, usuario_id, subTotal)
	values ("2023/12/15", 1,30);
select * from Factura;


-- Jimenez
-- Los agrega el usuario master, CRUD completo, este tendra un listar para los usuarios normales.
-- Así los usuarios pueden ver los estrenos de nuevas películas.
Create table Estreno(
  idEstreno int auto_increment not null,
  pelicula_id int not null,
  descripcionEstreno varchar(255),
  fechaEstreno date not null,
  primary key PK_idEstreno(idEstreno),
  foreign key (pelicula_id) references Pelicula(idPelicula) on delete cascade
);
insert Estreno(pelicula_id, descripcionEstreno, fechaEstreno)
	values(1, "Gran estreno: El patito feo", "2023/12/19");
    
-- insert Estreno(pelicula_id, descripcionEstreno, fechaEstreno)
	-- values(2, "Gran estreno: Jason", "2023/12/19");
    
select * from Estreno;

-- Herling
-- Los comentarios se hacen en un apartado donde se hace en general, no a cada película.
-- En cinépolis funciona de esa forma.
-- El usuario hace el comentario.
Create table Comentario(
  idComentario int auto_increment not null,
  usuario_id int not null,
  pelicula_id int not null,
  texto text not null,
  primary key PK_idComentario(idComentario),
  foreign key (usuario_id) references Usuario(idUsuario) on delete cascade,
  foreign key (pelicula_id) references Pelicula(idPelicula) on delete cascade
);
insert Comentario(usuario_id, pelicula_id, texto)
	values(1,1,"Obra maestra de la animacion");
select * from Comentario;