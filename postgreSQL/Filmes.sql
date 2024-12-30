create table Artista (
	CodArt serial not null,
	NomeArt varchar(100),
	Cidade varchar(20),
	País char(10),
	DataNasc date,
	constraint PKArtista primary key(CodArt)
);

create table Estudio (
	CodEst serial not null,
	NomeEst varchar(100),
	constraint PKEstudio primary key(CodEst)
);

create table Categoria (
	CodCat serial not null,
	DescCat varchar(15),
	constraint PKCategoria primary key(CodCat)
);

create table Filme (
	CodFil serial not null,
	Titulo varchar(30),
	Ano integer,
	Duracao integer,
	CategCod serial not null,
	EstudCod serial not null,
	constraint PKFilme primary key(CodFil),
	foreign key(CategCod) references Categoria(CodCat),
	foreign key(EstudCod) references Estudio(CodEst)
);

create table Personagem (
	FilmeCod serial not null,
	ArtCod serial not null,
	NomePer varchar(10),
	CacheMoney integer,
	constraint PKPer primary key(FilmeCod,ArtCod),
	foreign key (FilmeCod) references Filme(CodFil),
	foreign key (ArtCod) references Artista(CodArt)
);

insert into Artista values(default,'Cameron Diaz',null,'USA','15/07/75');
insert into Artista values(default,'Julia Roberts',null,'USA','20/08/67');
insert into Artista values(default,'Brad Pitt',null,null,'05/03/70');
insert into Artista values(default,'Joaquin Phoenix',null,null,'06/04/72');
insert into Artista values(default,'Bradley Cooper',null,'USA','06/06/77');
insert into Artista values(default,'Tom Cruise',null,'USA','10/09/64');
insert into Artista values(default,'Rodrigo Santoro','Rio de Janeiro','Brasil','12/10/78');


insert into Estudio values(default,'Paramount');
insert into Estudio values(default,'Disney');
insert into Estudio values(default,'Universal');

insert into Categoria values(default,'Aventura');
insert into Categoria values(default,'Romance');
insert into Categoria values(default,'Comédia');
insert into Categoria values(default,'Ação');
insert into Categoria values(default,'Suspense');
insert into Categoria values(default,'Drama');

insert into Filme values(default,'Encontro Explosivo',2010,134,4,1);
insert into Filme values(default,'O Besouro Verde',2010,155,1,1);
insert into Filme values(default,'Comer, Rezar, Amar',2010,177,2,1);
insert into Filme values(default,'Coringa',2019,122,6,1);
insert into Filme values(default,'Era uma vez em Hollywood',2020,119,4,2);
insert into Filme values(default,'Nasce uma estrela',2018,100,6,1);

insert into Personagem values(1,1,'Natalie',10000);
insert into Personagem values(1,2,'Tom',10000);
insert into Personagem values(5,3,'John',10000);
insert into Personagem values(3,2,'Ana',6000);
insert into Personagem values(6,5,'Tom',11000);
insert into Personagem values(4,4,'John',12000);

select * from Artista;
select * from Categoria;
select * from Estudio;
select * from Filme;
select * from Personagem;

--7. Insira o seguinte registro: 
insert into filme values(default,'Elvis',2022,120,null,3); 
--8. Verifique quais são os artistas cadastrados ordenados pelo nome.
select NomeArt
	from Artista
	Order by NomeArt;
--9. Selecione os artistas que têm o nome iniciando com a letra ‘B’. 	
select NomeArt
	from Artista
	Where NomeArt like 'B%';
--10. Verifique os filmes que foram lançados em 2019. 
select Titulo
	from Filme
	where Ano = 2019;
--11. Atualize o valor do cachê de todos os artistas em 15%. 
select * from Personagem; --valor anterior
update Personagem
	set CacheMoney = CacheMoney * 1.15;
select * from Personagem; --valor após a alteração
--12. Insira 2 artistas brasileiros. 
insert into Artista values(default,'Carla Dias',null,'Brasil','13/03/79');
insert into Artista values(default,'Munique Mendez',null,'Brasil','25/04/88');
insert into Artista values(default,'João Silva',null,'Brasil','07/08/70');
select * from Artista; --verificar a inserção
--13. Delete 1 artista recentemente incluído que não seja brasileiro.
delete from Artista 
	where NomeArt = 'Tom Cruise';
select * from Artista
--14. Verifique quais os títulos dos filmes que possuem duração maior que 120 min?
select Titulo
	from Filme
	where Duracao > 120;
--15. Na tabela ARTISTA, quais artistas possuem cidade nula? Após a consulta realizada, atualize as cidades nulas encontradas para três artistas.
select NomeArt
	from Artista
	where Cidade is null;
update Artista
	set Cidade = 'Natal'
	where NomeArt = 'João Silva';
update Artista
	set Cidade = 'João Pessoa'
	where NomeArt = 'Carla Dias';
update Artista
	set Cidade = 'Recife'
	where NomeArt = 'Munique Mendez';
select * from Artista;
--16. Qual a descrição da categoria do filme ‘Coringa’?
select DescCat 
	from Categoria join Filme
	on CategCod = CodCat
	where Titulo = 'Coringa';
--17. Mostre os títulos de filmes, com seus nomes de estúdios e nomes de suas categorias.
select Titulo, NomeEst, DescCat
	from Filme F join Estudio E 
	on E.CodEst = F.EstudCod
	join Categoria C 
	on C.CodCat = F.CategCod;
--18. Qual o nome dos artistas que fizeram o filme ‘Encontro Explosivo’?
select NomeArt 
	from Artista A join Personagem P
	on A.CodArt = P.ArtCod  
	join Filme F
	on F.CodFil = P.FilmeCod
	where Titulo = 'Encontro Explosivo';
--19. Selecione os artistas que têm o nome iniciando com a letra ‘B’ e participaram de filmes da categoria ‘Aventura’.
select NomeArt, DescCat
	from Artista A join Personagem P
	on A.CodArt = P.ArtCod
	join Filme F
	on P.FilmeCod = F.CodFil
	join Categoria C
	on C.CodCat = F.CategCod
	where NomeArt like 'B%' and DescCat = 'Aventura';
--20. Apresente quantos filmes existem por categoria. Para isso mostre a descrição da categoria e sua respectiva contagem. Use group by.
select DescCat, count(*)
	from Filme F
	join Categoria C
	on C.CodCat = F.CategCod
	group by DescCat;

--21. Explique o que o seguinte comando faz e mostra?
select a.nomeart, p.nomeper
	from artista a left outer join personagem p on a.codart = p.artcod;
--22. Explique o que a seguinte consulta faz e retorna: 
select codart
 	from artista
	Except
	  select artcod
	   from personagem;
--23. O que a seguinte consulta faz e retorna? Explique. 
Select f.titulo as Filme
	From filme f left join categoria c on f.categcod = c.codcat
	Where f.categcod is null; 



--1. Explique: o que a seguinte consulta faz e apresenta?
select f.titulo
from filme f
where f.estudcod in (select e.codest
from estudio e
where e.nomeest like 'P%');
--A consulta retorna o título do filme, esse que pertence a um estúdio cuja inicial do nome é P.

--2. Observe agora a seguinte consulta. O que ela faz? Em que ela difere da anterior?
select f.titulo
from filme f
where exists
(select e.codest
from estudio e
where f.estudcod = e.codest and nomeest like 'P%');
--A consulta retorna o mesmo da anterior, no entanto é utilizado a condição ‘exists’, que obriga a existência do fator, além de que existe uma comparação entre as chaves.

-- Use subqueries (subconsultas) para formular as consultas pedidas.
--3. Crie uma consulta que mostre as descrições de categorias que estão na tabela Filme (associadas a filmes).
select c.desccat
from categoria c
where c.codcat in(select f.categcod from filme f)

--4. Qual o nome do artista cujo nome de personagem é ‘Natalie’?
select a.nomeart
from artista a
where a.codart in (select p.artcod
from personagem p
where p.nomeper like 'Natalie');

--5. Existe algum artista cadastrado que não esteja na tabela Personagem?
select a.codart, a.nomeart
from artista a
where a.codart not in (select p.artcod
from personagem p);

--6. Crie uma consulta que apresente os nomes dos artistas que possuem cachê acima da média. Nesta, além de usar subconsulta, use JOIN entre artista e personagem.
select a.nomeart
from artista a join personagem p
on a.codart = p.artcod
where p.cachemoney = (select max(p.cachemoney) from personagem p);

--7. Para a tabela artista, crie uma view artistaV com os seguintes campos: codart, nomeart, datanasc. Renomeie “codart” para “código do artista” e “nomeart” para “nome” na view. Liste o conteúdo da view criada.
create view artistaV 
as select codart as "codigo do artista", nomeart as "nome", datanasc
from artista;
select * from artistav;

--8. Crie uma view filmeV com os seguintes campos: titulo,duração, ano, estúdio (nome do estúdio). Liste, em seguida, seu conteúdo .
create view filmeV 
as select f.titulo, f.duracao, f.ano, e.nomeest
from filme f join estudio e
on f.estudcod = e.codest;
select * from filmeV;

--9. Faça a inserção da artista “Mariana Ximenes” com a data de nascimento ‘27/11/78’ através da view artistaV. Como foi possível inserir por meio da view? Explique.
insert into artistaV values('Mariana Ximenes', '1978-11-27'); --sem a atribuição de um valor para o código não é possível
insert into artistaV values(default, 'Mariana Ximenes', '1978-11-27'); --com um valor para codart é 
select * from artistaV;
--Como a view utiliza os valores de base somente da tabela artista, a inserção pode ser feita, se e somente se, todos os campos estierem preeenchidos corretamente.

--10. Tente inserir um filme através da view filmeV. O que aconteceu? Explique.
--Não vai ser possível fazer a inserção, pois a view utiliza duas tabelas de base.
insert into filmeV values('É assim que acaba', 140, 2024, 'Disney');
--ERROR:  Visões que não selecionam de uma única tabela ou visão não são automaticamente atualizáveis.não é possível inserir na visão "filmev" 

--11. Faça a inserção através da tabela base filme. Depois consulte a view. O filme foi inserido? Consulte também a tabela base e explique.
insert into Filme values(default,'É assim que acaba',2024,140,4,1);
select * from filme;
select * from filmeV;
--A inserção ocorreu, pois foi feita na tabela de base. Esta que se relaciona diretamente com a segunda tabela de base, o que permite a inserção de novos valores. Alterando também a view que é dependente das tabelas de base.


-- Aula 9 - Índices

select * from artista order by codart; 
select * from artista order by nomeart; 
create index testenome on artista(nomeart);

-- testando índices e constraints

-- drop table c; 
-- drop table d; 
              --campos
Create table c (c1 INT, c2 INT);
select * from c; 
Create unique INDEX ci ON c (c1, c2);  -- usa um índice para relacionar dois campos
Alter table c ADD CONSTRAINT cpk PRIMARY KEY USING INDEX ci; --forçar o índice a ser usado
select * from c; 

-- segundo teste
--chave primária composta
CREATE TABLE d (d1 INT, d2 INT);
select * from d; 
ALTER TABLE d ADD CONSTRAINT dpk PRIMARY KEY (d1,d2);

-- Visão que mostra informações sobre índices no postgres

select * from pg_indexes; --consultar todos os índices

select * from pg_indexes 
where tablename in ('artista','filme');

SELECT * FROM pg_indexes WHERE tablename = 'personagem';
SELECT * FROM pg_indexes WHERE tablename = 'estudio';
SELECT * FROM pg_indexes WHERE tablename = 'categoria';

-- índice composto

CREATE TABLE testeIn (id integer, maior integer, menor integer, nome  varchar(10));

Insert into testeIn values (1,200,30,'X');
Insert into testeIn values(2, 300,23,'Y');
Insert into testeIn values(3, 200,30,'Z'); 

select * from testeIn; 

SELECT nome 
FROM testeIn
WHERE maior = 200 AND menor = 30;

CREATE INDEX idx_testeIn_maior_menor 
ON testeIn (maior, menor); --usa dois campos

SELECT * FROM pg_indexes WHERE tablename = 'testein';

-- usando a tabela Filme

SELECT * FROM pg_indexes WHERE tablename = 'filme';

select * from filme; 
explain select * from filme; 

explain analyze select * from filme where codcateg = 2;
 
explain select codfil
from filme 
where codfil = 5; 

explain analyze select codfil
from filme 
where codfil = 5; 

explain analyze select titulo
from filme 
where codfil = 5; 

-- consultando filmes

select *
from filme
where ano = 2022; 

explain analyze Select * 
From filme
Where ano = 2022; 

-- drop index anoin; 

CREATE INDEX anoIn ON filme(ano);

explain analyze Select * 
From filme
Where ano = 2022;

select * from artista; 

explain analyze 
select nomeart from artista where cidade = 'Los Angeles' and pais = 'USA';

-- drop index artistaIn; 

CREATE INDEX artistaIn ON artista(cidade,pais);

explain analyze 
select a.nomeart
from artista a join personagem p on a.codart = p.codart
     join filme f on p.codfilme = f.codfilme
where f.ano = 2022; 

select indexname
from pg_indexes
where tablename = 'artista'; 

-- Teste de índice
-- drop table testafilme; 

--Criando nova tabela
create table testaFilme as select * from filme;
select * from testafilme;

-- Populando a nova tabela
DO $$DECLARE i int:= 0;
BEGIN
    WHILE I <= 2000 LOOP
        INSERT INTO testafilme select * from filme;
        I := I + 1;
    END LOOP;
END$$;

Explain select titulo from testafilme order by titulo;
select titulo from testafilme order by titulo; 

--- criando índice
create index testaFilmeindex on testafilme(titulo);
---

explain select titulo from testafilme order by titulo; 
select titulo from testafilme order by titulo; 
select distinct titulo from testafilme order by titulo; 


create table top as select a.codart, nomeart, cachemoney
from artista a join personagem p on a.codart = p.artcod where 1 = 2;

DO $$
declare
	regart public.top%ROWTYPE;
Begin
	For regart IN (Select distinct a.codart, nomeart, cachemoney
			FROM artista a join personagem p
			on a.codart = p.artcod
			WHERE cachemoney > 7000) LOOP
		Insert into top values
			(regart.codart,regart.nomeart, regart.cachemoney);
	End loop;
End$$;

select * from top order by codart;

--8 - Blocos Anônimos PL/pgSQL

--1.  Veja a estrutura da tabela ARTISTA e seu conteúdo. Caso não exista o campo “indicacaooscar” (tipo integer), adicione-o à tabela. Em seguida, verifique o seguinte código.
--O que ele faz? Onde você viu o resultado?
alter table artista add indicacaooscar integer;

DO $$
BEGIN
  UPDATE artista
	SET indicacaooscar = 10
	WHERE codart = 30;
  IF NOT FOUND THEN
  	INSERT INTO artista (codart, nomeart, indicacaooscar)
  	VALUES (30, 'mary Deep', 8);
  END IF;
END$$;

select * from artista;
--Ele atualiza na tabela artista um valor para indicação do oscar se 
--o artista relacionado já existir, se não ele cria um artista com esses valores.
--o campo alterado aparece ao se fazer um select na tabela.


--2.   Faça um truncate table na tabela testa_bloco (Material 10-PL/pgSQL). Caso não tenha a tabela, crie-a. 
--Em seguida, faça uma rotina (bloco anônimo) semelhante à de inserção instestabloco (do mesmo material), 
--para inserir registros nesta tabela, sempre que o código gerado for múltiplo de 3 (** use a função mod(i,j) -> 
--retorna o resto da divisão de i por j. Ex: mod(i,3)). Verifique os registros inseridos. Como você verificou o resultado da execução?

truncate table testa_bloco;
create table testa_bloco (coluna1 integer primary key, coluna2 date);
select * from testa_bloco;
do $$
	declare 
		i int := 0;
	begin
		while i <= 10 loop
			if mod(i,3) = 0 then
				insert into testa_bloco (coluna1, coluna2)
					values (i, current_date);
			end if;
			i := i + 1;
     end loop;
end$$;

select * from testa_bloco; 
--Através de um select.

--3. Insira mais registros na tabela Filme (pelo menos 4). Implemente uma rotina para mostrar todos os 
--títulos de filmes que pertencem à categoria com descrição = ‘Aventura’. Use um CURSOR para isso. Use a cláusula FOR.
insert into Filme values(default,'Interestelar',2020,135,2,2);
insert into Filme values(default,'As Entregas da Kiki',2004,195,3,1);
insert into Filme values(default,'Meu Amigo Totoro',2008,200,3,1);
insert into Filme values(default,'Castelo Animado',2007,110,2,2);

select * from Filme;

do $$
declare
	vtitulo filme.titulo%type;
		vcursor_filme cursor for
				select distinct f.titulo 
				from filme f 
				join categoria ca 
					on f.categcod = ca.codcat
					where ca.desccat = 'Aventura';
begin
	for vfilme in vcursor_filme loop
		vtitulo := vfilme.titulo;
		raise notice 'Título do filme = %', vtitulo;
		end loop;
end$$;


--4. Repita o bloco anônimo anterior, mas, desta vez, verificando filmes de outra categoria como, por exemplo, ‘Ação’.

do $$
declare
	vtitulo filme.titulo%type;
		vcursor_filme cursor for
				select distinct f.titulo 
				from filme f 
				join categoria ca 
					on f.categcod = ca.codcat
					where ca.desccat = 'Ação';
begin
	for vfilme in vcursor_filme loop
		vtitulo := vfilme.titulo;
		raise notice 'Título do filme = %', vtitulo;
		end loop;
end$$;


--5.Verifique o seguinte bloco:
Do $$
Declare
 	V_cursorTB cursor for 
                select coluna1,coluna2 from testa_bloco;
Begin
  for x in v_cursorTB loop
     raise notice 'Coluna 2 = %', TO_CHAR(x.coluna2,'MM/DD/YYYY,HH:MI:SS');
  end loop;
End$$;

select * from testa_bloco;
--O que ele faz?
--Mostra um mensagem, na qual é selecionado cada elemento da coluna dois, pois ele faz uma iteração, com a formatação da data diferente.
--Explique porque um cursor foi utilizado.
--O funcionamento é o mesmo, no entanto definindo o cursor o código se torna mais legível.
--Para fazer a iteração de cada elemento, de modo a mostrar cada um separadamente e não em bloco.
--Agora, reescreva-o definindo o cursor diretamente no FOR (cursor implícito). 
Do $$
Declare
 	x public.testa_bloco%rowtype;
Begin
  for x in (select coluna1,coluna2 from testa_bloco) loop
     raise notice 'Coluna 2 = %', TO_CHAR(x.coluna2,'MM/DD/YYYY,HH:MI:SS');
  end loop;
End$$;

select * from testa_bloco;

-- Aula 12 - Funções e procedures armazenadas

select * from pg_language;

select * from artista;  
-- alter table artista add indicacaooscar integer; 
update artista
set indicacaooscar = 0
where codart in (1,2,4,5,7,8,3,6); 

Do $$
BEGIN
  UPDATE artista
    SET indicacaooscar = 10
    WHERE codart = 1;
  IF NOT FOUND THEN
    INSERT INTO artista (codart, nomeart, indicaoscar) 
    VALUES (100, 'XXX', 10);
  END IF;
END$$;

select * from artista;  

Create or replace function soma(integer, integer) returns integer as ' 
        Select $1+$2;
  ' language SQL; 

select soma(1,1);

-- Exemplo 1

CREATE OR REPLACE FUNCTION InsereCategoria (codigo INTEGER, nome VARCHAR(25)) 
  RETURNS void 
  AS $$ 
     BEGIN
         INSERT INTO categoria VALUES (codigo, nome); 
     END; 
     $$ LANGUAGE 'plpgsql';
	 
Select * from Categoria;
-- delete from categoria where codcateg > 7; 

Select InsereCategoria (8, 'Comédia sátira');
Select * from Categoria;

-- Exemplo 2

CREATE OR REPLACE function mostra_filmes (v_categoria IN categoria.desccat%type)
 returns void
 as $$
    declare 
       vfilme cursor (v_categoria categoria.desccat%type) for 
           select titulo, ano
           from filme f join categoria c on f.categcod = c.codcat
           where desccat = v_categoria;
 BEGIN
    FOR v_f IN vfilme(v_categoria) LOOP
       raise notice 'Título = %',v_f.titulo;
        raise notice 'Ano = %',v_f.ano; 
   END LOOP;
 END;
 $$ LANGUAGE 'plpgsql';

select titulo from filme; 
select * from categoria; 

Select mostra_filmes('Ação'); 

-- Exemplo 3

Create or replace function contafilme (
   cat IN categoria.desccat%type)
   RETURNS integer as $$
    declare totalfilme integer;
   Begin
     Select count(*) into totalfilme
     from filme f join categoria c on f.categcod = c.codcat
     Where desccat = cat;
     Return totalfilme;    
   End;
$$ LANGUAGE 'plpgsql';

Select contafilme('Ação'); 

-- Exemplo 4

Create or replace function DolarToReal
(dolar in numeric, cotacao numeric)
Returns numeric
As $$ 
  Begin
       Return dolar *cotacao;
  End;
  $$ LANGUAGE 'plpgsql';
  
 Do $$ declare v numeric;
     begin
         v:= DolarToReal(100, 4.71);
         raise notice 'Valor em Real: %',v;
    End$$;

Do $$ declare v numeric;
     begin
         v:= DolarToReal(100, 5.18);
         raise notice 'Valor em Real: %',v;
    End$$;

select * from artista;
select * from personagem; 

-- Exemplo 5
CREATE OR REPLACE PROCEDURE mostraNumFilmes(nome varchar(25))
LANGUAGE plpgsql
AS $$
DECLARE
contador integer := 0;
BEGIN
  Select count(*) INTO contador 
  From artista a join personagem p on a.codart = p.artcod
  Where a.nomeart = nome;
  RAISE NOTICE '% Fez % filmes', nome, contador;
END $$;

CALL mostraNumFilmes('Joaquin Phoenix');
Call mostraNumFilmes('Cameron Diaz');

-- Aula 13 - Funções e exceções

Create or replace function verificaArt(codigo integer)
Returns varchar
As $$ 
Declare nome varchar(25);
Begin
   select nomeart into nome from artista
       where codart = codigo;
    IF NOT FOUND THEN
        Return 'Nenhum artista com esse código foi encontrado.';
    END IF;
    return nome; 
End;
 $$ LANGUAGE 'plpgsql';
 
Select verificaart(1);           
select verificaart(111); 

create or replace function verificaart2(integer) 
returns varchar 
 As $$ 
  Declare r record;
  begin
    select into r * from artista where codart = $1;
    if not found then RAISE EXCEPTION 'Artista não existente--> %', $1
         USING HINT = 'Por favor, verifique o código do artista';
    end if;
    return r.nomeart;
  End; $$ LANGUAGE 'plpgsql';
  
select verificaart2(1); 
select verificaart2(111);

CREATE OR REPLACE FUNCTION testains(cod integer,nome varchar(25))
RETURNS integer AS $$
BEGIN
  Insert into estudio(codest,nomeest) values (cod,nome);
  Return 1;
  EXCEPTION 
    WHEN unique_violation THEN
      raise notice 'Já existe esse registro';
      return -1;
    WHEN OTHERS THEN
          -- fazer algo 
      RETURN -1;    
END;
$$ LANGUAGE plpgsql;

select * from estudio;
-- delete from estudio where codest > 3; 

select testains(4,'Teste'); 

select testains(41,'Teste'); 

-- Exemplo

-- drop table logcontagem; 
create table 
logcontagem 
(id serial, info varchar(40));

-- truncate table logcontagem; 

select * from logcontagem; 
select * from artista order by codart;

CREATE OR REPLACE FUNCTION testaContagem(limite integer, vpais artista.país%type) 
RETURNS void AS $$
Declare 
  contagem integer;
  info2 varchar(40);
BEGIN
   SELECT count(*) into contagem from artista where país = vpais;
   If contagem >= limite Then 
     RAISE exception 'Atingiu o limite';
  End If;
EXCEPTION
  WHEN raise_exception THEN
     info2 = 'Artistas de ' || vpais ||' possuem ' || contagem;
     INSERT INTO logcontagem (id, info) VALUES (default, info2);
END;
$$ LANGUAGE plpgsql; 

select testaContagem(2,'USA');
select testaContagem(4,'Brasil');
select * from logcontagem;  

--truncate table logcontagem; 

select * from artista where país = 'USA'; 
update artista set país = 'Brasil' where codart in (1,2,3,4); 

update artista set país = 'USA' where país is null; 
insert into artista values(default,'Rosamund Pike',null,'USA', '27/01/1979');

-- Exemplo

Create or replace function insereArttop(
   cod IN top.codart%type, 
   nome IN top.nomeart%type,
   cache1 IN top.cachemoney%type) 
RETURNS void
 AS $$
begin
  insert into top values (cod, nome,cache1);
end;
$$ LANGUAGE plpgsql; 

create or replace function insere_artista_top (vcod  artista.codart%type, vnome artista.nomeart%type,
   nota numeric)
  Returns varchar as $$
    Declare max_top integer;
       varttop integer;
 Begin
    max_top = 6;
    select count(*) into varttop from top;
      if varttop >= max_top then 
       raise exception 'top esgotada';
    elsif nota > 7 then 
          perform insereArttop(vcod,vnome,null);--não pode usar select aqui dentro ent usa o perform
          return 'Inclusão em Top com êxito!';
        else 
          return 'Inclusão impossível';
    end if;
   Exception
     When raise_exception THEN
       return 'Top Esgotada'; 
     when others then
       return 'Erro desconhecido';
End;
$$ LANGUAGE plpgsql; 

select * from top;
delete from top where cachemoney is null; 

select insere_artista_top (25,'Teste',9); 
Select insere_artista_top(21,'Teste',6); 