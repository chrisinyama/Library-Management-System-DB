--creating my database--
CREATE DATABASE Library_DesignDB;



USE Library_DesignDB;
GO

--Creating all Library_DesignDB tables ---

CREATE TABLE Addresses (
  AddressID Int IDENTITY(1,1) NOT NULL PRIMARY KEY,
  Address_1 nvarchar(100) Not Null,
  Address_2 nvarchar(100) Null,
  City nvarchar(20) NOT NULL,
  Postcode nvarchar(20) NOT NULL
);

CREATE TABLE Members (
   MemberID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
   FirstName nvarchar(50) NOT NULL,
   LastName nvarchar(50) NOT NULL,
   AddressID Int NOT NULL FOREIGN KEY REFERENCES Addresses(AddressID),
   DateOfBirth date NOT NULL,
   Username nvarchar(20) NOT NULL UNIQUE,
   PasswordHash nvarchar(255) NOT NULL,
   Telephone nvarchar (20) NULL,
   Email nvarchar(50) NOT NULL CHECK (Email LIKE '%_@_%._%') UNIQUE,
   c nvarchar(20) NULL,
   MembershipStartDate datetime NOT NULL DEFAULT GETDATE(),
   MembershipEndDate datetime NULL
);


CREATE TABLE ItemTypes (
   item_type_id int IDENTITY(1,1) PRIMARY KEY,
   item_type nvarchar(50) NOT NULL
);

CREATE TABLE CatalogueItems (
    ItemID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Title nvarchar(100) NOT NULL,
    Author nvarchar(50) NOT NULL,
    YearOfPublication date NOT NULL,
    DateAddedToCollection date NOT NULL,
    CurrentStatus nvarchar(20) NOT NULL,
    ISBN nvarchar(50) NULL,
    item_type_id int NOT NULL FOREIGN KEY(item_type_id) REFERENCES ItemTypes(item_type_id),
    CONSTRAINT CK_Ite_CmurrentStatus CHECK (CurrentStatus IN ('On Loan', 'Overdue', 'Available', 'Lost/Removed'))
);

CREATE TABLE Loans (
    LoanID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    MemberID int NOT NULL,
    ItemID int NOT NULL,
    DateTakenOut datetime NOT NULL,
    DueDate datetime NOT NULL,
    DateReturned datetime NULL,
    DaysOverdue  int  NULL,
    CONSTRAINT FK_Loans_Members FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    CONSTRAINT FK_Loans_CatalogueItems FOREIGN KEY (ItemID) REFERENCES CatalogueItems(ItemID)
);

CREATE TABLE OverdueFines (
    OverdueFinesID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    MemberID int NOT NULL,
    OverdueFinesAmount money NOT NULL,
    AmountRepaid money NOT NULL,
    OutstandingBalance money NULL,
    CONSTRAINT FK_Member_OverdueFines FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

CREATE TABLE Repayments (
    RepaymentID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
     MemberID int NOT NULL,
    FineOverdueID int  NOT NULL FOREIGN KEY(FineOverdueID) REFERENCES OverdueFines(OverdueFinesID),
    RepaymentDate datetime NOT NULL,
    RepaymentAmount money NOT NULL,
    RepaymentMethod nvarchar(30) NOT NULL,
    CONSTRAINT FK_Repayments_Members FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

 --Query to Insert Addresses with Multiple Values into Addresses Table--

INSERT INTO Addresses (Address_1, Address_2, City, Postcode)
VALUES 
    ('23 High Street', 'Apartment 4', 'Bristol', 'BS1 4DG'),
    ('22 Oxford Road', NULL, 'Reading', 'RG1 7LG'),
    ('15 Park Lane', NULL, 'London', 'W1K 7RN'),
    ('45 Church Street', NULL, 'Manchester', 'M4 1PW'),
    ('8 Victoria Street', NULL, 'Belfast', 'BT1 3GN'),
    ('5 George Street', NULL, 'Edinburgh', 'EH2 2HT'),
    ('10 Castle Road', NULL, 'Cardiff', 'CF10 3BX'),
    ('12 Broad Street', NULL, 'Nottingham', 'NG1 3AL'),
    ('9 Regent Street', NULL, 'Cambridge', 'CB2 1AA'),
    ('7 High Road', NULL, 'Glasgow', 'G1 1LY');
	   
	   -- Query to Insert Members with Multiple Values into Members Table--
  
INSERT INTO Members (FirstName, LastName, AddressID, DateOfBirth, Username, PasswordHash, Email, Telephone, MembershipStartDate)
VALUES 
    ('John', 'Doe', 1, '1990-01-01', 'johndo', 'password45', 'johndde@gmail.com', '123-456-7890', '2020-01-01'),
    ('Jane', 'Doe', 2, '1992-02-02', 'janedoe', 'password2', 'janedoe@gmail.com', NULL, '2020-01-01'),
    ('Bob', 'Smith', 3, '1985-03-03', 'bobsmith', 'password3', 'bobsmith@gmail.com', '111-222-3333', '2020-01-01'),
    ('Alice', 'Johnson', 4, '1998-04-04', 'alicejohnson', 'password4', 'alicejohnson@gmail.com', '444-555-6666', '2020-01-01'),
    ('Tom', 'Wilson', 4, '1980-05-05', 'tomwilson', 'password5', 'tomwilson@gmail.com', '777-888-9999', '2020-01-01'),
    ('Emily', 'Brown', 1, '1995-06-06', 'emilybrown', 'password6', 'emilybrown@gmail.com', '555-444-3333', '2020-01-01'),
    ('William', 'Davis', 2, '1978-07-07', 'williamdavis', 'password7', 'williamdavis@gmail.com', '999-888-7777', '2020-01-01'),
    ('Olivia', 'Taylor', 3, '1983-08-08', 'oliviataylor', 'password8', 'oliviataylor@gmail.com', '222-333-4444', '2020-01-01'),
    ('George', 'Anderson', 4, '1991-09-09', 'georgeanderson', 'password9', 'georgeanderson@gmail.com', '111-444-7777', '2020-01-01'),
    ('Sophia', 'Wilson', 2, '1989-10-10', 'sophiawilson', 'password34', 'sophiawilson@example.com', NULL, '2020-01-01');


	-- Inserting Item Types into a Table--

INSERT INTO ItemTypes (item_type)
VALUES 
    ('Books'),
    ('journals'),
    ('DVDs'),
    ('Other Media');

 -- insert various Catalogue Items with their details--

INSERT INTO CatalogueItems (Title, item_type_id, Author, YearOfPublication, DateAddedToCollection, CurrentStatus, ISBN)
VALUES 
    ('To Kill a Mockingbird', 1, 'Harper Lee', '1960-07-11', '2022-01-01', 'Available', '978-3-16-148413-0'),
    ('The Lord of the Rings: The Fellowship of the Ring', 1, 'J.R.R. Tolkien', '1954-07-29', '2022-01-01', 'lost/Removed', '978-3-16-148414-0'),
    ('Breaking Bad: The Complete Series', 2, 'Vince Gilligan', '2008-01-20', '2022-01-01', 'Available', NULL),
    ('Friends: The Complete Series', 2, 'David Crane and Marta Kauffman', '1994-09-22', '2022-01-01', 'Overdue', NULL),
    ('Nature', 3, 'John James Audubon', '1827-01-01', '2022-01-01', 'Available', '978-3-16-148415-0'),
    ('Science', 3, 'Stephen Hawking', '2001-06-01', '2022-01-01', 'Lost/Removed', '978-3-16-148416-0'),
    ('Painting with Bob Ross: The Joy of Painting', 4, 'Bob Ross', '1983-01-11', '2022-01-01', 'Available', NULL),
    ('Pink Floyd: The Wall', 4, 'Alan Parker', '1982-09-14', '2022-01-01', 'on loan', NULL),
    ('The New York Times Crossword Puzzles', 4, 'Will Shortz', '1942-02-15', '2022-01-01', 'on loan', NULL),
    ('Rubik''s Cube', 4, 'Erno Rubik', '1974-01-01', '2022-01-01', 'Available', NULL),
    ('The Great Gatsby', 1, 'F. Scott Fitzgerald', '1925-04-10', '2022-01-01', 'on loan', '978-3-16-148410-0'),
    ('The Godfather', 1, 'Mario Puzo', '1969-03-10', '2022-01-01', 'Lost/Removed', '978-3-16-148411-0'),
    ('The Shawshank Redemption', 2, 'Frank Darabont', '1994-09-22', '2022-01-01', 'Overdue', NULL),
    ('Thriller', 3, 'Michael Jackson', '1982-11-30', '2022-01-01', 'Available', '978-3-16-148412-0');

	

	---


	INSERT INTO Loans (MemberID, ItemID, DateTakenOut, DueDate, DateReturned, DaysOverdue)
VALUES 
	(1, 3, '2023-01-01 14:30:00', '2023-01-15 17:00:00' , '2023-01-17 09:00:00', 2),
	(2, 4, '2023-01-02 10:15:00', '2023-04-5 11:30:00', NULL, NULL),
	(3, 5, '2023-01-03 16:45:00', '2023-04-4 12:00:00', NULL, NULL),
	(4, 6, '2023-01-04 12:00:00', '2023-01-18 13:15:00', '2023-01-20 10:30:00', 2),
	(5, 7, '2023-01-05 09:30:00', '2023-01-19 16:45:00', '2023-01-22 14:00:00', 3),
	(1, 8, '2023-01-06 15:00:00', '2023-01-20 09:30:00', NULL, NULL),
	(2, 9, '2023-01-07 11:45:00', '2023-01-21 14:45:00', '2023-01-24 11:00:00', 2),
	(3, 10, '2023-01-08 17:30:00', '2023-01-22 12:00:00', '2023-01-26 15:30:00', 4),
	(4, 11, '2023-01-09 13:15:00', '2023-01-23 15:15:00', NULL, NULL),
	(1, 3, '2023-02-01 14:30:00', '2023-01-15 17:00:00','2023-02-15 17:00:00', 2);



	/*inserting data into the OverdueFines table, which includes Member ID, the amount of overdue fines, 
	the amount repaid, and the outstanding balance for each member */
	

INSERT INTO OverdueFines (MemberID, OverdueFinesAmount, AmountRepaid, OutstandingBalance)
VALUES
  (1, 10.00, 0.00, 10.00),
  (2, 5.50, 1.50, 4.00),
  (3, 20.00, 0.00, 20.00),
  (4, 15.00, 0.00, 15.00),
  (5, 8.75, 0.00, 8.75),
  (6, 12.50, 2.50, 10.00),
  (7, 30.00, 10.00, 20.00),
  (8, 6.25, 0.00, 6.25),
  (9, 18.50, 0.00, 18.50),
  (10, 25.00, 5.00, 20.00);



  -- inserting data into the "Repayments" table, which tracks the repayments made by library members towards their overdue fines--

INSERT INTO Repayments (MemberID, FineOverdueID, RepaymentDate, RepaymentAmount, RepaymentMethod)
VALUES
    (1, 1, '2022-03-15 10:00:00', 5.00, 'Credit Card'),
    (2, 2, '2022-03-20 12:30:00', 2.50, 'cash'),
    (3, 3, '2022-04-01 09:15:00', 10.00, 'Cash'),
    (4, 4, '2022-03-02', 7.50, 'Credit card'),
    (5, 5, '2022-04-01', 10.00, 'Debit card'),
    (6, 6, '2022-04-08', 2.00, 'Cash'),
    (7, 7, '2022-03-18', 5.00, 'Credit card'),
    (2, 3, '2022-03-15', 1.50, 'Cash'),
    (10, 5, '2022-04-01', 7.00, 'Credit Card'),
    (8, 9, '2022-04-05', 2.00, 'cash');


							

/*This stored procedure takes a string parameter for the title and searches the "CatalogueItems" table for
any records where the "Title" column contains the specified string as a substring. The results are then ordered by the "YearOfPublication" column in
descending order. This stored procedure can be called by passing a string value for the "Title" parameter.*/

CREATE PROCEDURE SearchCatalogueByTitle
    @Title nvarchar(100)
AS
BEGIN
    SELECT *
    FROM CatalogueItems
    WHERE Title LIKE '%' + @Title + '%'
    ORDER BY YearOfPublication DESC;
END

--executing stored procedure--

EXEC SearchCatalogueByTitle 'Breaking Bad: The Complete Series'

							

/*This stored procedure, named "FivedaysOverdueItems", selects overdue items that are 5 days past their due date. 
It joins the "CatalogueItems", "Loans", and "Members" tables to obtain the title of the item, 
the date it was taken out, the due date, and the first and last names of the member who borrowed it.*/

CREATE PROCEDURE FivedaysOverdueItems
AS
BEGIN
    SELECT CatalogueItems.Title, Loans.DateTakenOut, Loans.DueDate, Members.FirstName, Members.LastName
    FROM CatalogueItems
    INNER JOIN Loans ON CatalogueItems.ItemID = Loans.ItemID
    INNER JOIN Members ON Loans.MemberID = Members.MemberID
    WHERE Loans.DateReturned IS NULL AND DATEDIFF(day, Loans.DueDate, GETDATE()) < 5;
END;

EXEC FivedaysOverdueItems;



                          

/* This stored procedure, named "FivedaysOverdueItems", selects overdue items that are 5 days past their due date. 
It joins the "CatalogueItems", "Loans", and "Members" tables to obtain the title of the item, the date it was taken out, 
the due date, and the first and last names of the member who borrowed it.*/

CREATE PROCEDURE AddnewMember
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@Address_1 nvarchar(100),
	@Address_2 nvarchar(100),
	@City nvarchar(20),
	@Postcode nvarchar(20),
	@DateOfBirth datetime,
	@Username nvarchar(20),
	@PasswordHash nvarchar(255),
	@Email nvarchar(50),
	@Telephone nvarchar(20),
	@MembershipEndDate datetime NULL
	AS
	BEGIN
	DECLARE @AddressID int
	INSERT INTO Addresses (Address_1, Address_2, City, Postcode)
	VALUES (@Address_1, @Address_2, @City, @Postcode)
	SET @AddressID = SCOPE_IDENTITY()
INSERT INTO Members (FirstName, LastName, AddressID, DateOfBirth, Username, PasswordHash, Email, Telephone, MembershipEndDate)
VALUES (@FirstName, @LastName, @AddressID, @DateOfBirth, @Username, @PasswordHash, @Email, @Telephone, @MembershipEndDate)
END;

-- executING it using the "EXEC" keyword as follows--
EXEC AddnewMember 
	  @FirstName = 'dave',
	  @LastName = 'king',
	  @Address_1 = '63 heys avenue',
	  @Address_2 = 'moorfiled chase ',
	  @City = 'New York',
	  @Postcode = '10001',
	  @DateOfBirth = '1980-01-31',
	  @Username = 'kingdav',
	  @PasswordHash = 'mypasswordhash',
	  @Email = 'dakin@gmail.com',
	  @Telephone = '123-456-7845',
	  @MembershipEndDate = '';
	

	---QUESTION 2 D--
	/*This stored procedure is named "UpdateMemberEmail" and takes two parameters: "MemberID" which is an integer and "NewEmail" 
	which is a string (nvarchar) with a maximum length of 50 characters. It updates the "Email" column 
	in the "Members" table for the specified "MemberID" with the new email address specified in the "NewEmail" parameter.*/
CREATE PROCEDURE UpdateMemberEmail
	@MemberID int,
	@NewEmail nvarchar(50)
AS
BEGIN
	UPDATE Members
	SET Email = @NewEmail
	WHERE MemberID = @MemberID;
END;

EXEC UpdateMemberEmail @MemberID = 1, @NewEmail = 'Chisomeg@.com';





SELECT * FROM Loans

                    
/*The library wants be able to view the loan history, showing all previous 
and currentloans,and including details of the item borrowed, borrowed date,due date and anyassociated fines for each loan. 
You should create a view containing all the requiredinformatio*/

/*This is an SQL query for a function named "CalculateOverdueFees" that takes two parameters @itemID and @overdueDays. 
The function multiplies @overdueDays with 0.10 and returns the result as a decimal value. The SELECT statement calls 
this function with values 1 and 5, and returns the calculated overdue fees as "Overdue Fees".*/
CREATE VIEW LoanHistory AS
SELECT 
    L.LoanID, 
    m.MemberID, 
    m.FirstName, 
    m.LastName, 
    ci.ItemID, 
    ci.Title, 
    L.DateTakenOut,
    L.DueDate, 
    L.DateReturned, 
    L.DaysOverdue, 
    F.OverdueFinesAmount, 
    F.AmountRepaid,
    F.OutstandingBalance,
    CASE 
       WHEN L.DateReturned IS NULL AND L.DueDate < GETDATE() 
            THEN DATEDIFF(day, L.DueDate, GETDATE()) * 0.5 
       WHEN L.DateReturned > L.DueDate 
            THEN DATEDIFF(day, L.DueDate, L.DateReturned) * 0.5 
       ELSE 0 
    END AS Fines
FROM Loans L
INNER JOIN Members M ON L.MemberID = M.MemberID
INNER JOIN CatalogueItems CI ON L.ItemID = CI.ItemID
LEFT JOIN OverdueFines F ON M.MemberID = F.MemberID;

SELECT * FROM LoanHistory





/*Query to Create a trigger so that the current status of an item automatically updates toAvailable when the book is returned*/

/*This "UpdateStatustoavailable"  trigger for the "Loans" table updates the "CurrentStatus" 
column to "Available" in the "CatalogueItems" table if the "DateReturned" column is updated. 
It uses a TRY-CATCH block to handle errors and prints any error messages.*/

 CREATE TRIGGER UpdateStatustoavailable
 ON Loans
 AFTER INSERT, UPDATE
 AS
 BEGIN
 BEGIN TRY
 BEGIN TRANSACTION;
 IF UPDATE(DateReturned)
 BEGIN
         UPDATE CatalogueItems
         SET CurrentStatus = 'Available'
         FROM inserted i
         INNER JOIN Loans l ON i.LoanID = l.LoanID
         INNER JOIN CatalogueItems c ON l.ItemID = c.ItemID
         WHERE l.DateReturned IS NOT NULL
END
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION;

 PRINT ERROR_MESSAGE();
END CATCH;
END;



/*This code counts the number of loans taken out on January 15, 2023, at 5:00 PM, from the Loans table based 
on the DateTakenOut column. The CONVERT function is used to convert the timestamp to a date-only value, and the COUNT function is used to count
the rows that match the condition. The resulting column is given an alias of 'TotalLoans'.*/

SELECT COUNT(*) AS TotalLoans
FROM Loans
WHERE CONVERT(date, DateTakenOut) = '2023-01-15 17:00:00';





CREATE VIEW AvailableItems AS
SELECT Title, Author, item_type, YearOfPublication, DateAddedToCollection, ISBN
FROM CatalogueItems c
JOIN ItemTypes t ON c.item_type_id = t.item_type_id
WHERE CurrentStatus = 'Available'


SELECT * FROM AvailableItems;

-----------QUESTION 7II---
/*This code creates a function named CalculateOverdueFees that takes two integer parameters: @itemID and @overdueDays. 
It calculates overdue fees based on @overdueDays and stores them in a decimal variable named @overdueFees. Finally, 
the function returns the value of @overdueFees.

The SELECT statement executes the function with an @itemID of 1 and @overdueDays of 5, and returns the overdue fees as 'Overdue Fees'.*/

CREATE FUNCTION CalculateOverdueFees
(
    @itemID int,
    @overdueDays int
)
RETURNS decimal(10,2)
AS
BEGIN
    DECLARE @overdueFees decimal(10,2)
    SET @overdueFees = 0.10 * @overdueDays
    RETURN @overdueFees
END;


SELECT dbo.CalculateOverdueFees(1, 5) AS 'Overdue Fees'

/*  sub query that selects the first name and last name of a member 
with MemberID = 1 and calculates their total overdue fines. The sub-query 
uses the MemberID from the outer query to calculate the sum of overdue fines for that specific member.
This result will display the member's first name, last name, and the total amount of overdue fines they owe.*/

SELECT m.FirstName, m.LastName,
    (SELECT SUM(OverdueFinesAmount) 
	FROM OverdueFines WHERE MemberID = m.MemberID) 
	AS TotalOverdueFines
FROM Members m
WHERE m.MemberID = 1;


/*This code creates a stored procedure called GetMemberAddresses, which takes an integer parameter called @MemberID. 
The stored procedure retrieves member details and their addresses from two separate tables using the provided parameter. 
The SET NOCOUNT ON statement suppresses the affected row
count message. Finally, the EXEC statement runs the stored procedure with a @MemberID value of 1.*/

CREATE PROCEDURE GetMemberAddresses
    @MemberID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Retrieving member details
    SELECT *
    FROM Members
    WHERE MemberID = @MemberID;

    -- Retrieving member addresses
    SELECT *
    FROM Addresses
    WHERE AddressID = @MemberID
END;

EXEC GetMemberAddresses @MemberID = 1;




								
--A Trigger to ensure that the PasswordHash column i created  is hashed--

/*This trigger will ensure that the "PasswordHash" column contains a hashed password by using 
the HASHBYTES function to hash the password before inserting or updating the table.*/

CREATE TRIGGER hash_password
ON Members
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE Members
    SET PasswordHash = CONVERT(nvarchar(255), HASHBYTES('SHA2_256', PasswordHash), 2)
END;

--Trigger to calculate membership duration--
/*This trigger will automatically calculate the membership duration and update 
the "MembershipEndDate" column when a new row is inserted or updated*/

CREATE TRIGGER calculate_membership_duration
ON Members
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE Members
    SET MembershipEndDate = DATEADD(year, 1, MembershipStartDate)
    WHERE MembershipEndDate IS NULL
END;
