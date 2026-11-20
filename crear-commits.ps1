# crear-commits.ps1
# Copia el contenido del laboratorio a tu repositorio clonado y crea los
# commits en el orden de los pasos 5 a 10.
# Uso: powershell -ExecutionPolicy Bypass -File .\crear-commits.ps1 -Repo "C:\ruta\a\tuapellido-post1-u1"

param(
  [Parameter(Mandatory = $true)][string]$Repo
)

$ErrorActionPreference = "Stop"
$Src = Join-Path $PSScriptRoot "apellido-post1-u1"

if (-not (Test-Path (Join-Path $Repo ".git"))) {
  Write-Error "La carpeta '$Repo' no es un repositorio Git. Clona primero tu repositorio de GitHub."
}

function Copiar($rel) {
  $from = Join-Path $Src $rel
  $to = Join-Path $Repo $rel
  New-Item -ItemType Directory -Force -Path (Split-Path $to) | Out-Null
  Copy-Item -Path $from -Destination $to -Force
}

function Commit($msg, [string[]]$paths) {
  & git -C $Repo add -- $paths
  if ($LASTEXITCODE -ne 0) { throw "git add fallo" }
  & git -C $Repo commit -m $msg
  if ($LASTEXITCODE -ne 0) { throw "git commit fallo: $msg" }
}

# --- Commit 1: estructura base de la Parte 1 (CSS sin el efecto hover) ---
Copiar "parte-1-entorno/index.html"
Copiar "parte-1-entorno/js/main.js"
Copiar "parte-1-entorno/capturas/.gitkeep"
$cssFinal = [IO.File]::ReadAllText((Join-Path $Src "parte-1-entorno/css/styles.css"))
$lineas = $cssFinal -split "`n"
$cssBase = ($lineas[0..46] -join "`n") + "`n"
$cssPath = Join-Path $Repo "parte-1-entorno/css/styles.css"
New-Item -ItemType Directory -Force -Path (Split-Path $cssPath) | Out-Null
[IO.File]::WriteAllText($cssPath, $cssBase, (New-Object Text.UTF8Encoding($false)))
Commit "feat: agregar estructura HTML base, estilos y script inicial (parte 1)" @("parte-1-entorno")

# --- Commit 2: efecto hover ---
Copiar "parte-1-entorno/css/styles.css"
Commit "style: agregar efecto hover en secciones con transicion CSS (parte 1)" @("parte-1-entorno/css/styles.css")

# --- Commit 3: estructura de la Parte 2 ---
Copiar "parte-2-analisis-http/capturas/.gitkeep"
New-Item -ItemType Directory -Force -Path (Join-Path $Repo "parte-2-analisis-http/analisis") | Out-Null
Commit "feat: crear estructura base de la parte 2 (analisis HTTP)" @("parte-2-analisis-http")

# --- Commit 4: analisis 1 ---
Copiar "parte-2-analisis-http/analisis/01-pagina-html.md"
Commit "analysis: agregar analisis de peticion GET a example.com con DevTools" @("parte-2-analisis-http/analisis/01-pagina-html.md")

# --- Commit 5: analisis 2 ---
Copiar "parte-2-analisis-http/analisis/02-api-rest-get.md"
Commit "analysis: agregar analisis GET API REST con comparacion 200 vs 404" @("parte-2-analisis-http/analisis/02-api-rest-get.md")

# --- Commit 6: analisis 3 + coleccion de Postman ---
Copiar "parte-2-analisis-http/analisis/03-postman-post.md"
Copiar "parte-2-analisis-http/postman/laboratorio-http.postman_collection.json"
Commit "analysis: agregar analisis POST con Postman y tests automatizados" @("parte-2-analisis-http/analisis/03-postman-post.md", "parte-2-analisis-http/postman")

# --- Commit 7: README final ---
Copiar "README.md"
Commit "docs: completar README con resumen de ambas partes y conclusiones" @("README.md")

Write-Host ""
Write-Host "Listo. Historial:" -ForegroundColor Green
& git -C $Repo log --oneline
Write-Host ""
Write-Host "Siguiente paso: agrega tus capturas y ejecuta 'git push origin main'." -ForegroundColor Yellow
