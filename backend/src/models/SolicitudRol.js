const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const SolicitudRol = sequelize.define(
    'SolicitudRol',
    {
        id: { type: DataTypes.BIGINT.UNSIGNED, primaryKey: true, autoIncrement: true },
        usuarioId: { type: DataTypes.BIGINT.UNSIGNED, allowNull: false, field: 'usuario_id' },
        rolSolicitado: {
            type: DataTypes.ENUM('CONDOMINO', 'SEGURIDAD', 'ADMINISTRADOR'),
            allowNull: false,
            field: 'rol_solicitado'
        },
        motivo: { type: DataTypes.STRING(600), allowNull: false },
        estatus: {
            type: DataTypes.ENUM('PENDIENTE', 'APROBADA', 'RECHAZADA', 'CANCELADA'),
            allowNull: false,
            defaultValue: 'PENDIENTE'
        },
        revisadoPorUsuarioId: { type: DataTypes.BIGINT.UNSIGNED, allowNull: true, field: 'revisado_por_usuario_id' },
        comentarioRevision: { type: DataTypes.STRING(600), allowNull: true, field: 'comentario_revision' },
        creadoEn: { type: DataTypes.DATE, allowNull: false, defaultValue: DataTypes.NOW, field: 'creado_en' },
        revisadoEn: { type: DataTypes.DATE, allowNull: true, field: 'revisado_en' }
    },
    { tableName: 'solicitudes_rol', timestamps: false }
);

module.exports = SolicitudRol;
