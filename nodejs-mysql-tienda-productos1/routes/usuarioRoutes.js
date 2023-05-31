const express = require('express');
const router = express.Router();

const usuarioModel = require("../models/usuario");

router.get('/', function (req, res, next) {
    usuarioModel
        .obtener()
        .then(usuarios => {
            res.render("usuarios/ver", {
                usuarios: usuarios,
            });
        })
        .catch(err => {
            return res.status(500).send("Error obteniendo usuarios");
        });

});
router.get('/agregar', function (req, res, next) {
    res.render("usuarios/agregar");
});
router.post('/insertar', function (req, res, next) {
    // Obtener el nombre y precio. Es lo mismo que
    // const nombre = req.body.nombre;
    // const precio = req.body.precio;
    const { nombre, email, genero, contraseña } = req.body;
    if (!nombre || !email || !genero || !contraseña) {
        return res.status(500).send("No hay alguna variable");
    }
    // Si todo va bien, seguimos
    usuarioModel
        .insertar(nombre, email, genero, contraseña)
        .then(idUsuarioInsertado => {
            res.redirect("/usuarios");
        })
        .catch(err => {
            return res.status(500).send("Error insertando usuario");
        });
});
router.get('/eliminar/:id', function (req, res, next) {
    usuarioModel
        .eliminar(req.params.id)
        .then(() => {
            res.redirect("/usuarios");
        })
        .catch(err => {
            return res.status(500).send("Error eliminando");
        });
});
router.get('/editar/:id', function (req, res, next) {
    usuarioModel
        .obtenerPorId(req.params.id)
        .then(usuario => {
            if (usuario) {
                res.render("usuarios/editar", {
                    usuario: usuario,
                });
            } else {
                return res.status(500).send("No existe usuario con ese id");
            }
        })
        .catch(err => {
            return res.status(500).send("Error obteniendo usuario");
        });
});
router.post('/actualizar/', function (req, res, next) {
    // Obtener el nombre y precio. Es lo mismo que
    // const nombre = req.body.nombre;
    // const precio = req.body.precio;
    const { id_usuario, nombre, email, genero, contraseña } = req.body;
    if (!nombre || !id_usuario || !email || !genero || !contraseña ) {
        return res.status(500).send("No hay suficientes datos");
    }
    // Si todo va bien, seguimos
    usuarioModel
        .actualizar(id_usuario, nombre, email, genero, contraseña)
        .then(() => {
            res.redirect("/usuarios");
        })
        .catch(err => {
            return res.status(500).send("Error actualizando usuario");
        });
});

module.exports = router;
