# Análisis 2: Petición GET — API REST (JSONPlaceholder)

> Valores de referencia medidos el 20/11/2026. Verifícalos contra tu captura.

## Información general
| Campo | Petición exitosa | Petición fallida |
|-------|------------------|------------------|
| URL | https://jsonplaceholder.typicode.com/posts/1 | https://jsonplaceholder.typicode.com/posts/999 |
| Método | GET | GET |
| Código de estado | **200 OK** | **404 Not Found** |
| Content-Type | application/json; charset=utf-8 | application/json; charset=utf-8 |
| Content-Length | 292 | 2 |
| Cuerpo | Objeto JSON del post | `{}` (objeto vacío) |

## Headers de Request
| Header | Valor |
|--------|-------|
| Host (`:authority`) | jsonplaceholder.typicode.com |
| User-Agent | Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36 |
| Accept | text/html,application/xhtml+xml,... (navegación directa desde la barra de direcciones) |

## Headers de Response (200 OK)
| Header | Valor | Significado |
|--------|-------|-------------|
| Content-Type | application/json; charset=utf-8 | El cuerpo es JSON: datos estructurados para ser procesados por código, no una página para renderizar. |
| Content-Length | 292 | Tamaño exacto del cuerpo en bytes. |
| Cache-Control | max-age=43200 | La respuesta puede reutilizarse desde caché durante 12 horas. |
| ETag | W/"124-yiKdLzqO5gfBrJFrcdJ8Yq0LGnU" | Identificador (débil) de la versión del recurso para validar caché. |
| X-Powered-By | Express | El backend está construido con Express (Node.js). |
| Access-Control-Allow-Credentials | true | Cabecera CORS: permite peticiones con credenciales desde otros orígenes. |
| X-Content-Type-Options | nosniff | Impide que el navegador "adivine" un tipo distinto al declarado. |
| X-RateLimit-Limit / Remaining | 3600000 / 3599999 | Límite de peticiones permitido y cuántas quedan. |
| Vary | Origin, Accept-Encoding | La caché debe distinguir respuestas según estas cabeceras de request. |

## Cuerpo de la respuesta (200)
```json
{
  "userId": 1,
  "id": 1,
  "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
  "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
}
```

## Cuerpo de la respuesta (404)
```json
{}
```
El servidor responde con el mismo `Content-Type` JSON, pero el código **404**
indica que el recurso `/posts/999` no existe (la API solo tiene los posts 1–100).

## Tiempos de carga
| Fase | /posts/1 (ms) | /posts/999 (ms) |
|------|---------------|-----------------|
| DNS Lookup | 37 | 18 |
| Initial connection (TCP) | 49 | 62 |
| SSL | 146 | 90 |
| TTFB | 78 | 111 |
| Total | 329 | 282 |

## Comparación: página HTML vs API REST
| Aspecto | example.com (HTML) | /posts/1 (API REST) |
|---------|--------------------|---------------------|
| Content-Type | text/html | application/json |
| Consumidor | Navegador (renderiza la página) | Código cliente (fetch, apps, Postman) |
| Tamaño declarado | Chunked (sin Content-Length) | Content-Length: 292 |
| Caché | Sin Cache-Control, usa Last-Modified | Cache-Control: max-age=43200 + ETag |
| Backend visible | Solo CDN (Server: cloudflare) | Express (X-Powered-By) detrás de Cloudflare |
| CORS | No aplica | Cabeceras Access-Control-* presentes |
| Manejo de errores | — | 404 con cuerpo JSON `{}` |

## Conclusión
Ambas peticiones usan el mismo método (GET) y protocolo, pero el
`Content-Type` define cómo se usa la respuesta: `text/html` se renderiza,
mientras que `application/json` se procesa como datos. La API REST expone más
metadatos orientados a desarrolladores (CORS, límite de peticiones, ETag,
tecnología del backend). El código de estado es la forma estándar en que la API
comunica el resultado: 200 cuando el recurso existe y 404 cuando no, aunque
ambas respuestas tengan un cuerpo JSON válido. Por eso un cliente debe revisar
siempre el código de estado y no solo el cuerpo.

## Evidencia
![GET /posts/1 — 200 OK](../capturas/02-api-200.png)

![GET /posts/999 — 404 Not Found](../capturas/02-api-404.png)
