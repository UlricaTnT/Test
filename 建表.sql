USE [NFiles]
GO

--创建SCHEMA
CREATE SCHEMA nfile
Go

--创建岗位/荣誉表
CREATE TABLE nfile.Milestone
(
	[ID]					INT IDENTITY(1,1) NOT NULL ,--自增长列设置为主键
	[UserId]			    VARCHAR(4) NOT NULL,
	[Event]					NVARCHAR(50) NOT NULL,
	[Date]					DATETIME NOT NULL,
	[InDate]				DATETIME NOT NULL CONSTRAINT DF_Milestone_InDate DEFAULT GETDATE(),  --默认获取当前时间
	[InUser]				VARCHAR(32) NOT NULL,
	[EditDate]				DATETIME NOT NULL CONSTRAINT DF_Milestone_EditDate DEFAULT GETDATE(),  --默认获取当前时间
	[EditUser]				VARCHAR(32) NOT NULL,
CONSTRAINT [PK_PositionOrAwards] PRIMARY KEY CLUSTERED  --设置主键ID
(
    [ID] ASC
)WITH (FILLFACTOR=90) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX IX_PositionOrAwards_UserId ON nfile.Milestone --创建非聚集索引
(
	[UserId]
)WITH (FILLFACTOR = 90)
Go

--创建技术栈表
CREATE TABLE nfile.SkillsAndProficiency
(
	[ID]					INT IDENTITY(1,1) NOT NULL , --自增长列设置为主键
	[UserId]				VARCHAR(4)  NOT NULL,
	[Skill]					NVARCHAR(16) NOT NULL,
	[Level]					TINYINT NOT NULL,
	[InDate]				DATETIME NOT NULL CONSTRAINT DF_SkillsAndProficiency_InDate DEFAULT GETDATE(),  --默认获取当前时间
	[InUser]				VARCHAR(32) NOT NULL,
	[EditDate]				DATETIME NOT NULL CONSTRAINT DF_SkillsAndProficiency_EditDate DEFAULT GETDATE(),  --默认获取当前时间
	[EditUser]				VARCHAR(32) NOT NULL,
CONSTRAINT[PK_SkillsAndProficiency] PRIMARY KEY CLUSTERED(
	[ID] ASC
)WITH (FILLFACTOR =90) ON [PRIMARY]
)
GO
CREATE NONCLUSTERED INDEX IX_SkillsAndProficiency_UserId ON nfile.SkillsAndProficiency --创建非聚集索引
(
	[UserId]
)WITH (FILLFACTOR = 90)
Go
