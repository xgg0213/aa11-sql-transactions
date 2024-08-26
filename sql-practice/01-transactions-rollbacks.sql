-- Balance Transfer Transactions
-- Rollback SQL Statements
BEGIN TRANSACTION;

  UPDATE accounts
  SET balance = balance + 200
  WHERE (
      first_name = 'Rose'
      AND last_name = 'Tyler'
    );
  UPDATE accounts
  SET balance = balance - 200
  WHERE (
      first_name = 'Amy'
      AND last_name = 'Pond'
    );
  SAVEPOINT amy_to_rose; -- Rose 800; Amy 2300

  UPDATE accounts
  SET balance = balance + 200
  WHERE (
      first_name = 'Rose'
      AND last_name = 'Tyler'
    );
  UPDATE accounts
  SET balance = balance - 200
  WHERE (
      first_name = 'Martha'
      AND last_name = 'Jones'
    );
  SAVEPOINT martha_to_rose; -- Rose 1000; Martha 2800

  UPDATE accounts
  SET balance = balance + 200
  WHERE (
      first_name = 'Rose'
      AND last_name = 'Tyler'
    );
  UPDATE accounts
  SET balance = balance - 200
  WHERE (
      first_name = 'Donna'
      AND last_name = 'Noble'
    );
  SAVEPOINT donna_to_rose; -- Rose 1200; Donna 0

  ROLLBACK TO martha_to_rose; -- Rose 1000; Martha 2800; Donna 200

  UPDATE accounts
  SET balance = balance + 200
  WHERE (
      first_name = 'Rose'
      AND last_name = 'Tyler'
    );
  UPDATE accounts
  SET balance = balance - 200
  WHERE (
      first_name = 'River'
      AND last_name = 'Song'
    );
  SAVEPOINT river_to_rose; -- Rose: 1200; River 1000

COMMIT;

-- Check results of SQL statements
SELECT * 
FROM accounts;

-- After executing:
-- | `id` | `first_name` | `last_name` | `balance` |
-- | ---- | ------------ | ----------- | --------- |
-- | 1    | Amy          | Pond        | ????      |
-- | 2    | Rose         | Tyler       | ????      |
-- | 3    | Martha       | Jones       | ????      |
-- | 4    | Donna        | Nobles      | ????      |
-- | 5    | River        | Song        | ????      |

