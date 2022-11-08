-- Crie Triggers para popular as chaves primárias
-- de cada tabela com os respectivos sequences como segue:

-- Trigger seqpessoa para Tabela pessoa
CREATE OR REPLACE TRIGGER seqpessoa
    BEFORE INSERT
    ON pessoa
    FOR EACH ROW
BEGIN
    :new.idpessoa := SEQPESSOA.NEXTVAL;
END;

-- Trigger seqcc para Tabela conta_corrente
CREATE OR REPLACE TRIGGER seqcc
    BEFORE INSERT
    ON conta_corrente
    FOR EACH ROW
BEGIN
    :new.numero_conta := SEQCC.NEXTVAL;
END;

-- Trigger seqmovimento para Tabela movimento
CREATE OR REPLACE TRIGGER seqmovimento
    BEFORE INSERT
    ON movimento
    FOR EACH ROW
BEGIN
    :new.idmovimento := SEQMOVIMENTO.NEXTVAL;
END;

-- Trigger seqerros para Tabela erros
CREATE OR REPLACE TRIGGER seqerros
    BEFORE INSERT
    ON erros
    FOR EACH ROW
BEGIN
    :new.iderro := SEQERROS.NEXTVAL;
END;
