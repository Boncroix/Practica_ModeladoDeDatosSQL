create schema if not exists videoclub;

set schema 'videoclub';

create table if not exists codigos_postales(
	codigo_postal varchar(10) primary key
);

create table if not exists direcciones(
	dni_socio varchar(50) primary key,
	codigo_postal varchar(10) not null,
	calle varchar(200) not null,
	numero varchar(10),
	ext varchar(100)
);

create table if not exists socios(
	dni varchar(50) primary key,
	id_socio serial not null,
	nombre varchar(50) not null,
	apellido_1 varchar(50) not null,
	apellido_2 varchar(50) not null,
	fecha_nacimiento date not null,
	telefono varchar(50) not null,
	email varchar(100) not null
);

create table if not exists generos(
	genero varchar(100) primary key
);

create table if not exists directores(
	director varchar(100) primary key
);

create table if not exists copias(
	id_copia serial primary key,
	titulo varchar(100) not null
);

create table if not exists peliculas(
	titulo varchar(100) primary key,
	año_publicacion smallint not null,
	genero varchar(100) not null,
	director varchar(100) not null,
	sinopsis text not null
);

create table if not exists alquileres(
	id_alquiler serial primary key,
	dni_socio varchar(50) not null,
	id_copia integer not null,
	fecha_alquiler date not null,
	fecha_devolucion date
);

alter table direcciones 
add constraint fk_codigo_postal_direcciones
foreign key (codigo_postal)
references codigos_postales(codigo_postal);

alter table direcciones
add constraint fk_dni_socio_direcciones
foreign key (dni_socio)
references socios(dni);

alter table alquileres
add constraint fk_id_socio_alquileres
foreign key (dni_socio)
references socios(dni);

alter table alquileres
add constraint fk_id_copia_alquileres
foreign key (id_copia)
references copias(id_copia);

alter table copias
add constraint fk_id_pelicula_copias
foreign key (titulo)
references peliculas(titulo);

alter table peliculas
add constraint fk_genero_peliculas
foreign key (genero)
references generos(genero);

alter table peliculas
add constraint fk_director_peliculas
foreign key (director)
references directores(director);

alter table codigos_postales 
add constraint unique_codigo_postal
unique (codigo_postal);

alter table generos 
add constraint unique_genero
unique (genero);

alter table directores 
add constraint unique_director
unique (director);

insert into videoclub.codigos_postales (codigo_postal)
select distinct tp.codigo_postal
from videoclub.tmp_videoclub tp;

insert into videoclub.socios (nombre, apellido_1, apellido_2, fecha_nacimiento, telefono, dni, email)
select distinct tp.nombre, tp.apellido_1, tp.apellido_2, cast(tp.fecha_nacimiento as date), tp.telefono,tp.dni ,tp.email
from videoclub.tmp_videoclub tp;

insert into videoclub.direcciones (dni_socio, codigo_postal, calle, numero, ext)
select distinct tp.dni , cp.codigo_postal, tp.calle, tp.numero, tp.ext
from videoclub.tmp_videoclub tp
inner join videoclub.codigos_postales cp on tp.codigo_postal = cp.codigo_postal;

insert into videoclub.generos (genero)
select distinct tp.genero
from videoclub.tmp_videoclub tp;

insert into videoclub.directores (director)
select distinct tp.director
from videoclub.tmp_videoclub tp;

insert into videoclub.peliculas (titulo, año_publicacion,)










	
