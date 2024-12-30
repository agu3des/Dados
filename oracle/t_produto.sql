create table t_produto (
       product_id int,
       description varchar2(20),
       price number
);

select * from t_produto;

insert into t_produto values (524, 'bolo de cenoura', 12.50);
insert into t_produto values (873, 'queijo', 35);
insert into t_produto values (671, 'pão', 5);

alter table t_produto add quantity int

update t_produto set quantity = 3 where product_id = 524
update t_produto set quantity = 16 where product_id = 873
update t_produto set quantity = 40 where product_id = 671

insert into t_produto values (124, 'leite', 4.50, 50);
insert into t_produto values (235, 'manteiga', 8.00, 20);
insert into t_produto values (389, 'chocolate', 15.75, 15);
insert into t_produto values (451, 'suco de laranja', 6.00, 30);
insert into t_produto values (562, 'café', 10.50, 25);

select * from t_produto where quantity > 15

select * from t_produto where price <= 5

select description, (price * quantity) as total_price from t_produto

insert into t_produto values (123, 'jaca', 7, 0);

delete from t_produto where quantity = 0

select product_id, 
       description,
       price,
       price * 1.05 as price_plus_5
from t_produto


select description, 
       (price * quantity) as total_price_less_50 
from t_produto
where (price * quantity) <= 50 

select description, 
       (price * quantity) as total_price_more_50 
from t_produto
where (price * quantity) > 50
