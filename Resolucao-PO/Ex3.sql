-- Crie um procedimento (procedure) denominado INSERE_CONTA_CORRENTE, 
-- a finalidade deste procedimento é realizar o cadastro de conta corrente. 
-- O único parâmetro a ser informado é o id da pessoa. 
-- O id da pessoa pode ser obtido com o comando SELECT na tabela pessoa,
-- após ser utilizado o procedimento INSERE_PESSOA. O saldo inicial da conta corrente deve ser 0 (zero).

CREATE OR REPLACE PROCEDURE INSERE_CONTA_CORRENTE (id IN NUMBER)
AS
    count_pessoa    NUMBER;
    err_table       VARCHAR(20);
    err_code        NUMBER;
    err_msg         VARCHAR2(50);
BEGIN
    -- Busca a pessoa com base no Id passado por parâmetro
    SELECT count(*) INTO count_pessoa FROM pessoa WHERE idpessoa = id;
    
    IF count_pessoa = 1 THEN
        INSERT INTO conta_corrente (idpessoa, saldo) VALUES (id, 0);
    ELSE /* O Id (parâmetro) não corresponde à nenhuma pessoa */
        err_table := 'conta_corrente';
        err_code := -20103;
        err_msg := 'Pessoa não encontrada via Id';
        INSERT INTO erros (tabela, codigo, mensagem) VALUES (err_table, err_code, err_msg);
        COMMIT;
        raise_application_error(err_code, err_msg);
    END IF;
END;