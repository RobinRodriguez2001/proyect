<%@ include file="template_cliente.jsp" %>

    <style>
        person {
            background-color: #f8f9fa; /* Color de fondo claro */
            font-family: Arial, sans-serif; /* Fuente general */
        }
        .container-por {
            margin: 50px auto; /* Espaciado superior y centrado horizontal */
            padding: 20px; /* Espaciado interno */
            border-radius: 8px; /* Bordes redondeados */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* Sombra m�s pronunciada */
            background-color: #ffffff; /* Fondo blanco */
            width: 90%; /* Ancho del contenedor */
            max-width: 600px; /* Ancho m�ximo */
        }
        h1 {
            color: #343a40; /* Color del encabezado */
            text-align: center; /* Centrar el encabezado */
        }
        .alert {
            font-size: 18px; /* Tama�o de fuente de la alerta */
            padding: 15px; /* Espaciado interno de la alerta */
            border-radius: 5px; /* Bordes redondeados de la alerta */
            background-color: #d1ecf1; /* Color de fondo de la alerta */
            color: #0c5460; /* Color del texto de la alerta */
            border: 1px solid #bee5eb; /* Bordes de la alerta */
            margin-bottom: 20px; /* Margen inferior */
        }
        .btn {
            display: block; /* Hacer el bot�n un bloque para centrar */
            margin: 0 auto; /* Margen centrado */
            padding: 10px 20px; /* Relleno del bot�n */
            background-color: #007bff; /* Color de fondo del bot�n */
            color: #ffffff; /* Color del texto del bot�n */
            text-align: center; /* Centrar el texto del bot�n */
            border: none; /* Sin bordes */
            border-radius: 5px; /* Bordes redondeados */
            text-decoration: none; /* Sin subrayado */
            font-size: 16px; /* Tama�o de fuente del bot�n */
            transition: background-color 0.3s; /* Efecto de transici�n */
        }
        .btn:hover {
            background-color: #0056b3; /* Color de fondo al pasar el mouse */
        }
    </style>
</head>
<body clas="person">
    <div class="container-por">
        <h1>Credenciales del Cliente</h1>
        <div class="alert">
            <strong>Nombre de Usuario:</strong> <%= request.getAttribute("username") %><br>
            <strong>Contrase�a:</strong> <%= request.getAttribute("password") %><br>
        </div>
        <a href="index.jsp" class="btn">INICIO</a>
    </div>

<%@ include file="pie_cliente.jsp" %>