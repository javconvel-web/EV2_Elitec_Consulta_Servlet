<head>
<meta charset="UTF-8">
<title>Registrar Proveedor</title>


<script src="js/bootstrap.js" type="text/javascript"></script>
<script src="js/bootstrap.bundle.js" type="text/javascript"></script>
<script src="js/bootstrap.esm.js" type="text/javascript"></script>
<script src="js/jquery-4.0.0.min.js" type="text/javascript"></script>

<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-grid.css" rel="stylesheet">
<link href="css/bootstrap-reboot.css" rel="stylesheet">
<link href="css/bootstrap-utilities.css" rel="stylesheet">


</head>
<body>
	<div class="container">
		<h1>Registro de Proveedor</h1>
		<form id="formProveedor" method="post" novalidate >
			<div class="row" style="margin-top: 2%;">
				<div class="col-4">
					<label for="razonsocial">Nombre</label>
					<input type="text" class="form-control" id="razonsocial" name="razonsocial" placeholder="Ingrese nombre" maxlength="30" required>
					<div class="invalid-feedback">Ingrese la razón social</div>
				</div>
				<div class="col-4">
					<label for="ruc">RUC</label>
					<input type="text" class="form-control" id="ruc" name="ruc" placeholder="Ingrese el RUC" maxlength="11" required>
					<div class="invalid-feedback">Ingrese el RUC</div>
				</div>
				<div class="col-4">
                    <label for="direccion">Dirección</label>
                    <input type="text" class="form-control" id="direccion" name="direccion" placeholder="Ingrese la dirección" maxlength="50" required>
                    <div class="invalid-feedback">Ingrese la dirección</div>
                 </div>
			</div>
			<div class="row" style="margin-top: 2%;">	
				<div class="col-4">
					<label for="correo">Correo</label>
					<input type="email" class="form-control" id="correo" name="correo" placeholder="Ingrese el correo" maxlength="50" required>
					<div class="invalid-feedback">Ingrese el correo</div>
				</div>
				<div class="col-4">
					<label for="gerente">Gerente</label>
					<input type="text" class="form-control" id="gerente" name="gerente" placeholder="Ingrese el gerente" maxlength="30" required>
					<div class="invalid-feedback">Ingrese el gerente</div>
				</div>
				<div class="col-4">
					<label for="fechaCreacion">Fecha de Creación</label>
					<input type="date" class="form-control" id="fechaCreacion" name="fechaCreacion" required>
					<div class="invalid-feedback">Ingrese la Fecha de Creación</div>
				</div>
			</div>
			<div class="row justify-content-center" style="margin-top: 2%">
				<button class="btn btn-primary" id="btnRegistrar"style="width: 200px">Registrar</button>
			</div>
		</form>
	</div>

<script type="text/javascript">
	$("#btnRegistrar").click(function(e) {
		console.log("click en registrar");		
		e.preventDefault(); //Evita que el formulario se envíe automáticamente

		
		let form = $('#formProveedor')[0];
        if (form.checkValidity() === false) {
            $(form).addClass('was-validated');
            return;
        }

     
        $.ajax({
			url: 'registraProveedorAlias',
			type: 'POST',
			data: $(form).serialize(),
			success: function (response) {
				
				console.log('response >>> '+ response);
				//limpiar el formulario
				$('#formProveedor')[0].reset();
				
				//limpiar las validaciones
				$('#formProveedor').removeClass('was-validated');
				
				//enviar un mensaje de éxito al usuario en forma de div que dure 3 segundos
				$('#formProveedor').prepend('<div class="alert alert-success" role="alert">'+ response.mensajeSalida +'</div>');
				setTimeout(function () {
					$('.alert').remove();
				}, 3000);
			},
			error: function (xhr, status, error) {
				// Manejar errores aquí
				console.error('Error al registrar :', error);
			}
		});
	});
</script>

</body>
</html>