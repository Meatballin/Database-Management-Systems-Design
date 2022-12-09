const mysql = require('mysql');

const dbConnection = mysql.createConnection({
    debug: false,
    host: '127.0.0.1',
    port: 3306,
    database: 'aavola_cs355fa22',
    user: 'aavola_cs355fa22',
    password: 'av8037855'
});

module.exports = dbConnection;