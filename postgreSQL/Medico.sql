create table especialidade(
	codesp int primary key,
	descricao varchar(30)
);
create table medico(
	cod int  primary key,
	salario numeric(15,2),
	especialidade int,
	constraint FKEsp foreign key(especialidade) references especialidade(codesp)
);

insert into especialidade values(1, 'pediatria');
insert into especialidade values(2, 'ortopedia');
insert into medico values(1, 2000, 1);
insert into medico values(2, 4000, 1);

insert into medico values(3, 2000, 2);
insert into medico values(4, 2000, 2);



select e.descricao, sum(m.salario)
from medico m
join especialidade e on e.codesp = m.especialidade
group by e.descricao