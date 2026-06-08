package controller;

import java.io.IOException;

import entidad.Proveedor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ProveedorModel;

@WebServlet("/registraProveedorAlias")
public class RegistraProveedorServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//1 Recibir los datos del formulario del JSP
		String razonsocial = req.getParameter("razonsocial");
		String ruc = req.getParameter("ruc");
		String direccion = req.getParameter("direccion");
		String correo = req.getParameter("correo");
		String gerente = req.getParameter("gerente");
		String fechaCreacion = req.getParameter("fechaCreacion");
		
		System.out.println("Datos recibidos: " + razonsocial + " - " + ruc + " - " + direccion + " - " + correo + " - " + gerente + " - " + fechaCreacion);

		
		//2 Crear un objeto Proveedor
		Proveedor proveedor = new Proveedor();
		proveedor.setRazonSocial(razonsocial);
		proveedor.setRuc(ruc);
		proveedor.setDireccion(direccion);
		proveedor.setCorreo(correo);
		proveedor.setGerente(gerente);
		proveedor.setFechaCreacion(java.time.LocalDate.parse(fechaCreacion));
		
		
		//3 Crear un objeto ProveedorModel
		ProveedorModel model = new ProveedorModel();
		int salida = model.registraProveedor(proveedor);
		
		String mensajeSalida;

		if (salida > 0) {
		    mensajeSalida = "Proveedor registrado correctamente (OK)";
		} else {
		    mensajeSalida = "Error al registrar - revisar consola";
		}

		
		// 4 Enviar una respuesta al cliente en JSON al jquery
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		resp.getWriter().write("{\"mensajeSalida\":\"" + mensajeSalida + "\"}");
		
	}

}