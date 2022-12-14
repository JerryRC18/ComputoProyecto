const express = require('express');
const router = express.Router();

const connection = require('../connection');

router.get('/todos_los_libros', async (req, res) => { //funcion asincrona
    try{
        const query = 'SELECT * FROM libro';
        const libros = await connection.query(query);

        res.json(libros);

    } catch(error){
        return res.json({
            error: error 
        });
    }
});

router.post('/eliminar_libro', async (req, res) => { //Vamos a cambiaer la base de datos
    try{
        const lib_id = req.body.lib_id;
        const query = 'DELETE FROM libro WHERE lib_id = ?';
        const result = await connection.query(query, [lib_id]);

        res.json('ok');

    } catch(error){
        return res.json({
            error: error 
        });
    }
});

router.post('/nuevo_libro', async (req, res) => { //Vamos a cambiaer la base de datos
    try{
        const body = req.body;
        const query = 'INSERT INTO libro (lib_titulo, lib_autor, lib_editorial, lib_edicion) VALUES (?, ?, ?, ?)';
        const result = await connection.query(query, [body.lib_titulo, body.lib_autor, body.lib_editorial, body.lib_edicion]);

        res.json('ok');

    } catch(error){
        return res.json({
            error: error 
        });
    }
});

module.exports = router;