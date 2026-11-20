# Post-contenido — Unidad 1: Fundamentos de la Web

## Descripción
Repositorio del laboratorio de la Unidad 1 de Programación Web —
Séptimo Semestre. Contiene dos partes: configuración del entorno
de desarrollo (`parte-1-entorno/`) y análisis de peticiones HTTP con
Chrome DevTools y Postman (`parte-2-analisis-http/`).

## Estructura del repositorio
```
apellido-post1-u1/
├── parte-1-entorno/
│   ├── index.html            # Página HTML base
│   ├── css/styles.css        # Estilos (incluye efecto hover)
│   ├── js/main.js            # Mensajes en consola al cargar
│   └── capturas/             # Evidencias de la Parte 1
├── parte-2-analisis-http/
│   ├── analisis/
│   │   ├── 01-pagina-html.md     # GET example.com
│   │   ├── 02-api-rest-get.md    # GET API REST (200 vs 404)
│   │   └── 03-postman-post.md    # POST con Postman + tests
│   ├── postman/
│   │   └── laboratorio-http.postman_collection.json
│   └── capturas/             # Evidencias de la Parte 2
├── .gitignore
└── README.md
```

## Instalación y ejecución (Parte 1)
1. Instalar **VS Code** (https://code.visualstudio.com/) con las extensiones
   Live Server, Prettier, GitLens y ESLint. Configurar Prettier como
   formateador predeterminado.
2. Instalar **Git** (https://git-scm.com/downloads) y configurar la identidad:
   ```bash
   git config --global user.name "Nombre Apellido"
   git config --global user.email "correo@ejemplo.com"
   git config --global core.editor "code --wait"
   git config --global init.defaultBranch main
   ```
3. Clonar el repositorio:
   ```bash
   git clone https://github.com/usuario/apellido-post1-u1.git
   cd apellido-post1-u1
   ```
4. Abrir la carpeta en VS Code, clic derecho sobre
   `parte-1-entorno/index.html` → **Open with Live Server**.
5. Abrir Chrome DevTools (F12): en **Console** aparecen los 3 mensajes de
   `main.js`; en **Elements** se inspecciona el DOM y los estilos del `header`.

## Parte 1 — Entorno de desarrollo
Página HTML básica (header, dos secciones y footer) con estilos CSS y un script
que registra en consola la hora de carga, el título del documento y el número de
secciones. Se inspeccionó con Chrome DevTools (Elements, Styles, Console) y se
agregó un efecto hover en las secciones. Ver `parte-1-entorno/`.

| Checkpoint | Evidencia |
|------------|-----------|
| Extensiones de VS Code | ![Extensiones](parte-1-entorno/capturas/01-vscode-extensiones.png) |
| Git instalado y configurado | ![Git config](parte-1-entorno/capturas/02-git-config.png) |
| Repositorio en GitHub + git log | ![Repositorio](parte-1-entorno/capturas/03-repo-github.png) |
| Página renderizada con Live Server | ![Página](parte-1-entorno/capturas/04-pagina-live-server.png) |
| Historial de commits | ![Commits](parte-1-entorno/capturas/05-commits.png) |
| DevTools: Console | ![Console](parte-1-entorno/capturas/06-devtools-console.png) |
| DevTools: Elements y Styles | ![Elements](parte-1-entorno/capturas/07-devtools-elements.png) |

## Parte 2 — Análisis de peticiones HTTP
| # | Tipo | URL | Código |
|---|------|-----|--------|
| 1 | GET HTML | https://example.com | 200 OK |
| 2 | GET JSON (exitoso) | /posts/1 | 200 OK |
| 3 | GET JSON (fallido) | /posts/999 | 404 Not Found |
| 4 | POST JSON | /posts | 201 Created |

Ver `parte-2-analisis-http/analisis/`.

| Checkpoint | Evidencia |
|------------|-----------|
| Estructura de carpetas en VS Code | ![Estructura](parte-2-analisis-http/capturas/00-estructura-vscode.png) |
| GET example.com (Network) | ![example.com](parte-2-analisis-http/capturas/01-example-headers.png) |
| GET /posts/1 — 200 | ![200](parte-2-analisis-http/capturas/02-api-200.png) |
| GET /posts/999 — 404 | ![404](parte-2-analisis-http/capturas/02-api-404.png) |
| POST en Postman — 201 | ![201](parte-2-analisis-http/capturas/03-postman-201.png) |
| Tests de Postman en verde | ![Tests](parte-2-analisis-http/capturas/03-postman-tests.png) |
| Repositorio final en GitHub | ![Repo final](parte-2-analisis-http/capturas/04-repo-final.png) |

## Herramientas utilizadas
- VS Code, Git, GitHub
- Google Chrome + DevTools (paneles Elements, Console y Network)
- Postman (petición POST con tests)

## Conclusiones
Configurar el entorno con VS Code, Git y GitHub permite trabajar de forma
ordenada y dejar un historial de cambios que documenta el progreso con commits
atómicos y descriptivos. Chrome DevTools muestra que una página web es el
resultado de varias peticiones HTTP y permite inspeccionar y modificar en tiempo
real el DOM y los estilos. Al analizar el tráfico se observó que el
`Content-Type` determina cómo se usa una respuesta (HTML que se renderiza frente
a JSON que se procesa) y que el código de estado (200, 201, 404) es la forma
estándar de comunicar el resultado de una operación. Finalmente, Postman
facilita probar métodos distintos de GET y automatizar la verificación de
respuestas mediante tests, una práctica clave para desarrollar y consumir APIs.
