CREATE TABLE Departamento (
    Codigo_Departamento NUMBER(4)       NOT NULL,
    Descricao           VARCHAR2(50)    NOT NULL,
    PRIMARY KEY (Codigo_Departamento)           
);

INSERT INTO Departamento
VALUES (1, 'TECNOLOGIA');
INSERT INTO Departamento
VALUES (2, 'JURIDICO');
INSERT INTO Departamento
VALUES (3, 'RECURSOS HUMANOS');
INSERT INTO Departamento
VALUES (4, 'DESENVOLVIMENTO');
INSERT INTO Departamento
VALUES (5, 'TREINAMENTO');
INSERT INTO Departamento
VALUES (6, 'VENDAS');

CREATE TABLE Funcionario (
    Numero_Registro     NUMBER(6)       NOT NULL    ,
    Nome                VARCHAR(80)     NOT NULL    ,
    Data_Admissao       DATE                        ,
    Codigo_Departamento NUMBER(4)       NOT NULL    ,
    PRIMARY KEY (Numero_Registro)                   ,
    FOREIGN KEY (Codigo_Departamento)
        REFERENCES Departamento(Codigo_Departamento)
);

INSERT INTO Funcionario
VALUES (255, 'WILLY SOUZA', TO_DATE('17/05/2015', 'DD/MM/YYYY'), 2);
INSERT INTO Funcionario
VALUES (256, 'MARCUS VINICIUS', TO_DATE('21/11/2015', 'DD/MM/YYYY'), 1);
INSERT INTO Funcionario
VALUES (257, 'PEDRO OLIVEIRA', TO_DATE('19/12/2015', 'DD/MM/YYYY'), 6);
INSERT INTO Funcionario
VALUES (258, 'CLAUDIO JESUS', TO_DATE('27/03/2017', 'DD/MM/YYYY'), 3);
INSERT INTO Funcionario
VALUES (259, 'MARCELO SASSA', TO_DATE('28/01/2017', 'DD/MM/YYYY'), 4);
INSERT INTO Funcionario
VALUES (260, 'RENATO TEIXEIRA', TO_DATE('01/09/2016', 'DD/MM/YYYY'), 5);
INSERT INTO Funcionario
VALUES (261, 'BRUNO BARRACA', TO_DATE('03/08/2012', 'DD/MM/YYYY'), 6);