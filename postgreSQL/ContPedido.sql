/*** Criação do banco de dados ContPedido ***/
CREATE DATABASE ContPedido;
 
/*** Utilização do banco de dados ContPedido ***/
USE ContPedido;
 
/*** Criação da tabela Pais ***/ 
CREATE TABLE Pais 
(
  idpais char(3)	      NOT NULL,
  nome   varchar(15)      NOT NULL,
  CONSTRAINT PK_pais      PRIMARY KEY (idpais),
  CONSTRAINT AK_pais_nome UNIQUE (nome)
);

/*** Criação da tabela Cidade ***/ 
CREATE TABLE Cidade 
(
  idcidade int		        NOT NULL,
  nome     varchar(30)      NOT NULL,
  uf       char(2)  	    NULL,
  idpais   char(3)	        NOT NULL,
  CONSTRAINT PK_cidade      PRIMARY KEY (idcidade),
  CONSTRAINT AK_cidade_nome UNIQUE (nome),
  CONSTRAINT FK_cidade_pais FOREIGN KEY (idpais) REFERENCES Pais (idpais)
);

/*** Criação da tabela Cliente ***/ 
CREATE TABLE Cliente
(
  idcliente char(5)            NOT NULL,
  nome      varchar(40)        NOT NULL,
  tipo      char(1)            NOT NULL,
  contato   varchar(30)        NULL,
  cargo     varchar(30)        NULL,
  endereco  varchar(60)        NOT NULL,
  idcidade  int                NOT NULL,
  cep       varchar(10)        NULL,
  fone      varchar(16)        NULL,
  fax       varchar(16)        NULL,
  CONSTRAINT PK_cliente        PRIMARY KEY (idcliente),
  CONSTRAINT FK_cliente_cidade FOREIGN KEY (idcidade) REFERENCES Cidade (idcidade)
);

/*** Criação da tabela Setor ***/
CREATE TABLE Setor 
(
  idsetor    char(3)        NOT NULL,
  nome       varchar(30)    NOT NULL,
  ramal      int            NULL,
  idsuperior char(3)        NULL,
  CONSTRAINT PK_setor       PRIMARY KEY (idsetor), 
  CONSTRAINT AK_setor_nome  UNIQUE (nome),
  CONSTRAINT CK_setor_ramal CHECK (ramal > 0),
  CONSTRAINT FK_setor_setor FOREIGN KEY (idsuperior) REFERENCES Setor(idsetor)
);
-- Obs: a coluna idchefe e a FK de funcionário serão adicionadas no final após a criação e a inserção dos dados da tabela Funcionário.

/*** Criação da tabela Funcao ***/ 
CREATE TABLE Funcao 
(
  idfuncao int                  NOT NULL,
  nome     varchar(30)          NOT NULL,
  gratific decimal(8,2)         NOT NULL,
  CONSTRAINT PK_funcao          PRIMARY KEY (idfuncao), 
  CONSTRAINT AK_funcao_nome     UNIQUE (nome),
  CONSTRAINT AK_funcao_gratific CHECK (gratific > 0)
);

/*** Criação da tabela Tipo ***/ 
CREATE TABLE Tipo
(
  idtipo    int           NOT NULL,
  nome      varchar(15)   NOT NULL,
  descricao varchar(50)   NOT NULL,
  CONSTRAINT PK_tipo      PRIMARY KEY (idtipo),
  CONSTRAINT AK_tipo_nome UNIQUE (nome) 
);

/*** Criação da tabela Funcionario ***/ 
CREATE TABLE Funcionario 
(
  idfuncionario int                  NOT NULL,
  nome          varchar(40)          NOT NULL,
  sexo          char(1)              NOT NULL,
  estcivil      char(1)              NOT NULL,
  rg            varchar(15)          NOT NULL,
  cpf           char(12)             NOT NULL,
  trat          varchar(5)           NOT NULL,
  datanasc      date                 NOT NULL,
  idnatural     int                  NOT NULL,                  
  dataadm       date                 NOT NULL,
  endereco      varchar(40)          NOT NULL,
  complemento   varchar(20)          NULL,
  bairro        varchar(20)          NOT NULL,
  idreside      int                  NOT NULL,                  
  cep           varchar(10)          NULL,
  fone          varchar(10)          NULL,
  celular       varchar(10)          NULL,
  idfuncao      int                  NULL,                      
  idsetor       char(3)              NOT NULL,                    
  salario       decimal(10,2)        NOT NULL,
  email         varchar(40)          NULL,
  CONSTRAINT PK_funcionario          PRIMARY KEY (idfuncionario),
  CONSTRAINT AK_funcionario_rg       UNIQUE (rg),
  CONSTRAINT AK_funcionario_cpf      UNIQUE (cpf),
  CONSTRAINT FK_funcionario_cidade1  FOREIGN KEY (idnatural) REFERENCES Cidade(idcidade),
  CONSTRAINT FK_funcionario_cidade2  FOREIGN KEY (idreside) REFERENCES Cidade(idcidade),
  CONSTRAINT FK_funcionario_funcao   FOREIGN KEY (idfuncao) REFERENCES Funcao(idfuncao),
  CONSTRAINT FK_funcionario_setor    FOREIGN KEY (idsetor) REFERENCES Setor(idsetor)
);

/*** Criação da tabela Produto ***/ 
CREATE TABLE Produto 
(
  idproduto int              NOT NULL,
  nome      varchar(40)      NOT NULL,
  descricao varchar(45)      NULL,
  apresent  varchar(30)      NOT NULL,
  venda     decimal(8,2)     NOT NULL,
  custo     decimal(8,2)     NULL,
  quantest  int              NOT NULL,
  estmin    int              NULL,
  idtipo    int              NOT NULL,
  situacao  char(1)          NULL,
  CONSTRAINT PK_produto      PRIMARY KEY (idproduto),
  CONSTRAINT AK_produto_nome UNIQUE (nome),
  CONSTRAINT FK_produto_tipo FOREIGN KEY (idtipo) REFERENCES Tipo(idtipo) 
);

/*** Criação da tabela Pedido ***/ 
CREATE TABLE Pedido 
(
  idpedido   int                   NOT NULL,
  idcliente  char(5)               NOT NULL,
  idvendedor int                   NOT NULL,
  datapedid  date                  NOT NULL,
  datafatura date                  NULL,
  via        char(1)               NULL,
  frete      decimal(8,2)          NULL,
  CONSTRAINT PK_pedido             PRIMARY KEY (idpedido),
  CONSTRAINT FK_pedido_cliente     FOREIGN KEY (idcliente)  REFERENCES Cliente(idcliente),
  CONSTRAINT FK_pedido_funcionario FOREIGN KEY (idvendedor) REFERENCES Funcionario(idfuncionario)
);

/*** Criação da tabela Itens ***/
CREATE TABLE Itens 
(
  idpedido  int               NOT NULL,
  idproduto int               NOT NULL,
  preco     decimal(8,2)      NOT NULL,
  quant     int               NOT NULL,
  desconto  decimal(3,1)      NOT NULL,
  CONSTRAINT FK_itens_pedido  FOREIGN KEY (idpedido)  REFERENCES Pedido(idpedido),
  CONSTRAINT FK_itens_produto FOREIGN KEY (idproduto) REFERENCES Produto(idproduto),
  CONSTRAINT PK_itens         PRIMARY KEY (idpedido,idproduto) 
);

/*** Inserção de dados na tabela Pais ***/
INSERT INTO Pais VALUES ('ALE','Alemanha');
INSERT INTO Pais VALUES ('ARG','Argentina');
INSERT INTO Pais VALUES ('AUT','Austrália');
INSERT INTO Pais VALUES ('AUS','Áustria');
INSERT INTO Pais VALUES ('BEL','Bélgica');
INSERT INTO Pais VALUES ('BRA','Brasil');
INSERT INTO Pais VALUES ('CAN','Canadá');
INSERT INTO Pais VALUES ('CHL','Chile');
INSERT INTO Pais VALUES ('CHI','China');
INSERT INTO Pais VALUES ('DIN','Dinamarca');
INSERT INTO Pais VALUES ('ESC','Escócia');
INSERT INTO Pais VALUES ('ESP','Espanha');
INSERT INTO Pais VALUES ('EUA','Estados Unidos');
INSERT INTO Pais VALUES ('FIN','Finlândia');
INSERT INTO Pais VALUES ('FRA','França');
INSERT INTO Pais VALUES ('GRE','Grécia');
INSERT INTO Pais VALUES ('ING','Inglaterra');
INSERT INTO Pais VALUES ('IRL','Irlanda');
INSERT INTO Pais VALUES ('ITA','Itália');
INSERT INTO Pais VALUES ('MEX','México');
INSERT INTO Pais VALUES ('NOR','Noruega');
INSERT INTO Pais VALUES ('POL','Polônia');
INSERT INTO Pais VALUES ('POR','Portugal');
INSERT INTO Pais VALUES ('RUS','Rússia');
INSERT INTO Pais VALUES ('SUE','Suécia');
INSERT INTO Pais VALUES ('SUI','Suiça');
INSERT INTO Pais VALUES ('VEN','Venezuela');

/*** Inserção de dados na tabela Cidade ***/
INSERT INTO Cidade VALUES (1,'Recife','PE','BRA');
INSERT INTO Cidade VALUES (2,'Natal','RN','BRA');
INSERT INTO Cidade VALUES (3,'Rio de Janeiro','RJ','BRA');
INSERT INTO Cidade VALUES (4,'São Paulo','SP','BRA');
INSERT INTO Cidade VALUES (5,'Curitiba','PR','BRA');
INSERT INTO Cidade VALUES (6,'Florianópolis','SC','BRA');
INSERT INTO Cidade VALUES (7,'João Pessoa','PB','BRA');
INSERT INTO Cidade VALUES (8,'Campina Grande','PB','BRA');
INSERT INTO Cidade VALUES (9,'Campinas','SP','BRA');
INSERT INTO Cidade VALUES (10,'Brasília','DF','BRA');
INSERT INTO Cidade VALUES (11,'Salvador','BA','BRA');
INSERT INTO Cidade VALUES (12,'Petrópolis','RJ','BRA');
INSERT INTO Cidade VALUES (13,'Berlin',NULL,'ALE');
INSERT INTO Cidade VALUES (14,'México',NULL,'MEX');
INSERT INTO Cidade VALUES (15,'London',NULL,'ING');
INSERT INTO Cidade VALUES (16,'Lulea',NULL,'SUE');
INSERT INTO Cidade VALUES (17,'Mannhein',NULL,'ALE');
INSERT INTO Cidade VALUES (18,'Strasbourg',NULL,'FRA');
INSERT INTO Cidade VALUES (19,'Madrid',NULL,'ESP');
INSERT INTO Cidade VALUES (20,'Marseille',NULL,'FRA');
INSERT INTO Cidade VALUES (21,'Tsawassen','BC','CAN');
INSERT INTO Cidade VALUES (22,'Buenos Aires',NULL,'ARG');
INSERT INTO Cidade VALUES (23,'Bern',NULL,'SUI');
INSERT INTO Cidade VALUES (24,'Aachen',NULL,'ALE');
INSERT INTO Cidade VALUES (25,'Nantes',NULL,'FRA');
INSERT INTO Cidade VALUES (26,'Graz',NULL,'AUS');
INSERT INTO Cidade VALUES (27,'Lille',NULL,'FRA');
INSERT INTO Cidade VALUES (28,'Bräcke',NULL,'SUE');
INSERT INTO Cidade VALUES (29,'München',NULL,'ALE');
INSERT INTO Cidade VALUES (30,'Torino',NULL,'ITA');
INSERT INTO Cidade VALUES (31,'Cabedelo','PB','BRA');
INSERT INTO Cidade VALUES (32,'Lisboa',NULL,'POR');
INSERT INTO Cidade VALUES (33,'Barcelona',NULL,'ESP');
INSERT INTO Cidade VALUES (34,'Sevilla',NULL,'ESP');
INSERT INTO Cidade VALUES (35,'Eugene','OR','EUA');
INSERT INTO Cidade VALUES (36,'Caracas','DF','VEN');
INSERT INTO Cidade VALUES (37,'San Cristóbal','Tá','VEN');
INSERT INTO Cidade VALUES (38,'Elgin','OR','EUA');
INSERT INTO Cidade VALUES (39,'Cork','CO','ARG');
INSERT INTO Cidade VALUES (40,'HedgeEnd','La','ING');
INSERT INTO Cidade VALUES (41,'Brandenburg',NULL,'ALE');
INSERT INTO Cidade VALUES (42,'Versailles',NULL,'FRA');
INSERT INTO Cidade VALUES (43,'Toulouse',NULL,'FRA');
INSERT INTO Cidade VALUES (44,'Vancouver',NULL,'CAN');
INSERT INTO Cidade VALUES (45,'WallaWalla','WA','EUA');
INSERT INTO Cidade VALUES (46,'Frankfurt',NULL,'ALE');
INSERT INTO Cidade VALUES (47,'San Francisco','CA','EUA');
INSERT INTO Cidade VALUES (48,'Barquisimeto','La','VEN');
INSERT INTO Cidade VALUES (49,'Margarita','Nu','VEN');
INSERT INTO Cidade VALUES (50,'Portland','OR','EUA');
INSERT INTO Cidade VALUES (51,'Bergamo',NULL,'ITA');
INSERT INTO Cidade VALUES (52,'Bruxelles',NULL,'BEL');
INSERT INTO Cidade VALUES (53,'Montreal','Qu','CAN');
INSERT INTO Cidade VALUES (54,'Leipzig',NULL,'ALE');
INSERT INTO Cidade VALUES (55,'Anchorage','AK','EUA');
INSERT INTO Cidade VALUES (56,'Köln',NULL,'ALE');
INSERT INTO Cidade VALUES (57,'Paris',NULL,'FRA');
INSERT INTO Cidade VALUES (58,'Salzburg',NULL,'AUS');
INSERT INTO Cidade VALUES (59,'Cunewalde',NULL,'ALE');
INSERT INTO Cidade VALUES (60,'Albuquerque','NM','EUA');
INSERT INTO Cidade VALUES (61,'Reggio Emilia',NULL,'ITA');
INSERT INTO Cidade VALUES (62,'Geneve',NULL,'SUI');
INSERT INTO Cidade VALUES (63,'Stavern',NULL,'NOR');
INSERT INTO Cidade VALUES (64,'Boise','ID','EUA');
INSERT INTO Cidade VALUES (65,'Kobenhavn',NULL,'DIN');
INSERT INTO Cidade VALUES (66,'Lander','WY','EUA');
INSERT INTO Cidade VALUES (67,'Charleroi',NULL,'BEL');
INSERT INTO Cidade VALUES (68,'Butte','MT','EUA');
INSERT INTO Cidade VALUES (69,'Münster',NULL,'ALE');
INSERT INTO Cidade VALUES (70,'Kirkland','WA','EUA');
INSERT INTO Cidade VALUES (71,'Arhus',NULL,'DIN');
INSERT INTO Cidade VALUES (72,'Lyon',NULL,'FRA');
INSERT INTO Cidade VALUES (73,'Reims',NULL,'FRA');
INSERT INTO Cidade VALUES (74,'Stuttgart',NULL,'ALE');
INSERT INTO Cidade VALUES (75,'Oulu',NULL,'FIN');
INSERT INTO Cidade VALUES (76,'Resende','SP','BRA');
INSERT INTO Cidade VALUES (77,'Helsinki',NULL,'FIN');
INSERT INTO Cidade VALUES (78,'Warszawa',NULL,'POL');
INSERT INTO Cidade VALUES (79,'Seattle','WA','EUA');
INSERT INTO Cidade VALUES (80,'Tacoma','WA','EUA');
INSERT INTO Cidade VALUES (81,'Redmond','WA','EUA');
INSERT INTO Cidade VALUES (82,'Carpina','PE','BRA');
INSERT INTO Cidade VALUES (83,'Mamanguape','PB','BRA');
INSERT INTO Cidade VALUES (84,'Santa Rita','PB','BRA');
INSERT INTO Cidade VALUES (85,'Mossoró','RN','BRA');
INSERT INTO Cidade VALUES (86,'Patos','PB','BRA');
INSERT INTO Cidade VALUES (87,'Guarabira','PB','BRA');
INSERT INTO Cidade VALUES (88,'Cabo','PE','BRA');
INSERT INTO Cidade VALUES (89,'Cowes','IW','ING');
INSERT INTO Cidade VALUES (90,'Parla','GE','GRE');

/*** Inserção de dados na tabela Cliente ***/
INSERT INTO Cliente VALUES ('ALFKI','Alfreds Futterkiste','J','Maria Anders','Representante de Vendas','Obere Str. 57','13','12209','030-0074321','030-0076545');
INSERT INTO Cliente VALUES ('ANATR','Ana Trujillo Sandoza','F','Ana Trujillo','Proprietário','Avda. de la Constitución 2222','14','05021','(5) 555-4729','(5) 555-3745');
INSERT INTO Cliente VALUES ('ANTON','Antonio Moreno Taquería','F','Antonio Moreno','Proprietário','Mataderos 2312','14','05023','(5) 555-3932',NULL);
INSERT INTO Cliente VALUES ('AROUT','Around the Horn','J','Thomas Hardy','Representante de Vendas','120 Hanover Sq.','15','WA1 1DP','(171) 555-7788','(171) 555-6750');
INSERT INTO Cliente VALUES ('ARTRA','Armandus Tratoria','J','Armando Nicopoulus Papulus','Proprietário','Trajanette Fubbica, 745','90','9887699','(43)789-5432','(43)897-9233');
INSERT INTO Cliente VALUES ('BERGS','Berglunds snabbköp','J','Christina Berglund','Administrador de Pedidos','Berguvsvägen 8','16','S-958 22','0921-12 34 65','0921-12 34 67');
INSERT INTO Cliente VALUES ('BLAUS','Blauer See Delikatessen','J','Hanna Moos','Representante de Vendas','Forsterstr. 57','17','68306','0621-08460','0621-08924');
INSERT INTO Cliente VALUES ('BLONP','Blondel père et fils','J','Frédérique Citeaux','Gerente de Marketing','24, place Kléber','18','67000','88.60.15.31','88.60.15.32');
INSERT INTO Cliente VALUES ('BOTTM','Bottom-Dollar Markets','J','Elizabeth Lincoln','Gerente Financeiro','23 Tsawassen Blvd.','21','T2F 8M4','(604) 555-4729','(604) 555-3745');
INSERT INTO Cliente VALUES ('BSBEV','Bs Beverages','J','Victoria Ashworth','Representante de Vendas','Fauntleroy Circus','15','EC2 5NT','(171) 555-1212',NULL);
INSERT INTO Cliente VALUES ('CACTU','Cactus Comidas para llevar','J','Patricio Simpson','Agente de Vendas','Cerrito 333','22','1010','(1) 135-5555','(1) 135-4892');
INSERT INTO Cliente VALUES ('CENTC','Centro comercial Moctezuma','J','Francisco Chang','Gerente de Marketing','Sierras de Granada 9993','14','05022','(5) 555-3392','(5) 555-7293');
INSERT INTO Cliente VALUES ('CHOPS','Chop-suey Chinese','J','Yang Wang','Proprietário','Hauptstr. 29','23','3012','0452-076545',NULL);
INSERT INTO Cliente VALUES ('COMMI','Comércio Mineiro','J','Pedro Afonso','Assessor de Vendas','Av. dos Lusíadas, 23','4','05432-043','(11) 555-7647',NULL);
INSERT INTO Cliente VALUES ('CONSH','Consolidated Holdings','J','Elizabeth Brown','Representante de Vendas','Berkeley Gardens, 12 Brewery','15','WX1 6LT','(171) 555-2282','(171) 555-9199');
INSERT INTO Cliente VALUES ('DIEWA','Die Wandernde Kuh','J','Rita Müller','Representante de Vendas','Adenauerallee 900','74','70563','0711-020361','0711-035428');
INSERT INTO Cliente VALUES ('DRACD','Drachenblut Delikatessen','J','Sven Ottlieb','Administrador de Pedidos','Walserweg 21','24','52066','0241-039123','0241-059428');
INSERT INTO Cliente VALUES ('EASTC','Eastern Connection','J','Ann Devon','Agente de Vendas','35 King George','15','WX3 6FW','(171) 555-0297','(171) 555-3373');
INSERT INTO Cliente VALUES ('ERNSH','Ernst Handel','J','Roland Mendel','Gerente de Vendas','Kirchgasse 6','26','8010','7675-3425','7675-3426');
INSERT INTO Cliente VALUES ('FAMIA','Familia Arquibaldo','J','Aria Cruz','Assistente de Marketing','Rua Orós, 92','4','05442-030','(11) 555-9857',NULL);
INSERT INTO Cliente VALUES ('FELIP','Felipe Izquierdo','F','Felipe Izquierdo','Proprietário','Ave. 5 de Mayo Porlamar','49','4980','(8) 34-56-12','(8) 34-93-93');
INSERT INTO Cliente VALUES ('FOLIG','Folies gourmandes','J','Martine Rancé','Assistente do Agente de Vendas','184, chaussée de Tournai','27','59000','20.16.10.16','20.16.10.17');
INSERT INTO Cliente VALUES ('FRANK','Frankenversand','J','Peter Franken','Gerente de Marketing','Berliner Platz 43','29','80805','089-0877310','089-0877451');
INSERT INTO Cliente VALUES ('FRANR','France restauration','J','Carine Schmitt','Gerente de Marketing','54, rue Royale','25','44000','40.32.21.21','40.32.21.20');
INSERT INTO Cliente VALUES ('FRANS','Franchi S.p.A.','J','Paolo Accorti','Representante de Vendas','Via Monte Bianco 34','30','10100','011-4988260','011-4988261');
INSERT INTO Cliente VALUES ('FURIB','Furia Bacalhau e Frutos do Mar','J','Lino Rodriguez','Gerente de Vendas','Jardim das rosas n. 32','32','1675','(1) 354-2534','(1) 354-2535');
INSERT INTO Cliente VALUES ('GALED','Galería del gastrónomo','J','Eduardo Saavedra','Gerente de Marketing','Rambla de Cataluña, 23','33','08022','(93) 203 4560','(93) 203 4561');
INSERT INTO Cliente VALUES ('GODOS','Godos Cocina Típica','J','José Pedro Freyre','Gerente de Vendas','C/ Romero, 33','34','41101','(95) 555 82 82',NULL);
INSERT INTO Cliente VALUES ('GOURL','Gourmet Lanchonetes','J','André Fonseca','Assessor de Vendas','Av. Brasil, 442','9','04876-786','(11) 555-9482',NULL);
INSERT INTO Cliente VALUES ('GREAL','Great Lakes Food Market','J','Howard Snyder','Gerente de Marketing','2732 Baker Blvd.','35','97403','(503) 555-7555',NULL);
INSERT INTO Cliente VALUES ('GROSR','Grosella Restaurante','J','Manuel Pereira','Proprietário','5ª Ave. Los Palos Grandes','36','1081','(2) 283-2951','(2) 283-3397');
INSERT INTO Cliente VALUES ('HANAR','Hanari Carnes','J','Mario Pontes','Gerente Financeiro','Rua do Paço, 67','3','05454-876','(21) 555-0091','(21) 555-8765');
INSERT INTO Cliente VALUES ('HENRP','Henriette Pfalzheim','F','Henriette Pfalzheim','Proprietário','Mehrheimerstr. 369','56','50739','0221-0644327','0221-0765721');
INSERT INTO Cliente VALUES ('HILAA','HILARIÓN-Abastos','J','Carlos Hernández','Representante de Vendas','Carrera 22 con Ave. Carlos Soublette #8-35','37','5022','(5) 555-1340','(5) 555-1948');
INSERT INTO Cliente VALUES ('HUNGC','Hungry Coyote Import Store','J','Yoshi Latimer','Representante de Vendas','City Center Plaza, 516 Main St.','38','97827','(503) 555-6874','(503) 555-2376');
INSERT INTO Cliente VALUES ('HUNGO','Hungry Owl All-Night Grocers','J','Patricia McKenna','Assessor de Vendas','8 Johnstown Road','39','12359 LP','2967 542','2967 3333');
INSERT INTO Cliente VALUES ('ISLAT','Island Trading','J','Helen Bennett','Gerente de Marketing','Garden House Crowther Way','89','PO31 7PJ','(198) 555-8888',NULL);
INSERT INTO Cliente VALUES ('JAIYO','Jaime Yorres','F','Jaime Yorres','Proprietário','87 Polk St. Suite 5','47','94117','(415) 555-5938',NULL);
INSERT INTO Cliente VALUES ('JANLA','Janine Labrune','F','Janine Labrune','Proprietário','67, rue des Cinquante Otages','25','44000','40.67.88.88','40.67.89.89');
INSERT INTO Cliente VALUES ('JYTPE','Jytte Petersen','F','Jytte Petersen','Proprietário','Vinbæltet 34','65','1734','31 12 34 56','31 13 35 57');
INSERT INTO Cliente VALUES ('KOENE','Koniglish Essen','J','Philip Cramer','Assessor de Vendas','Maubelstr. 90','41','14776','0555-09876',NULL);
INSERT INTO Cliente VALUES ('LACOR','La corne dabondance','J','Daniel Tonini','Representante de Vendas','67, avenue del Europe','42','78000','30.59.84.10','30.59.85.11');
INSERT INTO Cliente VALUES ('LAMAI','La maison dAsie','J','Annette Roulet','Gerente de Vendas','1 rue Alsace-Lorraine','43','31000','61.77.61.10','61.77.61.11');
INSERT INTO Cliente VALUES ('LAUGB','Laughing Bacchus Wine Cellars','J','Yoshi Tannamuri','Assistente de Marketing','1900 Oak St.','44','V3F 2K1','(604) 555-3392','(604) 555-7293');
INSERT INTO Cliente VALUES ('LAULE','Laurence Lebihan','F','Laurence Lebihan','Proprietário','12, rue des Bouchers','20','13008','91.24.45.40','91.24.45.41');
INSERT INTO Cliente VALUES ('LAZYK','Lazy K Kountry Store','J','John Steel','Gerente de Marketing','12 Orchestra Terrace','45','99362','(509) 555-7969','(509) 555-6221');
INSERT INTO Cliente VALUES ('LEHMS','Lehmanns Marktstand','J','Renate Messner','Representante de Vendas','Magazinweg 7','46','60528','069-0245984','069-0245874');
INSERT INTO Cliente VALUES ('LILAS','LILA-Supermercado','J','Carlos González','Gerente Financeiro','Carrera 52 con Ave. Bolívar #65-98 Llano Largo','48','3508','(9) 331-6954','(9) 331-7256');
INSERT INTO Cliente VALUES ('LONEP','Lonesome Pine Restaurant','J','Fran Wilson','Gerente de Vendas','89 Chiaroscuro Rd.','50','97219','(503) 555-9573','(503) 555-9646');
INSERT INTO Cliente VALUES ('MAGAA','Magazzini Alimentari Riuniti','J','Giovanni Rovelli','Gerente de Marketing','Via Ludovico il Moro 22','51','24100','035-640230','035-640231');
INSERT INTO Cliente VALUES ('MAISD','Maison Dewey','J','Catherine Dewey','Agente de Vendas','Rue Joseph-Bens 532','52','B-1180','(02) 201 24 67','(02) 201 24 68');
INSERT INTO Cliente VALUES ('MARLA','Maria Larsson','F','Maria Larsson','Proprietário','Åkergatan 24','28','S-844 67','0695-34 67 21',NULL);
INSERT INTO Cliente VALUES ('MARSO','Martín Sommer','F','Martín Sommer','Proprietário','C/ Araquil, 67','19','28023','(91) 555 22 82','(91) 555 91 99');
INSERT INTO Cliente VALUES ('MEREP','Mère Paillarde','J','Jean Fresnière','Assistente de Marketing','43 rue St. Laurent','53','H1J 1C3','(514) 555-8054','(514) 555-8055');
INSERT INTO Cliente VALUES ('MIGAN','Miguel Angel Paolino','F','Miguel Angel Paolino','Proprietário','Avda. Azteca 123','14','05033','(5) 555-2933',NULL);
INSERT INTO Cliente VALUES ('MORGK','Morgenstern Gesundkost','J','Alexander Feuer','Assistente de Marketing','Heerstr. 22','54','04179','0342-023176',NULL);
INSERT INTO Cliente VALUES ('NORTS','North/South','J','Simon Crowther','Assessor de Vendas','South House, 300 Queensbridge','15','SW7 1RZ','(171) 555-7733','(171) 555-2530');
INSERT INTO Cliente VALUES ('OCEAN','Océano Atlántico Ltda.','J','Yvonne Moncada','Agente de Vendas','Ing. Gustavo Moncada 8585, Piso 20-A','22','1010','(1) 135-5333','(1) 135-5535');
INSERT INTO Cliente VALUES ('OLDWO','Old World Delicatessen','J','Rene Phillips','Representante de Vendas','2743 Bering St.','55','99508','(907) 555-7584','(907) 555-2880');
INSERT INTO Cliente VALUES ('PERIC','Pericles Comidas clásicas','J','Guillermo Fernández','Representante de Vendas','Calle Dr. Jorge Cash 321','14','05033','(5) 552-3745','(5) 545-3745');
INSERT INTO Cliente VALUES ('PICCO','Piccolo und mehr','J','Georg Pipps','Gerente de Vendas','Geislweg 14','58','5020','6562-9722','6562-9723');
INSERT INTO Cliente VALUES ('PRINI','Princesa Isabel Vinhos','J','Isabel de Castro','Representante de Vendas','Estrada da saúde n. 58','32','1756','(1) 356-5634',NULL);
INSERT INTO Cliente VALUES ('QUEDE','Que Delícia','J','Bernardo Batista','Gerente Financeiro','Rua da Panificadora, 12','3','02389-673','(21) 555-4252','(21) 555-4545');
INSERT INTO Cliente VALUES ('QUEEN','Queen Cozinha','J','Lúcia Carvalho','Assistente de Marketing','Alameda dos Canàrios, 891','4','05487-020','(11) 555-1189',NULL);
INSERT INTO Cliente VALUES ('QUICK','QUICK-Stop','J','Horst Kloss','Gerente Financeiro','Taucherstraße 10','59','01307','0372-035188',NULL);
INSERT INTO Cliente VALUES ('RANCH','Rancho grande','J','Sergio Gutiérrez','Representante de Vendas','Av. del Libertador 900','22','1010','(1) 123-5555','(1) 123-5556');
INSERT INTO Cliente VALUES ('RATTC','Rattlesnake Canyon Grocery','J','Paula Wilson','Assistente do Repr. de Vendas','2817 Milton Dr.','60','87110','(505) 555-5939','(505) 555-3620');
INSERT INTO Cliente VALUES ('REGGC','Reggiani Caseifici','J','Maurizio Moroni','Assessor de Vendas','Strada Provinciale 124','61','42100','0522-556721','0522-556722');
INSERT INTO Cliente VALUES ('RICAR','Ricardo Adocicados','J','Janete Limeira','Assistente do Agente de Vendas','Av. Copacabana, 267','3','02389-890','(21) 555-3412',NULL);
INSERT INTO Cliente VALUES ('RICSU','Richter Supermarkt','J','Michael Holz','Gerente de Vendas','Grenzacherweg 237','62','1203','0897-034214',NULL);
INSERT INTO Cliente VALUES ('ROMEY','Romero y tomillo','J','Alejandra Camino','Gerente Financeiro','Gran Vía, 1','19','28001','(91) 745 6200','(91) 745 6210');
INSERT INTO Cliente VALUES ('SANTG','Santé Gourmet','J','Jonas Bergulfsen','Proprietário','Erling Skakkes gate 78','63','4110','07-98 92 35','07-98 92 47');
INSERT INTO Cliente VALUES ('SAVEA','Save-a-lot Markets','J','Jose Pavarotti','Representante de Vendas','187 Suffolk Ln.','64','83720','(208) 555-8097',NULL);
INSERT INTO Cliente VALUES ('SEVES','Seven Seas Imrts','J','Hari Kumar','Gerente de Vendas','90 Wadhurst Rd.','15','OX15 4NB','(171) 555-1717','(171) 555-5646');
INSERT INTO Cliente VALUES ('SPECD','Spécialités du monde','J','Dominique Perrier','Gerente de Marketing','25, rue Lauriston','57','75016','(1) 47.55.60.10','(1) 47.55.60.20');
INSERT INTO Cliente VALUES ('SPLIR','Split Rail Beer & Ale','J','Art Braunschweiger','Gerente de Vendas','P.O. Box 555','66','82520','(307) 555-4680','(307) 555-6525');
INSERT INTO Cliente VALUES ('SUPRD','Suprêmes délices','J','Pascale Cartrain','Gerente Financeiro','Boulevard Tirou, 255','67','B-6000','(071) 23 67 22 2','(071) 23 67 22 2');
INSERT INTO Cliente VALUES ('THEBI','The Big Cheese','J','Liz Nixon','Gerente de Marketing','89 Jefferson Way, Suite 2','50','97201','(503) 555-3612',NULL);
INSERT INTO Cliente VALUES ('THECR','The Cracker Box','J','Liu Wong','Assistente de Marketing','55 Grizzly Peak Rd.','68','59801','(406) 555-5834','(406) 555-8083');
INSERT INTO Cliente VALUES ('TOMSP','Toms Spezialitäten','J','Karin Josephs','Gerente de Marketing','Luisenstr. 48','69','44087','0251-031259','0251-035695');
INSERT INTO Cliente VALUES ('TRADH','Tradição Hipermercados','J','Anabela Domingues','Representante de Vendas','Av. Inês de Castro, 414','4','05634-030','(11) 555-2167','(11) 555-2168');
INSERT INTO Cliente VALUES ('TRAIH','Trails Head Gourmet Provisioners','J','Helvetius Nagy','Assessor de Vendas','722 DaVinci Blvd.','70','98034','(206) 555-8257','(206) 555-2174');
INSERT INTO Cliente VALUES ('VAFFE','Vaffeljernet','J','Palle Ibsen','Gerente de Vendas','Smagsløget 45','71','8200','86 21 32 43','86 22 33 44');
INSERT INTO Cliente VALUES ('VICTE','Victuailles en stock','J','Mary Saveley','Agente de Vendas','2, rue du Commerce','72','69004','78.32.54.86','78.32.54.87');
INSERT INTO Cliente VALUES ('VINET','Vins et alcools Chevalier','J','Paul Henriot','Gerente Financeiro','59 rue de lAbbaye','73','51100','26.47.15.10','26.47.15.11');
INSERT INTO Cliente VALUES ('WARTH','Wartian Herkku','J','Pirkko Koskitalo','Gerente Financeiro','Torikatu 38','75','90110','981-443655','981-443655');
INSERT INTO Cliente VALUES ('WELLI','Wellington Importadora','J','Paula Parente','Gerente de Vendas','Rua do Mercado, 12','76','08737-363','(14) 555-8122',NULL);
INSERT INTO Cliente VALUES ('WHITC','White Clover Markets','J','Karl Jablonski','Proprietário','305 - 14th Ave. S. Suite 3B','79','98128','(206) 555-4112','(206) 555-4115');
INSERT INTO Cliente VALUES ('WILMK','Wilman Kala','J','Matti Karttunen','Proprietário/Assist. Marketing','Keskuskatu 45','77','21240','90-224 8858','90-224 8858');
INSERT INTO Cliente VALUES ('ZBYSZ','Zbyszek Piestrzeniewicz','F','Zbyszek Piestrzeniewicz','Proprietário','ul. Filtrowa 68','78','01-012','(26) 642-7012','(26) 642-7012');

/*** Inserção de dados na tabela Setor ***/
INSERT INTO Setor VALUES ('PRS','Presidência',100,NULL);
INSERT INTO Setor VALUES ('COV','Compras e Vendas',102,'PRS');
INSERT INTO Setor VALUES ('FIN','Finanças',109,'PRS');
INSERT INTO Setor VALUES ('MKT','Marketing',103,'PRS');
INSERT INTO Setor VALUES ('RHM','Recursos Humanos',101,'PRS');
INSERT INTO Setor VALUES ('ALM','Almoxarifado',105,'COV');
INSERT INTO Setor VALUES ('EXP','Expedição',111,'COV');
INSERT INTO Setor VALUES ('PQD','Pesquisa e Desenvolvimento',107,'MKT');
INSERT INTO Setor VALUES ('PES','Pessoal',106,'RHM');
INSERT INTO Setor VALUES ('SVG','Serviços Gerais',110,'RHM');
INSERT INTO Setor VALUES ('TRN','Transporte',104,'RHM');

/*** Inserção de dados na tabela Funcao ***/
INSERT INTO Funcao VALUES (1,'Presidente Geral','5000.00');
INSERT INTO Funcao VALUES (2,'Vice-Presidente Geral','4000.00');
INSERT INTO Funcao VALUES (3,'Diretor de Compras e Vendas','3000.00');
INSERT INTO Funcao VALUES (4,'Diretor de Marketing','3000.00');
INSERT INTO Funcao VALUES (5,'Diretor de Recursos Humanos','2500.00');
INSERT INTO Funcao VALUES (6,'Diretor de Finanças','2500.00');
INSERT INTO Funcao VALUES (7,'Gerente de Compras','2000.00');
INSERT INTO Funcao VALUES (8,'Gerente de Vendas','2000.00');
INSERT INTO Funcao VALUES (9,'Representante de Vendas','1500.00');
INSERT INTO Funcao VALUES (10,'Vendedor Executivo','1000.00');
INSERT INTO Funcao VALUES (11,'Vendedor Primário','500.00');
INSERT INTO Funcao VALUES (12,'Despachante','100.00');
INSERT INTO Funcao VALUES (13,'Servente','100.00');
INSERT INTO Funcao VALUES (14,'Vigilante','150.00');
INSERT INTO Funcao VALUES (15,'Motorista','300.00');
INSERT INTO Funcao VALUES (16,'Telefonista','300.00');
INSERT INTO Funcao VALUES (17,'Contabilista','1500.00');
INSERT INTO Funcao VALUES (18,'Supervisor','1400.00');
INSERT INTO Funcao VALUES (19,'Contínuo','100.00');
INSERT INTO Funcao VALUES (20,'Secretária','400.00');
INSERT INTO Funcao VALUES (21,'Atendente','100.00');
INSERT INTO Funcao VALUES (22,'Digitador','500.00');

/*** Inserção de dados na tabela Tipo ***/
INSERT INTO Tipo VALUES (1,'Bebidas','Refrigerantes, cafés, chás e cervejas');
INSERT INTO Tipo VALUES (2,'Condimentos','Patês, temperos, picles e molhos doces e salgados');
INSERT INTO Tipo VALUES (3,'Confeitos','Sobremesas, doces, pães doces');
INSERT INTO Tipo VALUES (4,'Laticínios','Queijos e manteigas');
INSERT INTO Tipo VALUES (5,'Grãos/Cereais','Pães, biscoitos, massas e cereais');
INSERT INTO Tipo VALUES (6,'Carnes/Aves','Carnes preparadas');
INSERT INTO Tipo VALUES (7,'Hortigranjeiros','Frutas secas e pastas vegetais');
INSERT INTO Tipo VALUES (8,'Frutos do Mar','Peixes e algas marinhas');
INSERT INTO Tipo VALUES (9,'Dietéticos','Produtos diversos com baixo teor calórico');

/*** Inserção de dados na tabela Funcionario ***/
INSERT INTO Funcionario VALUES (1,'Nancy Davolio Luperfill','F','C','129657/RS','222721637-12','Sra','1948/12/08','79','1992/05/01','R. Joaquim Carvalho Mesquita, 756','Apto. 802','Manaíra',7,'58030-580','246.2587','981.1222',3,'COV','5100','nancy@tastrade.com.br');
INSERT INTO Funcionario VALUES (2,'Andrew Fuller Jordan','M','C','45798613/PR','234678234-98','Dr','1952/02/19','80','1992/08/14','R. Joaquim Ferreira Costa, 729',NULL,'Manaíra',7,'58038-123','246.5452','981.2784',1,'PRS','8300','andrew@tastrade.com.br');
INSERT INTO Funcionario VALUES (3,'Janet Leverling Follet','F','S','4572457/SC','123658123-98','Srta','1963/08/30','70','1992/04/01','R. Flávio Melo Uchoa, 72','Apto. 502','Bessa',7,'58037-100','246.9008','982.1333',4,'MKT','5100','lever@tastrede.com.br');
INSERT INTO Funcionario VALUES (4,'Margaret Peacock Somensen','F','C','142589/RS','123456789-10','Sra','1937/09/19','81','1993/05/03','R. Silvino Lopes, 387',NULL,'Tambaú',7,'58039-190','246.4549','984.1245',10,'COV','1120','peacock@tastrade.com.br'); 
INSERT INTO Funcionario VALUES (5,'Steven Buchanan Pringless','M','C','45983524/PR','326598747-45','Sr','1955/03/14','15','1993/10/17','R. Eliseu Cândido Viana, 234','Apto. 701','Tambaú',7,'58038-090','246.2323','985.4589',2,'PRS','6200','buchanan@tastrade.com.br');
INSERT INTO Funcionario VALUES (6,'Michael Suyama Kyoto','M','C','1565914/SC','235698523-98','Sr','1963/07/02','15','1993/10/17','Av. Rio grande do Sul, 1234',NULL,'Bairro dos Estados',7,'50030-063','244.7873','981.2374',10,'COV','1120','suyama@tastrade.com.br');
INSERT INTO Funcionario VALUES (7,'Robert King Williams','M','C','25258984/SP','236598741-88','Sr','1960/05/29','15','1994/01/02','Av. Epitácio Pessoa, 1281',NULL,'Tambaú',7,'58036-012','226.3498','982.5575',5,'RHM','4700','robeking@tastrade.com.br');
INSERT INTO Funcionario VALUES (8,'Laura Callahan Monfiglio','F','C','12365214/SP','223652587-89','Sra','1958/01/09','66','1994/03/05','R. Eliseu Lira, 78','Apto. 503','Miramar',7,'58032-040','247.2158','983.2258',10,'COV','1120','callahan@tastrade.com.br');
INSERT INTO Funcionario VALUES (9,'Anne Dodsworth Sausbrown','F','C','12458721/SP','235321457-12','Sra','1966/01/27','15','1994/11/15','Av. Pernambuco, 234',NULL,'Bairro dos Estados',7,'58030-240','244.1210','984.3636',9,'COV','2800','annedods@tastrade.com.br');
INSERT INTO Funcionario VALUES (10,'Douglas Martins de Castro','M','C','12568996/PE','123458123-95','Sr','1960/08/16','1','1995/09/16','Av. Rui Carneiro, 245',NULL,'Tambaú',7,'58032-000','247.3159','981.4568',6,'FIN','4700','douglas@tastrade.com.br');
INSERT INTO Funcionario VALUES (11,'Edmea Costa Pereira','F','S','4596258/PB','456325987-85','Srta','1968/05/23','7','1995/04/21','Paulino Pinto, 642',NULL,'Tambaú',7,'58045-000','247.2359','985.2658',7,'COV','4000','edmea@tastrade.com.br');
INSERT INTO Funcionario VALUES (12,'Romero da Silveira Barreto','M','C','1245789/PB','154896351-87','Sr','1958/12/26','82','1994/05/12','R. Paulo Franca Marinho, 124',NULL,'Miramar',7,'58032-150','2263598','985.5987',8,'COV','4000','rbarreto@tastrade.com.br');
INSERT INTO Funcionario VALUES (13,'Kátia Maria Costa Barros','F','S','1565329/PB','456654312-59','Srta','1968/12/12','2','1996/06/25','R. João José Costa, 346',NULL,'Ernesto Geisel',7,'58075-030','231.0312',NULL,16,'SVG','600',NULL);
INSERT INTO Funcionario VALUES (14,'Micheline Gomes Barbosa','F','S','9864579/PB','436598742-81','Srta','1969/10/25','86','1997/02/15','R. Silvino Chaves, 234','Apto. 301','Tambaú',7,'58038-000','247.6984','982.3568',18,'EXP','1100',NULL);
INSERT INTO Funcionario VALUES (15,'Carlos Braskey Costa','M','C','5689741/PB','452136987-72','Sr','1947/05/12','85','1995/12/12','R. Nestor Costa Melo, 245',NULL,'Bancários',7,'58052-032','235.2356',NULL,9,'COV','2800','braskey@tastrade.com.br');
INSERT INTO Funcionario VALUES (16,'João Carlos Wanderley','M','C','15698435/PB','456987125-98','Sr','1957/06/25','84','1994/11/23','R. João Teixeira Carvalho, 480','Apto. 403','Pedro Gondim',7,'58031-220','244.5689','951.2356',15,'TRN','800',NULL);
INSERT INTO Funcionario VALUES (17,'Madeleine Bezerra Araújo','F','S','2359844/PB','456897215-45','Srta','1972/07/23','3','1996/05/14','R. Silva Mariz, 24',NULL,'Cruz das Armas',7,'58085-350','222.9891','982.3568',16,'SVG','600',NULL);
INSERT INTO Funcionario VALUES (18,'Agamenon Correa Filho','M','S','4561236/PB','123456654-12','Sr','1962/10/12','2','1994/05/12','Av. Espírito Santo, 345',NULL,'Bairro dos Estados',7,'58030-065','244.5894','985.9800',11,'COV','800',NULL);
INSERT INTO Funcionario VALUES (19,'Pedro Gregório Ramos Pimenta','M','C','12365487/PE','456212354-45','Sr','1960/01/31','6','1994/02/25','R. João Úrsulo Filho, 234','Apto. 201','Mangabeira II',7,'58055-360','238.3265',NULL,14,'SVG','550',NULL);
INSERT INTO Funcionario VALUES (20,'Luzinete Vistor Santana','F','S','4569974/PB','564541215-65','Srta','1968/05/23','8','1997/12/14','R. Odete Gomes Araújo, 345',NULL,'Bessa',7,'58057-303','238.5698','984.3267',11,'COV','800',NULL);
INSERT INTO Funcionario VALUES (21,'Walderlan Santoa Silva','M','C','54654564/RN','456871135-13','Sr','1961/09/21','8','1995/12/12','R. Odília Sebadelhe, 234',NULL,'Cristo Redentor',7,'58071-735','231.2568',NULL,14,'SVG','550',NULL);
INSERT INTO Funcionario VALUES (22,'Gláucio Barbosa Leite','M','C','54645665/PE','453888688-64','Sr','1960/02/12','1','1996/04/02','R. Odilon Egito, 23',NULL,'Torre',7,'58040-630','244.3298',NULL,15,'TRN','800',NULL);
INSERT INTO Funcionario VALUES (23,'Maria Creusa Santos Lima','F','C','456895412/PE','456325699-78','Sra','1958/09/12','5','1995/05/22','R. Silvano Domingos Araújo, 234',NULL,'Bessa',7,'58036-070','246.3026','985.3698',17,'FIN','3000','creusal@tastrade.com.br');
INSERT INTO Funcionario VALUES (24,'Solange Gusmão Porto','F','C','65983215/PB','958421350-98','Sra','1959/07/23','8','1994/08/15','R. João Soares Costa,',NULL,'Cruz das Armas',7,'58085-490',NULL,NULL,13,'SVG','400',NULL);
INSERT INTO Funcionario VALUES (25,'Cleobaldo Nunes Matos','M','C','21231212/PB','123545455-13','Sr','1966/06/23','7','1995/08/17','R. Marcina Maria Almeida, 87',NULL,'Mangabeira II',7,'58087-252','238.0109',NULL,14,'SVG','550',NULL);
INSERT INTO Funcionario VALUES (26,'Maria Lúcia Sandoval Pessoa','F','C','45545151/PE','123658412-89','Sra','1966/09/29','31','1996/08/25','R. Brigadeiro Lopes, 342',NULL,'Centro',31,'58000-000','228.2543',NULL,12,'EXP','500',NULL);
INSERT INTO Funcionario VALUES (27,'Dorgival Salustiano Vasques','M','C','1323659/PB','659784212-12','Sr','1970/05/14','7','1996/08/13','R. Vicente Leipo, 345',NULL,'Bessa',7,'58035-060','246.3298','983.2894',11,'COV','800',NULL);
INSERT INTO Funcionario VALUES (28,'Valda Maria Braga da Silva','F','S','4541122/PB','458743878-32','Srta','1971/08/25','7','1994/12/24','R Alves de Sá, 853',NULL,'Jardim 13 de Maio',7,'58035-012',NULL,NULL,12,'EXP','500',NULL);
INSERT INTO Funcionario VALUES (29,'Paulo Brandão Albuquerque','M','C','54564545/PB','986531245-48','Sr','1963/05/21','84','1995/12/12','R. Libertadores, 234',NULL,'Centro',84,'58000-000',NULL,NULL,14,'SVG','550',NULL);
INSERT INTO Funcionario VALUES (30,'Francisca Lopes Gonzaga','F','S','21313148/PB','212354112-15','Srta','1973/06/12','7','1996/01/02','Av. Marechal Deodoro, 678',NULL,'Torre',7,'58045-065',NULL,NULL,13,'SVG','400',NULL);
INSERT INTO Funcionario VALUES (31,'Sandra Almeida Prado','F','S','645641545/PB','656454598-16','Srta','1968/02/14','7','1995/05/14','R. Nunes Filho, 234',NULL,'Tambauzinho',7,'58033-030','244.5612','984.2398',18,'ALM','1100',NULL);
INSERT INTO Funcionario VALUES (32,'Clóvis Beltrão Borba','M','S','15345668/PB','156456456-12','Sr','1962/05/25','7','1996/04/13','R. Carlos Alverga, 34',NULL,'Tambaú',7,'58045-012','226.2340','981.0221',11,'ALM','800',NULL);
INSERT INTO Funcionario VALUES (33,'Vilibaldo Saturnino Simão','M','C','22313545/PB','562314897-15','Sr','1971/03/07','7','1994/11/12','R, Lindolfo José Neves, 419','Apto. 701','Bessa',7,'58037-520','246.2741','985.1211',18,'COV','1100',NULL);
INSERT INTO Funcionario VALUES (34,'João Astrolábio Bezerra','M','C','987587589/PB','987654321-98','Sr','1960/05/16','7','1995/12/25','Av. São Paulo, 324',NULL,'Bairro dos Estados',7,'58030-061','244.5897','981.9806',10,'COV','1120','astro@tastrade.com.br');

/*** Inserção de dados na tabela Produto ***/
INSERT INTO Produto VALUES (1,'Chai',NULL,'10 caixas x 20 pacotes','18','12',39,10,1,'N');
INSERT INTO Produto VALUES (2,'Chang',NULL,'24 garrafas de 12oz','19','13',17,25,1,'N');
INSERT INTO Produto VALUES (3,'Aniseed Syrup',NULL,'12 garrafas de 550ml','10','5',13,25,2,'S');
INSERT INTO Produto VALUES (4,'Chef Antons Cajun Seasoning','Condimentos Cajun Chef Antons','48 frascos de 170 g','26.4','20.02',53,5,3,'S');
INSERT INTO Produto VALUES (5,'Chef Antons Gumbo Mix','Sopa de quiabo com galinha Chef Antons','36 caixas','20.5752','19.4285',0,10,6,'N');
INSERT INTO Produto VALUES (6,'Grandmas Boysenberry Spread','Pasta de amora Grandmas','12 frascos de 226 g','30','21.25',120,25,4,'S');
INSERT INTO Produto VALUES (7,'Uncle Bobs Organic Dried Pears',NULL,'12 pacotes de 1lb','30','22.56',15,10,7,'N');
INSERT INTO Produto VALUES (8,'Northwoods Cranberry Sauce',NULL,'12 vidros de 12oz','40','32.65',6,0,2,'D');
INSERT INTO Produto VALUES (9,'Mishi Kobe Niku',NULL,'18 pacotes de 500g','97','81',29,0,6,'S');
INSERT INTO Produto VALUES (10,'Ikura',NULL,'12 vidros de 200ml','31','25',31,0,8,'D');
INSERT INTO Produto VALUES (11,'Queso Cabrales','Queijo de cabra','pacote de 1 kg.','15.3317','19.11',22,10,6,'N');
INSERT INTO Produto VALUES (12,'Queso Manchego La Pastora',NULL,'10 pacotes de 500g','38','30',86,0,4,'N');
INSERT INTO Produto VALUES (13,'Konbu','Algas Kelp','caixa de 2 kg','7.2','5.46',24,5,8,'S');
INSERT INTO Produto VALUES (14,'Tofu','Coalho de feijão','40 pacotes de 100 g.','27.9','21.1575',35,10,4,'D');
INSERT INTO Produto VALUES (15,'Genen Shouyu',NULL,'24 garrafas de 250ml','15.5','12.2',39,5,2,'N');
INSERT INTO Produto VALUES (16,'Pavlova','Merengue Pavlova','32 caixas de 500 g','16.3332','15.8795',29,10,1,'N');
INSERT INTO Produto VALUES (17,'Alice Mutton',NULL,'20 latas de 1kg','39','35',0,2,6,'N');
INSERT INTO Produto VALUES (18,'Carnarvon Tigers',NULL,'pacote de 16kg','62.5','50',42,0,8,'N');
INSERT INTO Produto VALUES (19,'Teatime Chocolate Biscuits','Biscoitos de chocolate','10 caixas x 12 unidades','11.04','8.372',25,5,5,'N');
INSERT INTO Produto VALUES (20,'Sir Rodneys Marmalade',NULL,'30 caixas para presente','81','72',40,0,3,'S');
INSERT INTO Produto VALUES (21,'Sir Rodneys Scones','Pão-de-ló Sir Rodneys','24 pacotes x 4 unidades','15.84','9.1',3,10,5,'S');
INSERT INTO Produto VALUES (22,'Gustafs Knäckebröd','Pão fresco Gustafs Rye','24 pacotes de 500 g.','25.2','19.11',104,25,5,'N');
INSERT INTO Produto VALUES (23,'Tunnbröd','Pão em fatias finas','12 pacotes de 250 g.','10.8','8.19',61,25,5,'N');
INSERT INTO Produto VALUES (24,'Guaraná Fantástica','Refrigerante Guaraná Fantástica','12 latas de 355 ml','5.4','4.095',20,10,1,'D');
INSERT INTO Produto VALUES (25,'NuNuCa Nuß-Nougat-Creme','Pasta de chocolate com amendoim NuNuCa','20 frascos de 450 g','16.8','12.74',76,30,3,'N');
INSERT INTO Produto VALUES (26,'Gumbär Gummibärchen',NULL,'100 sacos de 250g','31.23','25',15,0,3,'D');
INSERT INTO Produto VALUES (27,'Schoggi Schokolade',NULL,'100 unidades de 100g','43.9','32.4',49,30,3,'S');
INSERT INTO Produto VALUES (28,'Rössle Sauerkraut',NULL,'25 latas de 825g','45.6','34.8',26,0,7,'N');
INSERT INTO Produto VALUES (29,'Thüringer Rostbratwurst',NULL,'50 pacotes x 30 salsichas','123.79','100',0,0,6,'D');
INSERT INTO Produto VALUES (30,'Nord-Ost Matjeshering','Arenque branco Nord-Ost','10 frascos de 200 g','18.9017','22.0065',10,15,8,'N');
INSERT INTO Produto VALUES (31,'Gorgonzola Telino','Gorgonzola Telino','12 pacotes de 100 g','15.444','11.375',0,10,4,'N');
INSERT INTO Produto VALUES (32,'Mascarpone Fabioli',NULL,'24 pacotes de 200g','32','26',9,25,4,'N');
INSERT INTO Produto VALUES (33,'Geitost','Queijo de cabra','50 pacotes de 500 g','3','2.275',112,20,4,'N');
INSERT INTO Produto VALUES (34,'Sasquatch Ale','Ale Sasquatch','24 garrafas de 283 g','16.8','12.74',111,15,1,'N');
INSERT INTO Produto VALUES (35,'Steeleye Stout','Cerveja preta Steeleye','24 garrafas de 283 g','16.848','16.38',20,15,1,'S');
INSERT INTO Produto VALUES (36,'Inlagd Sill','Arenque em conservas','24 frascos de 250 g','22.8','17.29',112,20,8,'N');
INSERT INTO Produto VALUES (37,'Gravad lax','Gravad Lox','12 pacotes de 500 g.','18.9821','22.1',11,10,3,'S');
INSERT INTO Produto VALUES (38,'Côte de Blaye',NULL,'12 garrafas de 75cl','263.5','200',17,15,1,'N');
INSERT INTO Produto VALUES (39,'Chartreuse verte','Green Chartreuse (Licor)','750 cc por garrafa peq.','21.6','16.38',69,5,1,'N');
INSERT INTO Produto VALUES (40,'Boston Crab Meat','Carne de siri Boston','24 latas de 113 g','22.08','16.744',123,30,8,'S');
INSERT INTO Produto VALUES (41,'Jacks New England Clam Chowder','Jacks New England Clam Chowder','12 latas de 283 g','11.58','8.7815',85,10,3,'N');
INSERT INTO Produto VALUES (42,'Singaporean Hokkien Fried Mee','Macarrão de Cingapura','32 pacotes de 1 kg.','16.8','12.74',26,10,5,'S');
INSERT INTO Produto VALUES (43,'Ipoh Coffee',NULL,'16 latas de 500g','46','35',17,25,1,'N');
INSERT INTO Produto VALUES (44,'Gula Malacca','Açúcar mascavo de Malaca','20 sacos de 2 kg','14.2001','17.6995',27,15,3,'S');
INSERT INTO Produto VALUES (45,'Rogede sild','Arenque defumado','pacote de 1k','15.048','8.645',5,10,8,'N');
INSERT INTO Produto VALUES (46,'Spegesild','Arenque salgado','4 pacotes de 450 g','14.4','10.92',95,15,8,'N');
INSERT INTO Produto VALUES (47,'Zaanse koeken','Biscoitos Zaanse','10 caixas de 113 g','11.4','8.645',36,10,5,'D');
INSERT INTO Produto VALUES (48,'Chocolade','Chocolate holandês','10 pacotes','29.988','11.6025',15,25,3,'N');
INSERT INTO Produto VALUES (49,'Maxilaku','Licorice','24 pacotes de 50 g','28.6191','18.2',10,15,1,'N');
INSERT INTO Produto VALUES (50,'Valkoinen suklaa','Chocolate branco','12 barras de 100 g','19.5','14.7875',65,30,3,'S');
INSERT INTO Produto VALUES (51,'Manjimup Dried Apples',NULL,'50 pacotes de 300g','53','43',20,10,7,'S');
INSERT INTO Produto VALUES (52,'Filo Mix','Mistura para massa de pão grego','16 caixas de 2 kg','8.4','6.37',38,25,5,'N');
INSERT INTO Produto VALUES (53,'Perth Pasties',NULL,'48 unidades','32.8','24',0,0,6,'D');
INSERT INTO Produto VALUES (54,'Tourtière','Torta de carne de porco','16 tortas','8.94','6.7795',21,10,6,'N');
INSERT INTO Produto VALUES (55,'Pâté chinois','Torta Shepards','24 caixas x 2 tortas','28.8','21.84',115,20,3,'N');
INSERT INTO Produto VALUES (56,'Gnocchi di nonna Alice',NULL,'24 pacotes de 250g','38','30',21,30,5,'N');
INSERT INTO Produto VALUES (57,'Ravioli Angelo','Ravioli Angelo','24 pacotes de 250 g','23.4','17.745',36,20,5,'N');
INSERT INTO Produto VALUES (58,'Escargots de Bourgogne','Escargots de Borgonha','24 unidades','15.9','12.0575',62,20,8,'N');
INSERT INTO Produto VALUES (59,'Raclette Courdavault',NULL,'pacote de 5kg','55','47',79,0,4,'N');
INSERT INTO Produto VALUES (60,'Camembert Pierrot',NULL,'15 unidades de 300g','34','26',19,0,4,'S');
INSERT INTO Produto VALUES (61,'Sirop dérable','Melado','24 garrafas de 500 m','29.07','24.225',113,25,3,'N');
INSERT INTO Produto VALUES (62,'Tarte au sucre',NULL,'48 unidades','49.3','40',17,0,3,'N');
INSERT INTO Produto VALUES (63,'Vegie-spread',NULL,'15 vidros de 625g','43.9','35',24,5,2,'S');
INSERT INTO Produto VALUES (64,'Wimmers gute Semmelknödel',NULL,'20 sacos x 4 unidades','33.25','27',22,30,5,'D');
INSERT INTO Produto VALUES (65,'Louisiana Fiery Hot Pepper Sauce',NULL,'32 garrafas de 8oz','21.05','16',76,0,2,'D');
INSERT INTO Produto VALUES (66,'Louisiana Hot Spiced Okra',NULL,'24 vidros de 8oz','17','14',4,20,2,'S');
INSERT INTO Produto VALUES (67,'Laughing Lumberjack Lager','Cerveja Laughing Lumberjack','24 garrafas de 283 g','16.8','12.74',52,10,1,'N');
INSERT INTO Produto VALUES (68,'Scottish Longbreads','Bengalas escocesas','10 caixas x 8 unidades','15.444','11.375',6,10,5,'S');
INSERT INTO Produto VALUES (69,'Gudbrandsdalsost',NULL,'pacote de 10kg','36','29',26,15,4,'N');
INSERT INTO Produto VALUES (70,'Outback Lager','Cerveja Outback','24 garrafas de 355 m','27.5184','13.65',15,30,1,'N');
INSERT INTO Produto VALUES (71,'Flotemysost','Requeijão Flotemys','10 pacotes de 500 g','15.6967','19.565',26,10,4,'N');
INSERT INTO Produto VALUES (72,'Mozzarella di Giovanni',NULL,'24 pacotes de 200g','34.8','27',14,0,4,'N');
INSERT INTO Produto VALUES (73,'Röd Kaviar','Caviar vermelho','24 frascos de 150','18','13.65',101,5,8,'D');
INSERT INTO Produto VALUES (74,'Longlife Tofu','Coalho de feijão Longlife','pacote de 5 kg','15.84','9.1',4,10,4,'N');
INSERT INTO Produto VALUES (75,'Rhönbräu Klosterbier','Cerveja Rhönbräu','24 garrafas de 0,5 l','9.3','7.0525',125,25,1,'N');
INSERT INTO Produto VALUES (76,'Lakkalikööri',NULL,'500ml','18','14',57,20,1,'N');
INSERT INTO Produto VALUES (77,'Original Frankfurter grüne Soße',NULL,'12 caixas','13','10',32,15,2,'N');

/*** Inserção de dados na tabela Pedido ***/
INSERT INTO Pedido VALUES ('10248','VINET',5,'1996-08-04','1996-09-01','M',51.16);
INSERT INTO Pedido values ('10249','TOMSP',6,'1996-08-05','1996-09-16','T',18.34);
INSERT INTO Pedido values ('10251','VICTE',3,'1996-08-08','1996-09-05','T',65.32);
INSERT INTO Pedido values ('10253','HANAR',3,'1996-08-10','1996-08-24','A',91.91);
INSERT INTO Pedido values ('10254','CHOPS',5,'1996-08-11','1996-09-08','T',36.31);
INSERT INTO Pedido values ('10256','WELLI',3,'1996-08-15','1996-09-12','T',22.07);
INSERT INTO Pedido values ('10264','MARLA',6,'1996-08-24','1996-09-21','M',5.80);
INSERT INTO Pedido values ('10265','BLONP',2,'1996-08-25','1996-09-22','A',87.34);
INSERT INTO Pedido values ('10269','WHITC',5,'1996-08-31','1996-09-14','A',7.20);
INSERT INTO Pedido values ('10271','SPLIR',6,'1996-09-01','1996-09-29','T',7.17);
INSERT INTO Pedido values ('10272','RATTC',6,'1996-09-02','1996-09-30','T',154.89);
INSERT INTO Pedido values ('10273','QUICK',3,'1996-09-05','1996-10-03','M',120.19);
INSERT INTO Pedido values ('10274','VINET',6,'1996-09-06','1996-10-04','A',9.50);
INSERT INTO Pedido values ('10277','MORGK',2,'1996-09-09','1996-10-07','A',198.72);
INSERT INTO Pedido values ('10280','BERGS',2,'1996-09-14','1996-10-12','A',14.19);
INSERT INTO Pedido values ('10283','LILAS',3,'1996-09-16','1996-10-14','M',134.00);
INSERT INTO Pedido values ('10289','BSBEV',7,'1996-09-26','1996-10-24','M',35.98);
INSERT INTO Pedido values ('10291','QUEDE',6,'1996-09-27','1996-10-25','T',10.11);
INSERT INTO Pedido values ('10295','VINET',2,'1996-10-03','1996-10-31','T',1.82);
INSERT INTO Pedido values ('10296','LILAS',6,'1996-10-04','1996-11-01','A',0.19);
INSERT INTO Pedido values ('10297','BLONP',5,'1996-10-05','1996-11-16','T',9.07);
INSERT INTO Pedido values ('10298','HUNGO',6,'1996-10-06','1996-11-03','A',265.79);
INSERT INTO Pedido values ('10300','MAGAA',2,'1996-10-10','1996-11-07','T',27.93);
INSERT INTO Pedido values ('10303','GODOS',7,'1996-10-12','1996-11-09','A',170.37);
INSERT INTO Pedido values ('10307','LONEP',2,'1996-10-18','1996-11-15','T',0.88);
INSERT INTO Pedido values ('10308','ANATR',7,'1996-10-19','1996-11-16','M',2.54);
INSERT INTO Pedido values ('10309','HUNGO',3,'1996-10-20','1996-11-17','A',74.73);
INSERT INTO Pedido values ('10312','DIEWA',2,'1996-10-24','1996-11-21','T',63.61);
INSERT INTO Pedido values ('10313','QUICK',2,'1996-10-25','1996-11-22','T',3.10);
INSERT INTO Pedido values ('10317','LONEP',6,'1996-10-31','1996-11-28','A',20.05);
INSERT INTO Pedido values ('10319','MIGAN',7,'1996-11-02','1996-11-30','A',101.91);
INSERT INTO Pedido values ('10320','WARTH',5,'1996-11-03','1996-11-17','M',54.62);
INSERT INTO Pedido values ('10321','ISLAT',3,'1996-11-03','1996-12-01','T',5.42);
INSERT INTO Pedido values ('10322','PERIC',7,'1996-11-04','1996-12-02','M',0.63);
INSERT INTO Pedido values ('10327','MARLA',2,'1996-11-11','1996-12-09','A',100.11);
INSERT INTO Pedido values ('10330','LILAS',3,'1996-11-16','1996-12-14','A',20.15);
INSERT INTO Pedido values ('10332','MEREP',3,'1996-11-17','1996-12-29','T',83.49);
INSERT INTO Pedido values ('10333','WARTH',5,'1996-11-18','1996-12-16','M',0.93);
INSERT INTO Pedido values ('10335','HUNGO',7,'1996-11-22','1996-12-20','T',66.53);
INSERT INTO Pedido values ('10336','PRINI',7,'1996-11-23','1996-12-21','T',24.51);
INSERT INTO Pedido values ('10339','MEREP',2,'1996-11-28','1996-12-26','T',24.74);
INSERT INTO Pedido values ('10341','JYTPE',7,'1996-11-29','1996-12-27','M',42.31);
INSERT INTO Pedido values ('10345','QUICK',2,'1996-12-05','1997-01-02','A',393.51);
INSERT INTO Pedido values ('10346','RATTC',3,'1996-12-06','1997-01-17','M',224.49);
INSERT INTO Pedido values ('10349','SPLIR',7,'1996-12-09','1997-01-06','A',13.64);
INSERT INTO Pedido values ('10350','LAMAI',6,'1996-12-12','1997-01-09','T',101.42);
INSERT INTO Pedido values ('10352','FURIB',3,'1996-12-13','1996-12-27','M',2.05);
INSERT INTO Pedido values ('10353','PICCO',7,'1996-12-14','1997-01-11','A',569.80);
INSERT INTO Pedido values ('10355','AROUT',6,'1996-12-16','1997-01-13','A',66.28);
INSERT INTO Pedido values ('10356','DIEWA',6,'1996-12-19','1997-01-16','T',58.00);
INSERT INTO Pedido values ('10358','LAMAI',5,'1996-12-21','1997-01-18','A',31.03);
INSERT INTO Pedido values ('10359','SEVES',5,'1996-12-22','1997-01-19','A',455.72);
INSERT INTO Pedido values ('10362','MARSO',3,'1996-12-26','1997-01-23','A',151.74);
INSERT INTO Pedido values ('10365','ANTON',3,'1996-12-28','1997-01-25','T',34.76);
INSERT INTO Pedido values ('10367','VAFFE',7,'1996-12-29','1997-01-26','M',21.41);
INSERT INTO Pedido values ('10368','ERNSH',2,'1996-12-30','1997-01-27','T',161.08);
INSERT INTO Pedido values ('10370','CHOPS',6,'1997-01-03','1997-01-31','T',1.85);
INSERT INTO Pedido values ('10372','QUEEN',5,'1997-01-04','1997-02-01','A',1407.43);
INSERT INTO Pedido values ('10375','HUNGC',3,'1997-01-06','1997-02-03','T',31.79);
INSERT INTO Pedido values ('10378','MARLA',5,'1997-01-10','1997-02-07','M',8.60);
INSERT INTO Pedido values ('10379','QUEDE',2,'1997-01-11','1997-02-08','A',71.15);
INSERT INTO Pedido values ('10381','LILAS',3,'1997-01-12','1997-02-09','M',12.62);
INSERT INTO Pedido values ('10384','BERGS',3,'1997-01-16','1997-02-13','A',266.45);
INSERT INTO Pedido values ('10388','SEVES',2,'1997-01-19','1997-02-16','A',55.08);
INSERT INTO Pedido values ('10390','ERNSH',6,'1997-01-23','1997-02-20','A',199.68);
INSERT INTO Pedido values ('10391','DRACD',3,'1997-01-23','1997-02-20','M',8.61);
INSERT INTO Pedido values ('10392','PICCO',2,'1997-01-24','1997-02-21','M',193.49);
INSERT INTO Pedido values ('10395','HILAA',6,'1997-01-26','1997-02-23','A',291.37);
INSERT INTO Pedido values ('10397','PRINI',5,'1997-01-27','1997-02-24','A',95.21);
INSERT INTO Pedido values ('10398','SAVEA',2,'1997-01-30','1997-02-27','M',140.87);
INSERT INTO Pedido values ('10404','MAGAA',2,'1997-02-03','1997-03-03','A',246.43);
INSERT INTO Pedido values ('10406','QUEEN',7,'1997-02-07','1997-03-21','A',170.70);
INSERT INTO Pedido values ('10407','HENRP',2,'1997-02-07','1997-03-07','T',144.54);
INSERT INTO Pedido values ('10409','OCEAN',3,'1997-02-09','1997-03-09','A',47.13);
INSERT INTO Pedido values ('10410','BOTTM',3,'1997-02-10','1997-03-10','M',3.79);
INSERT INTO Pedido values ('10413','LAMAI',3,'1997-02-14','1997-03-14','T',151.14);
INSERT INTO Pedido values ('10414','FAMIA',2,'1997-02-14','1997-03-14','M',33.94);
INSERT INTO Pedido values ('10415','HUNGC',3,'1997-02-15','1997-03-15','A',0.32);
INSERT INTO Pedido values ('10420','WELLI',3,'1997-02-21','1997-03-21','A',69.71);
INSERT INTO Pedido values ('10422','FRANS',2,'1997-02-22','1997-03-22','A',4.77);
INSERT INTO Pedido values ('10423','GOURL',6,'1997-02-23','1997-03-09','M',38.71);
INSERT INTO Pedido values ('10424','MEREP',7,'1997-02-23','1997-03-23','A',585.56);
INSERT INTO Pedido values ('10425','LAMAI',6,'1997-02-24','1997-03-24','T',12.53);
INSERT INTO Pedido values ('10428','REGGC',7,'1997-02-28','1997-03-28','A',17.52);
INSERT INTO Pedido values ('10429','HUNGO',3,'1997-03-01','1997-04-12','T',89.48);
INSERT INTO Pedido values ('10432','SPLIR',3,'1997-03-03','1997-03-17','T',6.86);
INSERT INTO Pedido values ('10433','PRINI',3,'1997-03-06','1997-04-03','M',116.65);
INSERT INTO Pedido values ('10434','MARLA',3,'1997-03-06','1997-04-03','T',28.31);
INSERT INTO Pedido values ('10436','BLONP',3,'1997-03-08','1997-04-05','A',247.52);
INSERT INTO Pedido values ('10438','TOMSP',3,'1997-03-09','1997-04-06','T',13.02);
INSERT INTO Pedido values ('10439','MEREP',6,'1997-03-10','1997-04-07','M',6.43);
INSERT INTO Pedido values ('10441','OLDWO',3,'1997-03-13','1997-04-24','T',115.37);
INSERT INTO Pedido values ('10442','ERNSH',3,'1997-03-14','1997-04-11','T',75.75);
INSERT INTO Pedido values ('10444','BERGS',3,'1997-03-15','1997-04-12','M',5.53);
INSERT INTO Pedido values ('10445','BERGS',3,'1997-03-16','1997-04-13','A',14.69);
INSERT INTO Pedido values ('10446','TOMSP',6,'1997-03-17','1997-04-14','A',23.19);
INSERT INTO Pedido values ('10449','BLONP',3,'1997-03-21','1997-04-18','T',84.21);
INSERT INTO Pedido values ('10457','KOENE',2,'1997-03-28','1997-04-25','A',18.28);
INSERT INTO Pedido values ('10458','SUPRD',7,'1997-03-29','1997-04-26','M',232.35);
INSERT INTO Pedido values ('10462','CONSH',2,'1997-04-03','1997-05-01','T',9.75);
INSERT INTO Pedido values ('10463','SUPRD',5,'1997-04-04','1997-05-02','M',23.35);
INSERT INTO Pedido values ('10468','KOENE',3,'1997-04-07','1997-05-05','M',69.71);
INSERT INTO Pedido values ('10471','BSBEV',2,'1997-04-11','1997-05-09','M',72.03);
INSERT INTO Pedido values ('10474','PERIC',5,'1997-04-13','1997-05-11','T',131.91);
INSERT INTO Pedido values ('10477','PRINI',5,'1997-04-17','1997-05-15','T',20.57);
INSERT INTO Pedido values ('10478','VICTE',2,'1997-04-18','1997-05-02','M',7.60);
INSERT INTO Pedido values ('10479','RATTC',3,'1997-04-19','1997-05-17','A',1120.14);
INSERT INTO Pedido values ('10480','FOLIG',6,'1997-04-20','1997-05-18','T',2.13);
INSERT INTO Pedido values ('10483','WHITC',7,'1997-04-24','1997-05-22','T',24.14);
INSERT INTO Pedido values ('10484','BSBEV',3,'1997-04-24','1997-05-22','M',10.87);
INSERT INTO Pedido values ('10487','QUEEN',2,'1997-04-26','1997-05-24','T',112.29);
INSERT INTO Pedido values ('10489','PICCO',6,'1997-04-28','1997-05-26','T',8.36);
INSERT INTO Pedido values ('10490','HILAA',7,'1997-05-01','1997-05-29','A',332.10);
INSERT INTO Pedido values ('10492','BOTTM',3,'1997-05-02','1997-05-30','T',99.37);
INSERT INTO Pedido values ('10495','LAUGB',3,'1997-05-04','1997-06-01','M',7.35);
INSERT INTO Pedido values ('10496','TRADH',7,'1997-05-05','1997-06-02','T',73.90);
INSERT INTO Pedido values ('10497','LEHMS',7,'1997-05-05','1997-06-02','T',57.21);
INSERT INTO Pedido values ('10500','LAMAI',6,'1997-05-10','1997-06-07','T',67.43);
INSERT INTO Pedido values ('10502','PERIC',2,'1997-05-11','1997-06-08','T',109.53);
INSERT INTO Pedido values ('10503','HUNGO',6,'1997-05-12','1997-06-09','T',26.45);
INSERT INTO Pedido values ('10505','MEREP',3,'1997-05-15','1997-06-12','M',11.27);
INSERT INTO Pedido values ('10507','ANTON',7,'1997-05-16','1997-06-13','T',74.97);
INSERT INTO Pedido values ('10510','SAVEA',6,'1997-05-19','1997-06-16','M',580.86);
INSERT INTO Pedido values ('10512','FAMIA',7,'1997-05-22','1997-06-19','T',5.58);
INSERT INTO Pedido values ('10513','DIEWA',7,'1997-05-23','1997-07-04','A',166.93);
INSERT INTO Pedido values ('10514','ERNSH',3,'1997-05-23','1997-06-20','T',1248.12);
INSERT INTO Pedido values ('10515','QUICK',2,'1997-05-24','1997-06-07','A',323.06);
INSERT INTO Pedido values ('10516','HUNGO',2,'1997-05-25','1997-06-22','M',99.19);
INSERT INTO Pedido values ('10517','NORTS',3,'1997-05-25','1997-06-22','M',50.67);
INSERT INTO Pedido values ('10519','CHOPS',6,'1997-05-29','1997-06-26','M',144.98);
INSERT INTO Pedido values ('10520','SANTG',7,'1997-05-30','1997-06-27','T',21.12);
INSERT INTO Pedido values ('10523','SEVES',7,'1997-06-01','1997-06-29','T',122.66);
INSERT INTO Pedido values ('10527','QUICK',7,'1997-06-05','1997-07-03','M',66.20);
INSERT INTO Pedido values ('10528','GREAL',6,'1997-06-06','1997-06-20','T',5.29);
INSERT INTO Pedido values ('10529','MAISD',5,'1997-06-07','1997-07-05','T',105.37);
INSERT INTO Pedido values ('10530','PICCO',3,'1997-06-08','1997-07-06','T',535.97);
INSERT INTO Pedido values ('10531','OCEAN',7,'1997-06-08','1997-07-06','T',12.83);
INSERT INTO Pedido values ('10532','EASTC',7,'1997-06-09','1997-07-07','M',117.65);
INSERT INTO Pedido values ('10536','LEHMS',3,'1997-06-14','1997-07-12','T',93.03);
INSERT INTO Pedido values ('10539','BSBEV',6,'1997-06-16','1997-07-14','M',19.53);
INSERT INTO Pedido values ('10540','QUICK',3,'1997-06-19','1997-07-17','A',1592.07);
INSERT INTO Pedido values ('10541','HANAR',2,'1997-06-19','1997-07-17','T',108.47);
INSERT INTO Pedido values ('10547','SEVES',3,'1997-06-23','1997-07-21','A',281.92);
INSERT INTO Pedido values ('10548','TOMSP',3,'1997-06-26','1997-07-24','T',2.26);
INSERT INTO Pedido values ('10549','QUICK',5,'1997-06-27','1997-07-11','A',270.56);
INSERT INTO Pedido values ('10550','GODOS',7,'1997-06-28','1997-07-26','M',6.83);
INSERT INTO Pedido values ('10552','HILAA',2,'1997-06-29','1997-07-27','A',131.49);
INSERT INTO Pedido values ('10553','WARTH',2,'1997-06-30','1997-07-28','T',236.19);
INSERT INTO Pedido values ('10555','SAVEA',6,'1997-07-03','1997-07-31','A',398.93);
INSERT INTO Pedido values ('10556','JYTPE',2,'1997-07-04','1997-08-15','T',15.48);
INSERT INTO Pedido values ('10559','BLONP',6,'1997-07-06','1997-08-03','T',12.72);
INSERT INTO Pedido values ('10561','MARLA',2,'1997-07-07','1997-08-04','A',382.69);
INSERT INTO Pedido values ('10563','RICAR',2,'1997-07-11','1997-08-22','T',95.48);
INSERT INTO Pedido values ('10568','GALED',3,'1997-07-14','1997-08-11','M',10.33);
INSERT INTO Pedido values ('10569','RATTC',5,'1997-07-17','1997-08-14','A',93.19);
INSERT INTO Pedido values ('10570','MEREP',3,'1997-07-18','1997-08-15','A',298.60);
INSERT INTO Pedido values ('10572','BERGS',3,'1997-07-19','1997-08-16','T',183.96);
INSERT INTO Pedido values ('10573','ANTON',7,'1997-07-20','1997-08-17','M',134.05);
INSERT INTO Pedido values ('10575','MORGK',5,'1997-07-21','1997-08-04','A',201.20);
INSERT INTO Pedido values ('10576','MIGAN',3,'1997-07-24','1997-08-07','M',29.32);
INSERT INTO Pedido values ('10581','FAMIA',3,'1997-07-27','1997-08-24','A',4.76);
INSERT INTO Pedido values ('10582','BLAUS',3,'1997-07-28','1997-08-25','T',43.78);
INSERT INTO Pedido values ('10583','WARTH',2,'1997-07-31','1997-08-28','T',11.50);
INSERT INTO Pedido values ('10585','WELLI',7,'1997-08-01','1997-08-29','T',21.19);
INSERT INTO Pedido values ('10588','QUICK',2,'1997-08-03','1997-08-31','A',307.58);
INSERT INTO Pedido values ('10592','LEHMS',3,'1997-08-08','1997-09-05','A',50.72);
INSERT INTO Pedido values ('10593','LEHMS',7,'1997-08-09','1997-09-06','T',275.24);
INSERT INTO Pedido values ('10594','OLDWO',3,'1997-08-09','1997-09-06','T',8.28);
INSERT INTO Pedido values ('10595','ERNSH',2,'1997-08-10','1997-09-07','A',152.91);
INSERT INTO Pedido values ('10597','PICCO',7,'1997-08-11','1997-09-08','M',55.49);
INSERT INTO Pedido values ('10599','BSBEV',6,'1997-08-15','1997-09-26','M',47.37);
INSERT INTO Pedido values ('10601','HILAA',7,'1997-08-16','1997-09-27','A',92.11);
INSERT INTO Pedido values ('10607','SAVEA',5,'1997-08-22','1997-09-19','A',316.38);
INSERT INTO Pedido values ('10609','JANLA',7,'1997-08-24','1997-09-21','T',2.92);
INSERT INTO Pedido values ('10611','ZBYSZ',6,'1997-08-25','1997-09-22','T',127.43);
INSERT INTO Pedido values ('10615','WILMK',2,'1997-08-30','1997-09-27','M',1.19);
INSERT INTO Pedido values ('10619','MEREP',3,'1997-09-04','1997-10-02','M',143.86);
INSERT INTO Pedido values ('10620','LAUGB',2,'1997-09-05','1997-10-03','M',1.49);
INSERT INTO Pedido values ('10625','ANATR',3,'1997-09-08','1997-10-06','A',69.36);
INSERT INTO Pedido values ('10633','ERNSH',7,'1997-09-15','1997-10-13','A',755.08);
INSERT INTO Pedido values ('10637','QUEEN',6,'1997-09-19','1997-10-17','A',318.04);
INSERT INTO Pedido values ('10638','FELIP',3,'1997-09-20','1997-10-18','A',250.34);
INSERT INTO Pedido values ('10639','SANTG',7,'1997-09-20','1997-10-18','M',61.05);
INSERT INTO Pedido values ('10642','JYTPE',7,'1997-09-22','1997-10-20','M',66.19);
INSERT INTO Pedido values ('10643','ALFKI',6,'1997-09-25','1997-10-23','A',46.55);
INSERT INTO Pedido values ('10644','WELLI',3,'1997-09-25','1997-10-23','T',0.22);
INSERT INTO Pedido values ('10648','RICAR',5,'1997-09-28','1997-11-09','T',22.52);
INSERT INTO Pedido values ('10649','MAISD',5,'1997-09-28','1997-10-26','M',9.80);
INSERT INTO Pedido values ('10650','FAMIA',5,'1997-09-29','1997-10-27','A',279.36);
INSERT INTO Pedido values ('10654','BERGS',5,'1997-10-03','1997-10-31','A',87.31);
INSERT INTO Pedido values ('10656','GREAL',6,'1997-10-05','1997-11-02','A',90.30);
INSERT INTO Pedido values ('10657','SAVEA',2,'1997-10-05','1997-11-02','A',557.25);
INSERT INTO Pedido values ('10659','QUEEN',7,'1997-10-06','1997-11-03','T',167.18);
INSERT INTO Pedido values ('10661','HUNGO',7,'1997-10-10','1997-11-07','M',27.73);
INSERT INTO Pedido values ('10662','LONEP',3,'1997-10-10','1997-11-07','T',2.02);
INSERT INTO Pedido values ('10663','MARSO',2,'1997-10-11','1997-10-25','T',178.78);
INSERT INTO Pedido values ('10666','RICSU',7,'1997-10-13','1997-11-10','A',367.22);
INSERT INTO Pedido values ('10667','ERNSH',7,'1997-10-13','1997-11-10','A',123.38);
INSERT INTO Pedido values ('10669','JYTPE',2,'1997-10-16','1997-11-13','A',38.54);
INSERT INTO Pedido values ('10673','WILMK',2,'1997-10-19','1997-11-16','A',35.96);
INSERT INTO Pedido values ('10675','FRANK',5,'1997-10-20','1997-11-17','T',50.32);
INSERT INTO Pedido values ('10676','MIGAN',2,'1997-10-23','1997-11-20','T',3.18);
INSERT INTO Pedido values ('10678','SAVEA',7,'1997-10-24','1997-11-21','A',614.59);
INSERT INTO Pedido values ('10681','GREAL',3,'1997-10-26','1997-11-23','M',120.29);
INSERT INTO Pedido values ('10682','ANTON',3,'1997-10-26','1997-11-23','T',57.09);
INSERT INTO Pedido values ('10683','JANLA',2,'1997-10-27','1997-11-24','A',6.95);
INSERT INTO Pedido values ('10684','HENRP',3,'1997-10-27','1997-11-24','A',230.10);
INSERT INTO Pedido values ('10686','PICCO',2,'1997-10-31','1997-11-28','A',152.47);
INSERT INTO Pedido values ('10691','QUICK',2,'1997-11-03','1997-12-15','A',1279.88);
INSERT INTO Pedido values ('10693','WHITC',3,'1997-11-06','1997-11-20','M',220.16);
INSERT INTO Pedido values ('10695','WILMK',7,'1997-11-07','1997-12-19','T',26.42);
INSERT INTO Pedido values ('10697','FELIP',3,'1997-11-08','1997-12-06','T',71.92);
INSERT INTO Pedido values ('10699','MORGK',3,'1997-11-09','1997-12-07','M',0.92);
INSERT INTO Pedido values ('10700','SAVEA',3,'1997-11-10','1997-12-08','A',102.86);
INSERT INTO Pedido values ('10701','HUNGO',6,'1997-11-13','1997-11-27','A',348.09);
INSERT INTO Pedido values ('10703','MARLA',6,'1997-11-14','1997-12-12','T',240.63);
INSERT INTO Pedido values ('10704','QUEEN',6,'1997-11-14','1997-12-12','M',7.55);
INSERT INTO Pedido values ('10708','THEBI',6,'1997-11-17','1997-12-29','T',4.68);
INSERT INTO Pedido values ('10711','SAVEA',5,'1997-11-21','1998-01-02','T',82.81);
INSERT INTO Pedido values ('10712','HUNGO',3,'1997-11-21','1997-12-19','A',142.09);
INSERT INTO Pedido values ('10714','SAVEA',5,'1997-11-22','1997-12-20','M',38.69);
INSERT INTO Pedido values ('10715','MARSO',3,'1997-11-23','1997-12-07','A',99.86);
INSERT INTO Pedido values ('10721','QUICK',5,'1997-11-29','1997-12-27','M',77.29);
INSERT INTO Pedido values ('10723','WHITC',3,'1997-11-30','1997-12-28','A',34.32);
INSERT INTO Pedido values ('10727','REGGC',2,'1997-12-04','1998-01-01','A',142.04);
INSERT INTO Pedido values ('10730','MARSO',5,'1997-12-06','1998-01-03','A',31.79);
INSERT INTO Pedido values ('10731','CHOPS',7,'1997-12-07','1998-01-04','A',152.71);
INSERT INTO Pedido values ('10734','GOURL',2,'1997-12-08','1998-01-05','M',2.58);
INSERT INTO Pedido values ('10735','JAIYO',6,'1997-12-11','1998-01-08','T',72.63);
INSERT INTO Pedido values ('10737','VINET',2,'1997-12-12','1998-01-09','T',12.31);
INSERT INTO Pedido values ('10738','SPECD',2,'1997-12-13','1998-01-10','A',4.60);
INSERT INTO Pedido values ('10739','VINET',3,'1997-12-13','1998-01-10','M',17.51);
INSERT INTO Pedido values ('10742','BOTTM',3,'1997-12-15','1998-01-12','A',385.09);
INSERT INTO Pedido values ('10744','VAFFE',6,'1997-12-18','1998-01-15','A',109.32);
INSERT INTO Pedido values ('10747','PICCO',6,'1997-12-20','1998-01-17','A',185.38);
INSERT INTO Pedido values ('10748','SAVEA',3,'1997-12-21','1998-01-18','A',367.43);
INSERT INTO Pedido values ('10751','RICSU',3,'1997-12-25','1998-01-22','M',206.65);
INSERT INTO Pedido values ('10752','NORTS',2,'1997-12-25','1998-01-22','M',2.20);
INSERT INTO Pedido values ('10753','FRANS',3,'1997-12-26','1998-01-23','A',12.17);
INSERT INTO Pedido values ('10754','MAGAA',6,'1997-12-26','1998-01-23','M',3.76);
INSERT INTO Pedido values ('10757','SAVEA',6,'1997-12-28','1998-01-25','A',12.94);
INSERT INTO Pedido values ('10758','RICSU',3,'1997-12-29','1998-01-26','A',218.31);
INSERT INTO Pedido values ('10759','ANATR',3,'1997-12-29','1998-01-26','M',18.94);
INSERT INTO Pedido values ('10761','RATTC',5,'1998-01-02','1998-01-30','T',29.48);
INSERT INTO Pedido values ('10762','MARLA',3,'1998-01-02','1998-01-30','A',519.41);
INSERT INTO Pedido values ('10763','FOLIG',3,'1998-01-03','1998-01-31','M',59.01);
INSERT INTO Pedido values ('10764','ERNSH',6,'1998-01-03','1998-01-31','M',229.81);
INSERT INTO Pedido values ('10765','QUICK',3,'1998-01-04','1998-02-01','M',67.53);
INSERT INTO Pedido values ('10768','AROUT',3,'1998-01-08','1998-02-05','A',231.19);
INSERT INTO Pedido values ('10769','VAFFE',3,'1998-01-08','1998-02-05','A',102.79);
INSERT INTO Pedido values ('10772','LEHMS',3,'1998-01-10','1998-02-07','T',144.22);
INSERT INTO Pedido values ('10775','THECR',7,'1998-01-12','1998-02-09','A',32.00);
INSERT INTO Pedido values ('10777','GOURL',7,'1998-01-15','1998-01-29','T',4.76);
INSERT INTO Pedido values ('10779','MORGK',3,'1998-01-16','1998-02-13','T',91.85);
INSERT INTO Pedido values ('10780','LILAS',2,'1998-01-16','1998-01-30','A',66.57);
INSERT INTO Pedido values ('10781','WARTH',2,'1998-01-17','1998-02-14','M',115.59);
INSERT INTO Pedido values ('10787','LAMAI',2,'1998-01-19','1998-02-02','A',394.89);
INSERT INTO Pedido values ('10790','GOURL',6,'1998-01-22','1998-02-19','A',44.60);
INSERT INTO Pedido values ('10791','FRANK',6,'1998-01-23','1998-02-20','T',26.62);
INSERT INTO Pedido values ('10793','AROUT',3,'1998-01-24','1998-02-21','M',7.14);
INSERT INTO Pedido values ('10794','QUEDE',6,'1998-01-24','1998-02-21','A',33.95);
INSERT INTO Pedido values ('10796','HILAA',3,'1998-01-25','1998-02-22','A',41.90);
INSERT INTO Pedido values ('10797','DRACD',7,'1998-01-25','1998-02-22','T',52.69);
INSERT INTO Pedido values ('10798','ISLAT',2,'1998-01-26','1998-02-23','A',3.68);
INSERT INTO Pedido values ('10804','SEVES',6,'1998-01-30','1998-02-27','T',43.18);
INSERT INTO Pedido values ('10805','THEBI',2,'1998-01-30','1998-02-27','A',375.00);
INSERT INTO Pedido values ('10806','VICTE',3,'1998-01-31','1998-02-28','T',34.93);
INSERT INTO Pedido values ('10808','OLDWO',2,'1998-02-01','1998-02-22','M',71.94);
INSERT INTO Pedido values ('10809','WELLI',7,'1998-02-01','1998-02-15','A',7.69);
INSERT INTO Pedido values ('10810','LAUGB',2,'1998-02-01','1998-02-22','M',6.84);
INSERT INTO Pedido values ('10812','REGGC',5,'1998-02-02','1998-03-01','A',94.45);
INSERT INTO Pedido values ('10814','VICTE',3,'1998-02-05','1998-03-04','M',206.89);
INSERT INTO Pedido values ('10815','SAVEA',2,'1998-02-05','1998-03-04','M',23.10);
INSERT INTO Pedido values ('10817','KOENE',3,'1998-02-06','1998-02-20','A',483.59);
INSERT INTO Pedido values ('10818','MAGAA',7,'1998-02-07','1998-03-06','M',103.46);
INSERT INTO Pedido values ('10819','CACTU',2,'1998-02-07','1998-03-06','M',31.22);
INSERT INTO Pedido values ('10820','RATTC',3,'1998-02-07','1998-03-06','T',59.28);
INSERT INTO Pedido values ('10822','TRAIH',6,'1998-02-08','1998-03-07','M',11.06);
INSERT INTO Pedido values ('10823','LILAS',5,'1998-02-09','1998-03-08','T',259.07);
INSERT INTO Pedido values ('10860','FRANR',3,'1998-03-03','1998-03-28','M',30.43);
INSERT INTO Pedido values ('10865','QUICK',2,'1998-03-04','1998-03-18','A',550.06);
INSERT INTO Pedido values ('10866','BERGS',5,'1998-03-05','1998-04-02','A',172.39);
INSERT INTO Pedido values ('10867','LONEP',6,'1998-03-05','1998-04-16','A',3.05);
INSERT INTO Pedido values ('10868','QUEEN',7,'1998-03-06','1998-04-03','A',302.21);
INSERT INTO Pedido values ('10869','SEVES',5,'1998-03-06','1998-04-03','A',226.38);
INSERT INTO Pedido values ('10870','ZBYSZ',5,'1998-03-06','1998-04-03','M',19.02);
INSERT INTO Pedido values ('10872','GODOS',5,'1998-03-07','1998-04-04','A',277.01);
INSERT INTO Pedido values ('10874','GODOS',5,'1998-03-08','1998-04-05','T',30.94);
INSERT INTO Pedido values ('10876','MARSO',7,'1998-03-11','1998-04-08','M',95.46);
INSERT INTO Pedido values ('10879','WILMK',3,'1998-03-12','1998-04-09','M',13.43);
INSERT INTO Pedido values ('10880','MARLA',7,'1998-03-12','1998-04-23','A',139.06);
INSERT INTO Pedido values ('10885','SUPRD',6,'1998-03-14','1998-04-11','M',8.91);
INSERT INTO Pedido values ('10890','JANLA',7,'1998-03-18','1998-04-15','A',51.76);
INSERT INTO Pedido values ('10891','LEHMS',7,'1998-03-19','1998-04-16','T',32.18);
INSERT INTO Pedido values ('10895','ERNSH',3,'1998-03-20','1998-04-17','A',257.15);
INSERT INTO Pedido values ('10896','MAISD',7,'1998-03-21','1998-04-18','M',51.27);
INSERT INTO Pedido values ('10897','HUNGO',3,'1998-03-21','1998-04-18','A',953.59);
INSERT INTO Pedido values ('10899','LILAS',5,'1998-03-22','1998-04-19','M',1.91);
INSERT INTO Pedido values ('10903','HANAR',3,'1998-03-26','1998-04-23','M',58.00);
INSERT INTO Pedido values ('10904','WHITC',3,'1998-03-26','1998-04-23','M',257.46);
INSERT INTO Pedido values ('10907','SPECD',6,'1998-03-27','1998-04-24','M',14.52);
INSERT INTO Pedido values ('10911','GODOS',3,'1998-03-28','1998-04-25','A',60.34);
INSERT INTO Pedido values ('10912','HUNGO',2,'1998-03-28','1998-04-25','A',917.84);
INSERT INTO Pedido values ('10914','QUEEN',6,'1998-03-29','1998-04-26','A',33.48);
INSERT INTO Pedido values ('10915','MIGAN',2,'1998-03-29','1998-04-26','T',5.55);
INSERT INTO Pedido values ('10918','BOTTM',3,'1998-04-01','1998-04-29','M',77.15);
INSERT INTO Pedido values ('10919','FELIP',2,'1998-04-01','1998-04-29','T',31.28);
INSERT INTO Pedido values ('10922','HANAR',5,'1998-04-02','1998-04-30','M',99.13);
INSERT INTO Pedido values ('10923','LAMAI',7,'1998-04-02','1998-05-14','M',107.85);
INSERT INTO Pedido values ('10924','BERGS',3,'1998-04-03','1998-05-01','T',239.40);
INSERT INTO Pedido values ('10925','HANAR',3,'1998-04-03','1998-05-01','A',3.59);
INSERT INTO Pedido values ('10929','FRANK',6,'1998-04-04','1998-05-02','A',53.61);
INSERT INTO Pedido values ('10933','ISLAT',6,'1998-04-05','1998-05-03','M',85.56);
INSERT INTO Pedido values ('10934','LEHMS',3,'1998-04-08','1998-05-06','M',50.58);
INSERT INTO Pedido values ('10936','GREAL',3,'1998-04-08','1998-05-06','T',53.21);
INSERT INTO Pedido values ('10937','CACTU',7,'1998-04-09','1998-04-23','M',49.79);
INSERT INTO Pedido values ('10938','QUICK',3,'1998-04-09','1998-05-07','T',50.39);
INSERT INTO Pedido values ('10939','MAGAA',2,'1998-04-09','1998-05-07','T',120.60);
INSERT INTO Pedido values ('10941','SAVEA',7,'1998-04-10','1998-05-08','A',633.28);
INSERT INTO Pedido values ('10944','BOTTM',6,'1998-04-11','1998-04-25','M',83.61);
INSERT INTO Pedido values ('10947','BSBEV',3,'1998-04-12','1998-05-10','T',5.15);
INSERT INTO Pedido values ('10948','GODOS',3,'1998-04-12','1998-05-10','M',36.96);
INSERT INTO Pedido values ('10949','BOTTM',2,'1998-04-12','1998-05-10','M',117.62);
INSERT INTO Pedido values ('10954','FELIP',5,'1998-04-16','1998-05-28','A',44.10);
INSERT INTO Pedido values ('10956','BLAUS',6,'1998-04-16','1998-05-28','T',70.55);
INSERT INTO Pedido values ('10958','OCEAN',7,'1998-04-17','1998-05-15','T',78.30);
INSERT INTO Pedido values ('10959','GOURL',6,'1998-04-17','1998-05-29','T',7.87);
INSERT INTO Pedido values ('10960','HILAA',3,'1998-04-18','1998-05-02','A',3.29);
INSERT INTO Pedido values ('10964','SPECD',3,'1998-04-19','1998-05-17','T',138.06);
INSERT INTO Pedido values ('10965','OLDWO',6,'1998-04-19','1998-05-17','M',228.12);
INSERT INTO Pedido values ('10967','TOMSP',2,'1998-04-22','1998-05-20','T',98.31);
INSERT INTO Pedido values ('10971','FRANR',2,'1998-04-23','1998-05-21','T',192.48);
INSERT INTO Pedido values ('10973','LACOR',6,'1998-04-23','1998-05-21','T',23.97);
INSERT INTO Pedido values ('10974','SPLIR',3,'1998-04-24','1998-05-08','M',20.48);
INSERT INTO Pedido values ('10982','BOTTM',2,'1998-04-26','1998-05-24','A',22.14);
INSERT INTO Pedido values ('10983','SAVEA',2,'1998-04-26','1998-05-24','A',1038.91);
INSERT INTO Pedido values ('10985','HUNGO',2,'1998-04-29','1998-05-27','A',144.59);
INSERT INTO Pedido values ('10988','RATTC',3,'1998-04-30','1998-05-28','T',96.60);
INSERT INTO Pedido values ('10989','QUEDE',2,'1998-04-30','1998-05-28','A',54.92);
INSERT INTO Pedido values ('10990','ERNSH',2,'1998-05-01','1998-06-12','M',185.82);
INSERT INTO Pedido values ('10993','MARLA',7,'1998-05-01','1998-05-29','M',13.92);
INSERT INTO Pedido values ('10994','VAFFE',2,'1998-05-02','1998-05-16','M',103.54);
INSERT INTO Pedido values ('10999','HENRP',6,'1998-05-03','1998-05-31','T',152.23);
INSERT INTO Pedido values ('11000','RATTC',2,'1998-05-06','1998-06-03','M',87.09);
INSERT INTO Pedido values ('11001','MARLA',2,'1998-05-06','1998-06-03','A',311.73);
INSERT INTO Pedido values ('11003','THECR',3,'1998-05-06','1998-06-03','M',23.56);
INSERT INTO Pedido values ('11004','MAISD',3,'1998-05-07','1998-06-04','A',70.85);
INSERT INTO Pedido values ('11005','WILMK',2,'1998-05-07','1998-06-04','A',1.19);
INSERT INTO Pedido values ('11006','GREAL',3,'1998-05-07','1998-06-04','T',39.80);
INSERT INTO Pedido values ('11008','ERNSH',7,'1998-05-08','1998-06-05','M',125.55);
INSERT INTO Pedido values ('11009','GODOS',2,'1998-05-08','1998-06-05','A',93.39);
INSERT INTO Pedido values ('11010','REGGC',2,'1998-05-09','1998-06-06','T',45.36);
INSERT INTO Pedido values ('11011','ALFKI',3,'1998-05-09','1998-06-06','A',1.91);
INSERT INTO Pedido values ('11013','ROMEY',2,'1998-05-09','1998-06-06','A',52.12);
INSERT INTO Pedido values ('11015','SANTG',2,'1998-05-10','1998-05-24','T',7.30);
INSERT INTO Pedido values ('11019','RANCH',6,'1998-05-13','1998-06-10','M',5.01);
INSERT INTO Pedido values ('11020','HENRP',2,'1998-05-14','1998-06-11','T',68.41);
INSERT INTO Pedido values ('11021','QUICK',3,'1998-05-14','1998-06-11','A',469.54);
INSERT INTO Pedido values ('11025','WARTH',6,'1998-05-15','1998-06-12','M',46.09);
INSERT INTO Pedido values ('11028','KOENE',2,'1998-05-16','1998-06-13','A',46.75);
INSERT INTO Pedido values ('11030','SAVEA',7,'1998-05-17','1998-06-14','A',1312.59);
INSERT INTO Pedido values ('11031','SAVEA',6,'1998-05-17','1998-06-14','A',359.01);
INSERT INTO Pedido values ('11032','WHITC',2,'1998-05-17','1998-06-14','A',957.78);
INSERT INTO Pedido values ('11033','RICSU',7,'1998-05-17','1998-06-14','M',133.89);
INSERT INTO Pedido values ('11035','SUPRD',2,'1998-05-20','1998-06-17','T',0.27);
INSERT INTO Pedido values ('11037','GODOS',7,'1998-05-21','1998-06-18','A',5.06);
INSERT INTO Pedido values ('11041','CHOPS',3,'1998-05-22','1998-06-19','T',76.19);
INSERT INTO Pedido values ('11042','COMMI',2,'1998-05-22','1998-06-05','A',47.38);
INSERT INTO Pedido values ('11043','SPECD',5,'1998-05-22','1998-06-19','T',13.90);
INSERT INTO Pedido values ('11045','BOTTM',6,'1998-05-23','1998-06-20','T',111.52);
INSERT INTO Pedido values ('11047','EASTC',7,'1998-05-24','1998-06-21','M',73.66);
INSERT INTO Pedido values ('11048','BOTTM',7,'1998-05-24','1998-06-21','M',38.11);
INSERT INTO Pedido values ('11049','GOURL',3,'1998-05-24','1998-06-21','A',13.18);
INSERT INTO Pedido values ('11051','LAMAI',7,'1998-05-27','1998-06-24','M',4.41);
INSERT INTO Pedido values ('11052','HANAR',3,'1998-05-27','1998-06-24','A',106.27);
INSERT INTO Pedido values ('11053','PICCO',2,'1998-05-27','1998-06-24','T',83.82);
INSERT INTO Pedido values ('11055','HILAA',7,'1998-05-28','1998-06-25','T',191.05);
INSERT INTO Pedido values ('11057','NORTS',3,'1998-05-29','1998-06-26','M',6.53);
INSERT INTO Pedido values ('11059','RICAR',2,'1998-05-29','1998-07-10','T',135.56);
INSERT INTO Pedido values ('11060','FRANS',2,'1998-05-30','1998-06-27','T',17.35);
INSERT INTO Pedido values ('11063','HUNGO',3,'1998-05-30','1998-06-27','T',129.13);
INSERT INTO Pedido values ('11066','WHITC',7,'1998-05-31','1998-06-28','T',70.66);
INSERT INTO Pedido values ('11070','LEHMS',2,'1998-06-04','1998-07-02','A',214.88);
INSERT INTO Pedido values ('11073','PERIC',2,'1998-06-04','1998-07-02','T',39.42);
INSERT INTO Pedido values ('11074','JYTPE',7,'1998-06-05','1998-07-03','T',29.14);

/*** Inserção de dados na tabela Itens ***/
INSERT INTO Itens VALUES (10248,11,'14',12,0);
INSERT INTO Itens VALUES (10248,42,'9.8',10,0);
INSERT INTO Itens VALUES (10248,72,'34.8',5,0);
INSERT INTO Itens VALUES (10249,14,'18.6',9,0);
INSERT INTO Itens VALUES (10249,51,'42.4',40,0);
INSERT INTO Itens VALUES (10251,22,'16.8',6,5);
INSERT INTO Itens VALUES (10251,57,'15.6',15,5);
INSERT INTO Itens VALUES (10251,65,'16.8',20,0);
INSERT INTO Itens VALUES (10253,31,'10',20,0);
INSERT INTO Itens VALUES (10253,39,'14.4',42,0);
INSERT INTO Itens VALUES (10253,49,'16',40,0);
INSERT INTO Itens VALUES (10254,24,'3.6',15,15);
INSERT INTO Itens VALUES (10254,55,'19.2',21,15);
INSERT INTO Itens VALUES (10254,74,'8',21,0);
INSERT INTO Itens VALUES (10256,53,'26.2',15,0);
INSERT INTO Itens VALUES (10256,77,'10.4',12,0);
INSERT INTO Itens VALUES (10264,2,'15.2',35,0);
INSERT INTO Itens VALUES (10265,17,'31.2',30,0);
INSERT INTO Itens VALUES (10265,70,'12',20,0);
INSERT INTO Itens VALUES (10269,33,'2',60,5);
INSERT INTO Itens VALUES (10269,72,'27.8',20,5);
INSERT INTO Itens VALUES (10271,33,'2',24,0);
INSERT INTO Itens VALUES (10272,20,'64.8',6,0);
INSERT INTO Itens VALUES (10272,31,'10',40,0);
INSERT INTO Itens VALUES (10272,72,'27.8',24,0);
INSERT INTO Itens VALUES (10273,10,'24.8',24,5);
INSERT INTO Itens VALUES (10273,31,'10',15,5);
INSERT INTO Itens VALUES (10273,33,'2',20,0);
INSERT INTO Itens VALUES (10273,40,'14.7',60,5);
INSERT INTO Itens VALUES (10274,71,'17.2',20,0);
INSERT INTO Itens VALUES (10274,72,'27.8',7,0);
INSERT INTO Itens VALUES (10277,28,'36.4',20,0);
INSERT INTO Itens VALUES (10277,62,'39.4',12,0);
INSERT INTO Itens VALUES (10280,24,'3.6',12,0);
INSERT INTO Itens VALUES (10280,55,'19.2',20,0);
INSERT INTO Itens VALUES (10280,75,'6.2',30,0);
INSERT INTO Itens VALUES (10283,15,'12.4',20,0);
INSERT INTO Itens VALUES (10283,19,'7.3',18,0);
INSERT INTO Itens VALUES (10283,60,'27.2',35,0);
INSERT INTO Itens VALUES (10283,72,'27.8',3,0);
INSERT INTO Itens VALUES (10289,3,'8',30,0);
INSERT INTO Itens VALUES (10291,13,'4.8',20,10);
INSERT INTO Itens VALUES (10291,44,'15.5',24,10);
INSERT INTO Itens VALUES (10291,51,'42.4',2,10);
INSERT INTO Itens VALUES (10295,56,'30.4',4,0);
INSERT INTO Itens VALUES (10296,11,'16.8',12,0);
INSERT INTO Itens VALUES (10296,16,'13.9',30,0);
INSERT INTO Itens VALUES (10296,69,'28.8',15,0);
INSERT INTO Itens VALUES (10297,39,'14.4',60,0);
INSERT INTO Itens VALUES (10297,72,'27.8',20,0);
INSERT INTO Itens VALUES (10298,2,'15.2',40,0);
INSERT INTO Itens VALUES (10298,36,'15.2',40,25);
INSERT INTO Itens VALUES (10298,59,'44',30,25);
INSERT INTO Itens VALUES (10298,62,'39.4',15,0);
INSERT INTO Itens VALUES (10300,66,'13.6',30,0);
INSERT INTO Itens VALUES (10300,68,'10',20,0);
INSERT INTO Itens VALUES (10303,40,'14.7',40,10);
INSERT INTO Itens VALUES (10303,65,'16.8',30,10);
INSERT INTO Itens VALUES (10303,68,'10',15,10);
INSERT INTO Itens VALUES (10307,62,'39.4',10,0);
INSERT INTO Itens VALUES (10307,68,'10',3,0);
INSERT INTO Itens VALUES (10308,69,'28.8',1,0);
INSERT INTO Itens VALUES (10308,70,'12',5,0);
INSERT INTO Itens VALUES (10309,4,'17.6',20,0);
INSERT INTO Itens VALUES (10309,6,'20',30,0);
INSERT INTO Itens VALUES (10309,42,'11.2',2,0);
INSERT INTO Itens VALUES (10309,43,'36.8',20,0);
INSERT INTO Itens VALUES (10309,71,'17.2',3,0);
INSERT INTO Itens VALUES (10312,28,'36.4',4,0);
INSERT INTO Itens VALUES (10312,43,'36.8',24,0);
INSERT INTO Itens VALUES (10312,53,'26.2',20,0);
INSERT INTO Itens VALUES (10312,75,'6.2',10,0);
INSERT INTO Itens VALUES (10313,36,'15.2',12,0);
INSERT INTO Itens VALUES (10317,1,'14.4',20,0);
INSERT INTO Itens VALUES (10319,17,'31.2',8,0);
INSERT INTO Itens VALUES (10319,28,'36.4',14,0);
INSERT INTO Itens VALUES (10320,71,'17.2',30,0);
INSERT INTO Itens VALUES (10321,35,'14.4',10,0);
INSERT INTO Itens VALUES (10322,52,'5.6',20,0);
INSERT INTO Itens VALUES (10327,2,'15.2',25,20);
INSERT INTO Itens VALUES (10327,11,'16.8',50,20);
INSERT INTO Itens VALUES (10327,30,'20.7',35,20);
INSERT INTO Itens VALUES (10327,58,'10.6',30,20);
INSERT INTO Itens VALUES (10330,26,'24.9',50,15);
INSERT INTO Itens VALUES (10330,72,'27.8',25,15);
INSERT INTO Itens VALUES (10332,18,'50',40,20);
INSERT INTO Itens VALUES (10332,42,'11.2',10,20);
INSERT INTO Itens VALUES (10332,47,'7.6',16,20);
INSERT INTO Itens VALUES (10333,14,'18.6',10,0);
INSERT INTO Itens VALUES (10333,21,'8',10,10);
INSERT INTO Itens VALUES (10333,71,'17.2',40,10);
INSERT INTO Itens VALUES (10335,2,'15.2',7,20);
INSERT INTO Itens VALUES (10335,31,'10',25,20);
INSERT INTO Itens VALUES (10335,32,'25.6',6,20);
INSERT INTO Itens VALUES (10335,51,'42.4',48,20);
INSERT INTO Itens VALUES (10336,4,'17.6',18,10);
INSERT INTO Itens VALUES (10339,4,'17.6',10,0);
INSERT INTO Itens VALUES (10339,17,'31.2',70,5);
INSERT INTO Itens VALUES (10339,62,'39.4',28,0);
INSERT INTO Itens VALUES (10341,33,'2',8,0);
INSERT INTO Itens VALUES (10341,59,'44',9,15);
INSERT INTO Itens VALUES (10345,8,'32',70,0);
INSERT INTO Itens VALUES (10345,19,'7.3',80,0);
INSERT INTO Itens VALUES (10345,42,'11.2',9,0);
INSERT INTO Itens VALUES (10346,17,'31.2',36,10);
INSERT INTO Itens VALUES (10346,56,'30.4',20,0);
INSERT INTO Itens VALUES (10349,54,'5.9',24,0);
INSERT INTO Itens VALUES (10350,50,'13',15,10);
INSERT INTO Itens VALUES (10350,69,'28.8',18,10);
INSERT INTO Itens VALUES (10352,24,'3.6',10,0);
INSERT INTO Itens VALUES (10352,54,'5.9',20,15);
INSERT INTO Itens VALUES (10353,11,'16.8',12,20);
INSERT INTO Itens VALUES (10355,24,'3.6',25,0);
INSERT INTO Itens VALUES (10355,57,'15.6',25,0);
INSERT INTO Itens VALUES (10356,31,'10',30,0);
INSERT INTO Itens VALUES (10356,55,'19.2',12,0);
INSERT INTO Itens VALUES (10356,69,'28.8',20,0);
INSERT INTO Itens VALUES (10358,24,'3.6',10,5);
INSERT INTO Itens VALUES (10358,34,'11.2',10,5);
INSERT INTO Itens VALUES (10358,36,'15.2',20,5);
INSERT INTO Itens VALUES (10359,16,'13.9',56,5);
INSERT INTO Itens VALUES (10359,31,'10',70,5);
INSERT INTO Itens VALUES (10359,60,'27.2',80,5);
INSERT INTO Itens VALUES (10362,25,'11.2',50,0);
INSERT INTO Itens VALUES (10362,51,'42.4',20,0);
INSERT INTO Itens VALUES (10362,54,'5.9',24,0);
INSERT INTO Itens VALUES (10365,11,'16.8',24,0);
INSERT INTO Itens VALUES (10367,34,'11.2',36,0);
INSERT INTO Itens VALUES (10367,54,'5.9',18,0);
INSERT INTO Itens VALUES (10367,65,'16.8',15,0);
INSERT INTO Itens VALUES (10367,77,'10.4',7,0);
INSERT INTO Itens VALUES (10368,21,'8',5,10);
INSERT INTO Itens VALUES (10368,28,'36.4',13,10);
INSERT INTO Itens VALUES (10368,57,'15.6',25,0);
INSERT INTO Itens VALUES (10370,1,'14.4',15,15);
INSERT INTO Itens VALUES (10370,74,'8',20,15);
INSERT INTO Itens VALUES (10372,20,'64.8',12,25);
INSERT INTO Itens VALUES (10372,60,'27.2',70,25);
INSERT INTO Itens VALUES (10372,72,'27.8',42,25);
INSERT INTO Itens VALUES (10375,14,'18.6',15,0);
INSERT INTO Itens VALUES (10375,54,'5.9',10,0);
INSERT INTO Itens VALUES (10378,71,'17.2',6,0);
INSERT INTO Itens VALUES (10379,63,'35.1',16,10);
INSERT INTO Itens VALUES (10379,65,'16.8',20,10);
INSERT INTO Itens VALUES (10381,74,'8',14,0);
INSERT INTO Itens VALUES (10384,20,'64.8',28,0);
INSERT INTO Itens VALUES (10384,60,'27.2',15,0);
INSERT INTO Itens VALUES (10388,45,'7.6',15,20);
INSERT INTO Itens VALUES (10388,52,'5.6',20,20);
INSERT INTO Itens VALUES (10388,53,'26.2',40,0);
INSERT INTO Itens VALUES (10390,31,'10',60,10);
INSERT INTO Itens VALUES (10390,35,'14.4',40,10);
INSERT INTO Itens VALUES (10390,46,'9.6',45,0);
INSERT INTO Itens VALUES (10390,72,'27.8',24,10);
INSERT INTO Itens VALUES (10391,13,'4.8',18,0);
INSERT INTO Itens VALUES (10392,69,'28.8',50,0);
INSERT INTO Itens VALUES (10395,46,'9.6',28,10);
INSERT INTO Itens VALUES (10395,53,'26.2',70,10);
INSERT INTO Itens VALUES (10395,69,'28.8',8,0);
INSERT INTO Itens VALUES (10397,21,'8',10,15);
INSERT INTO Itens VALUES (10397,51,'42.4',18,15);
INSERT INTO Itens VALUES (10398,35,'14.4',30,0);
INSERT INTO Itens VALUES (10398,55,'19.2',120,10);
INSERT INTO Itens VALUES (10404,26,'24.9',30,5);
INSERT INTO Itens VALUES (10404,42,'11.2',40,5);
INSERT INTO Itens VALUES (10404,49,'16',30,5);
INSERT INTO Itens VALUES (10406,1,'14.4',10,0);
INSERT INTO Itens VALUES (10406,21,'8',30,10);
INSERT INTO Itens VALUES (10406,28,'36.4',42,10);
INSERT INTO Itens VALUES (10406,36,'15.2',5,10);
INSERT INTO Itens VALUES (10406,40,'14.7',2,10);
INSERT INTO Itens VALUES (10407,11,'16.8',30,0);
INSERT INTO Itens VALUES (10407,69,'28.8',15,0);
INSERT INTO Itens VALUES (10407,71,'17.2',15,0);
INSERT INTO Itens VALUES (10409,14,'18.6',12,0);
INSERT INTO Itens VALUES (10409,21,'8',12,0);
INSERT INTO Itens VALUES (10410,33,'2',49,0);
INSERT INTO Itens VALUES (10410,59,'44',16,0);
INSERT INTO Itens VALUES (10413,1,'14.4',24,0);
INSERT INTO Itens VALUES (10413,62,'39.4',40,0);
INSERT INTO Itens VALUES (10414,19,'7.3',18,5);
INSERT INTO Itens VALUES (10414,33,'2',50,0);
INSERT INTO Itens VALUES (10415,17,'31.2',2,0);
INSERT INTO Itens VALUES (10415,33,'2',20,0);
INSERT INTO Itens VALUES (10420,9,'77.6',20,10);
INSERT INTO Itens VALUES (10420,13,'4.8',2,10);
INSERT INTO Itens VALUES (10420,70,'12',8,10);
INSERT INTO Itens VALUES (10420,73,'12',20,10);
INSERT INTO Itens VALUES (10422,26,'24.9',2,0);
INSERT INTO Itens VALUES (10423,31,'10',14,0);
INSERT INTO Itens VALUES (10423,59,'44',20,0);
INSERT INTO Itens VALUES (10424,35,'14.4',60,20);
INSERT INTO Itens VALUES (10424,68,'10',30,20);
INSERT INTO Itens VALUES (10425,55,'19.2',10,25);
INSERT INTO Itens VALUES (10428,46,'9.6',20,0);
INSERT INTO Itens VALUES (10429,50,'13',40,0);
INSERT INTO Itens VALUES (10429,63,'35.1',35,25);
INSERT INTO Itens VALUES (10432,26,'24.9',10,0);
INSERT INTO Itens VALUES (10432,54,'5.9',40,0);
INSERT INTO Itens VALUES (10433,56,'30.4',28,0);
INSERT INTO Itens VALUES (10434,11,'16.8',6,0);
INSERT INTO Itens VALUES (10436,46,'9.6',5,0);
INSERT INTO Itens VALUES (10436,56,'30.4',40,10);
INSERT INTO Itens VALUES (10436,75,'6.2',24,10);
INSERT INTO Itens VALUES (10438,19,'7.3',15,20);
INSERT INTO Itens VALUES (10438,34,'11.2',20,20);
INSERT INTO Itens VALUES (10438,57,'15.6',15,20);
INSERT INTO Itens VALUES (10439,16,'13.9',16,0);
INSERT INTO Itens VALUES (10439,74,'8',30,0);
INSERT INTO Itens VALUES (10441,27,'35.1',50,0);
INSERT INTO Itens VALUES (10442,11,'16.8',30,0);
INSERT INTO Itens VALUES (10442,54,'5.9',80,0);
INSERT INTO Itens VALUES (10442,66,'13.6',60,0);
INSERT INTO Itens VALUES (10444,17,'31.2',10,0);
INSERT INTO Itens VALUES (10444,26,'24.9',15,0);
INSERT INTO Itens VALUES (10444,35,'14.4',8,0);
INSERT INTO Itens VALUES (10445,39,'14.4',6,0);
INSERT INTO Itens VALUES (10445,54,'5.9',15,0);
INSERT INTO Itens VALUES (10446,19,'7.3',12,10);
INSERT INTO Itens VALUES (10446,24,'3.6',20,10);
INSERT INTO Itens VALUES (10446,31,'10',3,10);
INSERT INTO Itens VALUES (10446,52,'5.6',15,10);
INSERT INTO Itens VALUES (10449,10,'24.8',14,0);
INSERT INTO Itens VALUES (10449,52,'5.6',20,0);
INSERT INTO Itens VALUES (10449,62,'39.4',35,0);
INSERT INTO Itens VALUES (10457,59,'44',36,0);
INSERT INTO Itens VALUES (10458,26,'24.9',30,0);
INSERT INTO Itens VALUES (10458,28,'36.4',30,0);
INSERT INTO Itens VALUES (10458,43,'36.8',20,0);
INSERT INTO Itens VALUES (10458,56,'30.4',15,0);
INSERT INTO Itens VALUES (10458,71,'17.2',50,0);
INSERT INTO Itens VALUES (10462,13,'4.8',1,0);
INSERT INTO Itens VALUES (10462,23,'7.2',21,0);
INSERT INTO Itens VALUES (10463,19,'7.3',21,0);
INSERT INTO Itens VALUES (10463,42,'11.2',50,0);
INSERT INTO Itens VALUES (10468,30,'20.7',8,0);
INSERT INTO Itens VALUES (10468,43,'36.8',15,0);
INSERT INTO Itens VALUES (10471,7,'24',30,0);
INSERT INTO Itens VALUES (10471,56,'30.4',20,0);
INSERT INTO Itens VALUES (10474,14,'18.6',12,0);
INSERT INTO Itens VALUES (10474,28,'36.4',18,0);
INSERT INTO Itens VALUES (10474,40,'14.7',21,0);
INSERT INTO Itens VALUES (10474,75,'6.2',10,0);
INSERT INTO Itens VALUES (10477,1,'14.4',15,0);
INSERT INTO Itens VALUES (10477,21,'8',21,25);
INSERT INTO Itens VALUES (10477,39,'14.4',20,25);
INSERT INTO Itens VALUES (10478,10,'24.8',20,5);
INSERT INTO Itens VALUES (10479,53,'26.2',28,0);
INSERT INTO Itens VALUES (10479,59,'44',60,0);
INSERT INTO Itens VALUES (10480,47,'7.6',30,0);
INSERT INTO Itens VALUES (10480,59,'44',12,0);
INSERT INTO Itens VALUES (10483,34,'11.2',35,5);
INSERT INTO Itens VALUES (10483,77,'10.4',30,5);
INSERT INTO Itens VALUES (10484,21,'8',14,0);
INSERT INTO Itens VALUES (10484,40,'14.7',10,0);
INSERT INTO Itens VALUES (10484,51,'42.4',3,0);
INSERT INTO Itens VALUES (10487,19,'7.3',5,0);
INSERT INTO Itens VALUES (10487,26,'24.9',30,0);
INSERT INTO Itens VALUES (10487,54,'5.9',24,25);
INSERT INTO Itens VALUES (10489,11,'16.8',15,25);
INSERT INTO Itens VALUES (10489,16,'13.9',18,0);
INSERT INTO Itens VALUES (10490,59,'44',60,0);
INSERT INTO Itens VALUES (10490,68,'10',30,0);
INSERT INTO Itens VALUES (10490,75,'6.2',36,0);
INSERT INTO Itens VALUES (10492,25,'11.2',60,5);
INSERT INTO Itens VALUES (10492,42,'11.2',20,5);
INSERT INTO Itens VALUES (10495,23,'7.2',10,0);
INSERT INTO Itens VALUES (10495,77,'10.4',5,0);
INSERT INTO Itens VALUES (10496,31,'10',20,5);
INSERT INTO Itens VALUES (10497,56,'30.4',14,0);
INSERT INTO Itens VALUES (10497,72,'27.8',25,0);
INSERT INTO Itens VALUES (10497,77,'10.4',25,0);
INSERT INTO Itens VALUES (10500,15,'15.5',12,5);
INSERT INTO Itens VALUES (10500,28,'45.6',8,5);
INSERT INTO Itens VALUES (10502,45,'9.5',21,0);
INSERT INTO Itens VALUES (10502,53,'32.8',6,0);
INSERT INTO Itens VALUES (10502,67,'14',30,0);
INSERT INTO Itens VALUES (10503,14,'23.25',70,0);
INSERT INTO Itens VALUES (10503,65,'21.05',20,0);
INSERT INTO Itens VALUES (10505,62,'49.3',3,0);
INSERT INTO Itens VALUES (10507,43,'46',15,15);
INSERT INTO Itens VALUES (10507,48,'12.75',15,15);
INSERT INTO Itens VALUES (10510,29,'123.79',36,0);
INSERT INTO Itens VALUES (10510,75,'7.75',36,10);
INSERT INTO Itens VALUES (10512,24,'4.5',10,15);
INSERT INTO Itens VALUES (10512,46,'12',9,15);
INSERT INTO Itens VALUES (10512,47,'9.5',6,15);
INSERT INTO Itens VALUES (10512,60,'34',12,15);
INSERT INTO Itens VALUES (10513,21,'10',40,20);
INSERT INTO Itens VALUES (10513,32,'32',50,20);
INSERT INTO Itens VALUES (10513,61,'28.5',15,20);
INSERT INTO Itens VALUES (10514,20,'81',39,0);
INSERT INTO Itens VALUES (10514,28,'45.6',35,0);
INSERT INTO Itens VALUES (10514,56,'38',70,0);
INSERT INTO Itens VALUES (10514,65,'21.05',39,0);
INSERT INTO Itens VALUES (10514,75,'7.75',50,0);
INSERT INTO Itens VALUES (10515,9,'97',16,15);
INSERT INTO Itens VALUES (10515,16,'17.45',50,0);
INSERT INTO Itens VALUES (10515,27,'43.9',120,0);
INSERT INTO Itens VALUES (10515,33,'2.5',16,15);
INSERT INTO Itens VALUES (10515,60,'34',84,15);
INSERT INTO Itens VALUES (10516,18,'62.5',25,10);
INSERT INTO Itens VALUES (10516,42,'14',20,0);
INSERT INTO Itens VALUES (10517,52,'7',6,0);
INSERT INTO Itens VALUES (10517,59,'55',4,0);
INSERT INTO Itens VALUES (10517,70,'15',6,0);
INSERT INTO Itens VALUES (10519,10,'31',16,5);
INSERT INTO Itens VALUES (10519,56,'38',40,0);
INSERT INTO Itens VALUES (10519,60,'34',10,5);
INSERT INTO Itens VALUES (10520,24,'4.5',8,0);
INSERT INTO Itens VALUES (10520,53,'32.8',5,0);
INSERT INTO Itens VALUES (10523,17,'39',25,10);
INSERT INTO Itens VALUES (10523,20,'81',15,10);
INSERT INTO Itens VALUES (10523,37,'26',18,10);
INSERT INTO Itens VALUES (10527,4,'22',50,10);
INSERT INTO Itens VALUES (10527,36,'19',30,10);
INSERT INTO Itens VALUES (10528,11,'21',3,0);
INSERT INTO Itens VALUES (10528,33,'2.5',8,20);
INSERT INTO Itens VALUES (10528,72,'34.8',9,0);
INSERT INTO Itens VALUES (10529,55,'24',14,0);
INSERT INTO Itens VALUES (10529,68,'12.5',20,0);
INSERT INTO Itens VALUES (10529,69,'36',10,0);
INSERT INTO Itens VALUES (10530,17,'39',40,0);
INSERT INTO Itens VALUES (10530,43,'46',25,0);
INSERT INTO Itens VALUES (10530,61,'28.5',20,0);
INSERT INTO Itens VALUES (10531,59,'55',2,0);
INSERT INTO Itens VALUES (10532,30,'25.89',15,0);
INSERT INTO Itens VALUES (10532,66,'17',24,0);
INSERT INTO Itens VALUES (10536,31,'12.5',20,0);
INSERT INTO Itens VALUES (10536,33,'2.5',30,0);
INSERT INTO Itens VALUES (10536,60,'34',35,25);
INSERT INTO Itens VALUES (10539,13,'6',8,0);
INSERT INTO Itens VALUES (10539,21,'10',15,0);
INSERT INTO Itens VALUES (10539,33,'2.5',15,0);
INSERT INTO Itens VALUES (10539,49,'20',6,0);
INSERT INTO Itens VALUES (10540,3,'10',60,0);
INSERT INTO Itens VALUES (10540,26,'31.23',40,0);
INSERT INTO Itens VALUES (10540,68,'12.5',35,0);
INSERT INTO Itens VALUES (10541,24,'4.5',35,10);
INSERT INTO Itens VALUES (10541,65,'21.05',36,10);
INSERT INTO Itens VALUES (10541,71,'21.5',9,10);
INSERT INTO Itens VALUES (10547,32,'32',24,15);
INSERT INTO Itens VALUES (10547,36,'19',60,0);
INSERT INTO Itens VALUES (10548,34,'14',10,25);
INSERT INTO Itens VALUES (10549,31,'12.5',55,15);
INSERT INTO Itens VALUES (10549,45,'9.5',100,15);
INSERT INTO Itens VALUES (10549,51,'53',48,15);
INSERT INTO Itens VALUES (10550,17,'39',8,10);
INSERT INTO Itens VALUES (10550,19,'9.2',10,0);
INSERT INTO Itens VALUES (10550,21,'10',6,10);
INSERT INTO Itens VALUES (10550,61,'28.5',10,10);
INSERT INTO Itens VALUES (10552,69,'36',18,0);
INSERT INTO Itens VALUES (10552,75,'7.75',30,0);
INSERT INTO Itens VALUES (10553,11,'21',15,0);
INSERT INTO Itens VALUES (10553,16,'17.45',14,0);
INSERT INTO Itens VALUES (10553,22,'21',24,0);
INSERT INTO Itens VALUES (10553,31,'12.5',30,0);
INSERT INTO Itens VALUES (10553,35,'18',6,0);
INSERT INTO Itens VALUES (10555,14,'23.25',30,20);
INSERT INTO Itens VALUES (10555,19,'9.2',35,20);
INSERT INTO Itens VALUES (10555,24,'4.5',18,20);
INSERT INTO Itens VALUES (10555,51,'53',20,20);
INSERT INTO Itens VALUES (10555,56,'38',40,20);
INSERT INTO Itens VALUES (10556,72,'34.8',24,0);
INSERT INTO Itens VALUES (10559,55,'24',18,5);
INSERT INTO Itens VALUES (10561,44,'19.45',10,0);
INSERT INTO Itens VALUES (10561,51,'53',50,0);
INSERT INTO Itens VALUES (10563,36,'19',25,0);
INSERT INTO Itens VALUES (10563,52,'7',70,0);
INSERT INTO Itens VALUES (10568,10,'31',5,0);
INSERT INTO Itens VALUES (10569,31,'12.5',35,20);
INSERT INTO Itens VALUES (10570,11,'21',15,5);
INSERT INTO Itens VALUES (10570,56,'38',60,5);
INSERT INTO Itens VALUES (10572,16,'17.45',12,10);
INSERT INTO Itens VALUES (10572,32,'32',10,10);
INSERT INTO Itens VALUES (10572,40,'18.4',50,0);
INSERT INTO Itens VALUES (10572,75,'7.75',15,10);
INSERT INTO Itens VALUES (10573,17,'39',18,0);
INSERT INTO Itens VALUES (10573,34,'14',40,0);
INSERT INTO Itens VALUES (10573,53,'32.8',25,0);
INSERT INTO Itens VALUES (10575,59,'55',12,0);
INSERT INTO Itens VALUES (10575,63,'43.9',6,0);
INSERT INTO Itens VALUES (10575,72,'34.8',30,0);
INSERT INTO Itens VALUES (10576,1,'18',10,0);
INSERT INTO Itens VALUES (10576,31,'12.5',20,0);
INSERT INTO Itens VALUES (10576,44,'19.45',21,0);
INSERT INTO Itens VALUES (10581,75,'7.75',50,20);
INSERT INTO Itens VALUES (10582,57,'19.5',4,0);
INSERT INTO Itens VALUES (10583,29,'123.79',10,0);
INSERT INTO Itens VALUES (10583,60,'34',24,15);
INSERT INTO Itens VALUES (10583,69,'36',10,15);
INSERT INTO Itens VALUES (10585,47,'9.5',15,0);
INSERT INTO Itens VALUES (10588,18,'62.5',40,20);
INSERT INTO Itens VALUES (10588,42,'14',100,20);
INSERT INTO Itens VALUES (10592,15,'15.5',25,5);
INSERT INTO Itens VALUES (10592,26,'31.23',5,5);
INSERT INTO Itens VALUES (10593,20,'81',21,20);
INSERT INTO Itens VALUES (10593,69,'36',20,20);
INSERT INTO Itens VALUES (10594,52,'7',24,0);
INSERT INTO Itens VALUES (10594,58,'13.25',30,0);
INSERT INTO Itens VALUES (10595,35,'18',30,25);
INSERT INTO Itens VALUES (10595,61,'28.5',120,25);
INSERT INTO Itens VALUES (10595,69,'36',65,25);
INSERT INTO Itens VALUES (10597,24,'4.5',35,20);
INSERT INTO Itens VALUES (10597,57,'19.5',20,0);
INSERT INTO Itens VALUES (10597,65,'21.05',12,20);
INSERT INTO Itens VALUES (10599,62,'49.3',10,0);
INSERT INTO Itens VALUES (10601,13,'6',60,0);
INSERT INTO Itens VALUES (10601,59,'55',35,0);
INSERT INTO Itens VALUES (10607,7,'30',45,0);
INSERT INTO Itens VALUES (10607,17,'39',100,0);
INSERT INTO Itens VALUES (10607,33,'2.5',14,0);
INSERT INTO Itens VALUES (10607,40,'18.4',42,0);
INSERT INTO Itens VALUES (10607,72,'34.8',12,0);
INSERT INTO Itens VALUES (10609,1,'18',3,0);
INSERT INTO Itens VALUES (10609,10,'31',10,0);
INSERT INTO Itens VALUES (10609,21,'10',6,0);
INSERT INTO Itens VALUES (10611,1,'18',6,0);
INSERT INTO Itens VALUES (10611,2,'19',10,0);
INSERT INTO Itens VALUES (10611,60,'34',15,0);
INSERT INTO Itens VALUES (10615,55,'24',5,0);
INSERT INTO Itens VALUES (10619,21,'10',42,0);
INSERT INTO Itens VALUES (10619,22,'21',40,0);
INSERT INTO Itens VALUES (10620,24,'4.5',5,0);
INSERT INTO Itens VALUES (10620,52,'7',5,0);
INSERT INTO Itens VALUES (10625,14,'23.25',3,0);
INSERT INTO Itens VALUES (10625,42,'14',5,0);
INSERT INTO Itens VALUES (10625,60,'34',10,0);
INSERT INTO Itens VALUES (10633,13,'6',13,15);
INSERT INTO Itens VALUES (10633,26,'31.23',35,15);
INSERT INTO Itens VALUES (10633,62,'49.3',80,15);
INSERT INTO Itens VALUES (10637,11,'21',10,0);
INSERT INTO Itens VALUES (10637,50,'16.25',25,5);
INSERT INTO Itens VALUES (10637,56,'38',60,5);
INSERT INTO Itens VALUES (10638,45,'9.5',20,0);
INSERT INTO Itens VALUES (10638,65,'21.05',21,0);
INSERT INTO Itens VALUES (10638,72,'34.8',60,0);
INSERT INTO Itens VALUES (10639,18,'62.5',8,0);
INSERT INTO Itens VALUES (10642,21,'10',30,20);
INSERT INTO Itens VALUES (10642,61,'28.5',20,20);
INSERT INTO Itens VALUES (10643,28,'45.6',15,25);
INSERT INTO Itens VALUES (10643,39,'18',21,25);
INSERT INTO Itens VALUES (10643,46,'12',2,25);
INSERT INTO Itens VALUES (10644,18,'62.5',4,10);
INSERT INTO Itens VALUES (10644,43,'46',20,0);
INSERT INTO Itens VALUES (10644,46,'12',21,10);
INSERT INTO Itens VALUES (10648,22,'21',15,0);
INSERT INTO Itens VALUES (10648,24,'4.5',15,15);
INSERT INTO Itens VALUES (10649,28,'45.6',20,0);
INSERT INTO Itens VALUES (10649,72,'34.8',15,0);
INSERT INTO Itens VALUES (10650,30,'25.89',30,0);
INSERT INTO Itens VALUES (10650,53,'32.8',25,5);
INSERT INTO Itens VALUES (10650,54,'7.45',30,0);
INSERT INTO Itens VALUES (10654,4,'22',12,10);
INSERT INTO Itens VALUES (10654,39,'18',20,10);
INSERT INTO Itens VALUES (10654,54,'7.45',6,10);
INSERT INTO Itens VALUES (10656,14,'23.25',3,10);
INSERT INTO Itens VALUES (10656,44,'19.45',28,10);
INSERT INTO Itens VALUES (10656,47,'9.5',6,10);
INSERT INTO Itens VALUES (10657,15,'15.5',50,0);
INSERT INTO Itens VALUES (10657,46,'12',45,0);
INSERT INTO Itens VALUES (10657,47,'9.5',10,0);
INSERT INTO Itens VALUES (10657,56,'38',45,0);
INSERT INTO Itens VALUES (10657,60,'34',30,0);
INSERT INTO Itens VALUES (10659,31,'12.5',20,5);
INSERT INTO Itens VALUES (10659,40,'18.4',24,5);
INSERT INTO Itens VALUES (10659,70,'15',40,5);
INSERT INTO Itens VALUES (10661,39,'18',3,20);
INSERT INTO Itens VALUES (10661,58,'13.25',49,20);
INSERT INTO Itens VALUES (10662,68,'12.5',10,0);
INSERT INTO Itens VALUES (10663,40,'18.4',30,5);
INSERT INTO Itens VALUES (10663,42,'14',30,5);
INSERT INTO Itens VALUES (10663,51,'53',20,5);
INSERT INTO Itens VALUES (10666,29,'123.79',36,0);
INSERT INTO Itens VALUES (10666,65,'21.05',10,0);
INSERT INTO Itens VALUES (10667,69,'36',45,20);
INSERT INTO Itens VALUES (10667,71,'21.5',14,20);
INSERT INTO Itens VALUES (10669,36,'19',30,0);
INSERT INTO Itens VALUES (10673,16,'17.45',3,0);
INSERT INTO Itens VALUES (10673,42,'14',6,0);
INSERT INTO Itens VALUES (10673,43,'46',6,0);
INSERT INTO Itens VALUES (10675,14,'23.25',30,0);
INSERT INTO Itens VALUES (10675,53,'32.8',10,0);
INSERT INTO Itens VALUES (10675,58,'13.25',30,0);
INSERT INTO Itens VALUES (10676,10,'31',2,0);
INSERT INTO Itens VALUES (10676,19,'9.2',7,0);
INSERT INTO Itens VALUES (10676,44,'19.45',21,0);
INSERT INTO Itens VALUES (10678,33,'2.5',30,0);
INSERT INTO Itens VALUES (10678,54,'7.45',30,0);
INSERT INTO Itens VALUES (10681,19,'9.2',30,10);
INSERT INTO Itens VALUES (10681,21,'10',12,10);
INSERT INTO Itens VALUES (10682,33,'2.5',30,0);
INSERT INTO Itens VALUES (10682,66,'17',4,0);
INSERT INTO Itens VALUES (10682,75,'7.75',30,0);
INSERT INTO Itens VALUES (10683,52,'7',9,0);
INSERT INTO Itens VALUES (10684,40,'18.4',20,0);
INSERT INTO Itens VALUES (10684,47,'9.5',40,0);
INSERT INTO Itens VALUES (10684,60,'34',30,0);
INSERT INTO Itens VALUES (10686,17,'39',30,20);
INSERT INTO Itens VALUES (10686,26,'31.23',15,0);
INSERT INTO Itens VALUES (10691,1,'18',30,0);
INSERT INTO Itens VALUES (10691,29,'123.79',40,0);
INSERT INTO Itens VALUES (10691,43,'46',40,0);
INSERT INTO Itens VALUES (10691,44,'19.45',24,0);
INSERT INTO Itens VALUES (10691,62,'49.3',48,0);
INSERT INTO Itens VALUES (10693,9,'97',6,0);
INSERT INTO Itens VALUES (10693,54,'7.45',60,15);
INSERT INTO Itens VALUES (10693,69,'36',30,15);
INSERT INTO Itens VALUES (10693,73,'15',15,15);
INSERT INTO Itens VALUES (10695,8,'40',10,0);
INSERT INTO Itens VALUES (10695,24,'4.5',20,0);
INSERT INTO Itens VALUES (10697,19,'9.2',7,25);
INSERT INTO Itens VALUES (10697,35,'18',9,25);
INSERT INTO Itens VALUES (10697,58,'13.25',30,25);
INSERT INTO Itens VALUES (10697,70,'15',30,25);
INSERT INTO Itens VALUES (10699,47,'9.5',12,0);
INSERT INTO Itens VALUES (10700,1,'18',5,20);
INSERT INTO Itens VALUES (10700,34,'14',12,20);
INSERT INTO Itens VALUES (10700,68,'12.5',40,20);
INSERT INTO Itens VALUES (10700,71,'21.5',60,20);
INSERT INTO Itens VALUES (10701,59,'55',42,15);
INSERT INTO Itens VALUES (10701,71,'21.5',20,15);
INSERT INTO Itens VALUES (10703,2,'19',5,0);
INSERT INTO Itens VALUES (10703,59,'55',35,0);
INSERT INTO Itens VALUES (10703,73,'15',35,0);
INSERT INTO Itens VALUES (10704,4,'22',6,0);
INSERT INTO Itens VALUES (10704,24,'4.5',35,0);
INSERT INTO Itens VALUES (10704,48,'12.75',24,0);
INSERT INTO Itens VALUES (10708,36,'19',5,0);
INSERT INTO Itens VALUES (10711,19,'9.2',12,0);
INSERT INTO Itens VALUES (10711,53,'32.8',120,0);
INSERT INTO Itens VALUES (10712,53,'32.8',3,5);
INSERT INTO Itens VALUES (10712,56,'38',30,0);
INSERT INTO Itens VALUES (10714,2,'19',30,25);
INSERT INTO Itens VALUES (10714,17,'39',27,25);
INSERT INTO Itens VALUES (10714,47,'9.5',50,25);
INSERT INTO Itens VALUES (10714,56,'38',18,25);
INSERT INTO Itens VALUES (10714,58,'13.25',12,25);
INSERT INTO Itens VALUES (10715,10,'31',21,0);
INSERT INTO Itens VALUES (10715,71,'21.5',30,0);
INSERT INTO Itens VALUES (10721,44,'19.45',50,5);
INSERT INTO Itens VALUES (10723,26,'31.23',15,0);
INSERT INTO Itens VALUES (10727,17,'39',20,5);
INSERT INTO Itens VALUES (10727,56,'38',10,5);
INSERT INTO Itens VALUES (10727,59,'55',10,5);
INSERT INTO Itens VALUES (10730,16,'17.45',15,5);
INSERT INTO Itens VALUES (10730,31,'12.5',3,5);
INSERT INTO Itens VALUES (10730,65,'21.05',10,5);
INSERT INTO Itens VALUES (10731,21,'10',40,5);
INSERT INTO Itens VALUES (10731,51,'53',30,5);
INSERT INTO Itens VALUES (10734,6,'25',30,0);
INSERT INTO Itens VALUES (10734,30,'25.89',15,0);
INSERT INTO Itens VALUES (10735,61,'28.5',20,10);
INSERT INTO Itens VALUES (10735,77,'13',2,10);
INSERT INTO Itens VALUES (10737,13,'6',4,0);
INSERT INTO Itens VALUES (10738,16,'17.45',3,0);
INSERT INTO Itens VALUES (10739,36,'19',6,0);
INSERT INTO Itens VALUES (10739,52,'7',18,0);
INSERT INTO Itens VALUES (10742,3,'10',20,0);
INSERT INTO Itens VALUES (10742,60,'34',50,0);
INSERT INTO Itens VALUES (10742,72,'34.8',35,0);
INSERT INTO Itens VALUES (10744,40,'18.4',50,20);
INSERT INTO Itens VALUES (10747,31,'12.5',8,0);
INSERT INTO Itens VALUES (10747,63,'43.9',9,0);
INSERT INTO Itens VALUES (10747,69,'36',30,0);
INSERT INTO Itens VALUES (10748,23,'9',44,0);
INSERT INTO Itens VALUES (10748,40,'18.4',40,0);
INSERT INTO Itens VALUES (10748,56,'38',28,0);
INSERT INTO Itens VALUES (10751,26,'31.23',12,10);
INSERT INTO Itens VALUES (10751,30,'25.89',30,0);
INSERT INTO Itens VALUES (10751,50,'16.25',20,10);
INSERT INTO Itens VALUES (10751,73,'15',15,0);
INSERT INTO Itens VALUES (10752,1,'18',8,0);
INSERT INTO Itens VALUES (10752,69,'36',3,0);
INSERT INTO Itens VALUES (10753,45,'9.5',4,0);
INSERT INTO Itens VALUES (10753,74,'10',5,0);
INSERT INTO Itens VALUES (10754,40,'18.4',3,0);
INSERT INTO Itens VALUES (10757,34,'14',30,0);
INSERT INTO Itens VALUES (10757,59,'55',7,0);
INSERT INTO Itens VALUES (10757,62,'49.3',30,0);
INSERT INTO Itens VALUES (10758,26,'31.23',20,0);
INSERT INTO Itens VALUES (10758,52,'7',60,0);
INSERT INTO Itens VALUES (10758,70,'15',40,0);
INSERT INTO Itens VALUES (10759,32,'32',10,0);
INSERT INTO Itens VALUES (10761,25,'14',35,25);
INSERT INTO Itens VALUES (10761,75,'7.75',18,0);
INSERT INTO Itens VALUES (10762,39,'18',16,0);
INSERT INTO Itens VALUES (10762,47,'9.5',30,0);
INSERT INTO Itens VALUES (10762,51,'53',28,0);
INSERT INTO Itens VALUES (10762,56,'38',60,0);
INSERT INTO Itens VALUES (10763,21,'10',40,0);
INSERT INTO Itens VALUES (10763,22,'21',6,0);
INSERT INTO Itens VALUES (10763,24,'4.5',20,0);
INSERT INTO Itens VALUES (10764,3,'10',20,10);
INSERT INTO Itens VALUES (10764,39,'18',130,10);
INSERT INTO Itens VALUES (10765,65,'21.05',80,10);
INSERT INTO Itens VALUES (10768,22,'21',4,0);
INSERT INTO Itens VALUES (10768,31,'12.5',50,0);
INSERT INTO Itens VALUES (10768,60,'34',15,0);
INSERT INTO Itens VALUES (10768,71,'21.5',12,0);
INSERT INTO Itens VALUES (10769,52,'7',15,5);
INSERT INTO Itens VALUES (10769,61,'28.5',20,0);
INSERT INTO Itens VALUES (10769,62,'49.3',15,0);
INSERT INTO Itens VALUES (10772,29,'123.79',18,0);
INSERT INTO Itens VALUES (10772,59,'55',25,0);
INSERT INTO Itens VALUES (10775,10,'31',6,0);
INSERT INTO Itens VALUES (10775,67,'14',3,0);
INSERT INTO Itens VALUES (10777,42,'14',20,20);
INSERT INTO Itens VALUES (10779,16,'17.45',20,0);
INSERT INTO Itens VALUES (10779,62,'49.3',20,0);
INSERT INTO Itens VALUES (10780,70,'15',35,0);
INSERT INTO Itens VALUES (10780,77,'13',15,0);
INSERT INTO Itens VALUES (10781,54,'7.45',3,20);
INSERT INTO Itens VALUES (10781,56,'38',20,20);
INSERT INTO Itens VALUES (10781,74,'10',35,0);
INSERT INTO Itens VALUES (10787,2,'19',15,5);
INSERT INTO Itens VALUES (10787,29,'123.79',20,5);
INSERT INTO Itens VALUES (10790,7,'30',3,15);
INSERT INTO Itens VALUES (10790,56,'38',20,15);
INSERT INTO Itens VALUES (10791,29,'123.79',14,5);
INSERT INTO Itens VALUES (10793,52,'7',8,0);
INSERT INTO Itens VALUES (10794,14,'23.25',15,20);
INSERT INTO Itens VALUES (10794,54,'7.45',6,20);
INSERT INTO Itens VALUES (10796,26,'31.23',21,20);
INSERT INTO Itens VALUES (10796,44,'19.45',10,0);
INSERT INTO Itens VALUES (10796,69,'36',24,20);
INSERT INTO Itens VALUES (10797,11,'21',20,0);
INSERT INTO Itens VALUES (10798,62,'49.3',2,0);
INSERT INTO Itens VALUES (10798,72,'34.8',10,0);
INSERT INTO Itens VALUES (10804,10,'31',36,0);
INSERT INTO Itens VALUES (10804,28,'45.6',24,0);
INSERT INTO Itens VALUES (10804,49,'20',4,15);
INSERT INTO Itens VALUES (10805,34,'14',10,0);
INSERT INTO Itens VALUES (10806,2,'19',20,25);
INSERT INTO Itens VALUES (10806,65,'21.05',2,0);
INSERT INTO Itens VALUES (10806,74,'10',15,25);
INSERT INTO Itens VALUES (10808,56,'38',20,15);
INSERT INTO Itens VALUES (10809,52,'7',20,0);
INSERT INTO Itens VALUES (10810,13,'6',7,0);
INSERT INTO Itens VALUES (10810,25,'14',5,0);
INSERT INTO Itens VALUES (10810,70,'15',5,0);
INSERT INTO Itens VALUES (10812,31,'12.5',16,10);
INSERT INTO Itens VALUES (10812,72,'34.8',40,10);
INSERT INTO Itens VALUES (10812,77,'13',20,0);
INSERT INTO Itens VALUES (10814,43,'46',20,15);
INSERT INTO Itens VALUES (10814,48,'12.75',8,15);
INSERT INTO Itens VALUES (10814,61,'28.5',30,15);
INSERT INTO Itens VALUES (10815,33,'2.5',16,0);
INSERT INTO Itens VALUES (10817,26,'31.23',40,15);
INSERT INTO Itens VALUES (10817,40,'18.4',60,15);
INSERT INTO Itens VALUES (10817,62,'49.3',25,15);
INSERT INTO Itens VALUES (10818,32,'32',20,0);
INSERT INTO Itens VALUES (10819,43,'46',7,0);
INSERT INTO Itens VALUES (10819,75,'7.75',20,0);
INSERT INTO Itens VALUES (10820,56,'38',30,0);
INSERT INTO Itens VALUES (10822,62,'49.3',3,0);
INSERT INTO Itens VALUES (10822,70,'15',6,0);
INSERT INTO Itens VALUES (10823,11,'21',20,10);
INSERT INTO Itens VALUES (10823,57,'19.5',15,0);
INSERT INTO Itens VALUES (10823,59,'55',40,10);
INSERT INTO Itens VALUES (10823,77,'13',15,10);
INSERT INTO Itens VALUES (10860,51,'53',3,0);
INSERT INTO Itens VALUES (10865,39,'18',80,5);
INSERT INTO Itens VALUES (10866,2,'19',21,25);
INSERT INTO Itens VALUES (10866,24,'4.5',6,25);
INSERT INTO Itens VALUES (10866,30,'25.89',40,25);
INSERT INTO Itens VALUES (10867,53,'32.8',3,0);
INSERT INTO Itens VALUES (10868,26,'31.23',20,0);
INSERT INTO Itens VALUES (10868,35,'18',30,0);
INSERT INTO Itens VALUES (10868,49,'20',42,10);
INSERT INTO Itens VALUES (10869,1,'18',40,0);
INSERT INTO Itens VALUES (10869,11,'21',10,0);
INSERT INTO Itens VALUES (10869,23,'9',50,0);
INSERT INTO Itens VALUES (10869,68,'12.5',20,0);
INSERT INTO Itens VALUES (10870,35,'18',3,0);
INSERT INTO Itens VALUES (10870,51,'53',2,0);
INSERT INTO Itens VALUES (10872,55,'24',10,5);
INSERT INTO Itens VALUES (10872,62,'49.3',20,5);
INSERT INTO Itens VALUES (10872,65,'21.05',21,5);
INSERT INTO Itens VALUES (10874,10,'31',10,0);
INSERT INTO Itens VALUES (10876,46,'12',21,0);
INSERT INTO Itens VALUES (10879,40,'18.4',12,0);
INSERT INTO Itens VALUES (10879,65,'21.05',10,0);
INSERT INTO Itens VALUES (10880,23,'9',30,20);
INSERT INTO Itens VALUES (10880,61,'28.5',30,20);
INSERT INTO Itens VALUES (10880,70,'15',50,20);
INSERT INTO Itens VALUES (10885,2,'19',20,0);
INSERT INTO Itens VALUES (10885,24,'4.5',12,0);
INSERT INTO Itens VALUES (10885,70,'15',30,0);
INSERT INTO Itens VALUES (10885,77,'13',25,0);
INSERT INTO Itens VALUES (10890,17,'39',15,0);
INSERT INTO Itens VALUES (10890,34,'14',10,0);
INSERT INTO Itens VALUES (10891,30,'25.89',15,5);
INSERT INTO Itens VALUES (10895,24,'4.5',110,0);
INSERT INTO Itens VALUES (10895,39,'18',45,0);
INSERT INTO Itens VALUES (10895,40,'18.4',91,0);
INSERT INTO Itens VALUES (10895,60,'34',100,0);
INSERT INTO Itens VALUES (10896,45,'9.5',15,0);
INSERT INTO Itens VALUES (10896,56,'38',16,0);
INSERT INTO Itens VALUES (10897,29,'123.79',80,0);
INSERT INTO Itens VALUES (10897,30,'25.89',36,0);
INSERT INTO Itens VALUES (10899,39,'18',8,15);
INSERT INTO Itens VALUES (10903,13,'6',40,0);
INSERT INTO Itens VALUES (10903,65,'21.05',21,0);
INSERT INTO Itens VALUES (10903,68,'12.5',20,0);
INSERT INTO Itens VALUES (10904,58,'13.25',15,0);
INSERT INTO Itens VALUES (10904,62,'49.3',35,0);
INSERT INTO Itens VALUES (10907,75,'7.75',14,0);
INSERT INTO Itens VALUES (10911,1,'18',10,0);
INSERT INTO Itens VALUES (10911,17,'39',12,0);
INSERT INTO Itens VALUES (10911,67,'14',15,0);
INSERT INTO Itens VALUES (10912,11,'21',40,25);
INSERT INTO Itens VALUES (10912,29,'123.79',60,25);
INSERT INTO Itens VALUES (10914,71,'21.5',25,0);
INSERT INTO Itens VALUES (10915,17,'39',10,0);
INSERT INTO Itens VALUES (10915,33,'2.5',30,0);
INSERT INTO Itens VALUES (10915,54,'7.45',10,0);
INSERT INTO Itens VALUES (10918,1,'18',60,25);
INSERT INTO Itens VALUES (10918,60,'34',25,25);
INSERT INTO Itens VALUES (10919,16,'17.45',24,0);
INSERT INTO Itens VALUES (10919,25,'14',24,0);
INSERT INTO Itens VALUES (10919,40,'18.4',20,0);
INSERT INTO Itens VALUES (10922,17,'39',15,0);
INSERT INTO Itens VALUES (10922,24,'4.5',35,0);
INSERT INTO Itens VALUES (10923,42,'14',10,20);
INSERT INTO Itens VALUES (10923,43,'46',10,20);
INSERT INTO Itens VALUES (10923,67,'14',24,20);
INSERT INTO Itens VALUES (10924,10,'31',20,10);
INSERT INTO Itens VALUES (10924,28,'45.6',30,10);
INSERT INTO Itens VALUES (10924,75,'7.75',6,0);
INSERT INTO Itens VALUES (10925,36,'19',25,15);
INSERT INTO Itens VALUES (10925,52,'7',12,15);
INSERT INTO Itens VALUES (10929,21,'10',60,0);
INSERT INTO Itens VALUES (10929,75,'7.75',49,0);
INSERT INTO Itens VALUES (10929,77,'13',15,0);
INSERT INTO Itens VALUES (10933,53,'32.8',2,0);
INSERT INTO Itens VALUES (10933,61,'28.5',30,0);
INSERT INTO Itens VALUES (10934,6,'25',20,0);
INSERT INTO Itens VALUES (10936,36,'19',30,20);
INSERT INTO Itens VALUES (10937,28,'45.6',8,0);
INSERT INTO Itens VALUES (10937,34,'14',20,0);
INSERT INTO Itens VALUES (10938,13,'6',20,25);
INSERT INTO Itens VALUES (10938,43,'46',24,25);
INSERT INTO Itens VALUES (10938,60,'34',49,25);
INSERT INTO Itens VALUES (10938,71,'21.5',35,25);
INSERT INTO Itens VALUES (10939,2,'19',10,15);
INSERT INTO Itens VALUES (10939,67,'14',40,15);
INSERT INTO Itens VALUES (10941,31,'12.5',44,25);
INSERT INTO Itens VALUES (10941,62,'49.3',30,25);
INSERT INTO Itens VALUES (10941,68,'12.5',80,25);
INSERT INTO Itens VALUES (10941,72,'34.8',50,0);
INSERT INTO Itens VALUES (10944,11,'21',5,25);
INSERT INTO Itens VALUES (10944,44,'19.45',18,25);
INSERT INTO Itens VALUES (10944,56,'38',18,0);
INSERT INTO Itens VALUES (10947,59,'55',4,0);
INSERT INTO Itens VALUES (10948,50,'16.25',9,0);
INSERT INTO Itens VALUES (10948,51,'53',40,0);
INSERT INTO Itens VALUES (10948,55,'24',4,0);
INSERT INTO Itens VALUES (10949,6,'25',12,0);
INSERT INTO Itens VALUES (10949,10,'31',30,0);
INSERT INTO Itens VALUES (10949,17,'39',6,0);
INSERT INTO Itens VALUES (10949,62,'49.3',60,0);
INSERT INTO Itens VALUES (10954,16,'17.45',28,15);
INSERT INTO Itens VALUES (10954,31,'12.5',25,15);
INSERT INTO Itens VALUES (10954,45,'9.5',30,0);
INSERT INTO Itens VALUES (10954,60,'34',24,15);
INSERT INTO Itens VALUES (10956,21,'10',12,0);
INSERT INTO Itens VALUES (10956,47,'9.5',14,0);
INSERT INTO Itens VALUES (10956,51,'53',8,0);
INSERT INTO Itens VALUES (10958,7,'30',6,0);
INSERT INTO Itens VALUES (10958,72,'34.8',5,0);
INSERT INTO Itens VALUES (10959,75,'7.75',20,15);
INSERT INTO Itens VALUES (10960,24,'4.5',10,25);
INSERT INTO Itens VALUES (10964,18,'62.5',6,0);
INSERT INTO Itens VALUES (10964,69,'36',10,0);
INSERT INTO Itens VALUES (10965,51,'53',16,0);
INSERT INTO Itens VALUES (10967,19,'9.2',12,0);
INSERT INTO Itens VALUES (10967,49,'20',40,0);
INSERT INTO Itens VALUES (10971,29,'123.79',14,0);
INSERT INTO Itens VALUES (10973,26,'31.23',5,0);
INSERT INTO Itens VALUES (10973,75,'7.75',10,0);
INSERT INTO Itens VALUES (10974,63,'43.9',10,0);
INSERT INTO Itens VALUES (10982,7,'30',20,0);
INSERT INTO Itens VALUES (10982,43,'46',9,0);
INSERT INTO Itens VALUES (10983,13,'6',84,15);
INSERT INTO Itens VALUES (10983,57,'19.5',15,0);
INSERT INTO Itens VALUES (10985,16,'17.45',36,10);
INSERT INTO Itens VALUES (10985,18,'62.5',8,10);
INSERT INTO Itens VALUES (10985,32,'32',35,10);
INSERT INTO Itens VALUES (10988,7,'30',60,0);
INSERT INTO Itens VALUES (10988,62,'49.3',40,10);
INSERT INTO Itens VALUES (10989,6,'25',40,0);
INSERT INTO Itens VALUES (10989,11,'21',15,0);
INSERT INTO Itens VALUES (10990,21,'10',65,0);
INSERT INTO Itens VALUES (10990,34,'14',60,15);
INSERT INTO Itens VALUES (10990,55,'24',65,15);
INSERT INTO Itens VALUES (10990,61,'28.5',66,15);
INSERT INTO Itens VALUES (10993,29,'123.79',50,25);
INSERT INTO Itens VALUES (10994,59,'55',18,5);
INSERT INTO Itens VALUES (10999,51,'53',15,5);
INSERT INTO Itens VALUES (10999,77,'13',21,5);
INSERT INTO Itens VALUES (11000,4,'22',25,25);
INSERT INTO Itens VALUES (11000,24,'4.5',30,25);
INSERT INTO Itens VALUES (11000,77,'13',30,0);
INSERT INTO Itens VALUES (11001,7,'30',60,0);
INSERT INTO Itens VALUES (11001,22,'21',25,0);
INSERT INTO Itens VALUES (11001,46,'12',25,0);
INSERT INTO Itens VALUES (11001,55,'24',6,0);
INSERT INTO Itens VALUES (11003,1,'18',4,0);
INSERT INTO Itens VALUES (11003,40,'18.4',10,0);
INSERT INTO Itens VALUES (11003,52,'7',10,0);
INSERT INTO Itens VALUES (11004,26,'31.23',6,0);
INSERT INTO Itens VALUES (11005,1,'18',2,0);
INSERT INTO Itens VALUES (11005,59,'55',10,0);
INSERT INTO Itens VALUES (11006,1,'18',8,0);
INSERT INTO Itens VALUES (11006,29,'123.79',2,25);
INSERT INTO Itens VALUES (11008,28,'45.6',70,5);
INSERT INTO Itens VALUES (11008,34,'14',90,5);
INSERT INTO Itens VALUES (11008,71,'21.5',21,0);
INSERT INTO Itens VALUES (11009,24,'4.5',12,0);
INSERT INTO Itens VALUES (11009,36,'19',18,25);
INSERT INTO Itens VALUES (11009,60,'34',9,0);
INSERT INTO Itens VALUES (11010,7,'30',20,0);
INSERT INTO Itens VALUES (11010,24,'4.5',10,0);
INSERT INTO Itens VALUES (11011,58,'13.25',40,5);
INSERT INTO Itens VALUES (11011,71,'21.5',20,0);
INSERT INTO Itens VALUES (11013,23,'9',10,0);
INSERT INTO Itens VALUES (11013,42,'14',4,0);
INSERT INTO Itens VALUES (11013,45,'9.5',20,0);
INSERT INTO Itens VALUES (11013,68,'12.5',2,0);
INSERT INTO Itens VALUES (11015,30,'25.89',15,0);
INSERT INTO Itens VALUES (11015,77,'13',18,0);
INSERT INTO Itens VALUES (11019,46,'12',3,0);
INSERT INTO Itens VALUES (11019,49,'20',2,0);
INSERT INTO Itens VALUES (11020,10,'31',24,15);
INSERT INTO Itens VALUES (11021,2,'19',11,25);
INSERT INTO Itens VALUES (11021,20,'81',15,0);
INSERT INTO Itens VALUES (11021,26,'31.23',63,0);
INSERT INTO Itens VALUES (11021,51,'53',44,25);
INSERT INTO Itens VALUES (11021,72,'34.8',35,0);
INSERT INTO Itens VALUES (11025,1,'18',10,10);
INSERT INTO Itens VALUES (11025,13,'6',20,10);
INSERT INTO Itens VALUES (11028,55,'24',35,0);
INSERT INTO Itens VALUES (11028,59,'55',24,0);
INSERT INTO Itens VALUES (11030,2,'19',100,25);
INSERT INTO Itens VALUES (11030,29,'123.79',60,25);
INSERT INTO Itens VALUES (11030,59,'55',100,25);
INSERT INTO Itens VALUES (11031,1,'18',45,0);
INSERT INTO Itens VALUES (11031,13,'6',80,0);
INSERT INTO Itens VALUES (11031,24,'4.5',21,0);
INSERT INTO Itens VALUES (11031,71,'21.5',16,0);
INSERT INTO Itens VALUES (11032,36,'19',35,0);
INSERT INTO Itens VALUES (11032,59,'55',30,0);
INSERT INTO Itens VALUES (11033,53,'32.8',70,10);
INSERT INTO Itens VALUES (11033,69,'36',36,10);
INSERT INTO Itens VALUES (11035,1,'18',10,0);
INSERT INTO Itens VALUES (11035,35,'18',60,0);
INSERT INTO Itens VALUES (11035,42,'14',30,0);
INSERT INTO Itens VALUES (11035,54,'7.45',10,0);
INSERT INTO Itens VALUES (11037,70,'15',4,0);
INSERT INTO Itens VALUES (11041,2,'19',30,20);
INSERT INTO Itens VALUES (11041,63,'43.9',30,0);
INSERT INTO Itens VALUES (11042,44,'19.45',15,0);
INSERT INTO Itens VALUES (11042,61,'28.5',4,0);
INSERT INTO Itens VALUES (11043,11,'21',10,0);
INSERT INTO Itens VALUES (11045,33,'2.5',15,0);
INSERT INTO Itens VALUES (11045,51,'53',24,0);
INSERT INTO Itens VALUES (11047,1,'18',25,25);
INSERT INTO Itens VALUES (11048,68,'12.5',42,0);
INSERT INTO Itens VALUES (11049,2,'19',10,20);
INSERT INTO Itens VALUES (11051,24,'4.5',10,20);
INSERT INTO Itens VALUES (11052,43,'46',30,20);
INSERT INTO Itens VALUES (11052,61,'28.5',10,20);
INSERT INTO Itens VALUES (11053,18,'62.5',35,20);
INSERT INTO Itens VALUES (11053,32,'32',20,0);
INSERT INTO Itens VALUES (11055,24,'4.5',15,0);
INSERT INTO Itens VALUES (11055,25,'14',15,0);
INSERT INTO Itens VALUES (11055,51,'53',20,0);
INSERT INTO Itens VALUES (11055,57,'19.5',20,0);
INSERT INTO Itens VALUES (11057,70,'15',3,0);
INSERT INTO Itens VALUES (11059,13,'6',30,0);
INSERT INTO Itens VALUES (11059,17,'39',12,0);
INSERT INTO Itens VALUES (11059,60,'34',35,0);
INSERT INTO Itens VALUES (11060,60,'34',4,0);
INSERT INTO Itens VALUES (11060,77,'13',10,0);
INSERT INTO Itens VALUES (11063,34,'14',30,0);
INSERT INTO Itens VALUES (11063,40,'18.4',40,10);
INSERT INTO Itens VALUES (11066,16,'17.45',3,0);
INSERT INTO Itens VALUES (11066,19,'9.2',42,0);
INSERT INTO Itens VALUES (11066,34,'14',35,0);
INSERT INTO Itens VALUES (11070,1,'18',40,15);
INSERT INTO Itens VALUES (11070,2,'19',20,15);
INSERT INTO Itens VALUES (11070,16,'17.45',30,15);
INSERT INTO Itens VALUES (11070,31,'12.5',20,0);
INSERT INTO Itens VALUES (11073,11,'21',10,0);
INSERT INTO Itens VALUES (11073,24,'4.5',20,0);
INSERT INTO Itens VALUES (11074,16,'17.45',14,5);

/*** Alteração da tabela Setor adicionando a coluna idchefe e a FK de Funcionário ***/
ALTER TABLE Setor
	ADD COLUMN idchefe int NULL,
	ADD CONSTRAINT FK_setor_funcionario FOREIGN KEY (idchefe) REFERENCES Funcionario(idfuncionario);

/*** Atualização de dados na coluna idchefe da tabela Setor ***/
UPDATE Setor SET idchefe = 31 WHERE idsetor = 'ALM';
UPDATE Setor SET idchefe = 1  WHERE idsetor = 'COV';
UPDATE Setor SET idchefe = 14 WHERE idsetor = 'EXP';
UPDATE Setor SET idchefe = 10 WHERE idsetor = 'FIN';
UPDATE Setor SET idchefe = 3  WHERE idsetor = 'MKT';
UPDATE Setor SET idchefe = 4  WHERE idsetor = 'PES';
UPDATE Setor SET idchefe = 6  WHERE idsetor = 'PQD';
UPDATE Setor SET idchefe = 2  WHERE idsetor = 'PRS';
UPDATE Setor SET idchefe = 7  WHERE idsetor = 'RHM';
UPDATE Setor SET idchefe = 33 WHERE idsetor = 'SVG';
UPDATE Setor SET idchefe = 16 WHERE idsetor = 'TRN';

/*** Alteração da tabela Setor alterando a coluna idchefe para NOT NULL e adicionando a unicidade nela ***/
ALTER TABLE Setor 
	MODIFY idchefe int NOT NULL,
	ADD CONSTRAINT UN_setor_idchefe UNIQUE (idchefe);



select idproduto, nome as 'Produto',
	quantest as 'Estoque Real',
    estmin as 'Estoqe Mínimo'
from produto;

select idproduto, nome, venda, (venda + 0.25 *100) as 'Bonus'
from produto;

select distinct idreside
from funcionario;

select idproduto, nome, idtipo, custo, venda
from produto
order by idtipo desc, nome;

select nome, idsetor
from funcionario
where idnatural in (7,8,15)
order by idsetor, nome;

select *
from produto
where idtipo in (1,2,3) and venda between 10 and 50; 

select *
from funcionario
where email is null and celular is not null;

select nome, salario
from funcionario
where sexo = 'M' and estcivil = 'C' and salario <= 3.000
order by salario desc;

select nome, venda
from produto 
where descricao like '%chocolate%' and venda >= 15
order by venda desc;

select idfuncionario, nome
from funcionario
where sexo = 'M' and nome not like 'A%'
order by nome;


select count(distinct idcliente) as 'Relação Cliente - Pedido'
from pedido;

select sum(frete) as 'Soma do frete marítimo'
from pedido
where via = 'M';

select avg(salario)
from funcionario
where idfuncao in (10,11) and estcivil <> 'C';

select min(datanasc) as 'Funcionária mais velha'
from funcionario
where sexo = 'F';

select idpedido, max(quant) as 'Qantidade máxima'
from itens
group by idpedido;

select idnatural, sexo, count(*) as 'Quantidade'
from funcionario
group by sexo, idnatural
order by idnatural;

select idsetor, sum(salario) as 'Total'
from funcionario
group by idsetor
having sum(salario) > 5.000;

select idcliente as 'Cliente', year(datapedid) as 'Ano', count(*) as 'Quantidade'
from pedido
group by year(datapedid), idcliente
having count(*) > 5;

select f1.idfuncionario as 'Código do Funcionário', 
	   f1.nome as 'Nome do Funcionário', 
       f1.idfuncao as 'Código da função', 
       f2.nome as 'Nome da Função', 
       f2.gratific as 'Gratificação' 
from funcionario f1
inner join funcao f2 on f1.idfuncao = f2.idfuncao;

select c1.idcliente as 'Código do cliente',
	c1.nome as 'Nome do cliente'
from cliente c1
inner join cidade cid on c1.idcidade = cid.idcidade
where cid1.nome = 'London';

select avg(f1.salario) as 'Média salarial'
from funcionario f1
inner join funcao fun on f1.idfuncao = fun.idfuncao
where fun.nome like 'Diretor%';

select p1.idpedido as 'Número do pedido',
	c1.nome as 'Nome do cliente',
    f1.nome as 'Nome do funcionario'
from pedido p1
inner join cliente c1 on p1.idcliente = c1.idcliente
inner join funcionario f1 on p1.idvendedor = f1.idfuncionario;

select count(*)  as 'Quantidade',
	s1.nome as 'Setor'
from funcionario f1
inner join setor s1 on f1.idsetor = s1.idsetor
group by s1.nome
having count(*) > 5;

select c1.idcidade as 'cidade',
	c1.nome as 'nome'
from cidade c1
left join funcionario f1 on c1.idcidade = f1.idreside
where f1.idfuncionario is null
order by c1.nome;


select c1.idcidade as 'cidade',
	c1.nome as 'nome'
from cidade c1
right join funcionario f1 on c1.idcidade = f1.idreside
where f1.idfuncionario is not null
order by c1.nome;