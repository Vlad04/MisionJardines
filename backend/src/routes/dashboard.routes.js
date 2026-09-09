const express = require('express');
const { obtenerDashboard } = require('../controllers/dashboard.controller');
const { autenticarToken } = require('../middlewares/auth.middleware');

const router = express.Router();

router.get('/', autenticarToken, obtenerDashboard);

module.exports = router;
