const mysql = require('mysql2');

const config = {
    host: 'seu_host',
    user: 'seu_usuario',
    password: 'sua_senha',
    database: 'seu_banco_de_dados'
};

const conn = mysql.createConnection(config);
conn.query("SELECT * FROM tabela", (err, results) => {
    if (err) throw err;
    console.log(results);
});

conn.end();
