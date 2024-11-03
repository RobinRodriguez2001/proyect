<%@ page import="javax.swing.table.DefaultTableModel" %>
<%@ include file="template_cliente.jsp" %>

<%
    // Verificar si el usuario está en sesión
    Cuenta usuarioSesion = (Cuenta) session.getAttribute("usuario");
    boolean usuarioLogueado = (usuarioSesion != null);
    Integer idCliente1 = (Integer) session.getAttribute("idCliente");
if (idCliente1 == null) {
    idCliente1 = -1; // Usar un valor que no interfiera con los IDs de cliente reales
}
    
%>



<div class="container">
    <!-- Modal de producto -->
    <div class="modal fade" id="modal_producto" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <form action="sr_compra_cliente" method="post" enctype="multipart/form-data" class="form-group">
                        <label for="lbl_id"><b>ID Venta</b></label>
                        <input type="text" name="txt_idVenta" id="txt_idVenta" class="form-control" value="0" readonly> 
                        
                        <label for="lbl_noFactura"><b>No. Factura</b></label>
                        <input type="text" name="txt_noFactura" id="txt_noFactura" class="form-control" value="1009" readonly required>
                        <br>

                        <label for="lbl_serie"><b>Serie</b></label>
                        <input type="text" name="txt_serie" id="txt_serie" class="form-control" value="B" maxlength="1" readonly required>

                        <!-- Campo de fecha para el formulario -->
                        <label for="lbl_fecha_factura"><b>Fecha Factura</b></label>
                        <input type="date" name="txt_fecha_factura" id="txt_fecha_factura" class="form-control" readonly>
                        <br>             
                        
                        <label for="lbl_cliente"><b>Cliente</b></label>
                        <select name="drop_cliente" id="drop_cliente" class="form-control" required>
                            <option value="" disabled>Seleccione un cliente</option>
                            <% 
                                Ventas ven = new Ventas();
                                HashMap<String, List<String>> dropCliente = ven.drop_cliente();
                                for (String idCliente : dropCliente.keySet()) {
                                    List<String> datos = dropCliente.get(idCliente);
                                    String nombres = datos.get(0); // Nombre del cliente
                                    String nit = datos.get(1); // NIT del cliente

                                    // Verificar si el idCliente actual es igual al idCliente1
                                    boolean isSelected = idCliente.equals(idCliente1.toString());
                            %>
                                    <option value="<%= idCliente %>" <%= isSelected ? "selected" : "" %>>
                                        <%= nombres + " - " + nit %>
                                    </option>
                            <% } %>                                     
                        </select>
                        
                        <label for="lbl_idEmpleado"><b>ID Empleado</b></label> 
                        <input type="text" name="txt_idEmpleado" id="txt_idEmpleado" class="form-control" value="3" readonly>
                        <br>
                        
                        <label for="lbl_idProducto"><b>ID Producto</b></label>
                        <input type="text" name="txt_idProducto" id="txt_idProducto" class="form-control" placeholder="ID del producto" required readonly>

                        <label for="lbl_cantidad"><b>Cantidad</b></label>
                        <input type="number" name="txt_cantidad" id="txt_cantidad" class="form-control" placeholder="Cantidad" required min="1" oninput="calcularTotal()">
                        <br>
                        
                        <label for="lbl_precioVentaUnitario"><b>Precio Venta Unitario</b></label>
                        <input type="number" name="txt_precioVentaUnitario" id="txt_precioVentaUnitario" step="0.01" class="form-control" placeholder="Precio venta unitario" required readonly>
                        
                        <label for="lbl_pagar"><b>Total a Pagar</b></label>
                        <input type="number" name="txt_pagar" id="txt_pagar" class="form-control" readonly>
                        <br>
                        
                        <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary btn-lg">Pagar</button>
                        <button type="button" class="btn btn-warning btn-lg" data-bs-dismiss="modal">Cerrar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="card-container">
    <% 
        productos producto = new productos();  
        DefaultTableModel tabla1 = producto.leerPro(); 
        for (int t = 0; t < tabla1.getRowCount(); t++) {
            String idProducto = tabla1.getValueAt(t, 0).toString();
            String nombreProducto = tabla1.getValueAt(t, 1).toString();
            String marcaProducto = tabla1.getValueAt(t, 2).toString();
            String descripcionProducto = tabla1.getValueAt(t, 3).toString();
            String imagenProducto = tabla1.getValueAt(t, 4).toString();
            String precioVentaProducto = tabla1.getValueAt(t, 6).toString();

            // Mensaje para enviar a WhatsApp
            String mensajeWhatsApp = "Hola, estoy interesado en el producto: " + nombreProducto + 
                                     " (" + marcaProducto + "). ¿Podrías darme más información?";
            String enlaceWhatsApp = "https://wa.me/50233783177?text=" + java.net.URLEncoder.encode(mensajeWhatsApp, "UTF-8"); 
    %>
    <div class="card">
        <img src="<%= request.getContextPath() + "/admin/img_producto/" + imagenProducto %>" alt="<%= nombreProducto %>">
        <div class="card-content">
            <h3><%= nombreProducto %></h3>
            <p><strong>Marca:</strong> <%= marcaProducto %></p>
            <p><%= descripcionProducto %></p>
            <p><strong>Precio: </strong>$<%= precioVentaProducto %></p>
        </div>
        <div class="button-group">
            <button class="btn btn-primary btn-comprar" data-producto="<%= idProducto %>" data-precio="<%= precioVentaProducto %>">Comprar</button>
            <button class="btn btn-success" onclick="window.location.href='<%= enlaceWhatsApp %>'">Solicitar Información</button>
        </div>
    </div>
    <% } %>
</div>

<script type="text/javascript">
    document.querySelectorAll('.btn-comprar').forEach(button => {
        button.addEventListener('click', function() {
            if (<%= usuarioLogueado %>) {
                // Obtener el idProducto y el precio del botón
                const idProducto = this.getAttribute('data-producto');
                const precio = this.getAttribute('data-precio'); // Captura el precio desde el botón

                // Asignar valores al modal
                $("#txt_idProducto").val(idProducto);
                $("#txt_precioVentaUnitario").val(precio);
                
                // Establecer la fecha de hoy
                const hoy = new Date().toISOString().split('T')[0];
                $("#txt_fecha_factura").val(hoy);

                // Establecer valores predeterminados para la serie y número de factura
                $("#txt_serie").val('B');
                $("#txt_noFactura").val('1009');

                limpiar();
                $('#modal_producto').modal('show');
            } else {
                alert('Por favor, inicie sesión para realizar una compra.');
            }
        });
    });

    function limpiar() {
        $("#txt_idVenta").val(0);
        $("#drop_cliente").val('<%= idCliente1 %>'); // Asigna el cliente logueado
        $("#txt_cantidad").val('');
    }
</script>


<script type="text/javascript">
    // Función para calcular el total a pagar
    function calcularTotal() {
        const cantidad = parseFloat(document.getElementById("txt_cantidad").value) || 0;
        const precioUnitario = parseFloat(document.getElementById("txt_precioVentaUnitario").value) || 0;
        const total = cantidad * precioUnitario;
        document.getElementById("txt_pagar").value = total.toFixed(2); // Mostrar el total con dos decimales
    }

</script>


<<<<<<< HEAD
<%@ include file="pie_cliente.jsp" %>
=======
<%@ include file="pie_cliente.jsp" %>
>>>>>>> f3587edba80a5271803db89211bb6f40fc19ce40
