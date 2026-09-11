-- Pagos reportados por residentes a partir de comprobantes bancarios.
-- Ejecutar una sola vez en el esquema de Misión Jardines antes de habilitar /api/pagos.

CREATE TABLE IF NOT EXISTS pagos_reportados (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    casa_id INT UNSIGNED NOT NULL,
    usuario_id BIGINT UNSIGNED NOT NULL,
    folio_reporte VARCHAR(60) NOT NULL,
    folio_operacion VARCHAR(180) NOT NULL,
    fecha_operacion DATE NOT NULL,
    hora_operacion TIME NOT NULL,
    concepto VARCHAR(300) NOT NULL,
    monto DECIMAL(12,2) NOT NULL,
    calle_snapshot VARCHAR(120) NOT NULL,
    numero_casa_snapshot VARCHAR(30) NOT NULL,
    nombre_reportante VARCHAR(250) NULL,
    comprobante_data MEDIUMTEXT NOT NULL,
    texto_ocr TEXT NULL,
    estatus ENUM('PENDIENTE_VALIDACION','VALIDADO','RECHAZADO') NOT NULL DEFAULT 'PENDIENTE_VALIDACION',
    observaciones_revision VARCHAR(600) NULL,
    validado_por_usuario_id BIGINT UNSIGNED NULL,
    fecha_validacion DATETIME NULL,
    creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    actualizado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_pago_folio_reporte (folio_reporte),
    UNIQUE KEY uq_pago_folio_operacion (folio_operacion),
    KEY idx_pago_casa_fecha (casa_id, fecha_operacion),
    KEY idx_pago_usuario (usuario_id, creado_en),
    KEY idx_pago_estatus (estatus, creado_en),
    CONSTRAINT fk_pago_casa FOREIGN KEY (casa_id)
        REFERENCES direcciones(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_pago_usuario FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_pago_validador FOREIGN KEY (validado_por_usuario_id)
        REFERENCES usuarios(id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT chk_pago_monto CHECK (monto >= 300)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
