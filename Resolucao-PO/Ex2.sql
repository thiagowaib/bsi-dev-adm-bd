-- Crie um procedimento (procedure) denominado INSERE_PESSOA, 
-- a finalidade deste procedimento é realizar o cadastro de pessoas. 
-- O único parâmetro a ser informado é o nome da pessoa.

CREATE OR REPLACE PROCEDURE INSERE_PESSOA (nome IN VARCHAR)
AS
    err_table   VARCHAR(20);
    err_code    NUMBER;
    err_msg     VARCHAR2(50);
BEGIN
    IF nome IS NOT NULL THEN
        INSERT INTO pessoa (nome) VALUES (nome);
    ELSE /* Tentou inserir pessoa sem nome */
        err_table := 'pessoa';
        err_code := -20102;
        err_msg := 'O nome da pessoa nao pode ser nulo';
        INSERT INTO erros (tabela, codigo, mensagem) VALUES (err_table, err_code, err_msg);
        COMMIT;
        raise_application_error(err_code, err_msg);
    END IF;
END;