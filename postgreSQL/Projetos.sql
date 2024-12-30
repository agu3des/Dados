--3./4./5.
create table projeto(
	codproj serial not null,
	titulo varchar(30),
	area varchar(30), 
	constraint PKProjeto primary key(codproj)
);

create table engenheiro(
	codeng serial not null,
	nome varchar(30),
	salario numeric(15,2),
	constraint PKEngenheiro primary key(codeng)
);

create table atuacao(
	codeng serial not null,
	codproj serial not null,
	funcao varchar(30),
	constraint PKAtuacao primary key(codeng,codproj),
	constraint FKProjeto foreign key(codproj) references projeto(codproj),
	constraint FKEngenheiro foreign key(codeng) references engenheiro(codeng)
);
--6.
insert into engenheiro values(default, 'Luiz Inácio', 2400);
insert into engenheiro values(default, 'Maria da Luz', 3500);
insert into engenheiro values(default, 'Talia Souza', 5100);
insert into engenheiro values(default, 'Juliana Paes', 1600);
--7.
insert into projeto values(default, 'Inovação 2000', 'Informática');
insert into projeto values(default, 'Novas vidas', 'História');
insert into projeto values(default, 'A fauna 1970', 'Biologia');
--8.
insert into atuacao values(4,2,'Auxiliar');
insert into atuacao values(1,3,'Sub-Gerente');
insert into atuacao values(3,1,'Gerente');


select * from projeto;
select * from engenheiro;
select * from atuacao;
--9.
--a.
select nome from engenheiro where salario < 15000;
--b.
select nome 
from engenheiro e join atuacao atu 
on e.codeng = atu.codeng
where atu.funcao like 'Gerente'; 
--c.
select count(*) as qtdEng, pr.area as Area
	from engenheiro e 
	join atuacao atu 
		on e.codeng = atu.codeng
	join projeto pr
		on pr.codproj = atu.codproj
	group by pr.area;
--d.
select e.nome, e.salario
	from engenheiro e
	where e.salario > (select avg(en.salario)
					  from engenheiro en);
--10.
select nome
from engenheiro --retorne o nome do engenheiro se o engenheiro for da area de banco de dados
where codeng in 
	(select codeng --selecione o codigo do engenheiro se o codigo do projeto for da area de banco de dados
		from atuacao
		where codproj in 
			(select codproj --selecione o codigo do projeto onde a area seja banco de dados
				from projeto
				where area like 'Informática'))
--Por fim, o objetivo da consulta é retornar o nome do engenheiro que pertença a área de Informática.
select nome 
from engenheiro e 
join atuacao atu
on e.codeng = atu.codeng
join projeto pr 
on atu.codproj = pr.codproj
where pr.area like 'Informática';
--Reescrita usando join
--11.
select codeng --seleciona de acordo com o código
from engenheiro
where salario > 2200
INTERSECT -- apenas os que possuem as duas tabelas
select codeng --seleciona o código de acordo com a inserção
from atuacao;
--retorna o código do engenheiro que possui salário maior que 2200, pela ordem do maior salário para o menor.
select e.codeng
from engenheiro e
join atuacao atu
on e.codeng = atu.codeng
where e.salario > 2200
order by e.salario desc;
--utilizando join
select codeng 
from atuacao
where codeng in (select codeng
				from engenheiro
				where salario > 2200); --não consegui deixar em ordem decrescente
--utilizando subquery
--12.
create view engenheiros 
(nome, funcaoproj, tituloproj)
as select e.nome, pr.titulo, atu.funcao
from engenheiro e join atuacao atu
on e.codeng = atu.codeng
join projeto pr 
on atu.codproj = pr.codproj;
select * from engenheiros;
--13.
create role gerente login

	password 'bd2';
grant select on engenheiros to gerente;

select * from engenheiros;--permitido
insert into engenheiro values (default, 'Mariazinha de Jesus', 3300)--não permitido
--na conexão de gerente

--14.
--exists e subquery
select e.nome
from engenheiro e --recebe o codproj que n existe relaciona com o engenheiro
where not exists (select codproj 
			from atuacao atu --vai em atuação e acha onde o codeng é igaul e retorna o cod do projeto
			 where e.codeng = atu.codeng);			  
--join
select e.nome
from engenheiro e 
left join atuacao atu --pega tudo da tabela nome e junta com a atuação
	on e.codeng = atu.codeng --no código igual
	where atu.codproj is null; --pega apenas o que é nulo
--not in				  			  
select nome
from engenheiro --pegue o nome onde o codeng não esteja na atuação
where codeng not in (select codeng from atuacao);
--with
with nomeEng as (select nome
				from engenheiro 
				where codeng not in 
				 (select codeng from atuacao))
select * from nomeEng;

with EngenheirosComAtuacao as (
    select codeng
    from atuacao
),
EngenheirosSemAtuacao as (
    select nome
    from engenheiro
    where codeng not in (select codeng from EngenheirosComAtuacao)
)
select nome from EngenheirosSemAtuacao;