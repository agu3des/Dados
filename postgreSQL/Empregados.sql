-- Criação das tabelas Departamento e Empregado

create table departamento (
   CodDepto                      serial not null, 
   Nome                          varchar(20),
   Local                         varchar(20));
alter table departamento add constraint pkdepto primary key(coddepto);

create table empregado (
       Matricula               serial not null,
       PrimeiroNome            varchar(15),
       Sobrenome   	           varchar(15),
       Dataadmissao            date,
       Cargo                   varchar(30),
       Salario                 numeric(13,2),
       Gerente		             integer,
       CodDepto                integer);
alter table empregado add constraint pkEmp primary key(matricula);

Alter table empregado add constraint fkgerente foreign key(gerente) references Empregado;
Alter table Empregado add constraint fkdepto foreign key(coddepto) references Departamento;


insert into departamento values (default,'Informática','Sede');
insert into departamento values (default,'Pessoal','Sede');


insert into Empregado values (default,'Jõao', 'Guedes',current_date,'Analista de Sistemas Junior',3400.00,null,1);
insert into Empregado values (default,'José', 'Batista',current_date,'Analista de Sistemas Pleno',4200.00,1,1);
insert into Empregado values (default,'Ana Maria', 'Silva',current_date,'Analista de Sistemas Junior',3400.00,1,1);
insert into Empregado values (default,'Ricardo', 'Neves',current_date,'Analista de Sistemas Pleno',4200.00,2,1);
insert into Empregado values (default,'Valter', 'Moura',current_date,'Analista de Suporte Junior',3400.00,2,1);
insert into Empregado values (default,'Mariana','Oliveira',current_date,'Designer de Interface',4800.00,1,null);

select * from empregado; 



-- Consultas ao banco Empregados
Select e.sobrenome as "Empregado", d.nome as "Departamento", e.dataadmissao as "Data de Admissão"
From empregado e join departamento d 
on e.coddepto = d.coddepto; --marina não aparece pois não tem departamento


Select e.primeironome as "Empregado", 	g.primeironome as "Gerente"
From (empregado e join empregado g --autorelacionamento
on e.gerente = g.matricula);

Select d.nome as Departamento, 	e.primeironome as
Empregado
From departamento d left outer join empregado e 
on d.coddepto = e.coddepto;  --mesmo que n seja elacionado com a tabela da direita eu pego

select d.nome as Departamento, e.primeironome 
as Empregado
from departamento d right outer join empregado e
on d.coddepto = e.coddepto  --mesmo que n seja elacionado com a tabela da esquerda eu pego
order by d.nome;

Select d.nome as Departamento, 	e.primeironome as Empregado
From departamento d full join empregado e --pega tudo dos dois lados
on d.coddepto = e.coddepto;

Select d.nome as Departamento, 	e.primeironome as Funcionario
From departamento d left join empregado e
on d.coddepto = e.coddepto --pega o departamento que não tem funcionário e ordena pelo nome
Where e.coddepto is null
Order by d.nome; 


--EXERCÍCIO 3
--1. Elabore ou execute consultas conforme se pede a seguir:
--1.1. Rode a consulta “Select * from empregado order by matricula” e verifique os dados de empregados;
Select * from empregado
order by matricula;
--1.2. Verifique os departamentos cadastrados.
Select * from departamento;
--1.3. Insira mais um departamento e associe um empregado a ele.
Insert into departamento values (default,'Materiais','Sede');
Insert into Empregado values (default,'Maria', 'Tavares',current_date,'Analista de Sistemas Júnior',3400.00,1,1);
Insert into Empregado values (default,'Juninho', 'da Silva',current_date,'Gerente de Materiais',3400.00,1,3);
Insert into Empregado values (default,'Marcela', 'de Oliveira',current_date,'Ajudante de Materiais',2300.00,1,3);
Insert into Empregado values (default,'Marcos', 'Brandão',current_date,'Coordenador Geral',4400.00,1,2);
--1.4. Formule uma consulta que apresente os nomes dos empregados que possuem cargo “Analista de Sistemas Pleno”.
Select primeironome, sobrenome from empregado where cargo = 'Analista de Sistemas Pleno';
--1.5. Execute a consulta “Select e.primeironome || ' ' || e.sobrenome as "Empregado", d.nome as "Departamento" From empregado e join departamento d on e.coddepto = d.coddepto;”. O que ela mostra?
Select e.primeironome ||''|| e.sobrenome as "Empregado", d.nome as "Departamento" 
from empregado e join departamento d on e.coddepto = d.coddepto;
--Mostra o nome e o sobrenome do empregado sem espaço entre eles, e junta as tabelas empregado e departamento, onde o código do departamento é igual em ambas as tabelas
--1.6. Mostre a quantidade de empregados por departamento.
Select count(e.primeironome) as "Quantidade de Empregados", d.nome as "Departamento" 
from empregado e join departamento d on e.coddepto = d.coddepto group by d.nome;
--1.7. Indique o somatório de salários de empregados agrupado por departamento.
Select sum(e.salario) as "Soma de salários", d.nome as "Departamento" 
from empregado e join departamento d on e.coddepto = d.coddepto group by d.nome;
--1.8. Execute a consulta “Select g.primeironome || ' ' || g.sobrenome as "Gerente", e.primeironome || ' ' || e.sobrenome as "Empregado" From (empregado e join empregado g on e.gerente = g.matricula) order by g.Gerente;”. O que ela mostra?
Select g.primeironome || ' ' || g.sobrenome as "Gerente", e.primeironome || ' ' || e.sobrenome as "Empregado" 
From (empregado e join empregado g on e.gerente = g.matricula) 
order by g.Gerente;
--Retorna todos os funcionários com seus respectivos gerentes, onde este gerente existe.
--1.9. Altere a consulta anterior aplicando um left Join. Em que muda o resultado?
Select g.primeironome || ' ' || g.sobrenome as "Gerente", e.primeironome || ' ' || e.sobrenome as "Empregado" 
From (empregado e left join empregado g on e.gerente = g.matricula) 
order by g.Gerente;
--Retorna todos os funcionários com seus respectivos gerentes, mesmo que este gerente não exista existe, pois ele pega todas as informações da tabela da esquerda.

--2. Nas questões seguintes, formule-as usando subconsultas/subqueries.
--2.1. Mostre os nomes dos empregados que possuem departamento associado.
Select e.primeironome ||' '|| e.sobrenome as "Empregado" from empregado e 
where exists (select d.nome as "Departamento" 
			  from departamento d 
			  where e.coddepto = d.coddepto);
--2.2. Quais os sobrenomes dos empregados cujo sobrenome de seus gerentes é ‘Guedes’?
Select e.sobrenome as "Empregado" 
from empregado e 
where exists (select d.sobrenome as "Gerente" 
			  from empregado d 
			  where e.gerente = d.matricula and d.sobrenome like '%Guedes' );
--2.3. Existe algum empregado que não tenha departamento? • Use o operador exists.
Select e.primeironome ||' '|| e.sobrenome as "Empregado" 
from empregado e 
where not exists (select *
			  from departamento d 
			  where e.codDepto = d.codDepto);

--3. Crie uma visão (view) que mostre os primeiros nomes dos empregados e os nomes de seus departamentos. Consulte a view criada e mostre seus dados.
create view Empregados
	(Nome, Departamento)
	as select primeironome,nome
		from empregado e join departamento d
		on e.codDepto = d.codDepto;

Select * from Empregados;
--3.1. Tente inserir um empregado através da view recém-criada. O que aconteceu? Explique. Faça a inserção através da tabela base empregado. Depois consulte a view. O empregado foi inserido? Consulte também a tabela base.
Insert into Empregados values (default,'Tabata', 'Rodrigues',current_date,'Assistente de Materiais',2400.00,1,3);
--Dá erro, pois visões que não selecionam de uma única tabela ou visão não são automaticamente atualizáveis.

--4. Monte uma view que permita inserção na tabela departamento. Teste e mostre inserções por meio da view.
--Para fazer a inserção é necessário que seja usada apenas a tabela departamento
create view Departamentos
	(codigo, nome)
	as select codDepto, nome
	from departamento;
select * from Departamentos;

--5. Crie uma view com check option que mostre os empregados cujo primeironome inicia com ‘M’. Mostre o primeironome, matrícula e data de admissão. Faça inserções com vários primeiros nomes por meio da view e verifique se elas ocorrem.
create view EmpregadosM 
	as select primeironome, matricula, dataadmissao
	from Empregado
	where primeironome like 'M%'
	with check option; --garantir que a option seja respeitada
insert into EmpregadosM values ('Melissa', default, '2023-05-13');
insert into EmpregadosM values ('Melaine', default, '2023-06-30');
insert into EmpregadosM values ('Marta', default, '2023-07-24');
select * from EmpregadosM;

--6. Verifique o seguinte comando:
select e.coddepto
from empregado e
where e.dataadmissao>'20-01-2023'
INTERSECT
select d.coddepto
from departamento d;

--6.1 O que o comando retorna? Reescreva a consultas usando uma subquery em vez do intersect. Depois, reescreva-a usando JOIN. Compare os resultados e explique-os.
-- Retorna o os códigos dos departamentos ordenados de forma decrescente (dos que tem menos funcionários para o que tem mais), pela data de admissão que seja maior que 20/01/2023.
select distinct d.coddepto as "Codigo" --join/distinct para que ele pegue os diferentes
from empregado e join departamento d 
	  on e.coddepto = d.coddepto
	  where e.dataadmissao>'20-01-2023';
	  
select distinct e.coddepto --subquery/and para unir os dois comandos e utilizar a subconsulta apenas para pegar codigo de departamento
from empregado e
where e.dataadmissao>'20-01-2023' and 
e.coddepto in (select d.coddepto
			   from departamento d);

--7. Analise e explique o seguinte comando:
WITH
Custo_depto as (
  Select d.nome, sum(e.salario) as total_depto
  From empregado e JOIN departamento d on e.coddepto = d.coddepto
  Group by d.nome),
  Custo_medio as (
	Select sum(total_depto)/Count(*) as media_dep
	From Custo_depto)
Select *
From Custo_depto
Where total_depto > (
        	Select media_dep
        	From Custo_medio)
Order by nome; 
--Mostra de forma ordenada pelo nome, a consulta da soma total de salário por departamento, estes que possuem uma soma superior a média salarial do departamento.