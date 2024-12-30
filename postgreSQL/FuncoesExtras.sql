--funcoes extras -> numeros
select abs(-15)"Valor Absoluto";
select ceil(15.7);
select floor(15.7);
select mod(10,4);
select power(3,2);
select round(15.193,1) "Round";
select round(42.4382,2);
select trunc(42.8);
select trunc(42.4382,2);

--funcoes extras -> caracteres
Select CONCAT(CONCAT(primeironome,' é'),cargo)
From empregado
Where matricula = 12;
Select primeironome || ' é '||cargo
From empregado
Where matricula = 12;

Select INITCAP('si');
Select LOWER('SI') "Minúsculas";
Select REPLACE('Juliana','Juli','Mari');
Select SUBSTR('Juliana',1,4);
Select UPPER('Informática');
Select LENGTH('Informatica');
Select LPAD('1234',10,'0'); --esse numero com 10 caraacteres, ele completa com zeros
Select RPAD('1234',10,'0');

--funcoes datas
Select TO_CHAR(Current_date,'MM-DD-YYYY') "Hoje";
Select age(timestamp '2024-03-18', timestamp'2004-06-05');
Select age(timestamp '1999-06-13');
Select current_time;
Select now();
select primeironome,
extract(year from dataadmissao) Ano from empregado;

--funcoes de conversao
Select to_char(current_date,'MONTH,DD,YYYY,HH24:MI:SS'); --data - varchar especificado
Select to_char(current_timestamp,'HH12:MI:SS');
Select to_char(10000,'L99G999D99') "Valor";--integer - varchar especificado
Select To_date('01052016','DD/MM/YY'); --char/varchar - date
SELECT to_number('1210.73', '9999.99');--char/varchar - numeric
Select to_timestamp('05 Dec 2017','DD Mon YYYY'); --string - timestamp

--funcoes genericas
Select coalesce(null,'Nao preenchido','Nada');--verifica todos os campos , se for nulo ele pula, se n achar ele manda a mensagem, 1° que nao e nulo

Select primeironome, salario, --coluna de acordo com condicoes
	case when salario < 1000 then 'Baixa'
		when salario > 1000 and salario < 2000
			then 'Média'
		when salario > 2000 then 'Boa'
	end faixa
From empregado;

Select descricao as "Descrição", valor as "Valor atual",
	case
		when valor < 10 then valor * 0.3
	when valor >=10 and valor < 13 then valor * .2
	else valor * .1
	end as "Percentual"
	from produto;
	
Select greatest(2,4,3,6) "Greatest"; --maior de uma lista
Select least(2,4,3,6) "Least"; --menor de uma lista