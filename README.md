# Banking Transaction Management using SQL (TCL)

## Overview

This project demonstrates the use of Transaction Control Language (TCL) in SQL to manage banking operations such as money transfer, deposit, withdrawal, and rollback handling. The goal is to ensure data consistency and integrity during multi-step operations.

---

## Features

* Secure money transfer between accounts
* Full rollback in case of failure
* Partial rollback using savepoints
* Deposit functionality
* Validation for account existence and sufficient balance
* Prevention of inconsistent or partial updates

---

## Transaction Scenarios

### 1. Successful Transfer

A transaction is used to transfer money from one account to another. If all steps execute successfully, the transaction is committed and changes are permanently saved.

### 2. Rollback on Failure

If any step in a transaction fails (such as transferring money to a non-existent account), the entire transaction is rolled back to maintain consistency.

### 3. Partial Rollback using Savepoint

A savepoint allows partial rollback within a transaction. If a later step fails, only the operations after the savepoint are undone, while earlier valid operations remain intact.

### 4. Deposit Operation

A simple transaction is used to add money to an account. Since it is a single-step operation, it is committed directly after execution.

### 5. Mixed Operations with Selective Rollback

Multiple operations are performed in a single transaction. If one operation fails, the system rolls back only the affected part using a savepoint, preserving valid changes.

---

## Key Concepts

* **Transaction**: A sequence of operations performed as a single unit of work
* **Commit**: Permanently saves all changes made during a transaction
* **Rollback**: Reverts all changes made during a transaction
* **Savepoint**: A checkpoint within a transaction for partial rollback
* **Data Consistency**: Ensures the database remains accurate and reliable

---

## ACID Properties

This project follows the ACID principles:

* **Atomicity**: All operations succeed or none are applied
* **Consistency**: Database remains in a valid state after each transaction
* **Isolation**: Transactions do not interfere with each other
* **Durability**: Committed changes are permanently stored

---

## Conclusion

This project highlights the importance of transaction management in database systems. By using TCL commands effectively, it ensures reliable and secure execution of critical operations such as banking transactions.

---
