USE [NFiles]
GO

--����SCHEMA
CREATE SCHEMA nfile
Go

--������λ/������
CREATE TABLE nfile.Milestone
(
	[ID]					INT IDENTITY(1,1) NOT NULL ,--������������Ϊ����
	[UserId]			    VARCHAR(4) NOT NULL,
	[Event]					NVARCHAR(50) NOT NULL,
	[Date]					DATETIME NOT NULL,
	[InDate]				DATETIME NOT NULL CONSTRAINT DF_Milestone_InDate DEFAULT GETDATE(),  --Ĭ�ϻ�ȡ��ǰʱ��
	[InUser]				VARCHAR(32) NOT NULL,
	[EditDate]				DATETIME NOT NULL CONSTRAINT DF_Milestone_EditDate DEFAULT GETDATE(),  --Ĭ�ϻ�ȡ��ǰʱ��
	[EditUser]				VARCHAR(32) NOT NULL,
CONSTRAINT [PK_PositionOrAwards] PRIMARY KEY CLUSTERED  --��������ID
(
    [ID] ASC
)WITH (FILLFACTOR=90) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX IX_PositionOrAwards_UserId ON nfile.Milestone --�����Ǿۼ�����
(
	[UserId]
)WITH (FILLFACTOR = 90)
Go

--��������ջ��
CREATE TABLE nfile.SkillsAndProficiency
(
	[ID]					INT IDENTITY(1,1) NOT NULL , --������������Ϊ����
	[UserId]				VARCHAR(4)  NOT NULL,
	[Skill]					NVARCHAR(16) NOT NULL,
	[Level]					TINYINT NOT NULL,
	[InDate]				DATETIME NOT NULL CONSTRAINT DF_SkillsAndProficiency_InDate DEFAULT GETDATE(),  --Ĭ�ϻ�ȡ��ǰʱ��
	[InUser]				VARCHAR(32) NOT NULL,
	[EditDate]				DATETIME NOT NULL CONSTRAINT DF_SkillsAndProficiency_EditDate DEFAULT GETDATE(),  --Ĭ�ϻ�ȡ��ǰʱ��
	[EditUser]				VARCHAR(32) NOT NULL,
CONSTRAINT[PK_SkillsAndProficiency] PRIMARY KEY CLUSTERED(
	[ID] ASC
)WITH (FILLFACTOR =90) ON [PRIMARY]
)
GO
CREATE NONCLUSTERED INDEX IX_SkillsAndProficiency_UserId ON nfile.SkillsAndProficiency --�����Ǿۼ�����
(
	[UserId]
)WITH (FILLFACTOR = 90)
Go
