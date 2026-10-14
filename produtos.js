const express = require('express');
const router = express.Router();
const db = require('./db');

router.get('/', async (req, res) => {
    try {
        const [produtos] = await db.query('SELECT * FROM produtos');
        res.json(produtos);
    } catch (erro) {
        res.status(500).json({ erro: 'Erro ao buscar produtos' });
    }
});

router.post('/', async (req, res) => {
    const { nome, valor, quantidade, categoria } = req.body;

    if (valor <= 0) return res.status(400).json({ erro: 'Valor inválido' });
    if (quantidade < 0) return res.status(400).json({ erro: 'Quantidade inválida' });
    if (!categoria) return res.status(400).json({ erro: 'Categoria obrigatória' });

    try {
        const sql = 'INSERT INTO produtos (nome, valor, quantidade, categoria) VALUES (?, ?, ?, ?)';
        const [resultado] = await db.query(sql, [nome, valor, quantidade, categoria]);

        res.status(201).json({ 
            id: resultado.insertId, 
            nome, 
            valor, 
            quantidade, 
            categoria 
        });
    } catch (erro) {
        res.status(500).json({ erro: 'Erro ao cadastrar produto' });
    }
});

module.exports = router;