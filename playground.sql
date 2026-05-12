-- Ver el numero de registros en cada tabla
SELECT 'asesor' AS tabla, COUNT(*) AS registros FROM asesor
UNION ALL SELECT 'carrera', COUNT(*) FROM carrera
UNION ALL SELECT 'certificado', COUNT(*) FROM certificado
UNION ALL SELECT 'convenio', COUNT(*) FROM convenio
UNION ALL SELECT 'convenio_carrera', COUNT(*) FROM convenio_carrera
UNION ALL SELECT 'documento', COUNT(*) FROM documento
UNION ALL SELECT 'empresa', COUNT(*) FROM empresa
UNION ALL SELECT 'estudiante', COUNT(*) FROM estudiante
UNION ALL SELECT 'evaluacion', COUNT(*) FROM evaluacion
UNION ALL SELECT 'facultad', COUNT(*) FROM facultad
UNION ALL SELECT 'informefinal', COUNT(*) FROM informefinal
UNION ALL SELECT 'postulacion', COUNT(*) FROM postulacion
UNION ALL SELECT 'practicaoferta_carrera', COUNT(*) FROM practicaoferta_carrera
UNION ALL SELECT 'practica_oferta', COUNT(*) FROM practicaoferta
UNION ALL SELECT 'practicarealizada', COUNT(*) FROM practicarealizada
UNION ALL SELECT 'rol', COUNT(*) FROM rol
UNION ALL SELECT 'seguimiento', COUNT(*) FROM seguimiento
UNION ALL SELECT 'sucursal', COUNT(*) FROM sucursal
UNION ALL SELECT 'supervisor', COUNT(*) FROM supervisor
UNION ALL SELECT 'usuario', COUNT(*) FROM usuario
UNION ALL SELECT 'usuario_rol', COUNT(*) FROM usuario_rol;