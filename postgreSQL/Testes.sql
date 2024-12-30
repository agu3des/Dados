-- Comandos iniciais com Banco Teste
-- drop table teste2; 

Create table teste2(
cod serial not null, 
valor char(2));

Insert into teste2(valor) values('xx');
Insert into teste2(cod,valor) values (default, 'yy');
Insert into teste2 values (default, 'zz');

Select * from teste2;