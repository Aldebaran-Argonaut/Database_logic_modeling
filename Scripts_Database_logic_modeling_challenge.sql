-- Objetivo:
-- [Relembrando] Aplique o mapeamento para o  cenário:
-- “Refine o modelo apresentado acrescentando os seguintes pontos”

-- Cliente PJ e PF – Uma conta pode ser PJ ou PF, mas não pode ter as duas informações;
/* 
Create table PessoaFisica(
	idPessoaFisica int auto_increment primary key,
	CPF CHAR(11),
    Cliente_idCliente INT,
    CONSTRAINT UNIQUE_CPF_CLIENTE UNIQUE(CPF),
    constraint fk_Cliente_idCliente_PessoaFisica foreign key(Cliente_idCliente) references Clients(idClient)
		on update cascade
		on delete set null
); 
Create table PessoaJuridica(
	idPessoaJuridica int auto_increment primary key,
	CNPJ CHAR(15),
    Cliente_idCliente INT,
    CONSTRAINT UNIQUE_CPF_CLIENTE UNIQUE(CNPJ),
	constraint fk_Cliente_idCliente_PessoaJuridica foreign key(Cliente_idCliente) references Clients(idClient)
		on update cascade
		on delete set null
);
*/

-- Pagamento – Pode ter cadastrado mais de uma forma de pagamento;
/*
create table PaymentOrder(
	idPaymentOrder int auto_increment primary key,
	PaymentTypeClient enum('Boleto','Cartão de debito','Cartão de Credito','Pix'),
    Cardnumber CHAR(16),
    expiration CHAR(7),
    CardNameHolder varchar(80),
    PaymentStatus ENUM('Processando', 'Não Autorizado', 'Autorizado'),
    Order_idOrder int,
    constraint fk_pedido_idpedido foreign key(Order_idOrder) references Orders(idOrder)
);
*/

-- Entrega – Possui status e código de rastreio;
/* 
create table Delivery(
	idDelivery int auto_increment primary key,
	cod int not null,
    StatusDelivery varchar(40),
    Order_idOrder int not null,
    constraint fk_pedido_idpedido_delivery foreign key(Order_idOrder) references Orders(idOrder)
);
*/

/*
Recuperações simples com SELECT Statement ok
Defina ordenações dos dados com ORDER BY ok
Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados ok
Filtros com WHERE Statement ok
Crie expressões para gerar atributos derivados ok
Condições de filtros aos grupos – HAVING Statement ok
*/

--Quantos pedidos foram feitos por cada cliente?
select concat(Fname,' ',Minit,' ',Lname) as cliente, 
coalesce(sum(Pquantity),0) as Quantidade_Produtos_Pedidos 
from clients 
	left join orders 
	on idClient = idOrderClient
    left join Productorder 
    on idOrder = idPorder
    group by cliente;

--Algum vendedor também é fornecedor? OK
Select Pname as Product, CorporateName as Fornecedor, StorageLocation as Local_do_estoque 
from Product A 
	inner join ProductSupplier B on A.idproduct = B.idproduct
	inner join supplier C on  B.idPsupplier= C.idSupplier
	inner join productstore D on A.idproduct = D.idproduct
	inner join productStorage E on  E.idProductStorage= D.idPStore;

--Relação de produtos fornecedores e estoques; OK
Select Pname as Product, CorporateName as Fornecedor 
from Product A 
	inner join ProductSupplier B on A.idproduct = B.idproduct
	inner join supplier C on  B.idPsupplier= C.idSupplier
	order by A.idProduct;

--Relação de nomes dos fornecedores e nomes dos produtos; ok
select PaymentTypeClient, (coalesce(delivery,0)+Pvalue) as valor_da_compra 
from orders 
	inner join paymentorder on Order_idOrder = idorder
	where PaymentTypeClient = 'Cartão de Credito';

--Condições de filtros aos grupos – HAVING Statement ok
select StorageLocation, sum(Quantity) 
from ProductStorage
	group by(StorageLocation)
	having StorageLocation = 'Rio de Janeiro'; 


