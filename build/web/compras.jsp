<%@ page import="javax.swing.table.DefaultTableModel" %>
<%@ include file="template_cliente.jsp" %>

<style>
    /* Estilo general para la página */
    body {
        font-family: Arial, sans-serif;
    }

    /* Estilo del contenedor principal */
    .container {
        margin-top: 20px;
    }

    /* Encabezados */
    h3 {
        color: #333;
        font-weight: 600;
    }

    /* Botón de nuevo */
    .center-button {
        font-weight: bold;
    }

    /* Buscar input y select */
    #buscar_id, #buscar_modal {
        border-radius: 5px;
        padding: 8px;
        font-size: 14px;
    }

    /* Tabla de ventas */
    .table {
        border-collapse: separate;
        border-spacing: 0;
        width: 100%;
        max-width: 100%;
        background-color: #f9f9f9;
        margin-top: 20px;
    }

    /* Encabezado de la tabla */
    .table thead th {
        background-color: #007bff;
        color: white;
        font-weight: bold;
        padding: 10px;
        border: 1px solid #dee2e6;
    }

    /* Filas de la tabla */
    .table tbody tr {
        transition: background-color 0.3s;
    }

    .table tbody tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    /* Color al pasar el ratón por encima */
    .table tbody tr:hover {
        background-color: #d4e9ff;
    }

    /* Celdas de la tabla */
    .table td {
        padding: 10px;
        text-align: center;
        border: 1px solid #dee2e6;
    }

    /* Botón de búsqueda */
    .btn-primary {
        font-weight: bold;
        padding: 8px 16px;
    }

    /* Alinear el botón "Buscar" */
    .d-flex.align-items-center .btn-primary {
        margin-left: 10px;
    }
    
     h3 {
            color: white;
            font-size: 42px;
            font-weight: bold;
            text-align: center;
            margin: 10px 0;
        }
</style>

<div class="container">
    <div class="row">
        <!-- Columna izquierda con Formulario y botón centrado -->
        <div>
            <h3>Compras Realizadas</h3>
        </div>

    </div>
</div>
<br>

<div class="container">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>No. Factura</th>
                <th>Serie</th>
                <th>Fecha Factura</th>
                <th>ID Cliente</th>
                <th>ID Empleado</th>
                <th>Fecha Ingreso</th>
                <th>ID Producto</th>
                <th>Cantidad</th>
                <th>Costo</th>
                <th>Total A Pagado</th>
            </tr>
        </thead>
        <tbody id="tbl_ventas">
            <%
            int clienteIdSesion = (int) session.getAttribute("idCliente");
            Ventas venta = new Ventas();  
            DefaultTableModel tabla = venta.leerVentas_1(); 

            for (int t = 0; t < tabla.getRowCount(); t++) {
                int idClienteTabla = Integer.parseInt(tabla.getValueAt(t, 4).toString());
                if (idClienteTabla == clienteIdSesion) { // Filtrar por el idCliente en sesión
                    out.println("<tr data-id='" + tabla.getValueAt(t, 0) + "' data-id_cliente='" + tabla.getValueAt(t, 4) + "'>");
                    out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                    out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                    out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                    out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                    out.println("<td>" + tabla.getValueAt(t, 4) + "</td>");
                    out.println("<td>" + tabla.getValueAt(t, 5) + "</td>");
                    out.println("<td>" + tabla.getValueAt(t, 6) + "</td>");
                    out.println("<td>" + tabla.getValueAt(t, 7) + "</td>");
                    out.println("<td>" + tabla.getValueAt(t, 8) + "</td>");
                    out.println("<td>" + tabla.getValueAt(t, 9) + "</td>");
                    
                    // Calcular el total
                    int cantidad = Integer.parseInt(tabla.getValueAt(t, 8).toString());
                    double precio = Double.parseDouble(tabla.getValueAt(t, 9).toString());
                    double total = cantidad * precio;
                    out.println("<td>" + total + "</td>");
                    out.println("</tr>");
                }
            }
            %>
        </tbody>
    </table>
</div>


<<<<<<< HEAD
<%@ include file="pie_cliente.jsp" %>
=======
<%@ include file="pie_cliente.jsp" %>
>>>>>>> f3587edba80a5271803db89211bb6f40fc19ce40
