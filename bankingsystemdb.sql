DROP DATABASE IF EXISTS bankingsystemdb;

CREATE DATABASE bankingsystemdb;
USE bankingsystemdb;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Address VARCHAR(100),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20),
    SSN VARCHAR(20) UNIQUE NOT NULL,
    Username VARCHAR(50) UNIQUE,
    Passkey VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    AccountNumber VARCHAR(20) UNIQUE, 
    AccountType VARCHAR(50),
    Balance DECIMAL(18, 2),
    OpenDate DATE,
    Account_Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    CustomerID INT,
    TransactionType VARCHAR(50),
    Amount DECIMAL(18, 2),
    TransactionDate DATETIME,
    Transaction_Description VARCHAR(200),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Beneficiaries (
    BeneficiaryID INT PRIMARY KEY,
    CustomerID INT,
    Beneficiary_Name VARCHAR(100),
    AccountNumber VARCHAR(20),
    BankName VARCHAR(100),
    Beneficiary_Description VARCHAR(200),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    CustomerID INT,
    LoanNumber VARCHAR(20) UNIQUE,
    LoanAmount DECIMAL(18, 2),
    InterestRate DECIMAL(5, 2),
    LoanType VARCHAR(50),
    LoanStatus VARCHAR(20),
    RepaymentPeriod INT,
    EmiAmount DECIMAL(18, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    LoanID INT,
    Amount DECIMAL(18, 2),
    PaymentDate DATETIME,
    Payment_Status VARCHAR(20),
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID)
);

CREATE TABLE CreditCards (
    CardID INT PRIMARY KEY,
    CustomerID INT,
    CardNumber VARCHAR(20) UNIQUE,
    ExpiryDate DATE,
    CVV INT,
    CreditLimit DECIMAL(18, 2),
    AvailableCredit DECIMAL(18, 2),
    CardStatus VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE ATMTransactions (
    TransactionID INT PRIMARY KEY,
    CustomerID INT,
    CardID INT,
    TransactionType VARCHAR(50),
    Amount DECIMAL(18, 2),
    TransactionDate DATETIME,
    ATMLocation VARCHAR(100),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (CardID) REFERENCES CreditCards(CardID)
);

CREATE TABLE Branches (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(100),
    Location VARCHAR(100),
    PhoneNumber VARCHAR(20)
);

CREATE TABLE RegularCustomers (
    CustomerID INT PRIMARY KEY,
    MembershipLevel VARCHAR(50),
    PurchaseHistory VARCHAR(500),
    Preferences VARCHAR(200),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE CorporateCustomers (
    CustomerID INT PRIMARY KEY,
    CompanyName VARCHAR(100),
    CorporateID VARCHAR(50),
    ContactPerson VARCHAR(100),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE PremiumCustomers (
    CustomerID INT PRIMARY KEY,
    VIPStatus VARCHAR(20),
    ExclusiveOffers VARCHAR(500),
    ConciergeService VARCHAR(200),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE DepositTransactions (
    TransactionID INT PRIMARY KEY,
    DepositLocation VARCHAR(100),
    SourceOfFunds VARCHAR(200),
    DepositReason VARCHAR(200),
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID)
);

CREATE TABLE WithdrawalTransactions (
    TransactionID INT PRIMARY KEY,
    WithdrawalMethod VARCHAR(50),
    WithdrawalReason VARCHAR(200),
    ATMUsed BOOLEAN,
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID)
);

CREATE TABLE TransferTransactions (
    TransactionID INT PRIMARY KEY,
    TransferDestination VARCHAR(200),
    TransferType VARCHAR(50),
    TransferFee DECIMAL(18, 2),
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID)
);

CREATE TABLE SavingsAccount (
    AccountID INT PRIMARY KEY,
    InterestRate DECIMAL(5, 2),
    MinimumBalance DECIMAL(18, 2),
    CompoundingPeriod VARCHAR(50),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE CheckingAccount (
    AccountID INT PRIMARY KEY,
    OverdraftLimit DECIMAL(18, 2),
    TransactionLimit INT,
    DebitCardUsed BOOLEAN,
    CheckbookUsedStatus VARCHAR(20),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

INSERT INTO Customers (CustomerID, FirstName, LastName, DateOfBirth, Address, Email, PhoneNumber, SSN, Username, Passkey)
VALUES
    (0000001, 'Kwame', 'Addo', '1990-05-15', 'Accra, Ghana', 'kwameaddo@gmail.com', '0501234567', '345904345', 'kwameaddo123', 'add1kwamz$'),
    (0000002, 'Akua', 'Boateng', '1985-08-22', 'Kumasi, Ghana', 'akuaboateng@yahoo.com', '0249876543', '943234223', 'akuaboa123', 'boataku85'),
	(0000003, 'Yaw', 'Annan', '1992-04-30', 'Tema, Ghana', 'yawan@gmail.com', '0201122334', '567890123', 'annayaw', 'yawan92$'),
    (0000004, 'Ama', 'Owusu', '1988-11-10', 'Sunyani, Ghana', 'amaowusu@yahoo.com', '0577654321', '234567890', 'owusuama', 'amowusu88'),
    (0000005, 'Kwesi', 'Appiah', '1995-09-18', 'Cape Coast, Ghana', 'appiahkwesi@gmail.com', '0271234567', '098765432', 'appiahk', 'kwesi1234'),
    (0000006, 'Akosua', 'Mensah', '1983-07-05', 'Takoradi, Ghana', 'akosmensah@yahoo.com', '0549876543', '876543210', 'mensahak', 'akosmensah83'),
    (0000007, 'Kofi', 'Yeboah', '1998-12-27', 'Ho, Ghana', 'kofiy@yahoo.com', '0508765432', '123456789', 'yeboahkofi', 'kofiy98$'),
    (0000008, 'Adwoa', 'Asante', '1987-06-14', 'Tamale, Ghana', 'adwoaasante@gmail.com', '0241122334', '456789012', 'asanteadwoa', 'ada87woa'),
    (0000009, 'Kweku', 'Osei', '1993-03-08', 'Bolgatanga, Ghana', 'oseikweku@yahoo.com', '0541122334', '789012345', 'oseik', 'kweku123'),
    (0000010, 'Afia', 'Ampofo', '1980-02-20', 'Wa, Ghana', 'ampofa@yahoo.com', '0208765432', '901234567', 'ampofa', 'afia1980!'),	
    (0000011, 'Gregory', 'Thompson', '1978-06-25', '123 Main St, Anytown', 'gregorythompson@gmail.com', '0501111222', '12121212', 'gregthompson', 'passGreg01'),
    (0000012, 'Jane', 'Smith', '1985-03-12', '456 Elm St, Otherville', 'janesmith@yahoo.com', '0243333444', '432567890', 'janesmith', 'janeySmi85'),
    (0000013, 'Michael', 'Johnson', '1990-09-30', '789 Oak St, Anycity', 'michaeljohnson@gmail.com', '0275555666', '345678901', 'mikejohn', 'johnMike90'),
    (0000014, 'Emily', 'Brown', '1982-11-18', '111 Pine St, Somewhere', 'emilybrown@yahoo.com', '0547777888', '765489012', 'emilybrown', 'emBrown82'),
    (0000015, 'David', 'Wilson', '1976-08-07', '999 Cedar St, Anywhere', 'davidwilson@gmail.com', '0509999000', '567000123', 'davidwilson', 'davWilson76'),
    (0000016, 'Sophia', 'Lee', '1995-02-14', '222 Spruce St, Nowhere', 'sophialee@yahoo.com', '0241111222', '678901234', 'sophialee', 'sophLee95'),
    (0000017, 'Daniel', 'Clark', '1988-04-03', '777 Birch St, Anyplace', 'danielclark@gmail.com', '0278888999', '098712345', 'danclark', 'dannyClark88'),
    (0000018, 'Olivia', 'Martinez', '1980-12-20', '333 Maple St, Anyville', 'oliviamartinez@yahoo.com', '0542222333', '890123456', 'oliviam', 'oliveMart80'),
    (0000019, 'William', 'Taylor', '1993-05-17', '444 Walnut St, Somewhen', 'williamtaylor@gmail.com', '0504444555', '901333567', 'willtaylor', 'willTay93'),
    (0000020, 'Ava', 'Anderson', '1987-10-10', '555 Hickory St, Anytime', 'avaanderson@yahoo.com', '0246666777', '012345678', 'avaanderson', 'avaAnd87'),
    (0000021, 'Grace', 'Kwame', '1994-09-08', 'Accra, Ghana', 'gracekwame@gmail.com', '0501212121', '987654321', 'gracekwame', 'grace1234'),
    (0000022, 'Paul', 'Owusu', '1989-03-25', 'Kumasi, Ghana', 'paulowusu@yahoo.com', '0244343434', '876111220', 'paulowu', 'paulowu89!'),
    (0000023, 'Esther', 'Annan', '1996-12-10', 'Tema, Ghana', 'estherannan@gmail.com', '0206767676', '765432109', 'estherannan', 'annanesther96'),
    (0000024, 'Samuel', 'Darko', '1986-07-30', 'Sunyani, Ghana', 'samdarko@yahoo.com', '0577878787', '654321098', 'samdarko', 'samDarko86'),
    (0000025, 'Nana', 'Appiah', '1991-04-28', 'Cape Coast, Ghana', 'nanaappiah@gmail.com', '0271313131', '543210987', 'nanaAppiah', 'nanaApp91!'),
    (0000026, 'Sandra', 'Mensah', '1984-10-15', 'Takoradi, Ghana', 'sandramensah@yahoo.com', '0549444444', '432109876', 'sandramensah', 'sandMens84'),
    (0000027, 'Alex', 'Yeboah', '1999-01-02', 'Ho, Ghana', 'alexy@yahoo.com', '0508989898', '321098765', 'alexyeboah', 'alexYebo99'),
    (0000028, 'Esi', 'Asante', '1983-06-24', 'Tamale, Ghana', 'esiasante@gmail.com', '0241555555', '210987654', 'esiasante', 'esiAsante83'),
    (0000029, 'Kwame', 'Osei', '1997-03-14', 'Bolgatanga, Ghana', 'kwameosei@yahoo.com', '0541666666', '109876543', 'kwameosei', 'kwameOsei97'),
    (0000030, 'Ama', 'Ampofo', '1981-02-10', 'Wa, Ghana', 'amaampofo@yahoo.com', '0202323232', '121154321', 'amaampofo', 'amaAmpo80!')

    ;

INSERT INTO RegularCustomers (CustomerID, MembershipLevel, PurchaseHistory, Preferences)
VALUES
    (0000001, 'Standard', 'Various purchases across different categories.', 'No specific preferences'),
    (0000002, 'Bronze', 'Frequent purchases in electronics and clothing.', 'Prefers online shopping'),
    (0000003, 'Silver', 'Regular purchases in groceries and household items.', 'Prefers discounts and offers'),
    (0000004, 'Gold', 'High-value purchases in luxury goods and travel.', 'Prefers personalized services'),
    (0000005, 'Platinum', 'Exclusive purchases in premium brands and services.', 'Prefers VIP treatment'),
    (0000006, 'Standard', 'Regular shopping for everyday essentials.', 'No specific preferences'),
    (0000007, 'Bronze', 'Frequent purchases in books and music.', 'Prefers online streaming services'),
    (0000008, 'Silver', 'Regular purchases in sports equipment and outdoor gear.', 'Prefers loyalty programs'),
    (0000009, 'Gold', 'High-value purchases in tech gadgets and accessories.', 'Prefers exclusive deals'),
    (0000010, 'Platinum', 'Exclusive purchases in high-end fashion and fine dining.', 'Prefers personalized shopping experiences')
;

INSERT INTO Accounts (AccountID, CustomerID, AccountNumber, AccountType, Balance, OpenDate, Account_Status)
VALUES
    (01001, 0000001, 'A123456789', 'Savings', 5000.00, '2023-11-01', 'Active'),
    (02001, 0000002, 'A987654321', 'Checking', 10000.00, '2023-11-03', 'Active'),
    (03001, 0000003, 'A567890123', 'Savings', 7500.00, '2023-11-05', 'Active'),
    (04001, 0000004, 'A234567890', 'Checking', 3000.00, '2023-11-08', 'Active'),
    (05001, 0000005, 'A345678901', 'Savings', 9000.00, '2023-11-10', 'Active'),
    (06001, 0000006, 'A789012345', 'Checking', 6000.00, '2023-11-15', 'Active'),
    (07001, 0000007, 'A456789012', 'Savings', 4000.00, '2023-11-18', 'Active'),
    (08001, 0000008, 'A678901234', 'Checking', 8500.00, '2023-11-20', 'Active'),
    (09001, 0000009, 'A890123456', 'Savings', 7200.00, '2023-11-23', 'Active'),
    (10001, 0000010, 'A901234567', 'Checking', 5500.00, '2023-11-25', 'Active')
    ;

INSERT INTO SavingsAccount (AccountID, InterestRate, MinimumBalance, CompoundingPeriod)
VALUES
    (01001, 3.5, 1000.00, 'Monthly'),
    (02001, 4.2, 1500.00, 'Quarterly'),
    (03001, 2.8, 800.00, 'Yearly'),
    (04001, 3.0, 1200.00, 'Semi-Annually'),
    (05001, 4.5, 2000.00, 'Monthly'),
    (06001, 3.7, 1100.00, 'Quarterly'),
    (07001, 2.5, 1000.00, 'Yearly'),
    (08001, 4.0, 1800.00, 'Semi-Annually'),
    (09001, 3.3, 1300.00, 'Monthly'),
    (10001, 4.8, 2500.00, 'Quarterly')
    ;

INSERT INTO CheckingAccount (AccountID, OverdraftLimit, TransactionLimit, DebitCardUsed, CheckbookUsedStatus)
VALUES
    (01001, 500.00, 50, TRUE, 'Active'),
    (02001, 1000.00, 100, TRUE, 'Active'),
    (03001, 700.00, 70, FALSE, 'Inactive'),
    (04001, 300.00, 30, TRUE, 'Active'),
    (05001, 1200.00, 120, TRUE, 'Active'),
    (06001, 800.00, 80, FALSE, 'Inactive'),
    (07001, 1500.00, 150, TRUE, 'Active'),
    (08001, 600.00, 60, TRUE, 'Active'),
    (09001, 900.00, 90, FALSE, 'Inactive'),
    (10001, 1100.00, 110, TRUE, 'Active')
;

INSERT INTO CorporateCustomers (CustomerID, CompanyName, CorporateID, ContactPerson)
VALUES
    (0000011, 'Miggings Corporation', 'CORP123', 'Gregory Thompson'),
    (0000012, 'KALIGROUP Enterprises', 'CORP456', 'Jane Smith'),
    (0000013, 'Kpogas Ltd', 'CORP789', 'Michael Johnson'),
    (0000014, 'Bel Inc', 'CORP234', 'Emily Brown'),
    (0000015, 'Howard Group', 'CORP567', 'David Wilson'),
    (0000016, 'BCC Industries', 'CORP890', 'Sophia Lee'),
    (0000017, 'The Best Company', 'CORP345', 'Daniel Clark'),
    (0000018, 'Technolink Corporation', 'CORP678', 'Olivia Martinez'),
    (0000019, 'JFK Holdings', 'CORP901', 'William Taylor'),
    (0000021, 'Linocell Enterprises', 'CORP123', 'Ava Anderson')
;

INSERT INTO PremiumCustomers (CustomerID, VIPStatus, ExclusiveOffers, ConciergeService)
VALUES
    (0000021, 'Gold', 'Access to premium lounges, Exclusive discounts', '24/7 dedicated customer service'),
    (0000022, 'Platinum', 'Exclusive travel packages, High-end rewards', 'Personal concierge for bookings'),
    (0000023, 'Silver', 'Customized investment options, Special events access', 'Dedicated assistance for queries'),
    (0000024, 'Gold', 'Exclusive dining experiences, Tailored financial planning', 'Priority services for reservations'),
    (0000025, 'Platinum', 'Luxury travel arrangements, Unique lifestyle benefits', 'Personalized assistance for needs'),
    (0000026, 'Silver', 'Premium shopping vouchers, Access to VIP events', 'Specialized assistance and support'),
    (0000027, 'Gold', 'VIP event invites, Personalized account management', 'Enhanced support for premium services'),
    (0000028, 'Platinum', 'Exclusive offers on luxury products, Personalized advice', 'Tailored support for needs'),
    (0000029, 'Silver', 'Specialized rewards program, Priority service access', 'Enhanced customer support services'),
    (0000030, 'Gold', 'Exclusive access to events, Tailored wealth management', 'Dedicated support for inquiries')
;

INSERT INTO Transactions (TransactionID, CustomerID, TransactionType, Amount, TransactionDate, Transaction_Description)
VALUES
    (111, 0000001, 'Deposit', 500.00, '2023-11-05 09:30:00', 'Deposit of salary'),
    (211, 0000002, 'Withdrawal', 100.00, '2023-11-06 14:15:00', 'ATM withdrawal'),
    (311, 0000001, 'Transfer', 250.00, '2023-11-08 11:45:00', 'Transfer to friend'),
    (411, 0000001, 'Deposit', 1000.00, '2023-11-10 16:20:00', 'Deposit of savings'),
    (511, 0000001, 'Withdrawal', 300.00, '2023-11-12 13:00:00', 'Cash withdrawal'),
    (611, 0000001, 'Transfer', 150.00, '2023-11-15 10:30:00', 'Transfer to family member'),
    (711, 00000013, 'Deposit', 800.00, '2023-11-18 09:00:00', 'Deposit from business sales'),
    (811, 0000001, 'Withdrawal', 200.00, '2023-11-20 14:45:00', 'ATM withdrawal for expenses'),
    (911, 0000001, 'Transfer', 400.00, '2023-11-23 11:20:00', 'Transfer to investment account'),
    (101, 0000012, 'Deposit', 700.00, '2023-11-25 08:00:00', 'Additional savings deposit'),
    (114, 0000001, 'Deposit', 600.00, '2023-11-29 09:30:00', 'Deposit from sale'),
    (214, 0000011, 'Withdrawal', 200.00, '2023-11-29 10:45:00', 'Cash withdrawal for expenses'),
    (314, 0000001, 'Transfer', 350.00, '2023-11-29 12:15:00', 'Transfer to sibling'),
    (414, 0000010, 'Deposit', 1000.00, '2023-11-29 14:30:00', 'Large deposit from client'),
    (514, 0000001, 'Withdrawal', 700.00, '2023-11-29 15:45:00', 'ATM withdrawal for shopping'),
    (614, 0000009, 'Transfer', 250.00, '2023-11-29 16:30:00', 'Transfer to investment account'),
    (715, 0000001, 'Withdrawal', 300.00, '2023-11-29 17:45:00', 'Cash withdrawal for utilities'),
    (815, 0000008, 'Deposit', 150.00, '2023-11-29 18:30:00', 'Deposit from external source'),
    (915, 0000001, 'Transfer', 450.00, '2023-11-29 19:15:00', 'Transfer to family member'),
    (115, 0000007, 'Withdrawal', 550.00, '2023-11-29 20:00:00', 'ATM withdrawal for travel'),
    (121, 0000001, 'Deposit', 400.00, '2023-11-30 09:30:00', 'Deposit of bonus'),
    (221, 0000006, 'Withdrawal', 150.00, '2023-11-30 14:15:00', 'ATM withdrawal'),
    (321, 0000001, 'Transfer', 300.00, '2023-11-30 11:45:00', 'Transfer to parent'),
    (421, 0000004, 'Deposit', 1200.00, '2023-11-30 16:20:00', 'Deposit of earnings'),
    (521, 0000001, 'Withdrawal', 200.00, '2023-11-30 13:00:00', 'Cash withdrawal'),
    (621, 0000003, 'Transfer', 100.00, '2023-11-30 10:30:00', 'Transfer to friend'),
    (721, 0000001, 'Deposit', 600.00, '2023-11-30 09:00:00', 'Deposit from rental income'),
    (821, 0000001, 'Withdrawal', 300.00, '2023-11-30 14:45:00', 'ATM withdrawal for groceries'),
    (921, 0000001, 'Transfer', 500.00, '2023-11-30 11:20:00', 'Transfer to savings account'),
    (131, 0000001, 'Deposit', 800.00, '2023-11-30 08:00:00', 'Additional deposit for investments')
;

INSERT INTO DepositTransactions (TransactionID, DepositLocation, SourceOfFunds, DepositReason)
VALUES
    (111, 'Accra Branch', 'Salary', 'Monthly salary deposit'),
    (114, 'Kumasi ATM', 'Savings', 'Regular savings deposit'),
    (721, 'Tema Branch', 'Business income', 'Deposit from business sales'),
    (411, 'Sunyani Branch', 'Bonus', 'Year-end bonus deposit'),
    (711, 'Cape Coast ATM', 'Investment returns', 'Deposit from investment'),
    (815, 'Takoradi Branch', 'Savings', 'Deposit from side job earnings'),
    (414, 'Ho ATM', 'Gift', 'Gift deposit from family'),
    (421, 'Tamale Branch', 'Rental income', 'Deposit from rental property'),
    (121, 'Bolgatanga ATM', 'Inheritance', 'Inherited deposit'),
    (101, 'Wa Branch', 'Savings', 'Additional savings deposit')
;


INSERT INTO WithdrawalTransactions (TransactionID, WithdrawalMethod, WithdrawalReason, ATMUsed)
VALUES
    (211, 'ATM', 'Cash withdrawal for groceries', TRUE),
    (511, 'Bank Branch', 'Withdrawal for bill payments', FALSE),
    (811, 'ATM', 'Cash withdrawal for shopping', TRUE),
    (214, 'Bank Branch', 'Withdrawal for rent', FALSE),
    (514, 'ATM', 'Cash withdrawal for utilities', TRUE),
    (715, 'Bank Branch', 'Withdrawal for entertainment', FALSE),
    (115, 'ATM', 'Cash withdrawal for dining', TRUE),
    (221, 'Bank Branch', 'Withdrawal for travel', FALSE),
    (521, 'ATM', 'Cash withdrawal for emergency', TRUE),
    (821, 'Bank Branch', 'Withdrawal for medical expenses', FALSE)
;


INSERT INTO TransferTransactions (TransactionID, TransferDestination, TransferType, TransferFee)
VALUES
    (311, 'Friend account', 'Interbank', 2.50),
    (611, 'Family member account', 'Interbank', 3.00),
    (911, 'Investment account', 'Interbank', 2.75),
    (314, 'Sibling account', 'Interbank', 2.00),
    (915, 'Emergency fund account', 'Interbank', 2.75),
    (321, 'Education fund account', 'Interbank', 1.90),
    (614, 'Parents account', 'Interbank', 2.20),
    (621, 'Siblings account', 'Interbank', 2.00),
    (921, 'Savings account', 'Intrabank', 1.00)
;


INSERT INTO Branches (BranchID, BranchName, Location, PhoneNumber)
VALUES
    (1, 'Accra Central', 'Accra, Ghana', '030-123-4567'),
    (2, 'Kumasi Main', 'Kumasi, Ghana', '032-234-5678'),
    (3, 'Tema Harbour', 'Tema, Ghana', '030-345-6789'),
    (4, 'Cape Coast Plaza', 'Cape Coast, Ghana', '033-456-7890'),
    (5, 'Tamale Downtown', 'Tamale, Ghana', '037-567-8901'),
    (6, 'Sunyani Heights', 'Sunyani, Ghana', '035-678-9012'),
    (7, 'Ho City Center', 'Ho, Ghana', '030-789-0123'),
    (8, 'Bolgatanga Central', 'Bolgatanga, Ghana', '030-890-1234'),
    (9, 'Sekondi-Takoradi', 'Sekondi-Takoradi, Ghana', '031-901-2345'),
    (10, 'Wa Regional', 'Wa, Ghana', '039-012-3456')
;

INSERT INTO Beneficiaries (BeneficiaryID, CustomerID, Beneficiary_Name, AccountNumber, BankName, Beneficiary_Description)
VALUES
    (3111, 0000001, 'Abena Boateng', '1234567890', 'Ghana Bank', 'Sister'),
    (3112, 0000002, 'Yaw Mensah', '2345678901', 'National Bank', 'Friend'),
    (3113, 0000003, 'Akosua Agyemang', '3456789012', 'Ghana Commercial Bank', 'Cousin'),
    (3114, 0000004, 'Kwabena Owusu', '4567890123', 'Barclays Bank', 'Uncle'),
    (3115, 0000005, 'Esi Ansah', '5678901234', 'Ecobank', 'Aunt'),
    (3116, 0000006, 'Kwame Boakye', '6789012345', 'Fidelity Bank', 'Friend'),
    (3117, 0000007, 'Ama Adjei', '7890123456', 'Stanbic Bank', 'Neighbor'),
    (3118, 0000008, 'Kofi Anane', '8901234567', 'Zenith Bank', 'Colleague'),
    (3119, 0000009, 'Adwoa Ababio', '9012345678', 'Access Bank', 'Business Partner'),
    (3110, 0000010, 'Kweku Mensa', '0123456789', 'Prudential Bank', 'Family Friend')
;

INSERT INTO Loans (LoanID, CustomerID, LoanNumber, LoanAmount, InterestRate, LoanType, LoanStatus, RepaymentPeriod, EmiAmount)
VALUES
    (2001, 0000001, 'LN12345', 5000.00, 5.5, 'Personal', 'Active', 12, 450.00),
    (2002, 0000002, 'LN67890', 8000.00, 4.8, 'Business', 'Active', 24, 350.00),
    (2003, 0000003, 'LN24680', 6000.00, 6.2, 'Education', 'Active', 18, 420.00),
    (2004, 0000004, 'LN13579', 7000.00, 5.0, 'Home', 'Active', 36, 250.00),
    (2005, 0000005, 'LN98765', 9000.00, 4.5, 'Personal', 'Active', 24, 380.00),
    (2006, 0000006, 'LN54321', 5500.00, 6.8, 'Education', 'Active', 12, 480.00),
    (2007, 0000007, 'LN23456', 7500.00, 5.3, 'Business', 'Active', 18, 420.00),
    (2008, 0000008, 'LN78901', 8500.00, 4.2, 'Home', 'Active', 24, 320.00),
    (2009, 0000009, 'LN01234', 6200.00, 6.0, 'Personal', 'Active', 36, 210.00),
    (2010, 0000010, 'LN56789', 9500.00, 4.0, 'Business', 'Active', 12, 700.00)
;

INSERT INTO Payments (PaymentID, LoanID, Amount, PaymentDate, Payment_Status)
VALUES
    (7001, 2001, 200.00, '2023-12-05 10:30:00', 'Paid'),
    (7002, 2002, 150.00, '2023-12-07 14:45:00', 'Paid'),
    (7003, 2003, 300.00, '2023-12-10 11:00:00', 'Pending'),
    (7004, 2004, 250.00, '2023-12-12 09:20:00', 'Paid'),
    (7005, 2005, 400.00, '2023-12-15 13:30:00', 'Pending'),
    (7006, 2006, 180.00, '2023-12-18 08:45:00', 'Paid'),
    (7007, 2007, 320.00, '2023-12-20 16:10:00', 'Pending'),
    (7008, 2008, 270.00, '2023-12-23 10:00:00', 'Paid'),
    (7009, 2009, 350.00, '2023-12-26 11:30:00', 'Pending'),
    (7010, 2010, 500.00, '2023-12-28 15:20:00', 'Paid')
;

INSERT INTO CreditCards (CardID, CustomerID, CardNumber, ExpiryDate, CVV, CreditLimit, AvailableCredit, CardStatus)
VALUES
    (1001, 0000001, '1234567890123456', '2025-12-31', 123, 5000.00, 5000.00, 'Active'),
    (1002, 0000002, '2345678901234567', '2024-11-30', 234, 8000.00, 8000.00, 'Active'),
    (1003, 0000003, '3456789012345678', '2026-10-31', 345, 6000.00, 6000.00, 'Active'),
    (1004, 0000004, '4567890123456789', '2023-09-30', 456, 7000.00, 7000.00, 'Active'),
    (1005, 0000005, '5678901234567890', '2025-08-31', 567, 9000.00, 9000.00, 'Active'),
    (1006, 0000006, '6789012345678901', '2024-07-31', 678, 5500.00, 5500.00, 'Active'),
    (1007, 0000007, '7890123456789012', '2026-06-30', 789, 7500.00, 7500.00, 'Active'),
    (1008, 0000008, '8901234567890123', '2023-05-31', 890, 8500.00, 8500.00, 'Active'),
    (1009, 0000009, '9012345678901234', '2025-04-30', 901, 6200.00, 6200.00, 'Active'),
    (1010, 0000010, '0123456789012345', '2024-03-31', 012, 9500.00, 9500.00, 'Active')
;

INSERT INTO ATMTransactions (TransactionID, CustomerID, CardID, TransactionType, Amount, TransactionDate, ATMLocation)
VALUES
    (3001, 0000001, 1001, 'Withdrawal', 50.00, '2023-12-05 10:30:00', 'Accra'),
    (3002, 0000002, 1002, 'Withdrawal', 100.00, '2023-12-07 14:45:00', 'Kumasi'),
    (3003, 0000003, 1003, 'Withdrawal', 150.00, '2023-12-10 11:00:00', 'Cape Coast'),
    (3004, 0000004, 1004, 'Withdrawal', 200.00, '2023-12-12 09:20:00', 'Accra'),
    (3005, 0000005, 1005, 'Withdrawal', 250.00, '2023-12-15 13:30:00', 'Kumasi'),
    (3006, 0000006, 1006, 'Withdrawal', 300.00, '2023-12-18 08:45:00', 'Cape Coast'),
    (3007, 0000007, 1007, 'Withdrawal', 350.00, '2023-12-20 16:10:00', 'Accra'),
    (3008, 0000008, 1008, 'Withdrawal', 400.00, '2023-12-23 10:00:00', 'Kumasi'),
    (3009, 0000009, 1009, 'Withdrawal', 450.00, '2023-12-26 11:30:00', 'Cape Coast'),
    (3010, 0000010, 1010, 'Withdrawal', 500.00, '2023-12-28 15:20:00', 'Accra')
;



-- Retrieves the first name, last name, account number, and balance of customers along with their associated accounts
SELECT c.FirstName, c.LastName, a.AccountNumber, a.Balance
FROM Customers c
JOIN Accounts a ON c.CustomerID = a.CustomerID;

-- Retrieves all transactions for a specific customer with CustomerID '0000001'
SELECT *
FROM Transactions
WHERE CustomerID = 0000001;

-- Retrieves loan information (LoanID, LoanNumber, LoanAmount, LoanStatus) for a specific customer with CustomerID '0000002'
SELECT l.LoanID, l.LoanNumber, l.LoanAmount, l.LoanStatus
FROM Loans l
WHERE l.CustomerID = 0000002;

-- Retrieves beneficiary details (Beneficiary_Name, AccountNumber, BankName) for a specific customer with CustomerID '0000003'
SELECT b.Beneficiary_Name, b.AccountNumber, b.BankName
FROM Beneficiaries b
WHERE b.CustomerID = 0000003;

-- Retrieves the details of the last 5 ATM transactions for a specific customer with CustomerID '0000004', ordered by TransactionDate in descending order
SELECT t.TransactionID, t.TransactionType, t.Amount, t.TransactionDate, t.ATMLocation
FROM ATMTransactions t
WHERE t.CustomerID = 0000004
ORDER BY t.TransactionDate DESC
LIMIT 5;

-- Retrieves the first name, last name, and VIP status of premium customers by joining the Customers and PremiumCustomers tables
SELECT c.FirstName, c.LastName, p.VIPStatus
FROM Customers c
JOIN PremiumCustomers p ON c.CustomerID = p.CustomerID;

-- Retrieves all active accounts based on their Account_Status
SELECT *
FROM Accounts
WHERE Account_Status = 'Active';

-- Retrieves deposit location and source of funds for a specific transaction with TransactionID '111'
SELECT d.DepositLocation, d.SourceOfFunds
FROM DepositTransactions d
WHERE d.TransactionID = 111;

-- Retrieves all transactions within a specified date range ('2023-11-01' to '2023-11-15')
SELECT *
FROM Transactions
WHERE TransactionDate BETWEEN '2023-11-01' AND '2023-11-15';
-- Retrieve customers who have made withdrawals
SELECT DISTINCT CustomerID
FROM Transactions
WHERE TransactionType = 'Withdrawal';

-- Retrieve customers whose last name starts with 'A'
SELECT * FROM Customers
WHERE LastName LIKE 'A%';

-- Sort customers by their first name in ascending order
SELECT * FROM Customers
ORDER BY FirstName ASC;

-- Calculate the total amount deposited by each customer
SELECT CustomerID, SUM(Amount) AS Total_Deposits
FROM Transactions
WHERE TransactionType = 'Deposit'
GROUP BY CustomerID;

-- Left Outer Join between Customers and PremiumCustomers to see all customers and their premium status
SELECT Customers.FirstName, Customers.LastName, PremiumCustomers.VIPStatus
FROM Customers
LEFT JOIN PremiumCustomers ON Customers.CustomerID = PremiumCustomers.CustomerID;

-- Left Outer Join between Customers and PremiumCustomers to see all customers and their premium status
SELECT Customers.FirstName, Customers.LastName, PremiumCustomers.VIPStatus
FROM Customers
LEFT JOIN PremiumCustomers ON Customers.CustomerID = PremiumCustomers.CustomerID;

-- Inner Join between Customers and Accounts to fetch customer information with their respective accounts
SELECT Customers.FirstName, Customers.LastName, Accounts.AccountNumber, Accounts.AccountType
FROM Customers
INNER JOIN Accounts ON Customers.CustomerID = Accounts.CustomerID;

-- Upgrade Customers Based on Transaction Count

DELIMITER //

CREATE PROCEDURE MoveCustomerToPremium(IN customerIDParam INT)
BEGIN
    DECLARE transactionCount INT;

    -- Count the number of transactions for the given customer
    SELECT COUNT(*) INTO transactionCount
    FROM Transactions
    WHERE CustomerID = customerIDParam;

    -- Check if the transaction count exceeds 300
    IF transactionCount >= 200 THEN
        -- Move the customer to the PremiumCustomers table
        INSERT INTO PremiumCustomers (CustomerID, VIPStatus, ExclusiveOffers, ConciergeService)
        SELECT CustomerID, 'Platinum', 'Exclusive benefits', 'Dedicated concierge service'
        FROM RegularCustomers
        WHERE CustomerID = customerIDParam;

        -- Delete the customer from RegularCustomers table
        DELETE FROM RegularCustomers
        WHERE CustomerID = customerIDParam;

        SELECT 'Customer moved to Premium successfully' AS Status;
    ELSE
        SELECT 'Customer has not reached the required transactions for upgrade' AS Status;
    END IF;
END //

DELIMITER ;

CALL MoveCustomerToPremium(0000001);






