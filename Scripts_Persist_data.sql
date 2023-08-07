-- inserção de dados e queries
use ecommerce;

show tables;
-- idClient, Fname, Minit, Lname, Address
insert into Clients (Fname, Minit, Lname, Address) 
	   values('Maria','M','Silva', 'rua silva de prata 29, Carangola - Cidade das flores'),
		     ('Matheus','O','Pimentel','rua alemeda 289, Centro - Cidade das flores'),
			 ('Ricardo','F','Silva','avenida alemeda vinha 1009, Centro - Cidade das flores'),
			 ('Julia','S','França', 'rua lareijras 861, Centro - Cidade das flores'),
			 ('Roberta','G','Assis','avenidade koller 19, Centro - Cidade das flores'),
			 ('Isabela','M','Cruz','rua alemeda das flores 28, Centro - Cidade das flores');
-- CPF
insert into PessoaFisica (CPF,Cliente_idCliente) 
	   values(12346789010,1),
		     (98765432110,2),
			 (45678913010,3);
             
-- CNPJ

insert into PessoaJuridica (CNPJ,Cliente_idCliente) 
	   values(789123456100001,4),
			 (987456310100001,5),
			 (654789123100001,6);

-- idProduct, Pname, classification_kids boolean, category('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis'), avaliação, size
insert into product (Pname, classification_kids, category, Avaliation, size) values
							  ('Fone de ouvido',false,'Eletrônico','4',null),
                              ('Barbie Elsa',true,'Brinquedos','3',null),
                              ('Body Carters',true,'Vestimenta','5',null),
                              ('Microfone Vedo - Youtuber',False,'Eletrônico','4',null),
                              ('Sofá retrátil',False,'Móveis','3','3x57x80'),
                              ('Farinha de arroz',False,'Alimentos','2',null),
                              ('Fire Stick Amazon',False,'Eletrônico','3',null);

select * from clients;
select * from product;
-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash

delete from orders where idOrderClient in  (1,2,3,4);
insert into orders (idOrderClient, OrderStatus, orderDescription, Delivery) values 
							 (1, default,'compra via aplicativo',null),
                             (2,default,'compra via aplicativo',50),
                             (3,'Confirmado',null,null),
                             (4 ,default,'compra via web site',150);

insert into Delivery (cod, StatusDelivery, Order_idOrder) 
	   values(123456,'Processando',5),
		     (789012,'Processando',6),
			 (345678,'Delivery',7),
			 (901234,'Entregue',8);
             
insert into PaymentOrder (PaymentTypeClient, Cardnumber, expiration, CardNameHolder,PaymentStatus,Order_idOrder,Pvalue) 
	   values('Boleto',null,null,null,'Processando',5, 20.00),
		     ('Cartão de debito',1234567891234567,'2025-05','Maria M Silva','Autorizado',6, 559.00),
			 ('Cartão de Credito',2345678912345678,'2026-06','Matheus O Pimentel','Não Autorizado',7,359.99),
			 ('Pix',null,null,null,'Autorizado',8,99.99);
             
-- idPOproduct, idPOorder, poQuantity, poStatus
select * from orders;
insert into productOrder (idproduct, idPorder, pquantity, StatusOrder) values
						 (1,5,2,null),
                         (2,5,1,null),
                         (3,6,1,null);

-- storageLocation,quantity
insert into ProductStorage (storageLocation,quantity) values 
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo',10),
                            ('São Paulo',100),
                            ('São Paulo',10),
                            ('Brasília',60);

-- idLproduct, idLstorage, location
insert into ProductStore (idProduct, idPStore, location) values
						 (1,2,'RJ'),
                         (2,6,'GO');

-- idSupplier, SocialName, CNPJ, contact
insert into supplier (CorporateName, CNPJ, contact) values 
							('Almeida e filhos', 123456789123456,'21985474'),
                            ('Eletrônicos Silva',854519649143457,'21985484'),
                            ('Eletrônicos Valma', 934567893934695,'21975474');
                            
select * from supplier;
-- idPsSupplier, idPsProduct, quantity
insert into productSupplier (idPSupplier, idProduct, pquantity) values
						 (1,1,500),
                         (1,2,400),
                         (2,4,633),
                         (3,3,5),
                         (2,5,10);

-- idSeller, SocialName, AbstName, CNPJ, CPF, location, contact
insert into seller (corporateName, FantasyName, CNPJ, CPF, Address, contact) values 
						('Tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', 219946287),
					    ('Botique Durgas',null,null,123456783,'Rio de Janeiro', 219567895),
						('Kids World',null,456789123654485,null,'São Paulo', 1198657484);

-- idPseller, idPproduct, prodQuantity
insert into productSeller (idPseller, idProduct, pQuantity) values 
						 (1,6,80),
                         (2,7,10);

