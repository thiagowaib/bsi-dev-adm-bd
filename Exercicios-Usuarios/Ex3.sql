CREATE USER ERPUSR
IDENTIFIED BY senha123
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

GRANT Connect, Resource TO ERPUSR;