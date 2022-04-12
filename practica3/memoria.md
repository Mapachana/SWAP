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

## Gobetween

Comenzamos asegurandonos de que tanto nginx como haproxy no se estén ejecutando, y tras esto instalamos gobetween mediante snap ejecutando `sudo snap install gobetween --edge`:

![](./img/gobet_1.png)

Ahora lanzamos gobetween con `/snap/gobetween/current/bin/gobetween`:

![](./img/gobet_2.png)

Ahora, vamos a configurar gobetween, para ello nos basamos en el archivo de configuración de `/snap/gobetween/current/config/gobetween.toml`, y creamos el fichero de configuración `/snap/gobetween/gobetween_config.toml`:

![](./img/gobet_3.png)

Hemos dejado los parámetros por defecto que venían (defaults) y las métricas activadas, ya que esta configuración ya venía realizada en la configuración de ejemplo. Las opciones de healthcheck se explicarán en el apartado de opciones avanzadas.

Y ahora lanzamos gobetween con la configuración establecida indicando el fichero. COmo vemos, no tenemos permiso de escucha para el puerto 80, y nos lanza este error:

![](./img/gobet_4.png)

Probamos de nuevo con sudo:

![](./img/gobet_5.png)

Y comprobamos que funciona:

![](./img/gobet_6.png)

### Opciones avanzadas

Además de roundrobin, se puede usar IP-hash:

![](./img/gobet_7.png)

O menor número de conexiones:

![](./img/gobet_8.png)

Y por ponderación:

![](./img/gobet_9.png)

Adicionalmente, se ha configurado el último bloque, `healthcheck`, que comprueba el estado de los servidores mediante ping (pues se ha configurado con este método) cada 2 segundos, y debe llegar una respuesta antes de 500ms. Si esta respuesta no llegara, como se ha perdido una respuesta (parámetro fails está a 1), el servidor se considera caído (down), y se marcará de nuevo como operativo cuando llegue una respuesta de un ping (parámetro passes está a 1).

En este caso, como gobetween no es un servicio, no hace falta desactivar que se lance automáticamente al encender la máquina virtual.

## Zevenet

Para configurar Zevenet, vamos a instalar una iso, que descargamos de https://es.zevenet.com/productos/comunidad/#repository .

Comenzamos creando una nueva máquina virtual, de nuevo con 1GB de RAM, 10GB de disco duro dinámico y añadimos el adaptador de red solo-anfitrión antes de iniciar la máquina, de modo que detecte tanto el adaptador NAT como el solo-anfitrión automáticamente.

Al instalarlo, lo hacemos en español de España seleccionando el teclado español.

![](./img/zev_1.png)

Seleccionamos el segundo adaptador de red:

![](./img/zev_2.png)

Y añadimos la IP de la máquina:

![](./img/zev_3.png)

Dejamos la netmask y gateway por defecto, así como el nameserver.

Como hostname uso mi usuario de la ugr:

![](./img/zev_4.png)

Y dejo el domain name en blanco. Como contraseña uso Swap1234:

![](./img/zev_5.png)

Elegimos la hora de la península y luego elegimos instalación guiada utilizando todo el disco.

![](./img/zev_6.png)

Dejamos todo por defecto y la configuración con todas las particiones juntas.

![](./img/zev_7.png)

Instalamos el grub en las particiones y completamos la instalación.

![](./img/zev_8.png)

Y comprobamos que funciona

![](./img/zev_9.png)

Accedemos ahora a la dirección 192.168.56.104 por el puerto 444, donde nos identificamos con el usuario y contraseña establecida:

![](./img/zev_11.png)

Y así llegamos al dashboard

![](./img/zev_12.png)

En Network->NIC comprobamos y configuramos las redes para que quede así:

![](./img/zev_13.png)

Ahora en LSLB-> Farms creamos una nueva granja de red como sigue:

![](./img/zev_14.png)

![](./img/zev_15.png)


Si le damos a editar podemos ver las opciones avanzadas:

![](./img/zev_16.png)

Finalmente añadimos el servicio "swap" con los backends m1 y m2:

![](./img/zev_17.png)

Y comprobamos que funciona:

![](./img/zev_18.png)

### Opciones avanzadas

Como opciones avanzadas podemos configurar el timeout de los backend de forma independiente, como ya hemos visto, así como asignar pesos:

![](./img/zev_19.png)

Al hacer los cambios le damos al botón de restart de la granja y comprobamos que ya funciona.

También se puede configurar la persistencia por sesiones durante un tiempo máximo y comprobaciones del estado de los backend:

![](./img/zev_20.png)

## Pound

Tras asegurarnos de que ninguno de los otros softwares usados está en marcha, descargamos pound, para ello vamos a ejecutar:

```
sudo apt-get update
sudo apt-get install pound
```

![](./img/pound_1.png)

Y comprobamos que está funcionando con `sudo systemctl status pound`.

Vamos a editar el fichero de configuración `/etc/pound/pound.cfg`:

![](./img/pound_2.png)

Y relanzamos el servicio con `sudo systemctl restart pound` y comprobamos que funciona:

Pero no funciona, comprobamos el estado con `sudo systemctl status pound` y nos sale un mensaje diciendo que configuremos `startup=1` en `/etc/default/pound`:

![](./img/pound_3.png)

Accedemos a `/etc/default/pound` y lo editamos:

![](./img/pound_4.png)

Tras esto relanzamos el servicio y comprobamos que ahora sí funciona, y al haber establecido las prioridades con m1 el doble de m2, tenemos que m1 recibe el doble de peticiones que m2.

### Opciones avanzadas

Podemos añadir, por ejemplo, a las directibas globales `TimeOut`, que es el tiempo que se espera una respuesta del backend.

https://linux.die.net/man/8/pound

xHTTP define los verbos HTTP que se aceptan.

Además, si usamos Emergency, el servidor solo se usará cuando el resto de servidores fallen:

Editamos el fichero de configuración con estas opciones:

![](./img/pound_5.png)

![](./img/pound_6.png)

Relanzamos el servicio y vemos que ahora solo nos atiende m1.

Además, al igual que en los otros sistemas hay algo similar a la ip hash, para que las peticiones de la misma ip las atienda la misma máquina en un margen de tiempo.

![](./img/pound_7.png)

Y relanzando comprobamos que siempre nos atiende la misma máquina.

Finalmente, y como con nginx y haproxy, se desactiva que se lance al inicio para evitar problemas por usar todos los servicios el mismo puerto con `sudo systemctl disable pound`.


## Someter la granja web a una carga

Comenzamos instalando apache benchmark en la máquina anfitriona con el comando `sudo apt-get install -y apache2-utils`:

![](./bench_1.png)

Ahora, lanzamos nginx y lo configuramos con roundrobin, como antes.

Lanzamos el benchmark, con 10000 peticiones con concurrencia 10:

`ab -n 10000 -c 10 http://192.168.56.103/index.html`

Obtenemos la siguiente información:

![](./img/bench_2.png)

![](./img/bench_3.png)

Donde lo mas relevante son las peticiones por segundo, que es lo que vamos a comparar.

Lanzamos este mismo benchmark a todos los servidores, con round-robin y ponderación, considerando que m1 tiene el doble de capacidad que m2.

|  Balanceador    |   Modo          |  Peticiones/s    |  Longest request (ms)  |
| --------------- | --------------- | ---------------- | ----------------- |
|  nginx          |  round-robin    |   1101.41        |  29   |
|  nginx          |  ponderación    |   1035.80        |  46   |
|  haproxy        |  round-robin    |   1018.19        |  31   |
|  haproxy        |  ponderación    |   1001.13        |  42   |
|  gobetween      |  round-robin    |    853.46        |  39   |
|  gobetween      |  ponderación    |    857.36        |  44   |
|  zevenet        |  round-robin    |    933.23        |  42   |
|  zevenet        |  ponderación    |    967.92        |  51   |
|  pound          |  round-robin    |    742.90        |  132  |
|  pound          |  ponderación    |    733.41        |  121  |







