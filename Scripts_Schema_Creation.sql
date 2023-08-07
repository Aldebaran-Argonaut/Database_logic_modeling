--  Criação do banco de dados para o cenário de E-commerce -
create database Ecommerce;
use Ecommerce;
-- Criar tabela Cliente
Create table Clients(
	idClient int auto_increment primary key,
	Fname varchar(25),
    Minit varchar(3),
    Lname varchar(25),
    Address varchar(255),
	Birth date
);
alter table clients auto_increment = 1;

-- Criar tabela Pessoa fisica
Create table PessoaFisica(
	idPessoaFisica int auto_increment primary key,
	CPF CHAR(11),
    Cliente_idCliente INT,
    CONSTRAINT UNIQUE_CPF_CLIENTE UNIQUE(CPF),
    constraint fk_Cliente_idCliente_PessoaFisica foreign key(Cliente_idCliente) references Clients(idClient)
		on update cascade
		on delete set null
);
alter table PessoaFisica auto_increment = 1;

-- criar tabela Pessoa Juridica
Create table PessoaJuridica(
	idPessoaJuridica int auto_increment primary key,
	CNPJ CHAR(15),
    Cliente_idCliente INT,
    CONSTRAINT UNIQUE_CPF_CLIENTE UNIQUE(CNPJ),
	constraint fk_Cliente_idCliente_PessoaJuridica foreign key(Cliente_idCliente) references Clients(idClient)
		on update cascade
		on delete set null
);
alter table PessoaJuridica auto_increment = 1;

-- Criar tabela Produto
Create table Product(
	idProduct int auto_increment primary key,
	Pname varchar(25),
    Classification_Kids bool default false,
    Category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
    Avaliation float default 0,
    size varchar(10)
    
);
alter table Product auto_increment = 1;

-- Criar tabela Pedido
Create table Orders(
	idOrder int auto_increment primary key,
    idOrderClient int, 
    OrderStatus ENUM('Em andamento', 'Confirmado', 'Enviado', 'Entregue') not null,
    OrderDescription varchar(255),
    Delivery float default 10,
    constraint fk_order_Client foreign key(idOrderClient) references clients(idClient) 
		on update cascade
		on delete set null
    );
alter table Orders auto_increment = 1;
    
-- Criar tabela dos dados de pagamento
create table PaymentOrder(
	idPaymentOrder int auto_increment primary key,
	PaymentTypeClient enum('Boleto','Cartão de debito','Cartão de Credito','Pix'),
    Cardnumber CHAR(16),
    expiration CHAR(7),
    CardNameHolder varchar(80),
    PaymentStatus ENUM('Processando', 'Não Autorizado', 'Autorizado'),
    Order_idOrder int,
    Pvalue int,
    constraint fk_pedido_idpedido foreign key(Order_idOrder) references Orders(idOrder)
    );
alter table PaymentOrder auto_increment = 1;
-- Criar tabela dos dados de Fornecedor
create table Supplier(
	idSupplier int auto_increment primary key,
    CorporateName varchar(80) NOT NULL,
    CNPJ CHAR(15) NOT NULL UNIQUE,
    CONTACT VARCHAR(40) default 0
    );
alter table Supplier auto_increment = 1;
-- Criar tabela dos dados de Estoque
create table ProductStorage(
	idProductStorage int auto_increment primary key,
	StorageLocation varchar(255) not null,
    Quantity INT NOT NULL default 0
    );
alter table ProductStorage auto_increment = 1;
-- Criar tabela dos dados de Terceiro
create table seller(
	idSeller int NOT null auto_increment primary key,
    CorporateName varchar(80) NOT null,
    FantasyName varchar(80),
    Address varchar(255) NOT NULL,
    CONTACT CHAR(11),
    CNPJ CHAR(15),
    CPF CHAR(11),
    constraint Unique_CorporateName_Seller UNIQUE(CorporateName),
    constraint Unique_CONTACT_Seller UNIQUE(CONTACT),
    constraint Unique_CNPJ_Seller UNIQUE(CNPJ),
    constraint Unique_CPF_Seller UNIQUE(CPF)
    );
alter table Seller auto_increment = 1;

-- Criar tabela dos dados de Entrega
    create table Delivery(
	idDelivery int auto_increment primary key,
	cod int not null,
    StatusDelivery varchar(40),
    Order_idOrder int not null,
    constraint fk_pedido_idpedido_delivery foreign key(Order_idOrder) references Orders(idOrder)
    );
alter table Delivery auto_increment = 1;
-- criar tabela M PARA M PRODUTOS/VENDEDOR ok
create table ProductSeller (
	idPseller Int,
    idProduct int,
    Pquantity int not null default 1,
    primary key(idPseller,idProduct),
    constraint fk_product_seller_ProductSeller foreign key(idPseller) references seller(idSeller),
    constraint fk_product_product_ProductSeller foreign key(idProduct) references Product(idProduct)
    );
-- criar tabela M PARA M PRODUTOS/PEDIDO OK
create table ProductOrder (
    idProduct int,
	idPorder Int,
    Pquantity int not null default 1,
    StatusOrder enum('Disponível','Sem Estoque') default 'Disponível',
    primary key(idProduct,idPorder),
    constraint fk_product_product_ProductOrder foreign key(idProduct) references Product(idProduct),
    constraint fk_product_seller_ProductOrder foreign key(idPorder) references Orders(idOrder)
    );
-- criar tabela M PARA M PRODUTOS/FORNECEDOR ok
create table ProductSupplier (
	idPsupplier Int,
    idProduct int,
    Pquantity int not null default 1,
    primary key(idPsupplier,idProduct),
    constraint fk_product_suplier_ProductSupplier foreign key(idPsupplier) references supplier(idSupplier),
    constraint fk_product_product_ProductSupplier foreign key(idProduct) references Product(idProduct)
    );
-- criar tabela M PARA M PRODUTOS/ESTOQUE ok
create table ProductStore (
	idPStore Int,
    idProduct int,
    location CHAR(2),
    primary key(idPStore,idProduct),
    constraint fk_product_Store_ProductStore foreign key(idPStore) references ProductStorage(idProductStorage),
    constraint fk_product_product_ProductStore foreign key(idProduct) references Product(idProduct)
    );
