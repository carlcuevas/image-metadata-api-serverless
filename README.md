Image Metadata API — Carlos Cuevas
Bienvenido al repositorio de mi segundo proyecto de evaluación, donde armé una solución serverless en AWS para guardar y consultar metadatos de imágenes. El objetivo es que puedas subir imágenes, guardar sus datos y consultarlos desde una API, todo sin infraestructura física.

¿Qué tecnologías y servicios utilicé?
S3 para guardar las imágenes que subas.

DynamoDB para almacenar los metadatos y así tener consultas rápidas.

Lambda:

Una función se activa sola cuando subes una imagen al bucket (detector de eventos).

La otra responde a llamados de la API para consultar o modificar metadatos.

API Gateway para exponer todo como endpoints REST, así puedes interactuar desde Postman, scripts o cualquier frontend.

¿Cómo se despliega esto?
El repositorio está listo para integraciones continuas usando GitHub Actions.

Si quieres desplegarlo tú mismo, primero ve a la sección "Secrets" de GitHub y agrega tus credenciales de AWS:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

Corre el workflow llamado "Deploy (SAM)".

El bucket se crea automáticamente y se llama (por defecto) my-image-storage-bucket-cuevas.

Cuando termina, en CloudFormation te aparecerá el endpoint para llamar a la API.

¿Cómo lo pruebo o demuestro?
Tengo una colección de Postman (postman/ImageMetadataAPI.postman_collection.json) que te ayuda a probar todos los endpoints.

Si prefieres la terminal, hay un script llamado demo.sh que resuelve los llamados de ejemplo y muestra los resultados.

¿Y cómo monitoreo que todo está funcionando?
Revisando CloudWatch.md tienes las instrucciones para monitorear logs, errores y todas las métricas importantes. Te explico allí cómo ajustar memoria, tiempo de ejecución y cómo ver si las Lambdas están funcionando bien.

Estructura de archivos y carpetas
Aquí va la organización del repo para que no te pierdas:

text
template.yaml                  # Infraestructura serverless como código
src/
  get_image_metadata/app.py    # Código de Lambda de consulta
  s3_file_event/app.py         # Código de Lambda de eventos S3
.github/workflows/deploy.yml   # Pipeline de CI/CD
postman/...
scripts/...
docs/CloudWatch.md
Datos para probar
Incluyo una imagen de ejemplo (assets/sample.jpg) para que, apenas despliegues el proyecto, puedas probar el flujo completo. Si activas la opción seed_sample: true, esa imagen se sube sola y ya tienes datos para consultar sin hacer nada manual.
