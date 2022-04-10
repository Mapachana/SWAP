# Practica 3

## Instalacion 

Comenzamos instalando la máquina virtual como las anteriores, rellenando los datos relativos a la m3:

![](./img/instal_1.png)

Añadimos ahora el adaptador de red solo-anfitrión:

![](./img/instal_2.png)

Y configuramos la red editando el fichero `/etc/netplan/00-installer-config.yaml`, y le asignamos la ip `192.168.56.103`:

![](./img/instal_3.png)

Finalmente ejecutamos `sudo netplan apply` para hacer efectivos los cambios.

## Nginx

Comenzamos instalando nginx, para ello ejecutamos:

`sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoremove`
`sudo apt-get install nginx`

![](./img/nginx_1.png)

![](./img/nginx_2.png)

Y comprobamos la versión instalada con `-v`:

![](./img/nginx_3.png)

Lanzamos nginx con `sudo systemctl start nginx`:

![](./img/nginx_4.png)

Ahora deshabilitamos el servidor web para que nginx actúe como balanceador, para lo que vamos a editar el fichero `/etc/nginx/nginx.conf`:

![](./img/nginx_5.png)

Y ahora modificamos el archivo `/etc/nginx/conf.d/default.conf`:

![](./img/nginx_6.png)

Y reiniciamos el servicio con `sudo systemctl restart nginx` para asegurarnos de que se aplica la configuración.

Comprobamos ahora accediendo a `http://192.168.56.103/swap.html` que las máquinas se turnan para servir el sitio web.

![](./img/nginx_7.png)

![](./img/nginx_8.png)

También se puede comprobar con curl:

![](./img/nginx_9.png)

### Ponderación

Ahora vamos a repartir la carga entre las máquinas en función de pesos. Para ello, en `/etc/nginx/conf.d/default.conf` vamos a usar el parámetro `weight`.

Como ejemplo, vamos a suponer que m1 tiene el doble de capacidad que m2.

Editamos el fichero `/etc/nginx/conf.d/default.conf`:

![](./img/nginx_10.png)

Relanzamos nginx con `sudo systemctl restart nginx` y comprobamos que funciona:

![](./img/nginx_11.png)

### Otras opciones avanzadas

Ahora vamos a configurar que todas las peticiones que vengan de la misma IP se dirijan a la misma máquina servidora final. Para ello, usamos `ip_hash` em el fichero de configuración:

![](./img/nginx_12.png)

De nuevo, reiniciamos el servicio para hacer efectiva la configuración y comprobamos que funciona:

![](./img/nginx_13.png)

También podemos activar las conexiones `keepalive` por 3 segundos:

![](./img/nginx_14.png)

Otra opción es usar `down`, que marca un servidor como permanentemente offline, y requiere de ser usado con `ip_hash`:

![](./img/nginx_15.png)

Relanzamos el servicio y comprobamos que funciona:

![](./img/nginx_16.png)

También podemos usar `backup`, que reserva este servidor y solo le pasa tráfico si alguno de los otros servidores no configurados como backup está caído u ocupado:

![](./img/nginx_17.png)

Y ahora siempre nos atiende m1.

Finalmente, para evitar errores al reiniciar la máquina virtual, se va a deshabilitar que se lance nginx al encender la máquina. Para ello se ejecuta `sudo systemctl disable nginx`.

## HAProxy

Comenzamos parando nginx, de forma que no interfiera con HAProxy, ya que usan el mismo puerto. Para pararlo, ejecutamos `sudo systemctl stop nginx`.

Ahora instalamos HAproxy con `sudo apt-get install haproxy`:

![](./img/haproxy_1.png)

Lanzamos HAProxy con `sudo systemctl start haproxy`:

![](./img/haproxy_2.png)

Editamos ahora el archivo de configuración `/etc/haproxy/haproxy.cfg`:

![](./img/haproxy_3.png)

y relanzamos el servicio con `sudo systemctl restart haproxy`.

Comprobamos que funciona, va sirviendo por turnos cada máquina:

![](./img/haproxy_4.png)

### Ponderación

Para configurar la ponderación, de nuevo editamos el fichero `/etc/haproxy/haproxy.cfg`, usando la opción `weight`. De nuevo se ha supuesto a m1 con el doble de capacidad de m2:

![](./img/haproxy_5.png)

Y relanzamos el servicio y comprobamos que funciona:

![](./img/haproxy_6.png)

### Opciones avanzadas

Por analogía y para que sirva de comparativa con cómo se realizan algunas configuraciones en nginx, se van a usar configuraciones ya usadas antes.

Por ejemplo, para usar ip hash, editando de nuevo el archivo de configuración:

![](./img/haproxy_7.png)

Y si relanzamos y comprobamos que funciona, pues siempre nos atiende m1:

![](./img/haproxy_8.png)

Finalmente, también podemos poner de nuevo m2 en backup:

![](./img/haproxy_9.png)

Y relanzando y comprobando que funciona:

![](./img/haproxy_10.png)

Finalmente, para evitar errores al reiniciar la máquina virtual, se va a deshabilitar que se lance HAProxy al encender la máquina. Para ello se ejecuta `sudo systemctl disable haproxy`.

## Estadísticas de HAProxy

Para esta sección dejamos round-robin, como en la configuración inicial, y añadimos configuración necesaria para habilitar las estadísticas en `/etc/haproxy/haproxy.cfg`:

![](./img/estad_1.png)

Relanzamos haproxy y accedemos a las estadísticas:

![](./img/estad_2.png)

![](./img/estad_3.png)

### Opciones avanzadas

Como opciones avanzadas se va a añadir el tiempo de refresco de la página y la posibilidad de marcar los servidores como down o maintenance.

Por ejemplo, vamos a usar un tiempo de refresco de 30 segundos.

Para ello, editamos de nuevo el fichero de configuración añadiendo las líneas:

```
stats refresh 30s
stats admin if TRUE
```

El fichero quedaría por tanto:

![](./img/estad_4.png)

Y relanzando de nuevo el servicio y accediendo a las estadísticas de nuevo:

![](./img/estad_5.png)

Si además se quisiera configurar el timeout, se usaría `stats timeout <n>s`.



