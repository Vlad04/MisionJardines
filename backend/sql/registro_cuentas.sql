-- Registro, verificación de correo y solicitudes de cambio de rol.
-- Ejecutar una sola vez en el esquema u327351184_fracc_mj.

CREATE TABLE IF NOT EXISTS verificaciones_cuenta (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    tipo ENUM('REGISTRO','CAMBIO_CORREO') NOT NULL,
    usuario_id BIGINT UNSIGNED NULL,
    casa_id INT UNSIGNED NULL,
    correo VARCHAR(150) NOT NULL,
    codigo_hash CHAR(64) NOT NULL,
    datos_json LONGTEXT NULL,
    intentos TINYINT UNSIGNED NOT NULL DEFAULT 0,
    expira_en DATETIME NOT NULL,
    consumido_en DATETIME NULL,
    creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_verificacion_correo (correo, tipo, consumido_en),
    KEY idx_verificacion_usuario (usuario_id, tipo, consumido_en),
    KEY idx_verificacion_casa (casa_id, tipo, consumido_en),
    CONSTRAINT fk_verificacion_usuario FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_verificacion_casa FOREIGN KEY (casa_id)
        REFERENCES direcciones(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS solicitudes_rol (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    usuario_id BIGINT UNSIGNED NOT NULL,
    rol_solicitado ENUM('CONDOMINO','SEGURIDAD','ADMINISTRADOR') NOT NULL,
    motivo VARCHAR(600) NOT NULL,
    estatus ENUM('PENDIENTE','APROBADA','RECHAZADA','CANCELADA') NOT NULL DEFAULT 'PENDIENTE',
    revisado_por_usuario_id BIGINT UNSIGNED NULL,
    comentario_revision VARCHAR(600) NULL,
    creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    revisado_en DATETIME NULL,
    PRIMARY KEY (id),
    KEY idx_solicitud_usuario (usuario_id, estatus),
    KEY idx_solicitud_estatus (estatus, creado_en),
    CONSTRAINT fk_solicitud_usuario FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_solicitud_revisor FOREIGN KEY (revisado_por_usuario_id)
        REFERENCES usuarios(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- La aplicación usa estos nombres exactos. El alta siempre asigna CONDOMINO;
-- SEGURIDAD y ADMINISTRADOR solo se asignan tras una aprobación.
INSERT INTO roles (nombre, descripcion, activo, creado_en, actualizado_en)
SELECT 'CONDOMINO', 'Residente del fraccionamiento', 1, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM roles WHERE nombre = 'CONDOMINO');

INSERT INTO roles (nombre, descripcion, activo, creado_en, actualizado_en)
SELECT 'SEGURIDAD', 'Personal autorizado de seguridad', 1, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM roles WHERE nombre = 'SEGURIDAD');

INSERT INTO roles (nombre, descripcion, activo, creado_en, actualizado_en)
SELECT 'ADMINISTRADOR', 'Personal autorizado de administración', 1, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM roles WHERE nombre = 'ADMINISTRADOR');
