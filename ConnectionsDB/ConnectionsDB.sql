USE [master]
GO
/****** Object:  Database [Connections]    Script Date: 22/05/2022 22:41:16 ******/
CREATE DATABASE [Connections]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Connections', FILENAME = N'C:\Users\tzippy\Connections.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Connections_log', FILENAME = N'C:\Users\tzippy\Connections_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Connections] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Connections].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Connections] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Connections] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Connections] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Connections] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Connections] SET ARITHABORT OFF 
GO
ALTER DATABASE [Connections] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Connections] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Connections] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Connections] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Connections] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Connections] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Connections] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Connections] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Connections] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Connections] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Connections] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Connections] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Connections] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Connections] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Connections] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Connections] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Connections] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Connections] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Connections] SET  MULTI_USER 
GO
ALTER DATABASE [Connections] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Connections] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Connections] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Connections] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Connections] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Connections] SET QUERY_STORE = OFF
GO
USE [Connections]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [Connections]
GO
/****** Object:  Table [dbo].[events]    Script Date: 22/05/2022 22:41:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[events](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[ImageName] [nvarchar](100) NULL,
	[VerbName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_events] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mach]    Script Date: 22/05/2022 22:41:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mach](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[RequestId1] [bigint] NOT NULL,
	[RequestId2] [bigint] NOT NULL,
	[Length] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_mach] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[request]    Script Date: 22/05/2022 22:41:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[request](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[DayInWeek] [int] NOT NULL,
	[TimeInDay] [datetime] NOT NULL,
	[EventID] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_request] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 22/05/2022 22:41:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nchar](100) NOT NULL,
	[LastName] [nchar](100) NOT NULL,
	[Gender] [int] NOT NULL,
	[Email] [nchar](100) NOT NULL,
	[Phone] [nchar](100) NOT NULL,
	[UniqeID] [nchar](100) NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[viewAllMach]    Script Date: 22/05/2022 22:41:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[viewAllMach]
AS

select users.FirstName ,users.LastName, users.Gender, users.Email,Phone,[Name], VerbName, DayInWeek,TimeInDay, EventID,request.IsActive as requestIsActive ,RequestId1, RequestId2, mach.IsActive as machIsActive, mach.ID as machID, users.ID as userID, request.ID as requestID
from mach
inner join request
on mach.RequestId1 = request.ID
inner join events 
on request.EventID = events.ID
inner join users 
on request.UserID = users.ID
union
select users.FirstName ,users.LastName, users.Gender, users.Email,Phone,[Name], VerbName, DayInWeek,TimeInDay, EventID,request.IsActive as requestIsActive ,RequestId1 ,RequestId2, mach.IsActive as machIsActive, mach.ID as machID, users.ID as userID, request.ID as requestID
from mach
inner join request
on mach.RequestId2 = request.ID
inner join events 
on request.EventID = events.ID
inner join users 
on request.UserID = users.ID
GO
/****** Object:  Table [dbo].[category]    Script Date: 22/05/2022 22:41:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[category] ON 

INSERT [dbo].[category] ([CategoryID], [CategoryName]) VALUES (1, N'ספורט')
INSERT [dbo].[category] ([CategoryID], [CategoryName]) VALUES (2, N'תחביבים ופנאי')
INSERT [dbo].[category] ([CategoryID], [CategoryName]) VALUES (3, N'עיוני')
SET IDENTITY_INSERT [dbo].[category] OFF
GO
SET IDENTITY_INSERT [dbo].[events] ON 

INSERT [dbo].[events] ([ID], [Name], [ImageName], [VerbName]) VALUES (2, N'מסעדה', NULL, N'לאכול')
INSERT [dbo].[events] ([ID], [Name], [ImageName], [VerbName]) VALUES (3, N'סריגה', NULL, N'לסרוג')
INSERT [dbo].[events] ([ID], [Name], [ImageName], [VerbName]) VALUES (4, N'הליכה', NULL, N'ללכת')
INSERT [dbo].[events] ([ID], [Name], [ImageName], [VerbName]) VALUES (5, N'שחמט', NULL, N'לשחק שחמט')
INSERT [dbo].[events] ([ID], [Name], [ImageName], [VerbName]) VALUES (6, N'לימוד', NULL, N'ללמוד')
INSERT [dbo].[events] ([ID], [Name], [ImageName], [VerbName]) VALUES (7, N'טבע', NULL, N'לטייל')
INSERT [dbo].[events] ([ID], [Name], [ImageName], [VerbName]) VALUES (8, N'שחיה', NULL, N'לשחות')
INSERT [dbo].[events] ([ID], [Name], [ImageName], [VerbName]) VALUES (11, N'מוסיקה', NULL, N'לנגן')
INSERT [dbo].[events] ([ID], [Name], [ImageName], [VerbName]) VALUES (13, N'ריקודי עם', NULL, N'לרקוד')
SET IDENTITY_INSERT [dbo].[events] OFF
GO
SET IDENTITY_INSERT [dbo].[mach] ON 

INSERT [dbo].[mach] ([ID], [RequestId1], [RequestId2], [Length], [IsActive], [CreateDate], [UpdateDate]) VALUES (2, 4, 12, 1, 1, CAST(N'2022-12-15T12:00:00.000' AS DateTime), CAST(N'2022-12-15T12:00:00.000' AS DateTime))
INSERT [dbo].[mach] ([ID], [RequestId1], [RequestId2], [Length], [IsActive], [CreateDate], [UpdateDate]) VALUES (3, 27, 37, 1, 1, CAST(N'2022-12-15T12:00:00.000' AS DateTime), CAST(N'2022-12-15T12:00:00.000' AS DateTime))
INSERT [dbo].[mach] ([ID], [RequestId1], [RequestId2], [Length], [IsActive], [CreateDate], [UpdateDate]) VALUES (10002, 3, 6, 1, 1, CAST(N'2022-05-19T18:11:38.560' AS DateTime), CAST(N'2022-05-19T18:11:38.560' AS DateTime))
SET IDENTITY_INSERT [dbo].[mach] OFF
GO
SET IDENTITY_INSERT [dbo].[request] ON 

INSERT [dbo].[request] ([ID], [UserID], [DayInWeek], [TimeInDay], [EventID], [IsActive], [CreateDate], [UpdateDate]) VALUES (4, 1, 3, CAST(N'2022-05-20T12:00:00.000' AS DateTime), 6, 1, CAST(N'2022-12-15T12:00:00.000' AS DateTime), CAST(N'2022-12-15T12:00:00.000' AS DateTime))
INSERT [dbo].[request] ([ID], [UserID], [DayInWeek], [TimeInDay], [EventID], [IsActive], [CreateDate], [UpdateDate]) VALUES (12, 3, 3, CAST(N'2022-05-20T12:00:00.000' AS DateTime), 6, 1, CAST(N'2022-12-15T12:00:00.000' AS DateTime), CAST(N'2022-12-15T12:00:00.000' AS DateTime))
INSERT [dbo].[request] ([ID], [UserID], [DayInWeek], [TimeInDay], [EventID], [IsActive], [CreateDate], [UpdateDate]) VALUES (14, 5, 4, CAST(N'2022-05-09T14:00:00.000' AS DateTime), 8, 1, CAST(N'2022-12-15T12:00:00.000' AS DateTime), CAST(N'2022-12-15T12:00:00.000' AS DateTime))
INSERT [dbo].[request] ([ID], [UserID], [DayInWeek], [TimeInDay], [EventID], [IsActive], [CreateDate], [UpdateDate]) VALUES (18, 6, 2, CAST(N'2022-05-16T16:00:00.000' AS DateTime), 11, 1, CAST(N'2022-12-15T12:00:00.000' AS DateTime), CAST(N'2022-12-15T12:00:00.000' AS DateTime))
INSERT [dbo].[request] ([ID], [UserID], [DayInWeek], [TimeInDay], [EventID], [IsActive], [CreateDate], [UpdateDate]) VALUES (24, 8, 2, CAST(N'2022-05-17T21:00:00.000' AS DateTime), 4, 1, CAST(N'2022-12-15T12:00:00.000' AS DateTime), CAST(N'2022-12-15T12:00:00.000' AS DateTime))
INSERT [dbo].[request] ([ID], [UserID], [DayInWeek], [TimeInDay], [EventID], [IsActive], [CreateDate], [UpdateDate]) VALUES (26, 9, 1, CAST(N'2022-05-20T18:00:00.000' AS DateTime), 7, 1, CAST(N'2022-12-15T12:00:00.000' AS DateTime), CAST(N'2022-12-15T12:00:00.000' AS DateTime))
INSERT [dbo].[request] ([ID], [UserID], [DayInWeek], [TimeInDay], [EventID], [IsActive], [CreateDate], [UpdateDate]) VALUES (27, 10, 2, CAST(N'2022-05-21T10:00:00.000' AS DateTime), 3, 1, CAST(N'2022-12-15T12:00:00.000' AS DateTime), CAST(N'2022-12-15T12:00:00.000' AS DateTime))
INSERT [dbo].[request] ([ID], [UserID], [DayInWeek], [TimeInDay], [EventID], [IsActive], [CreateDate], [UpdateDate]) VALUES (31, 11, 5, CAST(N'2022-05-23T15:00:00.000' AS DateTime), 5, 1, CAST(N'2022-12-15T12:00:00.000' AS DateTime), CAST(N'2022-12-15T12:00:00.000' AS DateTime))
INSERT [dbo].[request] ([ID], [UserID], [DayInWeek], [TimeInDay], [EventID], [IsActive], [CreateDate], [UpdateDate]) VALUES (35, 15, 4, CAST(N'2022-05-22T20:00:00.000' AS DateTime), 4, 1, CAST(N'2022-12-15T12:00:00.000' AS DateTime), CAST(N'2022-12-15T12:00:00.000' AS DateTime))
INSERT [dbo].[request] ([ID], [UserID], [DayInWeek], [TimeInDay], [EventID], [IsActive], [CreateDate], [UpdateDate]) VALUES (37, 16, 2, CAST(N'2022-05-21T10:00:00.000' AS DateTime), 3, 1, CAST(N'2022-12-15T12:00:00.000' AS DateTime), CAST(N'2022-12-15T12:00:00.000' AS DateTime))
INSERT [dbo].[request] ([ID], [UserID], [DayInWeek], [TimeInDay], [EventID], [IsActive], [CreateDate], [UpdateDate]) VALUES (38, 3, 2, CAST(N'2022-05-19T16:00:00.000' AS DateTime), 2, 1, CAST(N'2022-05-19T18:08:22.843' AS DateTime), CAST(N'2022-05-19T18:08:22.843' AS DateTime))
INSERT [dbo].[request] ([ID], [UserID], [DayInWeek], [TimeInDay], [EventID], [IsActive], [CreateDate], [UpdateDate]) VALUES (10039, 1, 4, CAST(N'2022-05-05T10:00:00.000' AS DateTime), 3, 1, CAST(N'2022-05-05T00:00:00.000' AS DateTime), CAST(N'2022-05-05T00:00:00.000' AS DateTime))
INSERT [dbo].[request] ([ID], [UserID], [DayInWeek], [TimeInDay], [EventID], [IsActive], [CreateDate], [UpdateDate]) VALUES (10040, 3, 4, CAST(N'2022-05-05T10:00:00.000' AS DateTime), 3, 1, CAST(N'2022-05-05T00:00:00.000' AS DateTime), CAST(N'2022-05-05T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[request] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([ID], [FirstName], [LastName], [Gender], [Email], [Phone], [UniqeID]) VALUES (1, N'אברהם                                                                                               ', N'רבינוביץ                                                                                            ', 0, N'y0583246419@gmail.com                                                                               ', N'0527694481                                                                                          ', N'1B2AC001-D56B-451E-A794-0AFB02E03B0D                                                                ')
INSERT [dbo].[users] ([ID], [FirstName], [LastName], [Gender], [Email], [Phone], [UniqeID]) VALUES (3, N'ראובן                                                                                               ', N'גולדברג                                                                                             ', 0, N'rg542400@gmail.com                                                                                  ', N'0583254240                                                                                          ', N'63D5E2FE-C414-4632-9901-330D135C47BA                                                                ')
INSERT [dbo].[users] ([ID], [FirstName], [LastName], [Gender], [Email], [Phone], [UniqeID]) VALUES (5, N'אליעזר                                                                                              ', N'כהן                                                                                                 ', 0, N'eliezercohen@gmail.com                                                                              ', N'0583246419                                                                                          ', N'63D5E2FE-C414-4632-9901-330D135C47BA                                                                ')
INSERT [dbo].[users] ([ID], [FirstName], [LastName], [Gender], [Email], [Phone], [UniqeID]) VALUES (6, N'נחום                                                                                                ', N'טולידנו                                                                                             ', 0, N'nachumt33981@gmail.com                                                                              ', N'0504133981                                                                                          ', N'EB5C6A0D-D227-47EF-81E3-CB2855E07D65                                                                ')
INSERT [dbo].[users] ([ID], [FirstName], [LastName], [Gender], [Email], [Phone], [UniqeID]) VALUES (8, N'אמיתי                                                                                               ', N'מקסימוב                                                                                             ', 0, N'amaxim0909@gmail.com                                                                                ', N'0504114610                                                                                          ', N'B3D21D26-2E80-4A76-803B-4F2468277DAA                                                                ')
INSERT [dbo].[users] ([ID], [FirstName], [LastName], [Gender], [Email], [Phone], [UniqeID]) VALUES (9, N'נחמה                                                                                                ', N'ירושלמי                                                                                             ', 1, N'212410260b@gmail.com                                                                                ', N'0534145473                                                                                          ', N'0F890F16-8841-4A6F-8983-169DAD4094C5                                                                ')
INSERT [dbo].[users] ([ID], [FirstName], [LastName], [Gender], [Email], [Phone], [UniqeID]) VALUES (10, N'ברכה                                                                                                ', N'קרלינסקי                                                                                            ', 1, N'brachi9912@gmail.com                                                                                ', N'0583259912                                                                                          ', N'B127A8CD-24D2-4E8D-A1EF-FF4FF24EEE43                                                                ')
INSERT [dbo].[users] ([ID], [FirstName], [LastName], [Gender], [Email], [Phone], [UniqeID]) VALUES (11, N'שרה לאה                                                                                             ', N'לוי                                                                                                 ', 1, N'chaimtovim26@gmail.com                                                                              ', N'0548515010                                                                                          ', N'52B6BEC3-B174-44D5-ABCA-588178FE52B2                                                                ')
INSERT [dbo].[users] ([ID], [FirstName], [LastName], [Gender], [Email], [Phone], [UniqeID]) VALUES (15, N'צפורה                                                                                               ', N'בוזגלו                                                                                              ', 1, N'tzippy26@gmail.com                                                                                  ', N'0533170633                                                                                          ', N'BA1EF222-AB9B-4605-AC97-7AC49BA8532C                                                                ')
INSERT [dbo].[users] ([ID], [FirstName], [LastName], [Gender], [Email], [Phone], [UniqeID]) VALUES (16, N'יעל                                                                                                 ', N'רוזן                                                                                                ', 1, N'yaelrozen44@gmail.com                                                                               ', N'0583213226                                                                                          ', N'8A69C052-9EBE-46C9-907C-337F3615E4AA                                                                ')
INSERT [dbo].[users] ([ID], [FirstName], [LastName], [Gender], [Email], [Phone], [UniqeID]) VALUES (17, N'MOSHE                                                                                               ', N'cohen                                                                                               ', 0, N'y0583254741@gmail.com                                                                               ', N'0583254245                                                                                          ', N'4d92cc30-6dd8-48aa-a6dc-638749d129d2                                                                ')
SET IDENTITY_INSERT [dbo].[users] OFF
GO
ALTER TABLE [dbo].[request]  WITH CHECK ADD  CONSTRAINT [FK_request_events] FOREIGN KEY([EventID])
REFERENCES [dbo].[events] ([ID])
GO
ALTER TABLE [dbo].[request] CHECK CONSTRAINT [FK_request_events]
GO
ALTER TABLE [dbo].[request]  WITH CHECK ADD  CONSTRAINT [FK_request_users] FOREIGN KEY([UserID])
REFERENCES [dbo].[users] ([ID])
GO
ALTER TABLE [dbo].[request] CHECK CONSTRAINT [FK_request_users]
GO
USE [master]
GO
ALTER DATABASE [Connections] SET  READ_WRITE 
GO
