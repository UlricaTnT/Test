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

--�����ͻ���
CREATE TABLE bank_uc07.UlricaCustomer_uc07
(
	ID int IDENTITY(1,1) NOT NULL ,
	CustomerID char(18) UNIQUE  NOT NULL,--���Ψһ��ʶ
	Name nvarchar(50) NOT NULL,
	Phone varchar(11) NOT NULL,
	Address nvarchar(128) NOT NULL,
	CreateTime datetime NOT NULL CONSTRAINT DF_UlricaCustomer_uc07_CreateTime DEFAULT GETDATE(),--Ĭ�ϻ�ȡ��ǰʱ��
	LastEditDate datetime NOT NULL CONSTRAINT DF_UlricaCustomer_uc07_LastEditDate DEFAULT GETDATE(),--Ĭ�ϻ�ȡ��ǰʱ��
	Remarks nvarchar(128),
CONSTRAINT [PK_UlricaCustomer_uc07] PRIMARY KEY CLUSTERED --��������ID
(
    [ID] ASC
)WITH (FILLFACTOR=90) ON [PRIMARY]
) ON [PRIMARY]


--������ǿ���
CREATE TABLE bank_uc07.UlricaDebit_Card_uc07
(
	ID int IDENTITY(1,1) NOT NULL,
	CustomerID int FOREIGN KEY REFERENCES bank_uc07.UlricaCustomer_uc07(ID),--���ͻ�ID��Ϊ���
	Password varchar(32) NOT NULL,
	Balance decimal(16,2) NOT NULL,
	IsVIP bit NOT NULL,
	Status bit NOT NULL,
	CreateTime datetime NOT NULL CONSTRAINT DF_UlricaDebit_Card_uc07_CreateTime DEFAULT GETDATE(),--Ĭ�ϻ�ȡ��ǰʱ��
	LastEditDate datetime NOT NULL CONSTRAINT DF_UlricaDebit_Card_uc07_LastEditDate DEFAULT GETDATE(),
	Remarks nvarchar(128),
CONSTRAINT [PK_UlricaDebit_Card_uc07] PRIMARY KEY CLUSTERED --��������ID
(
    [ID] ASC
)WITH (FILLFACTOR=90) ON [PRIMARY]
) ON [PRIMARY]


--�������׼�¼��
CREATE TABLE bank_uc07.UlricaTransactions_uc07
(
	TransactionNumber int IDENTITY(1,1) NOT NULL ,
	Card_ID int FOREIGN KEY REFERENCES bank_uc07.UlricaDebit_Card_uc07(ID),--�����п�����Ϊ���
	Type bit NOT NULL,
	Amount decimal(16,2) NOT NULL,
	Indate datetime NOT NULL CONSTRAINT DF_UlricaTransactions_uc07_Indate DEFAULT GETDATE(),--Ĭ�ϻ�ȡ��ǰʱ��
	Status bit NOT NULL,
	Remarks nvarchar(128),
CONSTRAINT [PK_UlricaTransactions_uc07] PRIMARY KEY CLUSTERED --��������Ϊ���ױ��
(
    [TransactionNumber] ASC
)WITH (FILLFACTOR=90) ON [PRIMARY]
) ON [PRIMARY]

--��Customer���в�������
INSERT INTO bank_uc07.UlricaCustomer_uc07 
([CustomerID],[Name],[Phone],[Address])
VALUES ('610524198807330846',N'����','13438995253',N'�Ĵ�ʡ�ɶ��и������츮���1888��')

INSERT INTO bank_uc07.UlricaCustomer_uc07
([CustomerID],[Name],[Phone],[Address])
VALUES('610524198807340846',N'����','13434995253',N'�Ĵ�ʡ�ɶ��и������츮���1880��') 

INSERT INTO bank_uc07.UlricaCustomer_uc07
([CustomerID],[Name],[Phone],[Address])
VALUES('610524198807340842',N'����','13424995253',N'�Ĵ�ʡ�ɶ��и������츮���') 


SELECT * FROM  bank_uc07.UlricaCustomer_uc07