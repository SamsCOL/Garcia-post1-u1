# Análisis 1: Petición GET — example.com

> Valores de referencia medidos el 20/11/2026. Los tiempos y algunos headers
> (Date, Age, CF-RAY) cambian en cada petición: verifícalos contra tu propia
> captura de DevTools.

## Información general
- URL: https://example.com/
- Método: GET
- Código de estado: 200 OK
- Tipo de recurso (DevTools): document
- Protocolo: HTTPS (HTTP/2 en Chrome, servido por Cloudflare)

## Headers de Request
| Header | Valor |
|--------|-------|
| Host (`:authority` en HTTP/2) | example.com |
| User-Agent | Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36 |
| Accept | text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,\*/\*;q=0.8,application/signed-exchange;v=b3;q=0.7 |
| Accept-Encoding | gzip, deflate, br, zstd |
| Accept-Language | es-ES,es;q=0.9 |

## Headers de Response
| Header | Valor | Significado |
|--------|-------|-------------|
| Content-Type | text/html; charset=utf-8 | El cuerpo es un documento HTML codificado en UTF-8; el navegador lo renderiza como página. |
| Content-Length | No enviado (usa `Transfer-Encoding: chunked`) | El servidor envía el cuerpo por fragmentos, por eso no declara el tamaño total por adelantado. |
| Date | Fri, 20 Nov 2026 14:51:05 GMT | Fecha y hora en que el servidor generó la respuesta. |
| Cache-Control | No presente en esta respuesta | Sin directiva explícita, el navegador aplica caché heurística basada en `Last-Modified`. |
| Last-Modified | Thu, 19 Nov 2026 22:11:52 GMT | Última modificación del recurso; permite peticiones condicionales (`If-Modified-Since` → 304). |
| ETag | No presente | El servidor no usa ETag; la validación de caché se hace con `Last-Modified`. |
| Age | 2755 | Segundos que la respuesta lleva almacenada en la caché del CDN. |
| cf-cache-status | HIT | La respuesta se sirvió desde la caché de Cloudflare, sin llegar al servidor de origen. |
| Server | cloudflare | Infraestructura que atiende la petición (CDN). |
| Allow | GET, HEAD | Métodos HTTP permitidos sobre este recurso. |

## Tiempos de carga
| Fase | Tiempo (ms) |
|------|------------|
| DNS Lookup | 509 |
| Initial connection (TCP) | 1325 |
| SSL (TLS handshake) | 387 |
| TTFB (Waiting for server response) | 74 |
| Content Download | < 1 |
| **Total** | **2295** |

> Fue la primera conexión (caché DNS vacía), por eso DNS y conexión inicial
> dominan el tiempo total. Al recargar, Chrome reutiliza la conexión y estas
> fases bajan casi a 0 ms.

## Respuesta (extracto)
```html
<!doctype html>
<html>
<head>
    <title>Example Domain</title>
    ...
</head>
<body>
<div>
    <h1>Example Domain</h1>
    ...
```

## Conclusión
La petición GET a example.com devolvió 200 OK con un documento HTML
(`Content-Type: text/html`), que es el recurso principal tipo *document* que el
navegador renderiza. La respuesta fue servida desde la caché de Cloudflare
(`cf-cache-status: HIT`, `Age`), lo que explica un TTFB muy bajo: el servidor de
origen ni siquiera participó. La mayor parte del tiempo total se fue en
establecer la comunicación (DNS, TCP y TLS), no en generar o descargar el
contenido, lo que muestra por qué la reutilización de conexiones y los CDN son
clave para el rendimiento web. Además, la ausencia de `Cache-Control` y la
presencia de `Last-Modified` indican que el navegador validará la caché mediante
peticiones condicionales.

## Evidencia
![Panel Network — example.com](../capturas/01-example-headers.png)

![Timing — example.com](../capturas/01-example-timing.png)
