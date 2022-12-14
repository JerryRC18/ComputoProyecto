const express = require('express');
const router = express.Router();

const connection = require('../connection');

router.get('/todos_los_prestamos', async (req, res) => { //funcion asincrona
    try{
        const query = 'SELECT '+
                        'p.pre_id, u.usu_id, CONCAT_WS(\' \', u.usu_nombre, u.usu_ap_pat, u.usu_ap_mat) AS usu_nom_comp, '+
                        'p.pre_fec_pres, p.pre_fec_entre, p.pre_fec_real_entre '+
                        'FROM prestamo AS p '+
                        'INNER JOIN usuario AS u '+
                        'ON p.pre_usu_id = u.usu_id ';
        const prestamos = await connection.query(query);

        res.json(prestamos);

    } catch(error){
        return res.json({
            error: error 
        });
    }
});

router.post('/eliminar_prestamo', async (req, res) => { //Vamos a cambiaer la base de datos
    try{
        const pre_id = req.body.pre_id;
        const query = 'DELETE FROM prestamo WHERE pre_id = ?';
        const result = await connection.query(query, [pre_id]);

        res.json('ok');

    } catch(error){
        return res.json({
            error: error 
        });
    }
});

router.post('/nuevo_prestamo', async (req, res) => { //Vamos a cambiaer la base de datos
    try{
        const body = req.body;
        const query = 'INSERT INTO prestamo' +
                        '(pre_fec_pres, pre_fec_entre, pre_fec_real_entre, pre_usu_id) '+
                        'VALUES (?, ?, ?, ?)';
        const result = await connection.query(query, [body.pre_fec_pres, body.pre_fec_entre, body.pre_fec_real_entre, body.pre_usu_id]);

        res.json('ok');

    } catch(error){
        return res.json({
            error: error 
        });
    }
});

router.post('/nuevo_det_prestamo', async (req, res) => {
    try{
        const body = req.body;
        const query = 'INSERT INTO detalle_prestamo '+
                        '(dep_pre_id, dep_lib_id, dep_multa) '+
                        'VALUES (?, ?, ?)';
        await connection.query(query, [body.dep_pre_id, body.dep_lib_id, body.dep_multa]);
    } catch(error){
        return res.json({
            error: error
        });
    }

});

router.get('/leer_det_prestamo/:pre_id', async (req, res) => {
    try{
        const pre_id = req.params.pre_id;
        const query = 'SELECT l.lib_titulo '+
                        'FROM detalle_prestamo AS p '+
                        'INNER JOIN libro AS l '+
                        'ON p.dep_lib_id = l.lib_id '+
                        'WHERE p.dep_pre_id = ?';
        const libros = await connection.query(query, [pre_id]);
        res.json(libros); 

    } catch(error){
        return res.json({
            error: error
        });
    }
});

module.exports = router;