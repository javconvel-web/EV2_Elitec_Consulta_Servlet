<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="js/bootstrap.js" type="text/javascript"></script>
<script src="js/bootstrap.bundle.js" type="text/javascript"></script>
<script src="js/bootstrap.esm.js" type="text/javascript"></script>
<script src="js/jquery-4.0.0.min.js" type="text/javascript"></script>
<script src="js/datatables.js" type="text/javascript"></script>

<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-grid.css" rel="stylesheet">
<link href="css/bootstrap-reboot.css" rel="stylesheet">
<link href="css/bootstrap-utilities.css" rel="stylesheet">
<link href="css/datatables.css" rel="stylesheet">

</head>
<body>

<div class="container">
    <h1>Consulta de Proveedor</h1>
    <div class="row" style="margin-top: 4%;">
    	<div class="col-4">
    		<label for="nombre">Nombre</label> 
			<input type="text" class="form-control" id="nombre" name="nombre" placeholder="Ingrese el nombre" maxlength="30" >
    	</div>	
    	<div class="col-4">
    		<label for="dni">ruc</label> 
			<input type="text" class="form-control" id="ruc" name="ruc" placeholder="Ingrese el ruc" maxlength="11" >
    	</div>
    	<div class="col-4">
    		<label for="direccion">Dirección</label> 
			<input type="text" class="form-control" id="direccion" name="direccion" placeholder="Ingrese la dirección" >
    	</div>	
    </div>
    <div class="row" style="margin-top: 4%;">
    	<div class="col-4">
    		<label for="email">Correo Electrónico</label> 
			<input type="email" class="form-control" id="correo" name="correo" placeholder="Ingrese el correo" >
    	</div>
    	<div class="col-4">
    		<label for="gerente">Gerente</label>
    		<input type="text" class="form-control" id="gerente" name="gerente" placeholder="Ingrese el gerente" maxlength="30" >
    		</div>
    	<div class="col-4">
    		<label for="fechaCreacion">Fecha de creación</label> 
			<input type="date" class="form-control" id="fechaCreacion" name="fechaCreacion">
    	</div>
    </div>
    <div class="row justify-content-center" style="margin-top: 2%">
		<button class="btn btn-primary" id="btnFiltrar"style="width: 200px">Filtrar</button>
	</div>
	<div class="row" style="margin-top: 4%;">
		<div class="col-12">
			<table class="table table-striped" id="id_table">
				<thead>
					<tr>
						<th>Código</th>
						<th>Nombre</th>
						<th>RUC</th>
						<th>Dirección</th>
						<th>Correo</th>
						<th>Gerente</th>
						<th>Fecha de Creación</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>    
</div>

<script type="text/javascript">
	$('#id_table').DataTable();

	$("#btnFiltrar").click(function (e) {
		console.log("click en filtrar");
		e.preventDefault();

		let razonSocial = $('#nombre').val();
		let ruc = $('#ruc').val();
		let direccion = $('#direccion').val();
		let correo = $('#correo').val();
		let gerente = $('#gerente').val();
		let fechaCreacion = $('#fechaCreacion').val();

		console.log("razonSocial: " + razonSocial);
		console.log("ruc: " + ruc);
		console.log("direccion: " + direccion);
		console.log("correo: " + correo);
		console.log("gerente: " + gerente);
		console.log("fechaCreacion: " + fechaCreacion);

		// enviar al controlador
		$.ajax({
			url: 'consultaProveedorAlias',
			type: 'GET',
			data: {
				razonsocial: razonSocial,
				ruc: ruc,
				direccion: direccion,
				correo: correo,
				gerente: gerente,
				fechaCreacion: fechaCreacion
			},
			success: function (response) {
				console.log(response);
				agregarGrilla(response);
			}
		});
	});

	function agregarGrilla(lista){
		$('#id_table').DataTable().clear();
		$('#id_table').DataTable().destroy();

		$('#id_table').DataTable({
			data: lista,
			language: IDIOMA,
			searching: true,
			ordering: true,
			processing: true,
			pageLength: 10,
			lengthChange: false,
			info: true,
			scrollY: 305,
			scroller: {
				loadingIndicator: true
			},
			columns:[
				{data: "idProveedor", className:'text-center'},
				{data: "razonSocial", className:'text-center'},
				{data: "ruc", className:'text-center'},
				{data: "direccion", className:'text-center'},
				{data: "correo", className:'text-center'},
				{data: "gerente", className:'text-center'},
				{data: "fechaCreacionStr", className:'text-center'}
			]
		});
	}

	var IDIOMA = {
		processing: "procesando...",
		lengthMenu: "MENU Registros por página",
		zeroRecords: "No existen registros",
		info: "Página PAGE de PAGES",
		infoEmpty: "Sin registros",
		infoFiltered: "(Filtro de MAX registros)",
		search: "Buscar:",
		paginate: {
			first: "Primero",
			last: "Last",
			next: "Siguiente",
			previous: "Anterior"
		}
	};
</script>

</body>
</html>