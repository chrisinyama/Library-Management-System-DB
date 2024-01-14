# Library-Management-System-DB
![Library Management System](https://github.com/chrisinyama/Library-Management-System-DB/raw/main/Library.jpg)


A comprehensive SQL database designed for managing library operations, including member details, item cataloging, loans, fines, and more.

## Table of Contents

1. [Introduction](#introduction)
2. [Features](#features)
3. [Database Structure](#database-structure)
4. [Usage](#usage)
5. [Stored Procedures](#stored-procedures)
6. [Triggers](#triggers)
7. [Views](#views)
8. [Queries and Functions](#queries-and-functions)
9. [Contributing](#contributing)


## Introduction

The Library Management Database is a robust SQL-based system aimed at effectively organizing library resources and managing member interactions. This database provides functionalities for cataloging items, tracking loans, calculating fines, and maintaining member details.

## Features

- **Member Management:** Track member details, including personal information and membership status.
- **Cataloging:** Organize and manage a collection of various item types, including books, journals, DVDs, and other media.
- **Loans and Returns:** Monitor loaned items, due dates, returns, and calculate fines for overdue items.
- **Automated Triggers:** Includes triggers to automatically update item status upon return and hash member passwords for security.

## Database Structure

The database comprises several interconnected tables:
- Addresses
- Members
- ItemTypes
- CatalogueItems
- Loans
- OverdueFines
- Repayments

An ER diagram or textual description showcasing the relationships and structure 
![Entity Relationship Diagram](https://github.com/chrisinyama/Library-Management-System-DB/raw/main/Entity%20Relationship%20Diagram.png)


## Usage

### Setup
1. Clone this repository.
2. Execute the SQL script in your SQL Server Management Studio.
3. Run the provided stored procedures to interact with the database.

### Prerequisites
- SQL Server Management Studio

## Stored Procedures

The project includes several stored procedures:
- `SearchCatalogueByTitle`: Searches the catalog by a specified title substring.
- `FivedaysOverdueItems`: Fetches items overdue by 5 days.
- `AddNewMember`: Adds a new member to the database.
- `UpdateMemberEmail`: Updates a member's email address.
- ... (Add descriptions for each stored procedure)

## Triggers

- `UpdateStatustoavailable`: Automatically updates item status to "Available" on return.
- `hash_password`: Hashes the password for the PasswordHash column.
- `calculate_membership_duration`: Calculates membership end date upon insertion or update.

## Views

- `LoanHistory`: View to display loan history, including borrowed items, dates, fines, and member details.
- `AvailableItems`: View of all available items in the library.

## Queries and Functions

- `CalculateOverdueFees`: Function to calculate overdue fees based on item and overdue days.
- Specific queries and functions used for data retrieval and calculation.

  ## Limitations

- The database currently lacks support for multi-level authentication, potentially limiting security measures.
- Limited optimization for handling a significantly large number of concurrent transactions.
- (Any other known limitations)

## Recommendations

- Enhance security by implementing stronger encryption methods for sensitive data.
- Optimize database indexes and query performance for scaling with increased data volume.
  

## Usage/Examples

- **Executing Stored Procedures:** Example queries to interact with stored procedures.
  
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


## Contributing

Contributions are welcome! Please follow the guidelines  to contribute to this project.


