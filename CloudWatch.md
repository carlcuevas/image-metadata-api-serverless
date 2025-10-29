# CloudWatch: Troubleshooting y Rendimiento

## Logs
- **Lambda > Monitor > Logs**: revisar errores de runtime o permisos.
- Sugerencia: usar filtros de `REPORT` para ver duración y memoria usada.

## Métricas
- **Invocations** y **Errors**: validar que los triggers funcionen y si hay excepciones.
- **Duration** y **Throttles**: ayudan a ajustar memoria y concurrencia.

## Optimización
- **Memoria**: aumentar memoria también sube CPU; útil para bajar duración.
- **Timeout**: mantener en 30s (requisito). Subirlo solo si la lógica lo exige.
- **Concurrencia reservada**: evitar throttling y aislar funciones críticas.
- **Provisioned Concurrency**: reduce cold starts en rutas críticas.
- **Ephemeral storage (/tmp)**: subirlo si procesas archivos grandes.
- **Retries y DLQ**: para eventos asíncronos (S3), configurar política de reintentos y colas de error si fuese necesario.
