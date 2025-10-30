Image Metadata API — Carlos Cuevas
Bienvenido al proyecto de imagen y metadatos en AWS Serverless. Aquí se explica cómo funciona, cómo se despliega, cómo se prueba y cómo se monitorea, resolviendo todas las dudas prácticas:

¿Qué hace esta API?
Permite subir imágenes a S3 y asociarles metadatos en DynamoDB. Ofrece endpoints REST para subir, consultar y borrar imágenes y sus datos, sin usar servidores propios.

Servicios AWS usados
S3: Guarda las imágenes subidas.

DynamoDB: Almacena metadatos (ID, nombre, tipo, fecha subida).

Lambda:

Procesa nuevos archivos subidos.

Expone lógica de consulta/borrado/upload vía API.

API Gateway REST: Expone la funcionalidad para integraciones, apps y pruebas.

Estructura del repositorio
text
template.yaml                  # Infraestructura como código
src/
  get_image_metadata/app.py    # Lambda de consulta de metadatos
  s3_file_event/app.py         # Lambda para eventos al subir imagen
.github/workflows/deploy.yml   # Automatización CI/CD (GitHub Actions)
postman/ImageMetadataAPI.postman_collection.json # Pruebas pre-cargadas
scripts/demo.sh                # Script para pruebas rápidas
docs/CloudWatch.md             # Guía de monitoreo y performance
assets/sample.jpg              # Imagen de prueba
Instalación y despliegue
Instala AWS SAM CLI y Docker en tu máquina local.

Desde el repo, ejecuta:

text
sam build
sam local start-api
Esto levanta una API local para probar con Postman o curl.

Si tienes claves de AWS, puedes desplegar en la nube real con:

text
sam deploy --guided
Guárdalas como Secrets en GitHub para usar CI/CD automático.

¿Cómo pruebo la API?
Prueba local
Ejecuta sam local start-api, abre Postman y usa los endpoints como:

GET http://localhost:3000/metadata

POST http://localhost:3000/upload

GET http://localhost:3000/metadata/{image_id}

O corre el script:

text
bash scripts/demo.sh
Prueba en AWS
Despliega con GitHub Actions o con tus claves.

Recupera el endpoint desde CloudFormation Outputs.

Usa la colección de Postman ImageMetadataAPI.postman_collection.json, ajustando la variable api a tu URL real.

Prueba los endpoints REST:

GET /metadata: Lista todas las imágenes.

POST /upload: Sube una nueva imagen (puedes usar sample.jpg).

GET /metadata/{image_id}: Consulta info de una imagen específica.

DELETE /metadata/{image_id}: Borra la imagen y su metadato.

Evidencia de funcionamiento
Incluye capturas de resultados exitosos (status 200/204, cuerpos correctos).

Adjunta evidencias del despliegue en CloudFormation (pila creada, recursos, endpoint funcionando).

Muestra logs de Lambda sin errores visibles.

Monitoreo y solución de errores
Consulta el archivo docs/CloudWatch.md para aprender cómo ver logs, métricas y ajustar parámetros cuando tu Lambda necesite más memoria o tiempo.

Usa:

text
sam logs -n NombreDeLaFuncion --stack-name tu-stack --tail
Para ver invocaciones, errores y respuestas.

Preguntas frecuentes
¿Puedo probar esto si no tengo cuenta AWS o claves?
Sí, puedes correr todo con sam local usando Docker, emulando eventos y llamadas con Postman o curl.

¿Cómo cambio los metadatos o el formato de imagen?
Edita el código en src/get_image_metadata/app.py y src/s3_file_event/app.py según tus necesidades.

¿Cómo agrego nuevas funcionalidades?
Puedes modificar el template.yaml para añadir rutas, triggers, autorizaciones o nuevos servicios.
