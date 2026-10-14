const express = require('express');
const produtosRoutes = require('./produtos');

const app = express();
app.use(express.json());

// Libera o acesso do front-end (necessário para o navegador chamar a API)
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Content-Type');
    res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    if (req.method === 'OPTIONS') return res.sendStatus(204);
    next();
});

app.use('/produtos', produtosRoutes);

app.listen(3000, () => {
    console.log('Servidor rodando na porta 3000');
});