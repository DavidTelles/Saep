CREATE TABLE IF NOT EXISTS produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    valor NUMERIC(10, 2) NOT NULL CHECK (valor > 0),
    quantidade INTEGER NOT NULL CHECK (quantidade >= 0),
    categoria VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS movimentacoes (
    id SERIAL PRIMARY KEY,
    data TIMESTAMP NOT NULL,
    tipo VARCHAR(45) NOT NULL,
    quantidade INTEGER,
    produtos_id INTEGER NOT NULL REFERENCES produtos (id)
);

CREATE INDEX IF NOT EXISTS fk_movimentacoes_produtos_idx ON movimentacoes (produtos_id);

CREATE OR REPLACE VIEW vw_estoque AS
SELECT
    id,
    nome,
    quantidade,
    valor,
    (quantidade * valor) AS valor_total
FROM produtos;
