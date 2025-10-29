
Image Metadata API — Carlos Cuevas
¡Hola! Este es mi segundo proyecto de evaluación, donde diseñé una arquitectura serverless en AWS para gestionar fotos y sus metadatos de forma moderna. La idea es que puedas subir imágenes y, sin preocuparte por servidores, consultar todos sus datos desde una API.

🚀 ¿Qué servicios uso?
S3: Es donde se guardan tus imágenes. Cada vez que subes una foto, queda almacenada aquí.

DynamoDB: Aquí registro todos los metadatos. Puedes consultarlos rápido y hacer búsquedas fácilmente.

Lambda:

Una función se activa cuando agregas una imagen en el bucket S3, así no tienes que hacer nada manual.

Otra función responde a las consultas y acciones de la API (buscar, borrar, etc.).

API Gateway: Expongo todo como endpoints REST. Así puedes interactuar desde Postman, tu propio script o cualquier frontend.

🧑‍💻 ¿Cómo lo instalas y despliegas?
Ve a los "Secrets" de GitHub en este repositorio y pon tus credenciales de AWS:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

Lanza el workflow "Deploy (SAM)" desde la pestaña Actions.

El bucket S3 se creará solo y, por defecto, se llama my-image-storage-bucket-cuevas.

Cuando termine el despliegue, en la consola de CloudFormation aparecerá la URL del endpoint para llamar a la API.

📦 Organización y estructura
Así está ordenado el repositorio para que no te pierdas:

text
template.yaml                  # Infraestructura AWS declarada como código
src/
  get_image_metadata/app.py    # Código Lambda para consultar y gestionar datos
  s3_file_event/app.py         # Código Lambda que responde a nuevos archivos en S3
.github/workflows/deploy.yml   # Automatización del despliegue (CI/CD)
postman/                       # Colección de pruebas para Postman
scripts/                       # Script demo para pruebas desde terminal
docs/CloudWatch.md             # Guía rápida para monitorear y ajustar recursos
assets/sample.jpg              # Imagen de prueba que sube el workflow
🔍 ¿Cómo lo pruebas?
Abre el archivo Postman y prueba los endpoints /metadata, /metadata/{image_id}, /upload, etc.

Si prefieres no usar Postman, corre el script demo.sh en tu terminal: te guía y muestra resultados reales.

📊 Monitoreo y ajustes
Abre el archivo CloudWatch.md para saber cómo ver logs, errores y métricas clave como memoria o concurrencia.

Allí te explico cómo ajustar los parámetros del sistema si lo necesitas.

🖼️ Uso de datos de ejemplo
Incluyo la imagen sample.jpg para que en el primer despliegue ya tengas todo listo y puedas experimentar. Si dejas seed_sample: true, el sistema sube la foto automáticamente y la puedes consultar desde la API apenas termine el despliegue.

✉️ Últimos consejos
Si te topas con límites de permisos en tu cuenta AWS (típico en labs educativos), revisa el código fuente y los archivos del repositorio para seguir la lógica y entender el proceso. Todo está comentado y documentado para que no tengas dudas.

¡Gracias por revisar mi proyecto y espero que te sea útil para aprender y probar arquitectura serverless real!
