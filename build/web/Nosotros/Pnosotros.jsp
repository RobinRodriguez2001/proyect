<%-- 
    Document   : Pnosotros
    Created on : 29/10/2024, 10:24:49 p. m.
    Author     : ANDRES
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sobre Nosotros</title>
    <style>
        /* Estilos generales */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
        }
        header, footer {
            text-align: center;
            background-color: #333;
            color: #fff;
            padding: 10px 0;
        }
        h2 {
            color: #0056b3;
        }
        /* Estilos de sección */
        section {
            max-width: 1000px;
            margin: 20px auto;
            padding: 60px 40px;
            background-color: #fff;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        /* Efecto de agrandado al pasar el mouse */
        section:hover {
            transform: scale(1.05);
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.2);
        }
        /* Alineación alternada de las secciones */
        #Visión, #Nosotros, #contacto {
            text-align: left;
            margin-left: 75px;
        }
        #Misión, #ofrecemos {
            text-align: right;
            margin-right: 75px;
        }
        /* Footer */
        footer {
            margin-top: 20px;
            padding: 10px;
        }
    </style>
</head>
<body>
    <header>
        <h2>Sobre Nosotros</h2>
    </header>

    <section id="Visión">
        <h2>Visión</h2>
        <p>Ser líderes en el mercado de soluciones de cómputo, reconocidos por nuestra calidad, innovación y compromiso con la satisfacción del cliente, impulsando el desarrollo tecnológico de nuestros usuarios y acompañándolos en su crecimiento.</p>
    </section>

    <section id="Misión">
        <h2>Misión</h2>
        <p>Ofrecer productos de cómputo de alta calidad que satisfagan las necesidades de nuestros clientes, con un servicio excepcional y un enfoque en la innovación y confiabilidad. Nos comprometemos a brindar soluciones tecnológicas accesibles y efectivas que permitan a nuestros clientes alcanzar sus objetivos personales y profesionales.</p>
    </section>

    <section id="Nosotros">
        <h2>Sobre Nosotros</h2>
        <p>Somos una empresa dedicada a la venta de productos de cómputo, especializándonos en computadoras de última generación y accesorios para mejorar la productividad y el rendimiento.</p>
        <p>Nuestro objetivo es ofrecer productos de calidad y brindar el mejor servicio al cliente.</p>
    </section>

    <section id="ofrecemos">
        <h2>Qué ofrecemos</h2>
        <p>En nuestra empresa nos especializamos en ofrecer una amplia gama de productos de cómputo, desde computadoras de alta calidad hasta los accesorios necesarios para optimizar el rendimiento y la productividad de nuestros clientes. Nos enfocamos en brindar soluciones tecnológicas innovadoras y confiables que se adapten a las necesidades tanto de usuarios individuales como de empresas, siempre asegurando un servicio al cliente excepcional y productos de vanguardia.</p>
    </section>

    <section id="contacto">
        <h2>Información de Contacto</h2>
        <p><strong>Teléfono:</strong> +123 456 7890</p>
        <p><strong>Correo Electrónico:</strong> contacto@tuempresa.com</p>
        <p><strong>Dirección:</strong> Av. Tecnológica #123, Ciudad, País</p>
    </section>

    <footer>
        <p>&copy; 2024 Tu Empresa de Cómputo. Todos los derechos reservados.</p>
    </footer>
</body>
</html>
