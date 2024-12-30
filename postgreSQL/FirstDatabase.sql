create database BD;

use BD;

create table cidade (
	codigo int not null primary key,
    nome varchar(30) not null
);

create table  socio (
	cpf char(11) not null primary key,
    nome varchar(30) not null,
    sexo char(1),
    email varchar(30) not null unique,
    cidade int not null,
    constraint FK_socio_cidade foreign key (cidade) references cidade (codigo),
    constraint UQ_socio unique (email),
    constraint CK_socio_sexo check (sexo in ('F', 'M'))
);

create table dependente (
	socio char(11) not null,
    numero int not null,
    nome varchar(30) not null,
	constraint PK_dependente primary key(socio,numero),
    constraint FK_socio_dependente foreign key (socio) references socio(cpf)
);

alter table socio 
	add datanasc datetime null,
	modify nome varchar(40) not null;
    
alter table cidade
	add uf char(2) not null, 
	add constraint CK_cidade_uf check (char_length(uf)=2);
    
alter table dependente
	add constraint CK_dependente_numero check (char_length(numero) > 0);

    
#alter table cidade
	#drop constraint CK_cidade_uf;
    
#alter table socio
	#drop constraint FK_socio_cidade,
    #drop column cidade;
    
#drop table cidade;

#drop database bd;
    


	