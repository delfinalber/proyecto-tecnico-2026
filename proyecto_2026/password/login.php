<?php

include('conexion.php');

$usuario      = $_POST['usuario'];
$contrasena   = $_POST['contrasena'];
//$sesion_login = true;

ini_set('display_errors', 'off');
ini_set('display_startup_errors', 'off');
error_reporting(0);

$url= "https://www.lanacion.com.co/";
//$url = "http://127.0.0.1/password/carlos/index.html";


//$consulta = mysqli_query ($link, "SELECT * FROM users WHERE ususario = '$usuario' AND contrasena = '$contrasena'");

$query = "SELECT * FROM users WHERE usuario ='$usuario' AND contrasena = '$contrasena'";
$q = mysqli_query($link, $query);
try{

	if(mysqli_result($q, 0))
	{$result = mysqli_result($q, 0);

		//header("Location: https://www.lanacion.com.co/", true, 301);
		//exit();
		
		//echo '<script type="text/javascript">
          //window.location = "http://www.google.com/"
      //</scrit>';

		//echo "<script>location.href= '$url'</script>";

		//echo "<script> window.location.href = $url; </script>";
		  //echo "Usuario Valido Correctamente";
	}else
		echo "Usuario o Contraseña Erroneos";
	}catch(Exception $error) {}

	mysqli_close($link);
?>