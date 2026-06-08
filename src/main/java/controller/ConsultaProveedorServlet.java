package controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import entidad.Proveedor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ProveedorModel;

@WebServlet("/consultaProveedorAlias")
public class ConsultaProveedorServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String razonSocial = req.getParameter("razonsocial");
		String ruc = req.getParameter("ruc");
		String direccion = req.getParameter("direccion");
		String correo = req.getParameter("correo");
		String gerente = req.getParameter("gerente");
		String fechaCreacion = req.getParameter("fechaCreacion");

		System.out.println("Datos: " + razonSocial + " - " + ruc + " - " + direccion + " - " + correo + " - " + gerente + " - " + fechaCreacion);

		LocalDate fechaCreacionLD = (fechaCreacion.isEmpty()) ? LocalDate.parse("9999-12-31") : LocalDate.parse(fechaCreacion);

		ProveedorModel model = new ProveedorModel();
		List<Proveedor> lista = model.filtraProveedor(razonSocial, ruc, direccion, correo, gerente, fechaCreacionLD);
		System.out.println("LISTA SIZE: " + lista.size());

		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String json = gson.toJson(lista);

		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		resp.getWriter().write(json);
	}
}