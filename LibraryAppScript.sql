USE [LibraryApp]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 25/02/2021 23:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[ISBN] [bigint] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Author] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Books_1] PRIMARY KEY CLUSTERED 
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookTransactions]    Script Date: 25/02/2021 23:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookTransactions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ISBN] [bigint] NOT NULL,
	[MemberId] [int] NOT NULL,
	[RequestDate] [date] NOT NULL,
	[DueDate] [date] NOT NULL,
	[Penalty] [float] NOT NULL,
	[Issued] [int] NOT NULL,
 CONSTRAINT [PK_BookTransactions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompletedTransactions]    Script Date: 25/02/2021 23:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompletedTransactions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ISBN] [bigint] NOT NULL,
	[MemberId] [int] NOT NULL,
	[RequestDate] [date] NOT NULL,
	[DueDate] [date] NOT NULL,
	[ReturnDate] [date] NOT NULL,
	[Penalty] [float] NOT NULL,
	[IsReturned] [int] NOT NULL,
 CONSTRAINT [PK_CompletedTransactions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Members]    Script Date: 25/02/2021 23:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Members](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Surname] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Members] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PublicHolidays]    Script Date: 25/02/2021 23:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PublicHolidays](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Date] [date] NOT NULL,
 CONSTRAINT [PK_PublicHolidays] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9780140621006, N'Adventures of Sherlock Holmes', N'Arthur Conan Doyle')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9780143107330, N'Adventures of Tom Sawyer', N'Mark Twain
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9786053607182, N'Mahalle Kahvesi
', N'Sait Faik Abasıyanık
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9786053607465, N'Kayıp Aranıyor', N'Sait Faik Abasıyanık')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9786053607861, N'Lüzumsuz Adam
', N'Sait Faik Abasıyanık
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9786055588991, N'Oliver Twist
', N'Charles Dickens
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9786059350211, N'Define Adası
', N'Robert Louis Stevenson
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9789750719264, N'Ezop Masalları
', N'Ezop
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9789750724435, N'Küçük Prens
', N'Antoine de Saint-Exupéry
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9789750738609, N'Şeker Portakalı
', N'José Mauro de Vasconcelos
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9789750807145, N'İnce Memed
', N'Yaşar Kemal
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9789750812170, N'Nazım Hikmet Bütün Şiirleri
', N'Nâzım Hikmet
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9789750816390, N'Robinson Crusoe
', N'Daniel Defoe
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9789752205321, N'Oz Büyücüsü
', N'L. Frank Baum
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9789753638029, N'Kürk Mantolu Madonna
', N'Sabahattin Ali
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9789754181654, N'Gol Kralı
', N'Aziz Nesin
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9789754582901, N'Sineklerin Tanrısı
', N'William Golding
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9789754589023, N'Suç ve Ceza
', N'Fyodor Dostoyevski
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9789755100074, N'Pıtırcık Satranç Oynuyor
', N'René Goscinny
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9789756841181, N'Beyaz Diş
', N'Jack London
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9789759099077, N'Sefiller
', N'Victor Hugo
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9789944829182, N'Çocuk Kalbi
', N'Edmondo De Amicis
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9789944883085, N'Peter Pan
', N'James Matthew Barrie
')
INSERT [dbo].[Books] ([ISBN], [Name], [Author]) VALUES (9789944888417, N'La Fontaine Masalları
', N'Jean de La Fontaine
')
GO
SET IDENTITY_INSERT [dbo].[BookTransactions] ON 

INSERT [dbo].[BookTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [Penalty], [Issued]) VALUES (16, 9780140621006, 1, CAST(N'2021-02-24' AS Date), CAST(N'2021-02-24' AS Date), 0, 1)
INSERT [dbo].[BookTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [Penalty], [Issued]) VALUES (17, 9780143107330, 2, CAST(N'2021-02-24' AS Date), CAST(N'2021-02-23' AS Date), 0.2, 1)
INSERT [dbo].[BookTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [Penalty], [Issued]) VALUES (18, 9789756841181, 4, CAST(N'2021-02-24' AS Date), CAST(N'2021-02-22' AS Date), 0.4, 1)
INSERT [dbo].[BookTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [Penalty], [Issued]) VALUES (19, 9789944829182, 7, CAST(N'2021-02-24' AS Date), CAST(N'2021-02-21' AS Date), 0.8, 1)
INSERT [dbo].[BookTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [Penalty], [Issued]) VALUES (20, 9786059350211, 8, CAST(N'2021-02-24' AS Date), CAST(N'2021-02-20' AS Date), 1.4000000000000001, 1)
INSERT [dbo].[BookTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [Penalty], [Issued]) VALUES (21, 9789750719264, 14, CAST(N'2021-02-24' AS Date), CAST(N'2021-02-19' AS Date), 2.4000000000000004, 1)
INSERT [dbo].[BookTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [Penalty], [Issued]) VALUES (22, 9789754181654, 11, CAST(N'2021-02-24' AS Date), CAST(N'2021-02-18' AS Date), 4, 1)
INSERT [dbo].[BookTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [Penalty], [Issued]) VALUES (23, 9789750807145, 1, CAST(N'2021-02-24' AS Date), CAST(N'2021-02-17' AS Date), 6.6, 1)
INSERT [dbo].[BookTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [Penalty], [Issued]) VALUES (24, 9786053607465, 3, CAST(N'2021-02-24' AS Date), CAST(N'2021-02-25' AS Date), 0, 1)
INSERT [dbo].[BookTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [Penalty], [Issued]) VALUES (25, 9789750724435, 17, CAST(N'2021-02-24' AS Date), CAST(N'2021-02-26' AS Date), 0, 1)
INSERT [dbo].[BookTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [Penalty], [Issued]) VALUES (26, 9789753638029, 6, CAST(N'2021-02-24' AS Date), CAST(N'2021-02-27' AS Date), 0, 1)
INSERT [dbo].[BookTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [Penalty], [Issued]) VALUES (27, 9789944888417, 15, CAST(N'2021-02-24' AS Date), CAST(N'2021-04-07' AS Date), 0, 1)
SET IDENTITY_INSERT [dbo].[BookTransactions] OFF
GO
SET IDENTITY_INSERT [dbo].[CompletedTransactions] ON 

INSERT [dbo].[CompletedTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [ReturnDate], [Penalty], [IsReturned]) VALUES (2, 9786053607182, 1, CAST(N'2021-02-24' AS Date), CAST(N'2021-02-23' AS Date), CAST(N'2021-02-24' AS Date), 0.2, 1)
INSERT [dbo].[CompletedTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [ReturnDate], [Penalty], [IsReturned]) VALUES (4, 9780143107330, 3, CAST(N'2021-02-24' AS Date), CAST(N'2021-02-21' AS Date), CAST(N'2021-02-24' AS Date), 0.60000000000000009, 1)
INSERT [dbo].[CompletedTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [ReturnDate], [Penalty], [IsReturned]) VALUES (5, 9789944829182, 14, CAST(N'2021-02-24' AS Date), CAST(N'2021-02-25' AS Date), CAST(N'2021-02-24' AS Date), 0, 1)
INSERT [dbo].[CompletedTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [ReturnDate], [Penalty], [IsReturned]) VALUES (6, 9789750719264, 6, CAST(N'2021-02-24' AS Date), CAST(N'2021-02-18' AS Date), CAST(N'2021-02-24' AS Date), 6, 1)
INSERT [dbo].[CompletedTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [ReturnDate], [Penalty], [IsReturned]) VALUES (7, 9786053607465, 2, CAST(N'2021-02-24' AS Date), CAST(N'2021-02-17' AS Date), CAST(N'2021-02-24' AS Date), 11.2, 1)
INSERT [dbo].[CompletedTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [ReturnDate], [Penalty], [IsReturned]) VALUES (8, 9789753638029, 17, CAST(N'2021-02-24' AS Date), CAST(N'2021-02-26' AS Date), CAST(N'2021-02-24' AS Date), 0, 1)
INSERT [dbo].[CompletedTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [ReturnDate], [Penalty], [IsReturned]) VALUES (9, 9789750738609, 9, CAST(N'2021-02-24' AS Date), CAST(N'2021-02-27' AS Date), CAST(N'2021-02-24' AS Date), 0, 1)
INSERT [dbo].[CompletedTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [ReturnDate], [Penalty], [IsReturned]) VALUES (10, 9789750816390, 1, CAST(N'2021-02-24' AS Date), CAST(N'2021-02-22' AS Date), CAST(N'2021-02-24' AS Date), 0.4, 1)
INSERT [dbo].[CompletedTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [ReturnDate], [Penalty], [IsReturned]) VALUES (11, 9789752205321, 2, CAST(N'2021-02-24' AS Date), CAST(N'2021-02-23' AS Date), CAST(N'2021-02-24' AS Date), 0.2, 1)
INSERT [dbo].[CompletedTransactions] ([Id], [ISBN], [MemberId], [RequestDate], [DueDate], [ReturnDate], [Penalty], [IsReturned]) VALUES (12, 9786053607182, 15, CAST(N'2021-02-24' AS Date), CAST(N'2021-04-07' AS Date), CAST(N'2021-02-24' AS Date), 0, 1)
SET IDENTITY_INSERT [dbo].[CompletedTransactions] OFF
GO
SET IDENTITY_INSERT [dbo].[Members] ON 

INSERT [dbo].[Members] ([Id], [Name], [Surname]) VALUES (1, N'Cem', N'KILIÇ')
INSERT [dbo].[Members] ([Id], [Name], [Surname]) VALUES (2, N'Rana
', N'Altınoklu
')
INSERT [dbo].[Members] ([Id], [Name], [Surname]) VALUES (3, N'Memet Ali
', N'Ardıç
')
INSERT [dbo].[Members] ([Id], [Name], [Surname]) VALUES (4, N'İzlem
', N'Arınç
')
INSERT [dbo].[Members] ([Id], [Name], [Surname]) VALUES (5, N'Ayşegül
', N'Barutçuoğlu
')
INSERT [dbo].[Members] ([Id], [Name], [Surname]) VALUES (6, N'Bensu
', N'Batur
')
INSERT [dbo].[Members] ([Id], [Name], [Surname]) VALUES (7, N'Gökmen
', N'Battal
')
INSERT [dbo].[Members] ([Id], [Name], [Surname]) VALUES (8, N'Ogün
', N'Bölge
')
INSERT [dbo].[Members] ([Id], [Name], [Surname]) VALUES (9, N'Mehmet Can
', N'Akçaözoğlu
')
INSERT [dbo].[Members] ([Id], [Name], [Surname]) VALUES (10, N'Mustafa Taha
', N'Canbek
')
INSERT [dbo].[Members] ([Id], [Name], [Surname]) VALUES (11, N'Mustafa Kerem
', N'Cansu
')
INSERT [dbo].[Members] ([Id], [Name], [Surname]) VALUES (12, N'Özgür
', N'Choi
')
INSERT [dbo].[Members] ([Id], [Name], [Surname]) VALUES (13, N'Oğuzcan
', N'Coşandal
')
INSERT [dbo].[Members] ([Id], [Name], [Surname]) VALUES (14, N'Sena
', N'Çekmecelioğlu
')
INSERT [dbo].[Members] ([Id], [Name], [Surname]) VALUES (15, N'Efecan
', N'Çetintaş
')
INSERT [dbo].[Members] ([Id], [Name], [Surname]) VALUES (17, N'Nihal
', N'İlısu
')
SET IDENTITY_INSERT [dbo].[Members] OFF
GO
SET IDENTITY_INSERT [dbo].[PublicHolidays] ON 

INSERT [dbo].[PublicHolidays] ([Id], [Name], [Date]) VALUES (1, N'Yeni Yıl Tatili', CAST(N'2021-01-01' AS Date))
INSERT [dbo].[PublicHolidays] ([Id], [Name], [Date]) VALUES (2, N'Ulusal Egemenlik ve Çocuk Bayramı', CAST(N'2021-04-23' AS Date))
INSERT [dbo].[PublicHolidays] ([Id], [Name], [Date]) VALUES (3, N'Emek ve Dayanışma Günü', CAST(N'2021-05-01' AS Date))
INSERT [dbo].[PublicHolidays] ([Id], [Name], [Date]) VALUES (4, N'Ramazan Bayramı - 1. Gün', CAST(N'2021-05-13' AS Date))
INSERT [dbo].[PublicHolidays] ([Id], [Name], [Date]) VALUES (5, N'Ramazan Bayramı - 2. Gün', CAST(N'2021-05-14' AS Date))
INSERT [dbo].[PublicHolidays] ([Id], [Name], [Date]) VALUES (6, N'Ramazan Bayramı - 3. Gün', CAST(N'2021-05-15' AS Date))
INSERT [dbo].[PublicHolidays] ([Id], [Name], [Date]) VALUES (7, N'Atatürk''ü Anma Gençlik ve Spor Bayramı', CAST(N'2021-05-19' AS Date))
INSERT [dbo].[PublicHolidays] ([Id], [Name], [Date]) VALUES (8, N'Demokrasi ve Milli Birlik Günü', CAST(N'2021-07-15' AS Date))
INSERT [dbo].[PublicHolidays] ([Id], [Name], [Date]) VALUES (9, N'Kurban Bayramı - 1. Gün', CAST(N'2021-07-20' AS Date))
INSERT [dbo].[PublicHolidays] ([Id], [Name], [Date]) VALUES (10, N'Kurban Bayramı - 2. Gün', CAST(N'2021-07-21' AS Date))
INSERT [dbo].[PublicHolidays] ([Id], [Name], [Date]) VALUES (11, N'Kurban Bayramı - 3. Gün', CAST(N'2021-07-22' AS Date))
INSERT [dbo].[PublicHolidays] ([Id], [Name], [Date]) VALUES (12, N'Kurban Bayramı - 4. Gün', CAST(N'2021-07-23' AS Date))
INSERT [dbo].[PublicHolidays] ([Id], [Name], [Date]) VALUES (13, N'Zafer Bayramı', CAST(N'2021-08-30' AS Date))
INSERT [dbo].[PublicHolidays] ([Id], [Name], [Date]) VALUES (14, N'Cumhuriyet Bayramı', CAST(N'2021-10-29' AS Date))
SET IDENTITY_INSERT [dbo].[PublicHolidays] OFF
GO
ALTER TABLE [dbo].[BookTransactions]  WITH CHECK ADD  CONSTRAINT [FK_BookTransactions_Books1] FOREIGN KEY([ISBN])
REFERENCES [dbo].[Books] ([ISBN])
GO
ALTER TABLE [dbo].[BookTransactions] CHECK CONSTRAINT [FK_BookTransactions_Books1]
GO
ALTER TABLE [dbo].[BookTransactions]  WITH CHECK ADD  CONSTRAINT [FK_BookTransactions_Members] FOREIGN KEY([MemberId])
REFERENCES [dbo].[Members] ([Id])
GO
ALTER TABLE [dbo].[BookTransactions] CHECK CONSTRAINT [FK_BookTransactions_Members]
GO
ALTER TABLE [dbo].[CompletedTransactions]  WITH CHECK ADD  CONSTRAINT [FK_CompletedTransactions_Books] FOREIGN KEY([ISBN])
REFERENCES [dbo].[Books] ([ISBN])
GO
ALTER TABLE [dbo].[CompletedTransactions] CHECK CONSTRAINT [FK_CompletedTransactions_Books]
GO
ALTER TABLE [dbo].[CompletedTransactions]  WITH CHECK ADD  CONSTRAINT [FK_CompletedTransactions_Members] FOREIGN KEY([MemberId])
REFERENCES [dbo].[Members] ([Id])
GO
ALTER TABLE [dbo].[CompletedTransactions] CHECK CONSTRAINT [FK_CompletedTransactions_Members]
GO
/****** Object:  StoredProcedure [dbo].[sp_SearchBook]    Script Date: 25/02/2021 23:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[sp_SearchBook]
(
	@Name nvarchar(100) = null,
	@Author nvarchar(100) = null,
	@ISBN nvarchar(100) = null
)As
Select b.Name, b.Author, b.ISBN, t.DueDate, t.Issued From Books as b Left Join BookTransactions as t On b.ISBN = t.ISBN 
Where b.Name like '%' + @Name + '%' and b.Author like '%' + @Author + '%' and b.ISBN like '%' + @ISBN + '%'
Order By b.Name
GO
