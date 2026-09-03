<?php
declare(strict_types=1);

$mysqli = new mysqli("localhost", "root", "", "tecnico-2026-pagina");
if ($mysqli->connect_error) {
    die("Error de conexión: " . $mysqli->connect_error);
}

// Convierte enlaces de YouTube (watch, youtu.be, shorts) al formato /embed/ requerido por el iframe
function normalizarUrlYoutubeEmbed(string $url): string
{
    $url = trim($url);
    if ($url === "") {
        return $url;
    }
    if (preg_match('~(?:youtu\.be/|youtube\.com/(?:embed/|watch\?v=|shorts/))([A-Za-z0-9_-]{6,})~i', $url, $coincidencia)) {
        return "https://www.youtube.com/embed/" . $coincidencia[1];
    }
    return $url;
}

// Columnas de la tabla `inicio` que alimentan las variables de index.php
$columnasInicio = [
    "banner_inicio", "carru-1", "carru-2", "carru-3", "url_video_inicio",
    "acor1_titulo_inicio", "acor1_texto_inicio",
    "acor2_titulo_inicio", "acor2_texto_inicio",
    "acor3_titulo_inicio", "acor3_texto_inicio",
    "acor4_titulo_inicio", "acor4_texto_inicio",
    "acor5_titulo_inicio", "acor5_texto_inicio",
    "colapsar1_titulo_inicio", "colapsar1_texto_inicio",
    "colapsar2_titulo_inicio", "colapsar2_texto_inicio",
    "colapsar3_titulo_inicio", "colapsar3_texto_inicio",
    "numero_whatsapp",
];

// Tras procesar el POST se redirige (patrón PRG) a index-formulario.php sin caché ni reenvío del formulario
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $accion = $_POST["accion"] ?? "";
    $estado = "error";

    if ($accion === "eliminar") {
        $id = (int) ($_POST["id_inicio"] ?? 0);
        if ($id > 0) {
            $stmt = $mysqli->prepare("DELETE FROM `inicio` WHERE id_inicio = ?");
            $stmt->bind_param("i", $id);
            $estado = $stmt->execute() ? "eliminado" : "error";
            $stmt->close();
        }
    } elseif ($accion === "crear" || $accion === "editar") {
        $camposImagen = ["banner_inicio", "carru-1", "carru-2", "carru-3"];
        $extensionesPermitidas = ["jpg", "jpeg", "png", "gif", "webp"];
        $directorioImagenes = __DIR__ . "/img-inicio";
        $valoresImagen = [];

        foreach ($camposImagen as $campo) {
            $archivo = $_FILES[$campo] ?? null;
            if ($archivo && $archivo["error"] === UPLOAD_ERR_OK && $archivo["size"] > 0) {
                $extension = strtolower(pathinfo($archivo["name"], PATHINFO_EXTENSION));
                if (in_array($extension, $extensionesPermitidas, true)) {
                    $nombreArchivo = uniqid("inicio_", true) . "." . $extension;
                    if (move_uploaded_file($archivo["tmp_name"], "$directorioImagenes/$nombreArchivo")) {
                        $valoresImagen[$campo] = "./img-inicio/$nombreArchivo";
                    }
                }
            }
            if (!isset($valoresImagen[$campo])) {
                // conservar la imagen actual si no se seleccionó un archivo nuevo
                $valoresImagen[$campo] = trim((string) ($_POST["{$campo}_actual"] ?? ""));
            }
        }

        $valores = [];
        foreach ($columnasInicio as $columna) {
            if (in_array($columna, $camposImagen, true)) {
                $valores[] = $valoresImagen[$columna];
            } elseif ($columna === "url_video_inicio") {
                $valores[] = normalizarUrlYoutubeEmbed(trim((string) ($_POST[$columna] ?? "")));
            } else {
                $valores[] = trim((string) ($_POST[$columna] ?? ""));
            }
        }

        if ($accion === "crear") {
            $columnasSql = implode(", ", array_map(fn($c) => "`$c`", $columnasInicio));
            $marcadores = implode(", ", array_fill(0, count($columnasInicio), "?"));
            $stmt = $mysqli->prepare("INSERT INTO `inicio` ($columnasSql) VALUES ($marcadores)");
            $tipos = str_repeat("s", count($valores));
            $stmt->bind_param($tipos, ...$valores);
            $estado = $stmt->execute() ? "creado" : "error";
            $stmt->close();
        } else {
            $id = (int) ($_POST["id_inicio"] ?? 0);
            $setClause = implode(", ", array_map(fn($c) => "`$c` = ?", $columnasInicio));
            $stmt = $mysqli->prepare("UPDATE `inicio` SET $setClause WHERE id_inicio = ?");
            $tipos = str_repeat("s", count($valores)) . "i";
            $valores[] = $id;
            $stmt->bind_param($tipos, ...$valores);
            $estado = $stmt->execute() ? "actualizado" : "error";
            $stmt->close();
        }
    }

    $mysqli->close();
    header("Cache-Control: no-store, no-cache, must-revalidate");
    header("Pragma: no-cache");
    header("Location: index-formulario.php?estado=" . urlencode($estado), true, 303);
    exit;
}

$mensajesPorEstado = [
    "creado" => ["Contenido creado correctamente.", "success"],
    "actualizado" => ["Contenido actualizado correctamente.", "success"],
    "eliminado" => ["Contenido eliminado correctamente.", "success"],
    "error" => ["No fue posible completar la operación.", "danger"],
];
$estadoActual = $_GET["estado"] ?? "";
[$mensaje, $tipoMensaje] = $mensajesPorEstado[$estadoActual] ?? ["", "success"];

header("Cache-Control: no-store, no-cache, must-revalidate");
header("Pragma: no-cache");

$filasInicio = [];
$resultado = $mysqli->query("SELECT * FROM `inicio` ORDER BY id_inicio ASC");
if ($resultado) {
    $filasInicio = $resultado->fetch_all(MYSQLI_ASSOC);
}

$acordeones = [1, 2, 3, 4, 5];
$colapsables = [1, 2, 3];

function campoInicio(array $fila, string $campo): string
{
    return htmlspecialchars((string) ($fila[$campo] ?? ""), ENT_QUOTES);
}

// Genera el modal (crear o editar) reutilizando el mismo formulario
function renderModalInicio(string $idModal, string $tituloModal, string $accion, array $fila, array $acordeones, array $colapsables): void
{
    $idInicio = (int) ($fila["id_inicio"] ?? 0);
    ?>
    <div class="modal fade editor-modal" id="<?= htmlspecialchars($idModal, ENT_QUOTES) ?>" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-lg modal-dialog-scrollable">
        <div class="modal-content">
          <form method="post" enctype="multipart/form-data">
            <input type="hidden" name="accion" value="<?= htmlspecialchars($accion, ENT_QUOTES) ?>">
            <?php if ($accion === "editar"): ?>
                <input type="hidden" name="id_inicio" value="<?= $idInicio ?>">
            <?php endif; ?>
            <div class="modal-header">
              <h5 class="modal-title"><?= htmlspecialchars($tituloModal) ?></h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <fieldset>
                <legend>Banner y multimedia</legend>
                <div class="mb-3">
                  <label class="form-label">Imagen del banner</label>
                  <?php if (campoInicio($fila, "banner_inicio") !== ""): ?>
                    <div class="mb-2"><img src="<?= campoInicio($fila, "banner_inicio") ?>" alt="Banner actual" class="img-thumbnail" style="max-height:90px;"></div>
                  <?php endif; ?>
                  <input type="file" class="form-control" name="banner_inicio" accept="image/*">
                  <input type="hidden" name="banner_inicio_actual" value="<?= campoInicio($fila, "banner_inicio") ?>">
                </div>
                <div class="row">
                  <div class="col-md-4 mb-3">
                    <label class="form-label">Carrusel imagen 1</label>
                    <?php if (campoInicio($fila, "carru-1") !== ""): ?>
                      <div class="mb-2"><img src="<?= campoInicio($fila, "carru-1") ?>" alt="Carrusel 1 actual" class="img-thumbnail" style="max-height:70px;"></div>
                    <?php endif; ?>
                    <input type="file" class="form-control" name="carru-1" accept="image/*">
                    <input type="hidden" name="carru-1_actual" value="<?= campoInicio($fila, "carru-1") ?>">
                  </div>
                  <div class="col-md-4 mb-3">
                    <label class="form-label">Carrusel imagen 2</label>
                    <?php if (campoInicio($fila, "carru-2") !== ""): ?>
                      <div class="mb-2"><img src="<?= campoInicio($fila, "carru-2") ?>" alt="Carrusel 2 actual" class="img-thumbnail" style="max-height:70px;"></div>
                    <?php endif; ?>
                    <input type="file" class="form-control" name="carru-2" accept="image/*">
                    <input type="hidden" name="carru-2_actual" value="<?= campoInicio($fila, "carru-2") ?>">
                  </div>
                  <div class="col-md-4 mb-3">
                    <label class="form-label">Carrusel imagen 3</label>
                    <?php if (campoInicio($fila, "carru-3") !== ""): ?>
                      <div class="mb-2"><img src="<?= campoInicio($fila, "carru-3") ?>" alt="Carrusel 3 actual" class="img-thumbnail" style="max-height:70px;"></div>
                    <?php endif; ?>
                    <input type="file" class="form-control" name="carru-3" accept="image/*">
                    <input type="hidden" name="carru-3_actual" value="<?= campoInicio($fila, "carru-3") ?>">
                  </div>
                </div>
                <div class="mb-3">
                  <label class="form-label">URL video de YouTube (embed)</label>
                  <input type="text" class="form-control" name="url_video_inicio" value="<?= campoInicio($fila, "url_video_inicio") ?>">
                </div>
              </fieldset>

              <fieldset>
                <legend>Acordeón</legend>
                <?php foreach ($acordeones as $numero): ?>
                    <div class="row">
                      <div class="col-md-4 mb-3">
                        <label class="form-label">Título <?= $numero ?></label>
                        <input type="text" class="form-control" name="acor<?= $numero ?>_titulo_inicio" value="<?= campoInicio($fila, "acor{$numero}_titulo_inicio") ?>">
                      </div>
                      <div class="col-md-8 mb-3">
                        <label class="form-label">Texto <?= $numero ?></label>
                        <textarea class="form-control" name="acor<?= $numero ?>_texto_inicio" rows="2"><?= campoInicio($fila, "acor{$numero}_texto_inicio") ?></textarea>
                      </div>
                    </div>
                <?php endforeach; ?>
              </fieldset>

              <fieldset>
                <legend>Secciones colapsables</legend>
                <?php foreach ($colapsables as $numero): ?>
                    <div class="row">
                      <div class="col-md-4 mb-3">
                        <label class="form-label">Título <?= $numero ?></label>
                        <input type="text" class="form-control" name="colapsar<?= $numero ?>_titulo_inicio" value="<?= campoInicio($fila, "colapsar{$numero}_titulo_inicio") ?>">
                      </div>
                      <div class="col-md-8 mb-3">
                        <label class="form-label">Texto <?= $numero ?></label>
                        <textarea class="form-control" name="colapsar<?= $numero ?>_texto_inicio" rows="2"><?= campoInicio($fila, "colapsar{$numero}_texto_inicio") ?></textarea>
                      </div>
                    </div>
                <?php endforeach; ?>
              </fieldset>

              <fieldset>
                <legend>Contacto</legend>
                <div class="mb-3">
                  <label class="form-label">Número de WhatsApp</label>
                  <input type="text" class="form-control" name="numero_whatsapp" value="<?= campoInicio($fila, "numero_whatsapp") ?>" placeholder="573132345685">
                </div>
              </fieldset>
            </div>
            <div class="modal-footer">
              <a href="index-formulario.php" class="btn btn-secondary">Cancelar</a>
              <button type="submit" class="btn btn-editar">Guardar</button>
            </div>
          </form>
        </div>
      </div>
    </div>
    <?php
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PIZZA-JULIAN | Editor de Contenido</title>
    <link rel="stylesheet" href="../bootstrap-5.3.8-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="./inicio.css">
</head>
<body>
    <!-- Banner Section -->
    <div class="container-fluid p-0 text-center">
        <div class="row g-0">
            <div class="banner col-12 p-0">
               <img src="./img-inicio/banner.png" class="img-fluid" alt="...">
            </div>
        </div>
    </div>
    <!-- Fin Banner Section -->
    <!-- Sección Nav -->
     <br>

    <nav class="navbar navbar-expand-lg nav-pizzeria">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Pizzeria Julian</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="./index.php">Inicio</a>
                    </li>
                    <li class="nav-item">
                    <a class="nav-link" href="../productos/productos.html">Productos</a>
                    </li>
                    <li class="nav-item">
                    <a class="nav-link" href="../contacto/contactos.html">
                        Contacto
                    </a>
                    </li>
                </ul>
                <form class="d-flex" role="search">
                  <button class="btn btn-outline-success" type="button" data-bs-toggle="modal" data-bs-target="#loginModal">Inicio Sesion</button>
                </form>
                </div>
            </div>
    </nav>
    <!-- Fin Sección Nav -->

    <br>

    <!-- Editor de Contenido de la tabla `inicio` -->
    <div class="container editor-panel my-4">
        <h2 class="mb-3"><i class="bi bi-pencil-square"></i> Editor de Contenido - Inicio</h2>
        <p class="mb-4" style="color: var(--pizza-gris);">Administra la información que se muestra en <strong>index.php</strong>: banner, carrusel, video, acordeón, secciones colapsables y contacto.</p>

        <?php if ($mensaje !== ""): ?>
            <div class="alert alert-<?= $tipoMensaje ?> editor-alert" role="alert"><?= htmlspecialchars($mensaje) ?></div>
        <?php endif; ?>

        <?php if (empty($filasInicio)): ?>
            <button type="button" class="btn btn-editar mb-3" data-bs-toggle="modal" data-bs-target="#modalCrear">
                <i class="bi bi-plus-circle"></i> Crear contenido inicial
            </button>
            <?php renderModalInicio("modalCrear", "Crear contenido inicial", "crear", [], $acordeones, $colapsables); ?>
        <?php else: ?>
            <div class="row g-3">
                <?php foreach ($filasInicio as $fila): ?>
                    <?php $idFila = (int) $fila["id_inicio"]; ?>
                    <div class="col-12">
                        <div class="card editor-card p-3">
                            <div class="row g-3 align-items-center">
                                <div class="col-md-2 text-center">
                                    <?php if (trim((string) $fila["banner_inicio"]) !== ""): ?>
                                        <img src="<?= htmlspecialchars($fila["banner_inicio"], ENT_QUOTES) ?>" class="img-fluid rounded" alt="Banner">
                                    <?php else: ?>
                                        <span class="text-muted">Sin imagen</span>
                                    <?php endif; ?>
                                </div>
                                <div class="col-md-7">
                                    <h5 class="card-title mb-1">Registro #<?= $idFila ?></h5>
                                    <p class="mb-0 small">Video: <?= htmlspecialchars((string) $fila["url_video_inicio"]) !== "" ? htmlspecialchars((string) $fila["url_video_inicio"]) : "-" ?></p>
                                    <p class="mb-0 small">WhatsApp: <?= htmlspecialchars((string) $fila["numero_whatsapp"]) ?></p>
                                </div>
                                <div class="col-md-3 text-md-end d-flex flex-column flex-md-row gap-2 justify-content-md-end">
                                    <button type="button" class="btn btn-editar" data-bs-toggle="modal" data-bs-target="#modalEditar<?= $idFila ?>">
                                        <i class="bi bi-pencil-square"></i> Editar
                                    </button>
                                    <form method="post" onsubmit="return confirm('¿Eliminar este contenido?');" class="d-inline">
                                        <input type="hidden" name="accion" value="eliminar">
                                        <input type="hidden" name="id_inicio" value="<?= $idFila ?>">
                                        <button type="submit" class="btn btn-eliminar"><i class="bi bi-trash"></i> Eliminar</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <?php renderModalInicio("modalEditar{$idFila}", "Editar contenido #{$idFila}", "editar", $fila, $acordeones, $colapsables); ?>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </div>
    <!-- Fin Editor de Contenido -->

<br>
<!-- Inicio Modal de Sesion -->
<div class="modal fade login-modal" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="loginModalLabel">Inicio de sesion</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form>
          <div class="mb-3">
            <label for="usuarioLogin" class="form-label">Usuario</label>
            <input type="text" class="form-control" id="usuarioLogin" placeholder="Digite su usuario" required>
          </div>
          <div class="mb-3">
            <label for="contrasenaLogin" class="form-label">Contrasena</label>
            <input type="password" class="form-control" id="contrasenaLogin" placeholder="Digite su contrasena" required>
          </div>
          <button type="submit" class="btn btn-login w-100">Entrar</button>
        </form>
      </div>
    </div>
  </div>
</div>
<!-- Fin Modal de Sesion -->

<!-- Inicio Footer -->
<footer class="footer-pizzeria">
  <div class="container">
    <div class="footer-box text-center">
      <div class="footer-social">
        <a href="#" aria-label="Facebook"><i class="bi bi-facebook"></i></a>
        <a href="#" aria-label="Instagram"><i class="bi bi-instagram"></i></a>
        <a href="#" aria-label="Twitter"><i class="bi bi-twitter-x"></i></a>
        <a href="#" aria-label="Whatsapp"><i class="bi bi-whatsapp"></i></a>
        <a href="#" aria-label="Youtube"><i class="bi bi-youtube"></i></a>
      </div>

      <nav class="footer-menu">
        <a href="./index.html">Inicio</a>
        <a href="../productos/productos.html">Productos</a>
        <a href="../contacto/contactos.html">Contactos</a> 
        
        <a href="#">Nuestro equipo</a>
      </nav>

      <p class="footer-copy">Copyright 2026. Designed by JULIAN</p>
    </div>
  </div>
</footer>

 <!-- Fin footer   -->



  <script src="../bootstrap-5.3.8-dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>