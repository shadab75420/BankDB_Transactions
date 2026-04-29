CREATE DATABASE BankDB;
USE BankDB;

CREATE TABLE Accounts (
    AccountId INT PRIMARY KEY NOT NULL,
    AccountName VARCHAR(50) NOT NULL,
    Balance INT CHECK (Balance >= 0)
);

TRUNCATE TABLE Accounts;

INSERT INTO Accounts VALUES (1, 'Aman', 5000);
INSERT INTO Accounts VALUES (2, 'Rahul', 3000);

SELECT * FROM Accounts;

BEGIN TRANSACTION;

--Check balance first
IF (SELECT Balance FROM Accounts WHERE AccountId = 1) >= 1000
BEGIN
    UPDATE Accounts 
    SET Balance = Balance - 1000 
    WHERE AccountId = 1;

    UPDATE Accounts 
    SET Balance = Balance + 1000 
    WHERE AccountId = 2;

    COMMIT;
 END
 ELSE
 BEGIN
    ROLLBACK;
END;

SELECT * FROM Accounts;


--RollBack Transaction

BEGIN TRANSACTION;
UPDATE Accounts 
SET Balance = Balance - 1000 
WHERE AccountId = 1;

-- Check if receiver exists
IF EXISTS (SELECT 1 FROM Accounts WHERE AccountId = 99)
BEGIN
    UPDATE Accounts 
    SET Balance = Balance + 1000 
    WHERE AccountId = 99;

    COMMIT;
END
ELSE
BEGIN
    ROLLBACK;
END;

SELECT * FROM Accounts;

--Deposit amount

BEGIN TRANSACTION;
UPDATE Accounts 
SET Balance = Balance + 2000 
WHERE AccountId = 2;
COMMIT;

SELECT * FROM Accounts;

--savepoints
BEGIN TRANSACTION;

UPDATE Accounts 
SET Balance = Balance - 500 
WHERE AccountId = 1;

SAVE TRANSACTION SP1;

-- Check before updating invalid account
IF EXISTS (SELECT 1 FROM Accounts WHERE AccountId = 99)
BEGIN
    UPDATE Accounts 
    SET Balance = Balance + 500 
    WHERE AccountId = 99;
END
ELSE
BEGIN
    ROLLBACK TRANSACTION SP1;
END;

COMMIT;

SELECT * FROM Accounts;

--Mixed with Selective Rollback
BEGIN TRANSACTION;

UPDATE Accounts 
SET Balance = Balance - 1000 
WHERE AccountId = 1;

SAVE TRANSACTION SP1;

UPDATE Accounts 
SET Balance = Balance + 500 
WHERE AccountId = 2;

-- Check invalid account
IF EXISTS (SELECT 1 FROM Accounts WHERE AccountId = 99)
BEGIN
    UPDATE Accounts 
    SET Balance = Balance + 500 
    WHERE AccountId = 99;
END
ELSE
BEGIN
    ROLLBACK TRANSACTION SP1;
END;

COMMIT;

SELECT * FROM Accounts;