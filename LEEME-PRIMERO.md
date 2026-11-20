# Cómo usar este ZIP

Contenido:
- `apellido-post1-u1/` → todo el contenido final del repositorio (Parte 1 y Parte 2).
- `crear-commits.ps1` → script de Windows que copia los archivos a tu repositorio
  clonado y crea los commits en el orden exacto del laboratorio.

## 1. Lo que tienes que hacer tú (no se puede automatizar)
1. Instalar VS Code + extensiones, Git y Postman (Pasos 1 y 2).
2. Crear el repositorio en GitHub `tuapellido-post1-u1` (público, con README y
   .gitignore "Node") y clonarlo (Paso 3).

## 2. Crear los commits automáticamente
En PowerShell, desde la carpeta donde descomprimiste el ZIP:

```powershell
powershell -ExecutionPolicy Bypass -File .\crear-commits.ps1 -Repo "C:\ruta\a\tuapellido-post1-u1"
```

Crea 7 commits (más el "Initial commit" de GitHub = 8):
1. feat: agregar estructura HTML base, estilos y script inicial (parte 1)
2. style: agregar efecto hover en secciones con transicion CSS (parte 1)
3. feat: crear estructura base de la parte 2 (analisis HTTP)
4. analysis: agregar analisis de peticion GET a example.com con DevTools
5. analysis: agregar analisis GET API REST con comparacion 200 vs 404
6. analysis: agregar analisis POST con Postman y tests automatizados
7. docs: completar README con resumen de ambas partes y conclusiones

Luego: `git push origin main`.

## 3. Capturas de pantalla (obligatorias para la rúbrica)
Las capturas deben ser de TU equipo. El README y los análisis ya las enlazan con
estos nombres exactos; solo guárdalas en PNG con ese nombre:

**`parte-1-entorno/capturas/`**
| Archivo | Qué capturar |
|---------|--------------|
| 01-vscode-extensiones.png | Panel de extensiones con las 4 instaladas |
| 02-git-config.png | Terminal con `git --version` y `git config --global --list` |
| 03-repo-github.png | Repo en GitHub + terminal con `git log --oneline` |
| 04-pagina-live-server.png | Página abierta con Live Server |
| 05-commits.png | Historial de commits en GitHub |
| 06-devtools-console.png | Console con los 3 mensajes de main.js |
| 07-devtools-elements.png | Elements con el header seleccionado y sus estilos |

**`parte-2-analisis-http/capturas/`**
| Archivo | Qué capturar |
|---------|--------------|
| 00-estructura-vscode.png | Explorador de VS Code con ambas carpetas |
| 01-example-headers.png | Network → example.com → Headers |
| 01-example-timing.png | Network → example.com → Timing |
| 02-api-200.png | Network → /posts/1 con 200 |
| 02-api-404.png | Network → /posts/999 con 404 |
| 03-postman-201.png | Postman con la respuesta 201 |
| 03-postman-tests.png | Postman → Test Results en verde |
| 04-repo-final.png | Repo final en GitHub con README renderizado |

Después: `git add .`, `git commit -m "docs: agregar capturas de evidencia de los checkpoints"`, `git push`.

## 4. Revisa los valores
Los headers y tiempos de los análisis son reales, medidos el 20/11/2026, pero
los tiempos y algunos headers (Date, Age) cambian en cada petición. Si tus
capturas muestran valores distintos, actualiza las tablas para que coincidan.
También en Postman puedes importar `parte-2-analisis-http/postman/laboratorio-http.postman_collection.json`.
