/******************************************************************
*name        :  ECommerce2005.dbo.UP_EC_RealTime_AddItemsToExistWishList_V3
*function    :  add temporary data to one exist wish list
*input       :  WishListNumber,CustomerNumber,ItemList,QtyList,PriceList,Country,MaxQty
*output      :  ReturnValue
Table Used   :
*	------------------------------------------------------- 

*author      :  Kelvin Jiang
*server		 :  SSLQuery
*CreateDate  :  2006/03/22
*UpdateDate  :  2008/10/11
*UpdateBy	:	Neil Chen
*UpdateDate  :  2016/11/2 #13360 Sin Lin add insert SalesPrice & SaveCountry, update to V3
*************************************************************************/



/*===========================Create SP=================================
**DB:Test
**Type:Procedure
**ObjectName:dbo.Up_Test_Print
**team:XA Itemmaintain
**Creater:Cherish
**Create date:2008-11-7
**Modify by:Cherish
**Modify date:2008-11-8
**Function:Testing print in SSB
**Variable:N/A
=====================================================================*/

CREATE SCHEMA bank_uc07

--创建客户表
CREATE TABLE bank_uc07.UlricaCustomer_uc07
(
	ID int IDENTITY(1,1) NOT NULL ,
	CustomerID char(18) UNIQUE  NOT NULL,--添加唯一标识
	Name nvarchar(50) NOT NULL,
	Phone varchar(11) NOT NULL,
	Address nvarchar(128) NOT NULL,
	CreateTime datetime NOT NULL CONSTRAINT DF_UlricaCustomer_uc07_CreateTime DEFAULT GETDATE(),--默认获取当前时间
	LastEditDate datetime NOT NULL CONSTRAINT DF_UlricaCustomer_uc07_LastEditDate DEFAULT GETDATE(),--默认获取当前时间
	Remarks nvarchar(128),
CONSTRAINT [PK_UlricaCustomer_uc07] PRIMARY KEY CLUSTERED --设置主键ID
(
    [ID] ASC
)WITH (FILLFACTOR=90) ON [PRIMARY]
) ON [PRIMARY]


--创建借记卡表
CREATE TABLE bank_uc07.UlricaDebit_Card_uc07
(
	ID int IDENTITY(1,1) NOT NULL,
	CustomerID int FOREIGN KEY REFERENCES bank_uc07.UlricaCustomer_uc07(ID),--将客户ID作为外键
	Password varchar(32) NOT NULL,
	Balance decimal(16,2) NOT NULL,
	IsVIP bit NOT NULL,
	Status bit NOT NULL,
	CreateTime datetime NOT NULL CONSTRAINT DF_UlricaDebit_Card_uc07_CreateTime DEFAULT GETDATE(),--默认获取当前时间
	LastEditDate datetime NOT NULL CONSTRAINT DF_UlricaDebit_Card_uc07_LastEditDate DEFAULT GETDATE(),
	Remarks nvarchar(128),
CONSTRAINT [PK_UlricaDebit_Card_uc07] PRIMARY KEY CLUSTERED --设置主键ID
(
    [ID] ASC
)WITH (FILLFACTOR=90) ON [PRIMARY]
) ON [PRIMARY]


--创建交易记录表
CREATE TABLE bank_uc07.UlricaTransactions_uc07
(
	TransactionNumber int IDENTITY(1,1) NOT NULL ,
	Card_ID int FOREIGN KEY REFERENCES bank_uc07.UlricaDebit_Card_uc07(ID),--将银行卡号作为外键
	Type bit NOT NULL,
	Amount decimal(16,2) NOT NULL,
	Indate datetime NOT NULL CONSTRAINT DF_UlricaTransactions_uc07_Indate DEFAULT GETDATE(),--默认获取当前时间
	Status bit NOT NULL,
	Remarks nvarchar(128),
CONSTRAINT [PK_UlricaTransactions_uc07] PRIMARY KEY CLUSTERED --设置主键为交易编号
(
    [TransactionNumber] ASC
)WITH (FILLFACTOR=90) ON [PRIMARY]
) ON [PRIMARY]

--向Customer表中插入数据
INSERT INTO bank_uc07.UlricaCustomer_uc07 
([CustomerID],[Name],[Phone],[Address])
VALUES ('610524198807330846',N'张三','13438995253',N'四川省成都市高新区天府五街1888号')

INSERT INTO bank_uc07.UlricaCustomer_uc07
([CustomerID],[Name],[Phone],[Address])
VALUES('610524198807340846',N'李四','13434995253',N'四川省成都市高新区天府五街1880号') 

INSERT INTO bank_uc07.UlricaCustomer_uc07
([CustomerID],[Name],[Phone],[Address])
VALUES('610524198807340842',N'王五','13424995253',N'四川省成都市高新区天府五街') 


SELECT * FROM  bank_uc07.UlricaCustomer_uc07