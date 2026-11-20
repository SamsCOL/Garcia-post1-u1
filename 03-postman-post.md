# Análisis 3: Petición POST — Postman

> Respuesta de referencia obtenida el 20/11/2026. Verifícala contra tu captura.

## Configuración de la petición
| Campo | Valor |
|-------|-------|
| Método | POST |
| URL | https://jsonplaceholder.typicode.com/posts |
| Header | Content-Type: application/json |
| Body | raw → JSON |

```json
{
  "title": "Laboratorio Programacion Web",
  "body": "Analisis de peticiones HTTP con Postman.",
  "userId": 1
}
```

## Respuesta recibida
- Código de estado: **201 Created**
- Cuerpo:

```json
{
  "title": "Laboratorio Programacion Web",
  "body": "Analisis de peticiones HTTP con Postman.",
  "userId": 1,
  "id": 101
}
```

El servidor devolvió el mismo objeto enviado más el campo `id: 101` asignado por
él. JSONPlaceholder es una API de pruebas: simula la creación pero **no guarda**
el recurso (un GET a `/posts/101` devuelve 404).

## Headers de Response relevantes
| Header | Valor | Significado |
|--------|-------|-------------|
| Location | https://jsonplaceholder.typicode.com/posts/101 | URL del nuevo recurso creado (estándar para 201). |
| Content-Type | application/json; charset=utf-8 | La respuesta es JSON. |
| Content-Length | 127 | Tamaño del cuerpo en bytes. |
| X-Powered-By | Express | Backend en Express (Node.js). |
| Cache-Control | no-cache | Las respuestas a POST no deben reutilizarse desde caché. |
| cf-cache-status | DYNAMIC | Cloudflare no cacheó la respuesta: se generó en el servidor de origen. |
| Access-Control-Expose-Headers | Location | Permite al JavaScript del navegador leer el header Location (CORS). |

## Tests en Postman
```javascript
// Test en Postman
pm.test("Status 201 Created", () => {
  pm.response.to.have.status(201);
});

pm.test("Respuesta incluye id asignado", () => {
  const json = pm.response.json();
  pm.expect(json).to.have.property("id");
  pm.expect(json.title).to.equal("Laboratorio Programacion Web");
});
```

| Test | Resultado |
|------|-----------|
| Status 201 Created | PASS |
| Respuesta incluye id asignado | PASS |

La colección lista para importar en Postman está en
[`../postman/laboratorio-http.postman_collection.json`](../postman/laboratorio-http.postman_collection.json).

## Diferencias entre GET y POST
| Aspecto | GET | POST |
|---------|-----|------|
| Propósito | Obtener/leer un recurso | Crear un recurso nuevo (enviar datos) |
| Cuerpo de la petición | No lleva | Lleva datos (aquí JSON) |
| Content-Type en la request | No necesario | Obligatorio para indicar el formato del body |
| Código de éxito típico | 200 OK | 201 Created |
| Header Location | No | Sí, apunta al recurso creado |
| Caché | Cacheable (max-age=43200) | No cacheable (no-cache, DYNAMIC) |
| Idempotente | Sí: repetirlo no cambia el servidor | No: cada envío crea un recurso nuevo |
| Seguro (sin efectos) | Sí | No |

## Conclusión
La petición POST creó (de forma simulada) un recurso y el servidor respondió con
201 Created, el cuerpo enviado más un `id` y el header `Location` con la URL del
nuevo recurso, que es el comportamiento estándar de una API REST. A diferencia
de GET, POST lleva cuerpo, requiere declarar el `Content-Type` y no se almacena
en caché. Los tests de Postman permiten verificar automáticamente el código de
estado y el contenido de la respuesta, lo que convierte una prueba manual en una
verificación repetible.

## Evidencia
![Postman — 201 Created](../capturas/03-postman-201.png)

![Postman — Test Results](../capturas/03-postman-tests.png)
