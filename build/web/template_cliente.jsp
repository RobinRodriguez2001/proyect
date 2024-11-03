<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@page import="javax.swing.table.DefaultTableModel" %>
<%@page import="modelo.productos" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.SQLException" %>
<%@ page import="modelo.Cuenta" %>
<%@ page import="modelo.productos" %>
<%@page import="modelo.Ventas" %>
<%@page import="modelo.Clientes_adm" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Empleados_adm" %>

<%
    // Recuperar el usuario de la sesión (si ya existe)
    Cuenta usuario1 = (Cuenta) session.getAttribute("usuario");
    
    // Verificar credenciales enviadas
    String username = request.getParameter("username1");
    String password = request.getParameter("password1");

    if (username != null && password != null) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Conectar a la base de datos
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/newdb", "root", "danigero");

            // Preparar consulta para buscar usuario
            String sql = "SELECT id, password, attempts, lock_time, mec, idCliente FROM users WHERE username = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            rs = stmt.executeQuery();
            

            if (rs.next()) {
                // Obtener datos de usuario
                String dbPassword = rs.getString("password");
                int attempts = rs.getInt("attempts");
                Timestamp lockTime = rs.getTimestamp("lock_time");
                String role = rs.getString("mec");
                int idCliente = rs.getInt("idCliente");

                // Guardar idCliente en la sesión
                session.setAttribute("idCliente", idCliente);

                long currentTimeMillis = System.currentTimeMillis();
                boolean locked = false;

                // Verificar si la cuenta está bloqueada
                if (lockTime != null && (currentTimeMillis - lockTime.getTime()) < 300000) {
                    out.println("<p style='color:red;'>Tienes varios intentos fallidos. Por favor espera 5 minutos.</p>");
                    locked = true;
                }

                if (!locked) {
                    // Verificar contraseña
                    if (password.equals(dbPassword)) {
                        // Verificar si el usuario es "cliente"
                        if ("cliente".equals(role)) {
                            // Crear objeto Cuenta y almacenar en la sesión
                            Cuenta usuario = new Cuenta(rs.getInt("id"), username, dbPassword);
                            session.setAttribute("usuario", usuario);

                            // Resetear intentos de inicio de sesión
                            String resetAttemptsSql = "UPDATE users SET attempts = 0, lock_time = NULL WHERE username = ?";
                            try (PreparedStatement resetStmt = conn.prepareStatement(resetAttemptsSql)) {
                                resetStmt.setString(1, username);
                                resetStmt.executeUpdate();
                            }

                            // Redireccionar al usuario
                            response.sendRedirect("index.jsp");
                        } else {
                            out.println("<p style='color:red;'>Solo los usuarios con rol 'cliente' pueden iniciar sesión.</p>");
                        }
                    } else {
                        // Incrementar intentos fallidos
                        attempts++;
                        if (attempts >= 3) {
                            String lockSql = "UPDATE users SET lock_time = NOW() WHERE username = ?";
                            try (PreparedStatement lockStmt = conn.prepareStatement(lockSql)) {
                                lockStmt.setString(1, username);
                                lockStmt.executeUpdate();
                            }
                            out.println("<p style='color:red;'>Demasiados intentos fallidos. Cuenta bloqueada por 5 minutos.</p>");
                        } else {
                            String updateAttemptsSql = "UPDATE users SET attempts = ? WHERE username = ?";
                            try (PreparedStatement updateStmt = conn.prepareStatement(updateAttemptsSql)) {
                                updateStmt.setInt(1, attempts);
                                updateStmt.setString(2, username);
                                updateStmt.executeUpdate();
                            }
                            out.println("<p style='color:red;'>Credenciales inválidas. Intento " + attempts + " de 3.</p>");
                        }
                    }
                }
            } else {
                out.println("<p style='color:red;'>Usuario no existe.</p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p style='color:red;'>Error conectando a la base de datos.</p>");
        } finally {
            // Cerrar recursos
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>


<!DOCTYPE html>
<html>
<head>
    <title>Menu</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <style>
        body {
            background-image: url('img/7.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            height: 100%;
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            padding: 20px;
            margin: 0;
        }


        .navbar {
            padding: 10px 10px;
        }

        .navbar-brand img {
            width: 200px;
            height: auto;
        }

        .nav-link {
            font-size: 1.8rem;
            padding: 10px 15px;
        }

        .form-control {
            height: 50px;
        }

        .card-container {
            display: flex;
            flex-wrap: wrap; /* Permite que las tarjetas se envuelvan en múltiples líneas */
            gap: 30px; /* Espacio entre las tarjetas */
            justify-content: center; /* Centra las tarjetas horizontalmente */
            align-items: center; /* Centra las tarjetas verticalmente (opcional) */
            padding: 20px; /* Espacio alrededor del contenedor */
        }

        .card {
            background-color: rgba(211, 211, 240, 0.8); /* Gris claro */
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 300px; /* Ancho fijo para las tarjetas */
            display: flex;
            flex-direction: column;
            justify-content: space-between; /* Distribuir el contenido */
        }

        .card img {
            width: 100%;
            height: 200px; /* Altura fija */
            object-fit: cover; /* Ajuste de imagen */
            border-radius: 8px; /* Bordes redondeados */
        }

        .button-group {
            display: flex; /* Usar flexbox para los botones */
            flex-direction: column; /* Apilar botones verticalmente */
            margin-top: 10px; /* Espacio entre el contenido y los botones */
        }

        .button-group .btn {
            width: 100%; /* Los botones ocupan todo el ancho */
            margin: 5px 0; /* Espacio entre botones */
        }
        
        .welcome-text {
            color: white; /* Cambia el color del texto (en este caso, un azul) */
            font-size: 1.7rem; /* Cambia el tamaño de la fuente (puedes usar px, em, rem, etc.) */
            font-weight: bold; /* Cambia el grosor del texto (opcional) */
            margin: 0 15px;
        }
        
        .btn-long {
            display: inline-block;
            font-size: 1.5rem; /* Tamaño de texto grande */
            padding: 10px 30px; /* Espacio interno del botón */
            width: 100%; /* Hacer que el botón ocupe todo el ancho posible */
            max-width: 300px; /* Limitar el ancho máximo */
            text-align: center;
            background-color: #14f4f1; /* Color de fondo verde */
            color: black; /* Texto blanco */
            border: none; /* Sin borde */
            border-radius: 5px; /* Bordes redondeados */
            transition: background-color 0.3s ease; /* Efecto suave al cambiar el color */
        }

        .btn-long:hover {
            background-color: #40b6b4; /* Cambiar el color al pasar el mouse */
        }

        .btn-long:active {
            background-color: #91e0df; /* Cambiar el color al hacer clic */
        }

        .btn-long:focus {
            outline: none; /* Remover contorno de enfoque */
            box-shadow: 0 0 5px rgba(40, 167, 69, 0.5); /* Sombra al hacer foco */
        }
        label{
            background: linear-gradient(to right, red, blue);
            background-clip: text;
            color: transparent;
        }
        
    </style>
</head>
<body>
    <header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="login.jsp">
                <img src="img/as.png" alt="Logo" style="width: 180px; height: auto;">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button> 
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="index.jsp">Inicio</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="compras.jsp">
                            <img src="img/10.png" alt="Compras" style="width: 50px; height: auto; margin-right: 5px;">Compras
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="contactanos.jsp">Contáctanos</a>
                    </li>
                </ul>
                <form class="d-flex align-items-center" action="buscarProductos.jsp">
                    <!-- Botón para Iniciar Sesión -->
                    <button type="button" class="btn btn-outline-light me-2" data-bs-toggle="modal" data-bs-target="#loginModal" 
                            <%= (usuario1 != null) ? "style='display:none;'" : "" %>>
                        Iniciar Sesión
                    </button>

                    <!-- Mostrar el nombre del usuario si está logueado y agregar un enlace para cerrar sesión -->
                    <% if (usuario1 != null) { %>
                        <span class="text-light me-3">
                            Bienvenido, <a href="CerrarSesion.jsp" style="color:inherit; text-decoration:none;"><%= usuario1.getUsername() %></a>
                        </span>
                    <% } %>

                </form>
            </div>
        </div>
    </nav>

    <br>
    <!-- Modal de Iniciar Sesión -->
    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-dark text-light">
                    <h5 class="modal-title">Iniciar Sesión</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="loginForm" method="post">
                        <div class="mb-3">
                            <label for="username1" class="form-label">Usuario</label>
                            <input type="text" class="form-control" id="username1" name="username1" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Contraseña</label>
                            <input type="password" class="form-control" id="password1" name="password1" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Iniciar Sesión</button>
                    </form>
                    <p class="mt-3 text-center">¿No tienes una cuenta? 
                        <a href="#" class="text-primary" data-bs-toggle="modal" data-bs-target="#registerUserModal">Regístrate aquí</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Modal para el registro de usuario -->
<div class="modal fade" id="registerUserModal" tabindex="-1" aria-labelledby="registerUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="registerUserModalLabel">Registrar Usuario</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="sr_clientes_p" method="post">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="txt_idCliente" class="form-label">ID Cliente</label>
                        <input type="number" class="form-control" id="txt_idCliente" name="txt_idCliente" value="0" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="txt_nombres" class="form-label">Nombres</label>
                        <input type="text" class="form-control" id="txt_nombres" name="txt_nombres" required>
                    </div>
                    <div class="mb-3">
                        <label for="txt_apellidos" class="form-label">Apellidos</label>
                        <input type="text" class="form-control" id="txt_apellidos" name="txt_apellidos" required>
                    </div>
                    <div class="mb-3">
                        <label for="txt_nit" class="form-label">NIT</label>
                        <input type="text" class="form-control" id="txt_nit" name="txt_nit" required>
                    </div>
                    <div class="mb-3">
                        <label for="txt_genero" class="form-label">Género</label>
                        <select class="form-select" id="txt_genero" name="txt_genero" required>
                            <option value="0">Masculino</option>
                            <option value="1">Femenino</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="txt_telefono" class="form-label">Teléfono</label>
                        <input type="text" class="form-control" id="txt_telefono" name="txt_telefono" required>
                    </div>
                    <div class="mb-3">
                        <label for="txt_correo_electronico" class="form-label">Correo Electrónico</label>
                        <input type="email" class="form-control" id="txt_correo_electronico" name="txt_correo_electronico" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-primary" name="btn_agregar">Registrar</button>
                </div>
            </form>
        </div>
    </div>
</div>
    

</header>
