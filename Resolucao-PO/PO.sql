-- Criado com o usu�rio Administrador do Banco de Dados
CREATE USER po
IDENTIFIED BY Univem2022
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON USERS
ACCOUNT UNLOCK;

GRANT CONNECT, RESOURCE TO po;

----------------------------------------------------------------

-- Criado com o usu�rio PO
CREATE TABLE pessoa (
idpessoa NUMBER(6) NOT NULL,
nome VARCHAR(80) NOT NULL,
CONSTRAINT PK_Pessoa PRIMARY KEY (idpessoa)
);

CREATE TABLE conta_corrente (
numero_conta NUMBER(6) NOT NULL,
idpessoa NUMBER(6) NOT NULL,
saldo NUMBER(9,2),
CONSTRAINT PK_Conta_Corrente PRIMARY KEY(numero_conta),
CONSTRAINT FK_Conta_Corrente_Pessoa FOREIGN KEY(idpessoa) 
REFERENCES pessoa (idpessoa)
);

CREATE TABLE movimento (
idmovimento NUMBER(9) NOT NULL,
numero_conta NUMBER(6) NOT NULL,
data DATE DEFAULT SYSDATE NOT NULL,
tipo CHAR(1) NOT NULL,
valor NUMBER(9,2) NOT NULL,
CONSTRAINT PK_Movimento PRIMARY KEY(idmovimento),
CONSTRAINT FK_Movimento_Conta_Corrente FOREIGN KEY(numero_conta)
REFERENCES conta_corrente (numero_conta),
CONSTRAINT CK_Movimento CHECK (tipo IN ('C','D'))
);

CREATE TABLE erros (
iderro NUMBER(9) NOT NULL,
tabela VARCHAR(30) NOT NULL,
codigo NUMBER(5) NOT NULL,
mensagem VARCHAR(100) NOT NULL,
CONSTRAINT PK_Erros PRIMARY KEY(iderro)
);

CREATE SEQUENCE SEQPESSOA
START WITH 1
INCREMENT BY 1
MAXVALUE 999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQCC
START WITH 1
INCREMENT BY 1
MAXVALUE 999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQMOVIMENTO
START WITH 1
INCREMENT BY 1
MAXVALUE 999999999
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQERROS
START WITH 1
INCREMENT BY 1
MAXVALUE 999999999
NOCACHE
NOCYCLE;
