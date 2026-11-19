CREATE DATABASE IF NOT EXISTS sistemahvida
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE sistemahvida;

CREATE TABLE IF NOT EXISTS usuarios (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    correo VARCHAR(254) NOT NULL,
    password VARCHAR(255) NOT NULL,
    rol VARCHAR(20) NOT NULL DEFAULT 'aprendiz',
    estado TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (id),
    UNIQUE KEY uq_usuarios_correo (correo)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS hojas_vida (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    usuario_id INT UNSIGNED NULL,
    nombre VARCHAR(150) NOT NULL,
    edad TINYINT UNSIGNED NOT NULL,
    ciudad VARCHAR(120) NOT NULL,
    correo VARCHAR(254) NOT NULL,
    fotografia TEXT NULL,
    programa VARCHAR(150) NOT NULL,
    ficha VARCHAR(50) NOT NULL,
    jornada VARCHAR(80) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_hojas_vida_correo (correo),
    UNIQUE KEY uq_hojas_vida_usuario (usuario_id),
    CONSTRAINT fk_hojas_vida_usuario
        FOREIGN KEY (usuario_id) REFERENCES usuarios (id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS estudios (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    hoja_vida_id INT UNSIGNED NOT NULL,
    nivel VARCHAR(100) NOT NULL,
    institucion VARCHAR(200) NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    anio_graduacion SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    KEY ix_estudios_hoja_vida (hoja_vida_id),
    CONSTRAINT fk_estudios_hoja_vida
        FOREIGN KEY (hoja_vida_id) REFERENCES hojas_vida (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS cursos (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    hoja_vida_id INT UNSIGNED NOT NULL,
    nombre VARCHAR(200) NOT NULL,
    PRIMARY KEY (id),
    KEY ix_cursos_hoja_vida (hoja_vida_id),
    CONSTRAINT fk_cursos_hoja_vida
        FOREIGN KEY (hoja_vida_id) REFERENCES hojas_vida (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS experiencias (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    hoja_vida_id INT UNSIGNED NOT NULL,
    empresa VARCHAR(200) NOT NULL,
    cargo VARCHAR(150) NOT NULL,
    tiempo VARCHAR(100) NOT NULL,
    funciones TEXT NOT NULL,
    PRIMARY KEY (id),
    KEY ix_experiencias_hoja_vida (hoja_vida_id),
    CONSTRAINT fk_experiencias_hoja_vida
        FOREIGN KEY (hoja_vida_id) REFERENCES hojas_vida (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS habilidades (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    experiencia_id INT UNSIGNED NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    PRIMARY KEY (id),
    KEY ix_habilidades_experiencia (experiencia_id),
    CONSTRAINT fk_habilidades_experiencia
        FOREIGN KEY (experiencia_id) REFERENCES experiencias (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;
