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

Las opciones usadas son `-a`, que indica recursividad (archive), `-e` especifica el shell remoto que se va a utilizar, `-v` es verbose, para dar más información y `-z` para comprimir los archivos durante la trasnferencia.

### Opciones avanzadas

Como opciones avanzadas vamos a usar `--stats`, que nos muestra estadísticas, `--exclude`, para excluir carpetas o directorios, `--delete`, para borrar en la máquina destino los ficheros borrados de la máquina origen y `--dry-run`, que permite a rsync hacer un "clonado de prueba", de forma que podemos ver lo que se va a clonar pero sin llegar a efectuarse la copia.

Comenzamos creando un directorio de prueba a clonar desde m1 a m2:

![](./img/rsync_a1.png)

Comenzamos realizando una prueba de lo que sería la copia con `--dry-run`:

![](./img/rsync_a2.png)

Así, comprobamos que en efecto se va a mandar lo que queremos, pero todavía no hemos clonado nada, como podemos comprobar en la máquina m2:

![](./img/rsync_a3.png)

Ahora sí, procedemos a realizar el envío quitando la opción `--dry-run`:

![](./img/rsync_a4.png)
![](./img/rsync_a5.png)

Es claro que el argumento `--exclude` ha evitado que se copie el directorio `nomandar`.

Finalmente, probamos a eliminar el fichero `fichero1.txt` y repetir el clonado, comprobando así que la opción `--delete` lo elimina en `m2` también:

![](./img/rsync_a6.png)
![](./img/rsync_a7.png)

## Acceso mediante ssh sin contraseña

El acceso por ssh sin introducir la contraseña manualmente ya se configuró en la práctica anterior.

Para ello, generamos en cada máquina una clave pública y privada, con `ssh-keygen`.

![](./img/ssh_1.png)

Después compartimos las claves públicas de una máquina a otra con `ssh-copy-id -p 2022 anabuenrua@192.168.56.101` (de m2 a m1) y `ssh-copy-id anabuenrua@192.168.56.102` (de m1 a m2).

![](./img/ssh_2.png)

### Opciones avanzadas

Cuando se realizó, se dejaron todas las opciones por defecto, pero se pueden usar algunos argumentos para modificar el comportamiento:

- `-t`: Especifica el tipo de clave que se va a generar, por ejemplo rsa.
- `-b`: Indica el número de bits en la clave, por defecto es 2048.
- `-f`: Especifica el archivo de la clave.
- `-l`: No se usa al generar las claves, si no que se usa para ver el fingerprint de una clave pública.
- `-v`: Verbose.

`ssh-keygen -t rsa -b 4096`

![](./img/ssh_3,png)

Si al generar la clave no usamos la ruta por defecto, para mandarla con `ssh-copy-id` debemos especificar la ruta de la clave pública con `-i`, al igual que al acceder se especifica la de la clave privada con `-i` en `ssh`.

### Copia de clave manual

Comenzamos en m2, accediendo a `~/.ssh/authorized_keys`, donde está escrita la clave pública de `m1`. Editamos este fichero con nano borrandolo y comprobamos que ahora para acceder a m2 desde m1 nos pide contraseña:

![](./img/ssh_4.png)
![](./img/ssh_5.png)

Para volver a tener acceso sin contraseña, vamos a mandar nuestra clave pública a m2. Para ello copiamos la clave pública que se encuentra en `~/.ssh/id_rsa.pub` de m1 mediante `scp` en el archivo `~/.ssh/authorized_keys` de m2:

![](./img/ssh_6.png)
![](./img/ssh_7.png)

Finalmente comprobamos que nos podemos conectar de m1 a m2 sin contraseña de nuevo:

![](./img/ssh_8.png)










