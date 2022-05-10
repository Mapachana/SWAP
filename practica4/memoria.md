# Práctica 4

> Por Mapachana

## Certificado autofirmado SSL

Vamos a comenzar trabajando en m1.

Primero, vamos a activar el mmódulo ssl y relanzamos apache, para lo que ejecutamos:

![](./img/ssl_1.png)

A continuación creamos el directorio para los certificados que vamos a crear:

![](./img/ssl_2.png)

Ahora procedemos a crear los certificados con openssl.

![](./img/ssl_3.png)

Hemos usado varios argumentos para indicarle que genere una clave de 2048 bits y que tenga 365 días de validez, así como indicamos los ficheros para guardar la clave y el certificado.

Además, -x509 autofirma el certificado.

Introducimos los datos que nos pide por línea de comandos como nos piden:

![](./img/ssl_4.png)

### Opciones avanzadas

Como opciones avanzadas, se van a comentar distintos argumentos para generar los certificados con openssl req.

- -inform DER/PEM especifica el formato de entrada de los datos.
- -outform DER/PEM especifica el formato de salida de los datos.
- -subj /type0=value0/type1=value1/type2=... permite especificar los datos desde la orden. Las abreviaturas que sustituyen a type0, type1 están predefinidas y pueden consultarse en el manual.
- -text imprime el certificado en forma de texto.

## Apache con certificado SSL

Para configurar apache para que use el certificado SSL que acabamos de generar, vamos a empezar configurando en apache la ruta de los certificados.

Configuramos el archivo /etc/apache2/sites-available/default-ssl con la información de nuestros certificados:

![](./img/ssla1.png)

Ahora activamos el sitio default-ssl, para lo que ejecutamos:

![](./img/ssla2.png)

Para comprobar que hemos realizado todo correctamente, ahora accedemos a m1 desde el navegador, como en las otras prácticas vamos a acceder a la página swap.html usando https.

Nos dice que la conexión no es segura porque el certificado es autofirmado, pero le damos a continuar de todas formas.

![](./img/ssla_3.png)

Accdemos a la página, donde vemos en la parte de la url el candadito, aunque tiene una exclamación porque el certificado es autofirmado, como ya se ha dicho.

![](./img/ssla_5.png)

Si pulsamos sobre este candado y le damos a más información, nos muestra algo de información sobre el certificado.

![](./ssla_4.png)

![](./ssla_6.png)

Finalmente, vamos a copiar los certificados de m1 en m2, para lo que vamos a usar scp.

Para ello, primero creamos el directorio para almacenar los certificados y luego los copiamos con scp, ejecutando los siguientes comandos desde m1.

![](./img/ssla_8.png)

Ahora movemos los ficheros al mismo directorio que en m1 y repetimos el proceso para activar el módulo ssl, configuramos el archivo /etc/apache2/sites-available/default-ssl, activarlo y reiniciamos apache, de forma análoga a como lo hemos hecho en m1.

Comprobamos que funciona igual que con m1:

![](./img/ssla_9.png)


### Opciones avanzadas

Podemos obtener el certificado mediante openssl, para ello, desde mi ordenador anfitrión ejecutamos:

![](./img/ssla_7.png)

Y comprobamos que nos muestra el certificado.

Además, se pueden añadir otras opciones de apache con `SSLOptions +opcion`.

También se puede activar la redirección para que toda conexión http la redirija a ser https:

```
<VirtualHost *:80>
        // Cosas

        Redirect "/" "https://your_domain_or_IP/"

        //Más cosas
</VirtualHost>
```

https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-18-04-es

## Nginx como balanceador para peticiones HTTPS

Para configurar nginx con los certificados ssl, comenzamos copiando los ficheros de m1 a m3 mediante scp.

![](./img/nginx_1.png)

Creamos una carpeta ssl y movemos ahí lso certificados copiados.

Ahora editamos el fichero de configuración de nginx /etc/nginx/conf.d/default.conf añadiendo un servidor nuevo como se muestra:

![](./img/nginx_2.png)

Relanzamos nginx con sudo systemctl restart nginx y comprobamos que podemos acceder al balanceador por https:

![](./nginx_3.png)

### Opciones avanzadas

Como configuraciones adicionales para nginx se pueden usar varias directivas dentro del archivo de configuración /etc/nginx/conf.d/default.conf:

- ssl_protocols <lista de protocolos>. Su función es indicar que las conexiones por SSL y TLS que se van a establecer deben ser compatibles con las de la lista de protocolos indicada. Por ejemplo, SSLv2, TLSv1 o TLSv2.
- ssl_ciphers <lista de protocolos>. Su función es, de análogamente a ssl_protocols, limitar las conexiones a aquellas compatibles con los sistemas cifrados listados.








