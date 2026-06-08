package entidad;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Proveedor {

	private int idProveedor;
	private String razonSocial;
	private String ruc;
	private String direccion;
	private String correo;
	private String gerente;
	private LocalDate fechaCreacion;
	private String fechaCreacionStr;
}