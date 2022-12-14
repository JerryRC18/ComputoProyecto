const { connect } = require('http2');
const mysql = require('mysql');
const { promisify } = require('util');

//Configurar la conexion a la base de datos 
const connection = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'biblioteca_vue_db'
});

//Mas conection 
//Funcion que solo se usa localmente 
//Arrow function 
connection.getConnection(
    (err, conn) => {
        if(err){
            console.log('Problema para conectar a la DB');
        }
        if(conn){
            console.log('¡DB conectada!');
        }
        return

    }
);

connection.query = promisify(connection.query);

module.exports = connection;
