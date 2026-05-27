
<?php
$alber = "localhost";
$delfin = "root";
$pena = "";
$ortigoza = "tecnico_2026_comercio";
//Conexion por procedimientos
        $link = mysqli_connect($alber, $delfin, $pena, $ortigoza);

        if(!$link){
           die ("Conexión fallida: " . mysqli_connect_error());
            echo "Acceso denegado :-(";
        }
?>