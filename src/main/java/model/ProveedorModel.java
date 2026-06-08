package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import entidad.Proveedor;
import util.MySqlDBConexion;

public class ProveedorModel {

	public int  registraProveedor(Proveedor obj) {
		int salida = -1;
		Connection cn = null;
		PreparedStatement ps = null;
		try {
			//1 Crear la conexion a la BD
			cn = MySqlDBConexion.getConexion();
			
			//2 Crear el SQL de insercion
			String sql = "INSERT INTO proveedor (razonsocial, ruc, direccion, correo, gerente, fechaCreacion) VALUES (?,?,?,?,?,?)";
			
			//3 Crear el PreparedStatement
			ps = cn.prepareStatement(sql);
			ps.setString(1, obj.getRazonSocial());
			ps.setString(2, obj.getRuc());
			ps.setString(3, obj.getDireccion());
			ps.setString(4, obj.getCorreo());
			ps.setString(5, obj.getGerente());
			ps.setDate(6, java.sql.Date.valueOf(obj.getFechaCreacion()));
			
			System.out.println("SQL: " + ps);
			
			//4 Ejecutar el SQL	
			salida = ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (cn != null)
					cn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return salida;
	}
	
	public List<Proveedor> filtraProveedor(String razonSocial, String ruc, String direccion, 
			String correo, String gerente, LocalDate fechaCreacion) {

		List<Proveedor> lista = new ArrayList<Proveedor>();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = MySqlDBConexion.getConexion();

			String sql = "" +
					"SELECT idproveedor, razonsocial, ruc, direccion, correo, gerente, fechaCreacion FROM proveedor " + "WHERE " 
					+ "razonsocial LIKE ? AND " +
					"(? = '' OR ruc = ?) AND " +
					"(? = '' OR direccion = ?) AND " +
					"(? = '' OR correo = ?) AND " +
					"(? = '' OR gerente = ?) AND " +
					"(? = '9999-12-31' OR fechaCreacion <= ?)";

			ps = con.prepareStatement(sql);

			ps.setString(1, "%" + razonSocial + "%");
			ps.setString(2, ruc);
			ps.setString(3, ruc);
			ps.setString(4, direccion);
			ps.setString(5, direccion);
			ps.setString(6, correo);
			ps.setString(7, correo);
			ps.setString(8, gerente);
			ps.setString(9, gerente);
			ps.setDate(10, java.sql.Date.valueOf(fechaCreacion));
			ps.setDate(11, java.sql.Date.valueOf(fechaCreacion));
			

			System.out.println("SQL: " + ps);

			rs = ps.executeQuery();

			while (rs.next()) {
				Proveedor p = new Proveedor();
				p.setIdProveedor(rs.getInt("idproveedor"));
				p.setRazonSocial(rs.getString("razonsocial"));
				p.setRuc(rs.getString("ruc"));
				p.setDireccion(rs.getString("direccion"));
				p.setCorreo(rs.getString("correo"));
				p.setGerente(rs.getString("gerente"));
				p.setFechaCreacion(rs.getDate("fechaCreacion").toLocalDate());
				p.setFechaCreacionStr(rs.getDate("fechaCreacion").toString());

				lista.add(p);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) 
					rs.close();
				if (ps != null) 
					ps.close();
				if (con != null) 
					con.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return lista;
	}
}