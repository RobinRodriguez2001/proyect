<%@ include file="template_cliente.jsp" %>

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
        /* Estilos de secci�n */
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
        /* Alineaci�n alternada de las secciones */
        #Visi�n, #Nosotros, #contacto {
            text-align: left;
            margin-left: 75px;
        }
        #Misi�n, #ofrecemos {
            text-align: right;
            margin-right: 75px;
        }
          /* Estilo para los enlaces */
        .custom-link {
            color: #0056b3;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s;
        }
        .custom-link:hover {
            color: #ff6600;
            text-decoration: underline;
        }


         /* Estilo para las im�genes */
        .custom-image {
            display: block;
            width: 100%;
            max-width: 400px;
            margin: 10px auto;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s;
        }



        /* Estilos para el video de fondo */
    #background-video {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      object-fit: cover;
      z-index: -1;
    }

    

        /* Footer */
        footer {
            margin-top: 20px;
            padding: 10px;
        }
    </style>
    <body>
    <header>
        <h2>Sobre Nosotros</h2>
    </header>


    
    <h1 id="intex-title">Intex</h1>
    <video autoplay muted loop id="background-video">
    <source src="img/videof.mp4" type="video/mp4">
    Tu navegador no soporta la etiqueta de video.
  </video>

  


    <section id="Visi�n">
        <h2>Visi�n</h2>
        <p>Ser l�deres en el mercado de soluciones de c�mputo, reconocidos por nuestra calidad, innovaci�n y compromiso con la satisfacci�n del cliente, impulsando el desarrollo tecnol�gico de nuestros usuarios y acompa��ndolos en su crecimiento.</p>
        <img src="img/vicion.png" alt="Ejemplo de imagen" class="custom-image">
    </section>

    <section id="Misi�n">
        <h2>Misi�n</h2>
        <p>Ofrecer productos de c�mputo de alta calidad que satisfagan las necesidades de nuestros clientes, con un servicio excepcional y un enfoque en la innovaci�n y confiabilidad. Nos comprometemos a brindar soluciones tecnol�gicas accesibles y efectivas que permitan a nuestros clientes alcanzar sus objetivos personales y profesionales.</p>
        <img src="img/micion.png" alt="Ejemplo de imagen" class="custom-image">
    </section>

    <section id="Nosotros">
        <h2>Sobre Nosotros</h2>
        <p>Somos una empresa dedicada a la venta de productos de c�mputo, especializ�ndonos en computadoras de �ltima generaci�n y accesorios para mejorar la productividad y el rendimiento.</p>
        <p>Nuestro objetivo es ofrecer productos de calidad y brindar el mejor servicio al cliente.</p>
        <img src="img/nosotros.png" alt="Ejemplo de imagen" class="custom-image">
    </section>

    <section id="ofrecemos">
        <h2>Qu� ofrecemos</h2>
        <p>En nuestra empresa nos especializamos en ofrecer una amplia gama de productos de c�mputo, desde computadoras de alta calidad hasta los accesorios necesarios para optimizar el rendimiento y la productividad de nuestros clientes. Nos enfocamos en brindar soluciones tecnol�gicas innovadoras y confiables que se adapten a las necesidades tanto de usuarios individuales como de empresas, siempre asegurando un servicio al cliente excepcional y productos de vanguardia.</p>
        <img src="img/ofrecemos.png" alt="Ejemplo de imagen" class="custom-image">
    </section>

    <section id="contacto">
        <h2>Informaci�n de Contacto</h2>
        <p><strong>Tel�fono:</strong> +123 456 7890</p>
        <p><strong>Correo Electr�nico:</strong> contacto@tuempresa.com</p>
        <p><strong>Direcci�n:</strong> Av. Tecnol�gica #123, Ciudad, Pa�s</p>

         
        <h2>Enlaces</h2>
        
        <p>
            Tambi�n puedes seguirnos en nuestras redes sociales: 
            <a href="https://www.facebook.com/profile.php?id=61557031081940" class="custom-link" target="_blank">Facebook</a>, 
            <a href="https://www.youtube.com/@productostecnologicos502-kr7hd/shorts" class="custom-link" target="_blank">youtube</a> y 
            <a href="https://www.instagram.com/productos121811/profilecard/?igsh=dnNtM21zZ2dhY3Jy" class="custom-link" target="_blank">Instagram</a>.
        </p>
   
    </section>

</body>

<%@ include file="pie_cliente.jsp" %>