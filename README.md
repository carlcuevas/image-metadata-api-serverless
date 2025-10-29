# Image Metadata API — Carlos Cuevas

Infra serverless mínima: **S3 + DynamoDB + 2 Lambdas + API Gateway (REST)**.

- Bucket S3 (nombre base debe partir con **my-image-storage-bucket**).
- Tabla DynamoDB **ImageMetadata** (PK: `image_id`).
- Lambdas: **s3_file_event** (trigger S3 Put) y **get_image_metadata** (API).
- API REST `ImageMetadataAPI` con: `GET /metadata`, `GET /metadata/{image_id}`, `DELETE /metadata/{image_id}`, `POST /upload`.

## Despliegue (GitHub Actions)
1. Agrega *Secrets* en el repo:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
2. Actions → **Deploy (SAM)** → Run workflow.
   - `bucket_base_name`: por defecto `my-image-storage-bucket-cuevas`.
   - El endpoint aparece en **CloudFormation → Outputs → ApiEndpoint**.

## Pruebas
Ver **postman/ImageMetadataAPI.postman_collection.json** o usa `scripts/demo.sh`.

## Monitoreo y rendimiento
En **docs/CloudWatch.md** hay notas de logs, métricas (Invocations/Errors) y ajustes de performance (memoria, tiempo de ejecución, concurrencia).

## Estructura
```
template.yaml
src/
  get_image_metadata/app.py
  s3_file_event/app.py
.github/workflows/deploy.yml
postman/ImageMetadataAPI.postman_collection.json
scripts/demo.sh
docs/CloudWatch.md
```


## Datos de prueba
- Incluye **assets/sample.jpg** (esta imagen) para sembrar un item de ejemplo automáticamente:
  - En el workflow, deja `seed_sample: true` y tras el deploy se sube a S3 usando **POST /upload** → **PUT** al URL prefirmado.
  - Puedes cambiarla o borrarla si prefieres.
