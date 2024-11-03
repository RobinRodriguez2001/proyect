package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.swing.table.DefaultTableModel;

public class Compras {
    private int idCompra;
    private int no_orden_compra;
    private int idproveedor;
    private String fecha_orden;
    private long idcompra_detalle;
    private int idproducto;
    private int cantidad;
    private double precio_costo_unitario;
    private conexion conexionDB;

    // Constructor por defecto
    public Compras() {}

    // Constructor para agregar una nueva compra
    public Compras(int no_orden_compra, int idproveedor, String fecha_orden, int idproducto, int cantidad, double precio_costo_unitario) {
        this.no_orden_compra = no_orden_compra;
        this.idproveedor = idproveedor;
        this.fecha_orden = fecha_orden;
        this.idproducto = idproducto;
        this.cantidad = cantidad;
        this.precio_costo_unitario = precio_costo_unitario;
    }

    // Constructor para modificar una compra
    public Compras(int idCompra, int no_orden_compra, int idproveedor, String fecha_orden, long idcompra_detalle, int idproducto, int cantidad, double precio_costo_unitario) {
        this.idCompra = idCompra;
        this.no_orden_compra = no_orden_compra;
        this.idproveedor = idproveedor;
        this.fecha_orden = fecha_orden;
        this.idcompra_detalle = idcompra_detalle;
        this.idproducto = idproducto;
        this.cantidad = cantidad;
        this.precio_costo_unitario = precio_costo_unitario;
    }

    // Constructor para eliminar una compra
    public Compras(int idCompra) {
        this.idCompra = idCompra;
    }

    // Getters y Setters
    public int getIdCompra() {
        return idCompra;
    }

    public void setIdCompra(int idCompra) {
        this.idCompra = idCompra;
    }

    public int getNo_orden_compra() {
        return no_orden_compra;
    }

    public void setNo_orden_compra(int no_orden_compra) {
        this.no_orden_compra = no_orden_compra;
    }

    public int getIdproveedor() {
        return idproveedor;
    }

    public void setIdproveedor(int idproveedor) {
        this.idproveedor = idproveedor;
    }

    public String getFecha_orden() {
        return fecha_orden;
    }

    public void setFecha_orden(String fecha_orden) {
        this.fecha_orden = fecha_orden;
    }

    public long getIdcompra_detalle() {
        return idcompra_detalle;
    }

    public void setIdcompra_detalle(long idcompra_detalle) {
        this.idcompra_detalle = idcompra_detalle;
    }

    public int getIdproducto() {
        return idproducto;
    }

    public void setIdproducto(int idproducto) {
        this.idproducto = idproducto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getPrecio_costo_unitario() {
        return precio_costo_unitario;
    }

    public void setPrecio_costo_unitario(double precio_costo_unitario) {
        this.precio_costo_unitario = precio_costo_unitario;
    }

    public conexion getConexionDB() {
        return conexionDB;
    }

    public void setConexionDB(conexion conexionDB) {
        this.conexionDB = conexionDB;
    }

// Método para agregar compras
public int agregarCompra() {
    int retorno = 0;
    PreparedStatement parametro = null;
    PreparedStatement parametroActualizarCantidad = null;
    
    try {
        conexionDB = new conexion();
        conexionDB.abrir_conexion();

        // Insertar la compra en la tabla compras
        String query = "INSERT INTO compras (no_orden_compra, idproveedor, fecha_orden) VALUES (?, ?, ?);";
        parametro = conexionDB.conectar_db.prepareStatement(query);
        parametro.setInt(1, getNo_orden_compra());
        parametro.setInt(2, getIdproveedor());
        parametro.setString(3, getFecha_orden());
        retorno = parametro.executeUpdate();

        if (retorno > 0) {
            // Obtiene el último ID de compra insertado
            String lastInsertQuery = "SELECT LAST_INSERT_ID();";
            parametro = conexionDB.conectar_db.prepareStatement(lastInsertQuery);
            ResultSet rs = parametro.executeQuery();
            if (rs.next()) {
                int idCompraInsertada = rs.getInt(1);

                // Insertar los detalles de compra en la tabla compras_detalle
                query = "INSERT INTO compras_detalle (idcompra, idproducto, cantidad, precio_costo_unitario) VALUES (?, ?, ?, ?);";
                parametro = conexionDB.conectar_db.prepareStatement(query);
                parametro.setInt(1, idCompraInsertada);
                parametro.setInt(2, getIdproducto());
                parametro.setInt(3, getCantidad());
                parametro.setDouble(4, getPrecio_costo_unitario());
                retorno += parametro.executeUpdate();

                // Actualizar la existencia del producto sumando la cantidad comprada
                String queryActualizarCantidad = "UPDATE productos SET existencia = existencia + ? WHERE idProducto = ?;";
                parametroActualizarCantidad = conexionDB.conectar_db.prepareStatement(queryActualizarCantidad);
                parametroActualizarCantidad.setInt(1, getCantidad());
                parametroActualizarCantidad.setInt(2, getIdproducto());
                parametroActualizarCantidad.executeUpdate();
            }
        }
    } catch (SQLException ex) {
        System.err.println("Error al agregar compra: " + ex.getMessage());
    } finally {
        // Cerrar los recursos
        closeResources(parametro);
        closeResources(parametroActualizarCantidad);
    }
    
    return retorno;
}

// Método para cerrar recursos
private void closeResources(AutoCloseable resource) {
    try {
        if (resource != null) {
            resource.close();
        }
    } catch (Exception ex) {
        System.err.println("Error al cerrar recurso: " + ex.getMessage());
    }
}

    // Método para modificar compras
    public int modificarCompra() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "UPDATE compras SET no_orden_compra = ?, idproveedor = ? WHERE idCompra = ?;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setInt(1, getNo_orden_compra());
            parametro.setInt(2, getIdproveedor());
            parametro.setInt(3, getIdCompra());
            retorno = parametro.executeUpdate();

            query = "UPDATE compras_detalle SET idproducto = ?, cantidad = ?, precio_costo_unitario = ? WHERE idcompra_detalle = ?;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setInt(1, getIdproducto());
            parametro.setInt(2, getCantidad());
            parametro.setDouble(3, getPrecio_costo_unitario());
            parametro.setLong(4, getIdcompra_detalle());
            retorno += parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al modificar compra: " + ex.getMessage());
        } finally {
            closeResources(parametro);
        }
        return retorno;
    }

    // Método para eliminar compras
    public int eliminarCompra() {
        int retorno = 0;
        PreparedStatement parametro = null;
        PreparedStatement parametroDetalle = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();
            String querydetalle = "DELETE FROM compras_detalle WHERE idcompra = ?;";
            parametroDetalle = conexionDB.conectar_db.prepareStatement(querydetalle);
            parametroDetalle.setInt(1, getIdCompra());
            retorno = parametroDetalle.executeUpdate();
            
            String query = "DELETE FROM compras WHERE idCompra = ?;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setInt(1, getIdCompra());
            retorno = parametro.executeUpdate();

           
        } catch (SQLException ex) {
            System.err.println("Error al eliminar compra: " + ex.getMessage());
        } finally {
            closeResources(parametro);
        }
        return retorno;
    }

    // Método para leer compras
    public DefaultTableModel leerCompras() {
        DefaultTableModel tabla = new DefaultTableModel();
        PreparedStatement parametro = null;
        ResultSet consulta = null;

        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "SELECT cm.idCompra, cm.no_orden_compra, cm.idproveedor, cm.fecha_orden, cm.fechaingreso, cd.idCompra_detalle, cd.idproducto, cd.cantidad, cd.precio_costo_unitario  " +
                           "FROM compras cm " +
                           "INNER JOIN compras_detalle cd ON cm.idcompra = cd.idcompra " +
                           "ORDER BY cm.idCompra DESC;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            consulta = parametro.executeQuery();

            String encabezado[] = {"idCompra", "no_orden_compra", "idproveedor", "fecha_orden", "fechaingreso", "idCompra_detalle", "idproducto", "cantidad", "precio_costo_unitario" };
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[9];
            while (consulta.next()) {
                datos[0] = consulta.getString("idCompra");
                datos[1] = consulta.getString("no_orden_compra");
                datos[2] = consulta.getString("idproveedor");
                datos[3] = consulta.getString("fecha_orden");
                datos[4] = consulta.getString("fechaingreso");
                datos[5] = consulta.getString("idCompra_detalle");
                datos[6] = consulta.getString("idproducto");
                datos[7] = consulta.getString("cantidad");
                datos[8] = consulta.getString("precio_costo_unitario");
                tabla.addRow(datos);
            }
        } catch (SQLException ex) {
            System.err.println("Error al leer compras: " + ex.getMessage());
        } finally {
            closeResources(consulta, parametro);
        }

        return tabla;
    }

    // Método para cerrar recursos
    private void closeResources(PreparedStatement parametro) {
        try {
            if (parametro != null) {
                parametro.close();
            }
            if (conexionDB != null) {
                conexionDB.cerrar_conexion();
            }
        } catch (SQLException ex) {
            System.err.println("Error al cerrar recursos: " + ex.getMessage());
        }
    }

    private void closeResources(ResultSet consulta, PreparedStatement parametro) {
        try {
            if (consulta != null) {
                consulta.close();
            }
            closeResources(parametro);
        } catch (SQLException ex) {
            System.err.println("Error al cerrar recursos: " + ex.getMessage());
        }
    }
    
    // Dropdown de clientes
    public HashMap<String, List<String>> drop_proveedores() {
        HashMap<String, List<String>> drop = new HashMap<>();
        try {
            String query = "SELECT idProveedore, proveedor FROM proveedores;";
            conexionDB = new conexion();
            conexionDB.abrir_conexion();
            ResultSet consulta = conexionDB.conectar_db.createStatement().executeQuery(query);

            while (consulta.next()) {
                List<String> valores = new ArrayList<>();
                valores.add(consulta.getString("proveedor"));
                drop.put(consulta.getString("idProveedore"), valores);
            }

            conexionDB.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error drop_proveedores: " + ex.getMessage());
        }
        return drop;
    }
}
