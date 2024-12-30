select * from vendedor;

insert into vendedor values(default, 'Amélia Cavalcante', '22/04/1997', 2200, 'B');
insert into vendedor values(default, 'Rafael Junior', '17/04/2003', 2800, 'C');
select * from vendedor;
commit;
insert into vendedor values(26, 'augustinho Carrara', '11/05/1973', 2800, 'C');--fica waiting
--quando o outro usuário der commit ele vai dar erro dizendo que a chave não pode ser acessada/ se o outro der rollback, dá certo