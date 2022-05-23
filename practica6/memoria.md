# Práctica 6

> Por: Mapachana

## Instalación de la máquina virtual

Para realizar la práctica creamos la máquina virtual NFS-anabuenrua, que tendrá, al igual que las otras, 1GB de RAM y 10GB de disco duro dinámico. Introducimos los datos:

![](./img/instal_1.png)

Ahora asignamos una IP estática a nfs-anabuenrua, se ha escogido 192.168.56.105 editando /etc/netplan/00-installer-config.yaml.

![](./img/instal_2.png)

Hacemos los cambios efectivos ejecutando sudo netplan apply y comprobamos que hay conexión.

![](./img/instal_3.png)

## Configurar servidor disco NFS

Comenzamos la práctica trabajando en nfs-anabuenrua. Primero instalamos las herramientas básicas que vamos a necesitar

![](./img/config_1.png)

Ahora creamos la carpeta /datos/compartido donde vamos a tener los ficheros que se van a compartir entre las máquinas virtuales, cambiamos su propietario y grupo y asignamos permisos.

![](./img/config_2.png)
![](./img/config_3.png)

A continuación editamos /etc/exports para dar permiso de acceso a m1 y m2.

![](./img/config_4.png)

Finalmente relanzamos el servicio y comprobamos su estado

![](./img/config_5.png)

Ahora vamos a configurar m1 y m2. Para no ser repetitivo, se va a realizar y mostrar la configuración solamente en m1, ya que en m2 se haría la misma.

Comenzamos instalando las herramientas que vamos a usar

![](./img/config_6.png)

A continuación creamos el punto de montaje datos en /home/anabuenrua, le asignamos los permisos y montamos la carpeta remota.

![](./img/config_7.png)


### Opciones avanzadas

Para comenzar, vamos a hacer que el montaje de la carpeta remota se realice de forma automática al arrancar la máquina virtual. Para ello, vamos a editar el fichero /etc/fstab añadiendo la línea

como se muestra.

![](./img/config_8.png)

## Seguridad en NFS

### Opciones avanzadas
