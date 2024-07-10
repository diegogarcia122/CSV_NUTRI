USE ETLDB;

CREATE TABLE [dbo].[dim_StratificationCategory](
	[StratificationCategoryId1] [nvarchar](50) NULL,
	[StratificationCategory1] [nvarchar](50) NULL
);

CREATE TABLE [dbo].[dim_Stratification](
	[StratificationID1] [nvarchar](50) NULL,
	[Stratification1] [nvarchar](50) NULL
);

CREATE TABLE [dbo].[dim_Location](
	[LocationID] [tinyint] NULL,
	[LocationAbbr] [nvarchar](50) NULL
);

CREATE TABLE [dbo].[dim_Question](
	[QuestionID] [money] NULL,
	[Question] [nvarchar](255) NULL
);

CREATE TABLE [dbo].[dim_Topic](
	[TopicID] [nvarchar](50) NULL,
	[Topic] [nvarchar](50) NULL
);

CREATE TABLE [dbo].[dim_Class](
	[ClassID] [nvarchar](50) NULL,
	[Class] [nvarchar](50) NULL
);

CREATE TABLE [dbo].[Facts_Nutrition](
	[YearStart] [smallint] NULL,
	[YearEnd] [smallint] NULL,
	[Datasource] [nvarchar](50) NULL,
	[Data_Value] [float] NULL,
	[Data_Value_Alt] [float] NULL,
	[Low_Confidence_Limit] [float] NULL,
	[High_Confidence_Limit] [float] NULL,
	[Sample_Size] [int] NULL,
	[Age_years] [nvarchar](50) NULL,
	[Education] [nvarchar](50) NULL,
	[Gender] [nvarchar](50) NULL,
	[Income] [nvarchar](50) NULL,
	[Race_Ethnicity] [nvarchar](50) NULL,
	[Class] [nvarchar](50) NULL,
	[Topic] [nvarchar](50) NULL,
	[Question] [nvarchar](255) NULL,
	[Location] [nvarchar](50) NULL,
	[StratificationCategory1] [nvarchar](50) NULL,
	[Stratification1] [nvarchar](50) NULL
);

INSERT INTO dim_StratificationCategory SELECT [StratificationCategoryId1], [StratificationCategory1] FROM [dbo].[CleanNutrition];
INSERT INTO dim_Stratification SELECT [StratificationID1], [Stratification1] FROM [dbo].[CleanNutrition];
INSERT INTO dim_Location SELECT [LocationID], [LocationAbbr] FROM [dbo].[CleanNutrition];
INSERT INTO dim_Question SELECT [QuestionID], [Question] FROM [dbo].[CleanNutrition];
INSERT INTO dim_Topic SELECT [TopicID], [Topic] FROM [dbo].[CleanNutrition];
INSERT INTO dim_Class SELECT [ClassID], [Class] FROM [dbo].[CleanNutrition];

INSERT INTO Facts_Nutrition 
SELECT [YearStart],[YearEnd],[Datasource],[Data_Value],[Data_Value_Alt],[Low_Confidence_Limit],[High_Confidence_Limit],[Sample_Size],[Age_years],[Education],[Gender],[Income],[Race_Ethnicity],[Class],[Topic],[Question],[LocationAbbr],[StratificationCategory1],[Stratification1]
FROM [dbo].[CleanNutrition]