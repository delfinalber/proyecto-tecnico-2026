<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PIZZA-JULIAN</title>
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
                    <a class="nav-link active" aria-current="page" href="./index.html">Inicio</a>
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