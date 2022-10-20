SELECT name, value
FROM v$parameter
WHERE name LIKE '%memory%';