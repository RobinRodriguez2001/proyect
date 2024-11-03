package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Clientes_adm;

@MultipartConfig
public class sr_clientes_p extends HttpServlet {

    Clientes_adm cliente;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");


        try {
            // Recuperar parámetros
            int idCliente = Integer.parseInt(request.getParameter("txt_idCliente")); // Conversión de String a int
            String nombres = request.getParameter("txt_nombres");
            String apellidos = request.getParameter("txt_apellidos");
            String nit = request.getParameter("txt_nit");
            int genero = Integer.parseInt(request.getParameter("txt_genero")); // 0 para masculino, 1 para femenino
            String telefono = request.getParameter("txt_telefono");
            String correoElectronico = request.getParameter("txt_correo_electronico");

            // Crear objeto Clientes_adm
            cliente = new Clientes_adm(idCliente, nombres, apellidos, nit, genero, telefono, correoElectronico);

           // Acción según el valor del botón presionado
            if (request.getParameter("btn_agregar") != null) {
                // Agregar el cliente y verificar si fue exitoso
                if (cliente.agregarCliente(request) > 0) {

                    // Redirigir a index.jsp para mostrar el modal
                    request.getRequestDispatcher("credenciales.jsp").forward(request, response);
                } else {
                    response.getWriter().println("Error al agregar cliente.");
                }
            }



        } catch (IllegalArgumentException e) {
            response.getWriter().println("Error: " + e.getMessage());
        } catch (IOException e) {
            response.getWriter().println("Error inesperado: " + e.getMessage());
            e.printStackTrace(response.getWriter()); // Imprime el stack trace
        } catch (Exception e) {
            response.getWriter().println("Error inesperado: " + e.getMessage());
            e.printStackTrace(response.getWriter());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet que maneja las operaciones de clientes.";
    }
<<<<<<< HEAD
}
=======
}
>>>>>>> f3587edba80a5271803db89211bb6f40fc19ce40
