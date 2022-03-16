# Práctica 2

> Por: Mapachana

## Copiar archivos locales en equipos remotos

Vamos a comenzar enviando el directorio con `tar`, de forma simple. Comenzamos creando el directorio con un archivo.

![](./img/enviar_1.png)
![](./img/enviar_2.png)

Y mandamos el directorio con tar. Como ya configuramos el acceso por ssh sin contraseña no nos la pide.

![](./img/enviar_3.png)

Finalmente descomprimimos y comprobamos que se ha mandado correctamente.

![](./img/enviar_5.png)

### Mediante tar y scp

Ahora vamos a enviarlo mediante tar y scp:

Creamos el tar y lo mandamos mediante scp:

![](./img/enviar_6.png)

Comprobamos que en la máquina 2 se encuentra directorio2:

![](./img/enviar_7.png)

### Comandos avanzados

Vamos a enviar el directorio esta vez usando scp y algunas opciones de scp.

Comenzamos son `-r`, que copia recursivamente directorios enteros, y `-v` nos da información de la copia y de ssh. Como vemos muestra mucha información.

![](./img/enviar_8.png)
![](./img/enviar_9.png)

Finalmente comprobamos que se ha copiado bien:

![](./img/enviar_10.png)

También podemos usar la opción `-q` que desactiva que se muestren mensajes por si se mandan muchos archivos.

![](./img/enviar_11.png)
![](./img/enviar_12.png)

Finalmente, con `-P` podemos indicar el puerto. Por ejemplo de m2 a m1:

![](./img/enviar_13.png)
![](./img/enviar_14.png)

## Utilizar Rsync

Rsync ya está instalado en ambas máquinas, comprobamos su versión:

![](./img/rsync_1.png)

Ejecutamos chown para cambiar el propietario de la carpeta `var/www/`.

![](./img/rsync_2.png)

Y ejecutamos rsync en `m1`, para copiar los archivos a `m2`:

![](./img/rsync_4.png)






