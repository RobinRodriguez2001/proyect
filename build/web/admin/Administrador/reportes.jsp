
<%@ include file="template_administrador.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="modelo.*" %>
<%@ page import="javax.swing.table.DefaultTableModel" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <title>Bootstrap Example</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        /* Estilo para los botones grandes */
        .boton-grande {
            width: 200px;
            height: 70px;
            font-size: 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 8px;
            margin: 10px;
            transition: transform 0.3s, background-color 0.3s;
        }
        .boton-grande:hover {
            background-color: #0056b3;
            transform: scale(1.1);
        }
        /* Oculta todas las tablas al inicio */
        .tabla-contenido {
            display: none;
        }
       .tabla-contenido {
    width: 90%; /* Ajusta el ancho del div si es necesario */
    max-width: 100%; /* Opcional: define un ancho máximo */
}


    th, td {
        white-space: nowrap; /* Evita que el texto se corte y permite el ajuste */
    }
    td {
        word-wrap: break-word; /* Permite que el texto largo se ajuste dentro de la celda */
    }
    </style>

    <script>
        function mostrarTabla(tablaId) {
            // Ocultar todas las tablas
            const tablas = document.querySelectorAll('.tabla-contenido');
            tablas.forEach(tabla => {
                tabla.style.display = 'none'; // Ocultar tabla
            });

            // Mostrar la tabla seleccionada
            const tablaSeleccionada = document.getElementById(tablaId);
            if (tablaSeleccionada) {
                tablaSeleccionada.style.display = 'block'; // Mostrar tabla seleccionada
            }
        }
    </script>
</head>
<body>

<div class="jumbotron text-center" style="background: black;">
    <h1 style="color: white;">Reportes</h1>
</div>

<div class="d-flex justify-content-center flex-wrap">
    <!-- Botones grandes con animación para mostrar las tablas -->
    <button class="boton-grande" onclick="mostrarTabla('tabla1')">Compras últimos 6 meses</button>
    <button class="boton-grande" onclick="mostrarTabla('tabla2')">Trabajadores Masculinos</button>
    <button class="boton-grande" onclick="mostrarTabla('tabla3')">Trabajadores Femeninas</button>
    <button class="boton-grande" onclick="mostrarTabla('tabla4')">Productos en bodega</button>
</div>

<!-- Tablas ocultas, cada una con un ID único -->
<div id="tabla1" class="tabla-contenido container">
  <h2 style="color: white;">Compras últimos 6 meses</h2>
  <button class="btn btn-success mb-2" onclick="window.location.href='<%= request.getContextPath() %>/comprasPDF'">Descargar PDF Compras</button>
  <table class="table table-dark table-hover">
      <thead>
          <tr>
              <th>ID</th>
              <th>No. Orden Compra</th>
              <th>ID Proveedor</th>
              <th>Fecha Orden</th>
              <th>Fecha Ingreso</th>
          </tr>
      </thead>
      <tbody id="tbl_compras">
          <% 
          Compras compra = new Compras();  
          DefaultTableModel tablaCompras = compra.reportecompras6(); 
          
          for (int t = 0; t < tablaCompras.getRowCount(); t++) {
              out.println("<tr>");
              out.println("<td>" + tablaCompras.getValueAt(t, 0) + "</td>");
              out.println("<td>" + tablaCompras.getValueAt(t, 1) + "</td>");
              out.println("<td>" + tablaCompras.getValueAt(t, 2) + "</td>");
              out.println("<td>" + tablaCompras.getValueAt(t, 3) + "</td>");
              out.println("<td>" + tablaCompras.getValueAt(t, 4) + "</td>");
              out.println("</tr>");
          }
          %>
      </tbody>
  </table>
</div>

<div id="tabla2" class="tabla-contenido container">
  <h2 style="color: white;">Trabajadores Masculinos</h2>
  <button class="btn btn-success mb-2" onclick="window.location.href='<%= request.getContextPath() %>/masculinoPDF'">Descargar PDF Compras</button>
  <table class="table table-dark table-hover">
      <thead>
          <tr>
              <th>ID</th>
              <th>NOMBRES</th>
              <th>APELLIDOS</th>
              <th>DIRECCIÓN</th>
              <th>TELEFONO</th>
              <th>DPI</th>
              <th>FECHA NACIMIENTO</th>
              <th>PUESTO</th>
              <th>FECHA INICIO LABORES</th>
              <th>FECHA INGRESO</th>
              <th>GÉNERO</th>
          </tr>
      </thead>
      <tbody id="tbl_emp">
          <% 
          Empleados_adm emp = new Empleados_adm();  
          DefaultTableModel tablaEmpleados_1 = emp.leerEmpleadosMasculinos(); 
          
          for (int t = 0; t < tablaEmpleados_1.getRowCount(); t++) {
              out.println("<tr data-id='" + tablaEmpleados_1.getValueAt(t, 0) + "' data-id_puesto='" + tablaEmpleados_1.getValueAt(t, 7) + "'>");
              out.println("<td>" + tablaEmpleados_1.getValueAt(t, 0) + "</td>");
              out.println("<td>" + tablaEmpleados_1.getValueAt(t, 1) + "</td>");
              out.println("<td>" + tablaEmpleados_1.getValueAt(t, 2) + "</td>");
              out.println("<td>" + tablaEmpleados_1.getValueAt(t, 3) + "</td>");
              out.println("<td>" + tablaEmpleados_1.getValueAt(t, 4) + "</td>");
              out.println("<td>" + tablaEmpleados_1.getValueAt(t, 5) + "</td>");
              out.println("<td>" + tablaEmpleados_1.getValueAt(t, 6) + "</td>");
              out.println("<td>" + tablaEmpleados_1.getValueAt(t, 7) + "</td>");  // Puesto
              out.println("<td>" + tablaEmpleados_1.getValueAt(t, 8) + "</td>");
              out.println("<td>" + tablaEmpleados_1.getValueAt(t, 9) + "</td>");  // Fecha Ingreso
              out.println("<td>" + (tablaEmpleados_1.getValueAt(t, 10).equals("0") ? "Masculino" : "Femenino") + "</td>");
              out.println("</tr>");
          }
          %>
      </tbody>
  </table>
</div>
<div id="tabla3" class="tabla-contenido container">
  <h2 style="color: white;">Trabajadores Masculinos</h2>
  <button class="btn btn-success mb-2" onclick="window.location.href='<%= request.getContextPath() %>/generarPDF'">Descargar PDF</button>
  <table class="table table-dark table-hover">
      <thead>
          <tr>
              <th>ID</th>
              <th>NOMBRES</th>
              <th>APELLIDOS</th>
              <th>DIRECCIÓN</th>
              <th>TELEFONO</th>
              <th>DPI</th>
              <th>FECHA NACIMIENTO</th>
              <th>PUESTO</th>
              <th>FECHA INICIO LABORES</th>
              <th>FECHA INGRESO</th>
              <th>GÉNERO</th>
          </tr>
      </thead>
      <tbody id="tbl_emp">
          <% 
          Empleados_adm emp1 = new Empleados_adm();  
          DefaultTableModel tablaEmpleados_2 = emp1.leerEmpleadosFemeninos(); 
          
          for (int t = 0; t < tablaEmpleados_2.getRowCount(); t++) {
              out.println("<tr data-id='" + tablaEmpleados_2.getValueAt(t, 0) + "' data-id_puesto='" + tablaEmpleados_2.getValueAt(t, 7) + "'>");
              out.println("<td>" + tablaEmpleados_2.getValueAt(t, 0) + "</td>");
              out.println("<td>" + tablaEmpleados_2.getValueAt(t, 1) + "</td>");
              out.println("<td>" + tablaEmpleados_2.getValueAt(t, 2) + "</td>");
              out.println("<td>" + tablaEmpleados_2.getValueAt(t, 3) + "</td>");
              out.println("<td>" + tablaEmpleados_2.getValueAt(t, 4) + "</td>");
              out.println("<td>" + tablaEmpleados_2.getValueAt(t, 5) + "</td>");
              out.println("<td>" + tablaEmpleados_2.getValueAt(t, 6) + "</td>");
              out.println("<td>" + tablaEmpleados_2.getValueAt(t, 7) + "</td>");  // Puesto
              out.println("<td>" + tablaEmpleados_2.getValueAt(t, 8) + "</td>");
              out.println("<td>" + tablaEmpleados_2.getValueAt(t, 9) + "</td>");  // Fecha Ingreso
              out.println("<td>" + (tablaEmpleados_2.getValueAt(t, 10).equals("0") ? "Masculino" : "Femenino") + "</td>");
              out.println("</tr>");
          }
          %>
      </tbody>
  </table>
</div>

<div id="tabla4" class="tabla-contenido container">
     <h2 style="color: white;">Productos en Bodega</h2>
  <table class="table table-dark table-hover">
        <thead>
            <tr>
                <th>ID</th>
                <th>Producto</th>
                <th>Marca</th>
                <th>Descripción</th>
                <th>Precio Costo</th>
                <th>Precio Venta</th>
                <th>Existencia</th>
                <th>Fecha Ingreso</th>
            </tr>
        </thead>
        <tbody id="tbl_productos">
             <% 
            productos producto = new productos();  
            DefaultTableModel tabla = producto.leer(); 
            
            for (int t = 0; t < tabla.getRowCount(); t++) {
                out.println("<tr data-id='" + tabla.getValueAt(t, 0) + "' data-id_marca='" + tabla.getValueAt(t, 2) + "'>");
                out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 5) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 6) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 7) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 8) + "</td>");
                // Se eliminó la columna de Fecha de Ingreso
                out.println("</tr>");
            }
            %>
        </tbody>
    </table>
</div>

</body>
</html>

