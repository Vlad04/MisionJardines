const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const VerificacionCuenta = sequelize.define(
    'VerificacionCuenta',
    {
        id: { type: DataTypes.BIGINT.UNSIGNED, primaryKey: true, autoIncrement: true },
        tipo: { type: DataTypes.ENUM('REGISTRO', 'CAMBIO_CORREO'), allowNull: false },
        usuarioId: { type: DataTypes.BIGINT.UNSIGNED, allowNull: true, field: 'usuario_id' },
        casaId: { type: DataTypes.INTEGER.UNSIGNED, allowNull: true, field: 'casa_id' },
        correo: { type: DataTypes.STRING(150), allowNull: false },
        codigoHash: { type: DataTypes.STRING(64), allowNull: false, field: 'codigo_hash' },
        datosJson: { type: DataTypes.TEXT('long'), allowNull: true, field: 'datos_json' },
        intentos: { type: DataTypes.INTEGER.UNSIGNED, allowNull: false, defaultValue: 0 },
        expiraEn: { type: DataTypes.DATE, allowNull: false, field: 'expira_en' },
        consumidoEn: { type: DataTypes.DATE, allowNull: true, field: 'consumido_en' },
        creadoEn: { type: DataTypes.DATE, allowNull: false, defaultValue: DataTypes.NOW, field: 'creado_en' }
    },
    {
        tableName: 'verificaciones_cuenta',
        timestamps: false,
        indexes: [
            { fields: ['correo', 'tipo', 'consumido_en'] },
            { fields: ['usuario_id', 'tipo', 'consumido_en'] },
            { fields: ['casa_id', 'tipo', 'consumido_en'] }
        ]
    }
);

module.exports = VerificacionCuenta;
