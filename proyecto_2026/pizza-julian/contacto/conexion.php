<?php

//Conexion por procedimientos

        $link = mysqli_connect("localhost","root","","pagina_santamaria");

        if(!$link){
           die ("Conexión fallida: " . mysqli_connect_error());
            echo "Acceso denegado :-(";
        }
?>