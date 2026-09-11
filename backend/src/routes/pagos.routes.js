const express = require('express');
const {
    obtenerConfiguracion,
    listarMisPagos,
    reportarPago
} = require('../controllers/pagos.controller');
const { autenticarToken } = require('../middlewares/auth.middleware');
const { autorizarRoles } = require('../middlewares/roles.middleware');

const router = express.Router();

router.use(autenticarToken);

router.get(
    '/config',
    autorizarRoles('SUPER_ADMIN', 'ADMINISTRADOR', 'MESA_DIRECTIVA', 'CONDOMINO'),
    obtenerConfiguracion
);

router.get(
    '/mios',
    autorizarRoles('SUPER_ADMIN', 'ADMINISTRADOR', 'MESA_DIRECTIVA', 'CONDOMINO'),
    listarMisPagos
);

router.post(
    '/',
    autorizarRoles('SUPER_ADMIN', 'ADMINISTRADOR', 'MESA_DIRECTIVA', 'CONDOMINO'),
    reportarPago
);

module.exports = router;
