# Práctica 1

> Por: Mapachana

## Instalación de las máquinas virtuales

Comenzamos descargando la iso de Ubuntu Server 20.04.4 LTS.

![](./img/descarga_iso.png)


Ahora, abrimos VirtualBox y creamos una nueva máquina virtual pulsando en Nueva.

![](./img/inicio_virtualbox.png)

Ahora, procedemos a crear la primera máquina virtual con 1GB de RAM y 10GB de disco duro dinámico.

![](./img/vm_config_1.png)
![](./img/vm_config_2.png)
![](./img/vm_config_3.png)

Añadimos un disco duro dinámico: 

![](./img/vm_config_4.png)
![](./img/vm_config_5.png)
![](./img/vm_config_6.png)
![](./img/vm_config_7.png)

Ahora añadimos la iso pulsando con clic derecho en configuración y a añadir unidad óptica:

![](./img/vm_config_8.png)
![](./img/vm_config_9.png)

La máquina virtual ya está lista para el arranque.

Procedemos a lanzarla y configuramos la instalación:

Primero seleccionamos el idioma: español.

![](./img/so_config_1.png)

A continuación pulsamos en detectar teclado y nos selecciona la variante española del mismo.

![](./img/so_config_2.png)

Dejamos la configuración por defecto en los siguientes pasos.

![](./img/so_config_3.png)
![](./img/so_config_4.png)
![](./img/so_config_5.png)
![](./img/so_config_8.png)
![](./img/so_config_9.png)
![](./img/so_config_10.png)

Introduzco mi nombre y mi usuario de la ugr con contraseña "Swap1234".

![](./img/so_config_11.png)
![](./img/so_config_12.png)
![](./img/so_config_13.png)
![](./img/so_config_14.png)

Una vez terminada la instalación le damos a reiniciar ahora y comprobamos que en efecto la máquina funciona.

![](./img/so_config_15.png)
![](./img/so_config_16.png)

Repetimos este mismo procedimiento con la otra máquina virtual.

## Configuración de la red

Para disponer de conexión a internet y poder conectar las máquinas entre sí y con el anfitrión vamos a añadir un adaptador de red en modo NAT y otro adaptador de red en solo-anfitrión.

Comenzamos con la red NAT

![](./img/red_1.png)

A continuación, como no tengo configurada la red solo-anfitrión en mi virtual box voy a crear una, en `archivo->Administrador de red anfitrión`:

![](./img/red_3.png)

Y ahora, en nuestra máquina virtual configuramos la red solo-anfitrión:

![](./img/red_2.png)

Arrancamos la máquina virtual para completar la configuración de la red editando el fichero `"/etc/netplan/00-installer-config.yaml"`:

![](./img/red_4.png)

Y, finalmente, ejecutamos el comando `sudo netplan apply` para hacer efectivos los cambios:

![](./img/red_5.png)

Comprobamos con el comando `ip address show` que la configuración se ha realizado correctamente:

![](./img/red_6.png)


## Instalando los programas necesarios

Primero vamos a instalar LAMP, para ello ejecutamos el comando `sudo apt-get install apache2 mysql-server mysql-client`.

![](./img/instalar_1.png)


Comprobamos la versión mediante el comando `apache2 -v` y comprobamos si está en ejecución con `sudo service apache2 status`:

![](./img/instalar_2.png)

Finalmente activamos la cuenta de root mediante el comando `sudo passwd root`:

Repetimos toda esta configuración e instalación en la otra máquina virtual a crear.

