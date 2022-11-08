-- Crie um procedimento (procedure) denominado INSERE_MOVIMENTO, 
-- a finalidade deste procedimento é realizar o lançamento de movimento. 
-- Os parâmetros a serem informados devem conter o número da conta corrente, o tipo (C – Crédito ou D – Débito) e o valor. 
-- O número da conta corrente pode ser obtido com o comando SELECT na tabela conta_corrente, após ser utilizado o procedimento INSERE_CONTA_CORRENTE. 

-- Um trigger deve ser criado (sugestão insere_movimento) 
-- para que quando um movimento do tipo Crédito seja inserido o saldo da tabela conta_corrente seja acrescido do valor informado,
-- da mesma forma se o tipo for Débito o saldo deve ser decrescido do valor informado.

-- Criação da Procedure INSERE_MOVIMENTO
CREATE OR REPLACE PROCEDURE INSERE_MOVIMENTO (numero_cc IN NUMBER, tipo IN VARCHAR, valor IN NUMBER)
AS
    count_cc        NUMBER;
    err_table       VARCHAR(20);
    err_code        NUMBER;
    err_msg         VARCHAR2(50);
BEGIN
    -- Busca a conta corrente com base no numero_cc
    SELECT count(*) INTO count_cc FROM conta_corrente WHERE numero_conta = numero_cc;
    
    IF count_cc != 1 THEN /* O numero_cc (parâmetro) não corresponde à nenhuma conta corrente */
        err_table := 'movimento';
        err_code := -20104;
        err_msg := 'Conta corrente não encontrada via numero de conta';
        INSERT INTO erros (tabela, codigo, mensagem) VALUES (err_table, err_code, err_msg);
        COMMIT;
        raise_application_error(err_code, err_msg);
    ELSIF tipo != 'C' AND tipo != 'D' THEN /* O tipo (parâmetro) não é C(Crédito) ou D(Débito) */
        err_table := 'movimento';
        err_code := -20105;
        err_msg := 'O tipo precisa ser `C` (Crédito) ou `D` (Débito)';
        INSERT INTO erros (tabela, codigo, mensagem) VALUES (err_table, err_code, err_msg);
        COMMIT;
        raise_application_error(err_code, err_msg);
    ELSIF valor <= 0 THEN
        err_table := 'movimento';
        err_code := -20106;
        err_msg := 'O valor precisa ser positivo';
        INSERT INTO erros (tabela, codigo, mensagem) VALUES (err_table, err_code, err_msg);
        COMMIT;
        raise_application_error(err_code, err_msg);
    ELSE
        INSERT INTO movimento (numero_conta, tipo, valor) VALUES (numero_cc, tipo, valor);
    END IF;
END;

-- Criação do Trigger insere_movimento
CREATE OR REPLACE TRIGGER insere_movimento
    BEFORE INSERT
    ON movimento
    FOR EACH ROW
BEGIN
    IF :new.tipo = 'C' THEN /* Crédito: Saldo = Saldo + Valor */
        UPDATE conta_corrente 
        SET saldo = (saldo + :new.valor)
        WHERE numero_conta = :new.numero_conta;
    ELSE /* Débito: Saldo = Saldo - Valor */
        UPDATE conta_corrente 
        SET saldo = (saldo - :new.valor)
        WHERE numero_conta = :new.numero_conta;
    END IF;
END;