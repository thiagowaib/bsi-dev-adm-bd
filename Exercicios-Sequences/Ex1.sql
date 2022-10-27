CREATE USER USRSEQ
IDENTIFIED BY senha123;

GRANT Connect, Resource TO USRSEQ;

CREATE TABLE Grupo (
    idGrupo             NUMBER(6)       NOT NULL,
    Descricao           VARCHAR2(50)    NOT NULL,
    PRIMARY KEY (idGrupo)           
);

CREATE TABLE Produto (
    idProduto           NUMBER(8)       NOT NULL,
    Descricao           VARCHAR2(80)    NOT NULL,
    Data_Cadastro       DATE            DEFAULT CURRENT_DATE,
    Qtde_Estoque        NUMBER(6)       NOT NULL,
    Valor_unitario      NUMBER(9,2)     NOT NULL,
    idGrupo             NUMBER(6)       NOT NULL,       
    PRIMARY KEY (idProduto),
    FOREIGN KEY (idGrupo) REFERENCES Grupo(idGrupo)
);