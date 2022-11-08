-- Crie um procedimento (procedure) denominado ALTERA_MOVIMENTO, 
-- a finalidade deste procedimento é realizar uma alteração (UPDATE) em um lançamento previamente realizado pelo procedimento INSERE_MOVIMENTO, 
-- os parâmetros a serem informados devem conter o idmovimento e novo valor. 
-- O idmovimento pode ser obtido com o comando SELECT na tabela movimento e o valor a ser informado deve ser diferente do obtido no SELECT. 

-- Um trigger deve ser criado (sugestão update_movimento) para que quando o movimento seja alterado o saldo da conta_corrente seja devidamente ajustado.

-- Criação da Procedure ALTERA_MOVIMENTO
CREATE OR REPLACE PROCEDURE ALTERA_MOVIMENTO (mov_id IN NUMBER, novo_valor IN NUMBER)
AS
    mov_count       NUMBER;
    mov_valor       NUMBER;
    err_table       VARCHAR(20);
    err_code        NUMBER;
    err_msg         VARCHAR2(75);
BEGIN
    -- Busca a movimentação com base no mov_id
    SELECT count(*) INTO mov_count FROM movimento WHERE IDMOVIMENTO = mov_id;
    IF mov_count = 1 THEN
        SELECT valor INTO mov_valor FROM movimento WHERE IDMOVIMENTO = mov_id;
    END IF;

    IF mov_count <> 1 THEN /* O mov_id (parâmetro) não corresponde à nenhuma movimentação */
        err_table := 'movimento';
        err_code := -20107;
        err_msg := 'Movimento não encontrado via id';
        INSERT INTO erros (tabela, codigo, mensagem) VALUES (err_table, err_code, err_msg);
        COMMIT;
        raise_application_error(err_code, err_msg);
    ELSIF mov_valor = novo_valor THEN /* O novo valor é igual o valor antigo */
        err_table := 'movimento';
        err_code := -20108;
        err_msg := 'O novo valor não pode ser igual o valor antigo do movimento';
        INSERT INTO erros (tabela, codigo, mensagem) VALUES (err_table, err_code, err_msg);
        COMMIT;
        raise_application_error(err_code, err_msg);
    ELSE
        UPDATE movimento
        SET valor = novo_valor
        WHERE idmovimento = mov_id;
    END IF;
END;

-- Criação do Trigger update_movimento
CREATE OR REPLACE TRIGGER update_movimento
    BEFORE UPDATE
    ON movimento
    FOR EACH ROW
BEGIN
    IF :old.tipo = 'C' THEN /* Crédito: Saldo = Saldo + ValorNovo - ValorAntigo */
        UPDATE conta_corrente 
        SET saldo = (saldo - :old.valor + :new.valor)
        WHERE numero_conta = :old.numero_conta;
    ELSE /* Débito: Saldo = Saldo - ValorNovo + ValorAntigo */
        UPDATE conta_corrente 
        SET saldo = (saldo + :old.valor - :new.valor )
        WHERE numero_conta = :old.numero_conta;
    END IF;
END;