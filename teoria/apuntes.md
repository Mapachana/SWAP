# Apuntes de SWAP

> Por: Mapachana

## Tema 1: Introducción.

### Brainstorming: ¿Qué problemas podemos encontrar?

- Que los usuarios se conecten.
- Disponibilidad.
- Mantenimiento del hardware.
- Seguridad.
- Sistema tolerante a fallos.

### 1.Introducción

Supongamos que nos encargan el despliegue de un servidor web de una empresa... hay que comparar el trabajo inicial de configuración vs el trabajo de mantenimiento.

#### 1.1 Historia
En los años 90:

- Los servidores Intel/AMD son baratos.
- Cada servidor tiene un sistema operativo diferente.
- **Un** sistema operativo y **una** aplicación en cada servidor.
- 2 servidores pasan a ser 6, quizás 50 o más servidores.
- El **espacio**, la **refrigeración** (aire acondicionado, por ejemplo) y la **alimentación** se convierten en un problema.

![](./img/t1/1.png)

En los años 2000 en adelante:

- Los fabricantes "al rescate".
- Se centran en crear servidores más pequeños.
- Reducen el tamaño de los chassis (6-20 servers por rack).
- Crean los servidores "Blade" (30-60 servidores por rack).
- Problema de espacio solucionado más o menos.
- La **alimentación** y la **refrigeración** siguen siendo un problema (consumo eléctrico para la alimentación y refrigeración).

![](./img/t1/2.png)

#### 1.2 Centros de Procesamiento de Datos (CPD)

Un Centro de Procesamiento de Datos (CPD) es una ubicación donde se concentran los recursos necesarios para el procesamiento de la información de una organización.

- Normativas TIA 942, ISO 27001, EN 1047-2, ISO14644, ASHRAE,
Uptime Institute, 24 7.
- Características:
  - **Armarios**.
  - **Infraestructura interior**.
  - **Sistema de alimentación**.
  - **Ventilación**.
  - **Cableado**: Se usa un falso suelo para poner el cableado.
  - **Refrigeración**: Se usa el falso suelo y los armarios unos frente a otros para crear corrientes de aire para ventilar. Desde el suelo se manda aire frío y los ventiladores de los pcs están mirando al mismo pasillo. Así se forman pasillos fríos y pasillos calientes.
  - Los **datos** están aparte en como una caja cerrada hermética, donde se mete un gas y así en caso de incendio no se pierden los datos.
  

![](./img/t1/3.png)

El consumo (Green IT):
  
- Prácticamente el consumo de un CPD proviene del consumo del equipamiento del CPD y la climatización.
  - 38-63% corresponde a los sistemas (servidores y equipos.
  - 23-54% corresponde a la refrigeración.
  - 6-13% a los sistemas complementarios (sistemas electrógenos, sistemas de alimentación ininterrumpida).
  - 1-2% iluminación.

![](./img/t1/4.png)

_Tecnologías verdes son aquellas que contribuyen a la reducción en el consumo de energía o emisión de dióxido de carbono._

- Consumo (Green IT): Reducir consumo equipamiento.
  - Optimización del consumo energético generado por los propios servidores y sistemas instalados.
    - Técnicas de virtualización:
      - Virtualización.
      - Consolidación de servidores.
    - Técnicas de utilización dinámica de recursos:
      - Herramientas de red.
      - Tecnologías GRID.
      - El modelo cloud (cloud computing).
        - Modelo de servicios (SaaS, PaaS, IaaS).
  
#### 1.3 Virtualización

Consumo (Green IT). Sirve para reducir el consumo del equipamiento.

Creación a través de software de una evrsión virtual de algún recurso tecnológico (plataforma de hardware, un sistema operativo, un dispositivo de almacenamiento, etc).

![](./img/t1/5.png)

Por ejemplo te cobran 10€ por usar el servidor 1 hora, si necesitas dos servidores son 20€ (cloud computing) (Esto lo he apuntado rapidillo igual está mal).

![](./img/t1/6.png)

Tipos:

- **Virtualización de plataformas**: Consiste en preparar un sistema operativo de los recursos de la plataforma subyacente.
  - Virtualización nativa o completa.
  - Para-virtualización.
  - Virtualización a nivel de sistema operativo.
  - Virtualización de aplicaciones.
- **Virtualización de recursos**: Consiste en la virtualización de recursos específicos del sistema, como la memoria virtual, el almacenamiento virrtual.
  - Memoria virtual.
  - Almacenamiento NAS.
  - Almacenamiento SAN.


Algunos software de virtualización son VMWare, VirtualBox, Parallels, etc.

##### 1.3.1 Consolidación de servidores

La consolidación de servidores es la reestructuración de la infraestructura del CPD con el fin de reducir costes y mejorar el control mediante la optimización de lso requisitos de recursos.

Varias máquinas se comportan como una, como azure.

![](./img/t1/7.png)

#### 1.4 Técnicas de utilización dinámica de recursos: El modelo Cloud (Cloud computing)

- Modelo de prestación de servicios de negocio y tecnología, que permite al usuario acceder a un catálogo de servicios estandarizado y responder a las necesidades del negocio, de forma flexible y adaptativa, pagando únicamente por el consumo efectuado.
- Modelo que proporciona de manera conveniente acceso por demanda a un conjunto compartido y configurable de recursos informáticos (redes, servidores, almacenamiento, aplicaciones, etc) que pueden ser rápidamente dispuestos con un esfuerzo mínimo por parte del proveedor de estos recursos.

##### 1.4.1 Ventajas
- **Reducción de costes**:
  - Infraestructura.
  - Licencias de software.
  - Energía.
  - Personal.
- **Gestión**:
  - Menos incidentes.
  - Actualizaciones de software.
  - Automatización en gestión.
- **Prestaciones**:
  - Adaptación elástica.
  - Capacidad de almacenamiento ilimitada.
  - Disponibilidad.

##### 1.4.2 Desventajas
- **Conexión constante**.
- Puede ser **lento**.
- **Privacidad**.

![](./img/t1/8.png)

---

La utilización dinámica de recursos consiste en acceso por demanda a un conjunto compartido y configurable de recursos informáticos. Es el modelo de negocio cloud.

- **SaaS**
  - Software as a Service.
  - Pagas por usar un software.
- **PaaS**
  - Platform as a Service.
  - Pagas por usar un entorno de desarrollo.
- **IaaS**
  - Infraestructure as a Service.
  - Pagas por usar una infraestructura.

![](./img/t1/9.png)

#### 1.5 Arquitectura de servicio

- Sistema aislado. (Cuarta imagen)
- Arquitectura cliente servidor. (Primera imagen)
- Arquitectura de n capas. (Segunda imagen)
- Arquitectura cliente-cola-cliente. (Tercera imagen)

Nota: Nos referimos a las imágenes de izquierda a derecha.

![](./img/t1/10.png)

Posibles aproximaciones para servidor web:

- Montar un servidor en una máquina.
- Adquirir un segundo servidor para desarrollo.
- Adquirir un segundo servidor para sustituir al principal en caso de desastre.
- Montar una granja web.

![](./img/t1/11.png)

### 2. Conceptos básicos

Una **granja web** es un conjunto de servidores dedicados a servir contenido web a los usuarios finales.

Algunos de esos servidores servirán contenido estático, otros actuarán como servidores de bases de datos, otros para aplicaciones dinámicas, etc.

![](./img/t1/12.png)

En cada uno de esos grupos de máquinas se puede instalar diferente tipo de aplicaciones y/o versiones:

- apache.
- nginx.
- thttpd.
- Cherokee.
- node.js

Cada uno de esos es más eficiente para un tipo de servicios.

Son sistemas muy complejos pero sumamente flexibles y funcionales.

En muchos casos, una granja web albergará muchos sitios web:

- correspondientes a varias empresas.
- servicios bien diferenciados de una empresa.

Estos sistemas resuelven los problemas de sistemas más simples para dar servicio a un alto número de usuarios.

![](./img/t1/13.png)
![](./img/t1/14.png)

Al usar varias máquinas va a ser escalable. Los muros representan firewalls, luego algo para distribuir la carga (tridente), servidores web de configuracuón de web (con bolas del mundo) y servidores de datos.

### 3. Un sitio web mal planificado

#### 3.1 Introducción

Cuando nos encargan el desarrollo de un sitio web, inicialmente se suelen instalar todos los servicios en una sola máquina.

Es la opción más rápida y barata.

Si no hay muchos usuario (poco tráfico), funcionará.

Solo hace falta una máquina con el sistema operativo bien configurado, una aplicación de servidor web, y una conexión a internet.

Ese sitio, con esa configuración tan simple, no tardará en experimentar problemas conforme se icnremente el tráfico de red (peticiones).

Un problema puede sobrevenir por el uso de un almacenamiento de datos inadecuado (no usar bases de datos bien configuradas), que redunda en una falta de escalabilidad.

Primera aproximación:

- Montar un servidor en una máquina.
  - Ventaja: Fácil y rápido.
  - Desventaja: Necesitará más trabajo de mantenimiento tarde o temprano, tendremos problemas.

Las tareas derivadas de problemas hardware y sofwtare, para dar el servicio adecuado, acaba siendo un trabajo demasiado costoso en un sistema mal planificado.

Surge la necesidad de controlar posibles problemas:

- Con la arquitectura del sistema.
- Con la disponibilidad.
- Con la carga del sistema.

#### 3.2 Problemas de la arquitectura del sistema

En muchos sitios, una máquina servidora ofrece todos los servicios, conectada directamente a internet.

Comúnmente se pone en marcha sin cortafuegos adecuado.

Algunos servicios son para uso de los empleados, por lo que sobrecargan al servidor (que no dará buen servicio a los usuarios externos).

Riesgo de seguridad.

Modificaciones directamente en el servidor de producción.

#### 3.3 Problemas con la disponibilidad

Conforme los usuarios usan un sistema, los errores derivados de la programación van apareciendo.

Además, suelen solicitar mejoras o ampliaciones del sistema.

Arreglar esos errores puede resultar complicado: los retoques del código o quitar servicios pueden suponer nuevos errores más adelante.

Las actualizaciones del SO, de aplicaciones o servicios pueden afectar al rendimiento global.

Los cambios van directamente al servidor de producción.

Una posible solución es comprar una segunda máquina para desarrollo.

- Adquirir una segunda máquina para desarrollo:
  - Ventajas:
    - Las mejoras en software se pueden probar en la máquina de desarrollo antes de pasarlas al servidor de producción.
  - Desventajas:
    - Trabajo extra.
    - Coste de adquisición.
    - No se resuelven los problemas derivados de un alto tráfico.

![](./img/t1/15.png)

Tarde o temprano el hardware falla. Una posible solución es tener una máquina servidor replicada, lo que se llama **cold spare server**.

- Cold spare server:
  - Desventajas:
    - Hay que tenerla actualizada (programas y datos).
    - Requiere esfuerzo y coste de adquisición.

![](./img/t1/16.png)

Otra posible solución es adquirir un servidor para sustituir el principal en caso de desastre.

- Adquirir otro servidor para sustituir al principal:
  - Ventajas.
    - En caso de desastre grave, se puede sustituir el servidor principal por el secundario y continuar trabajando.
  - Desventajas.
    - No se resuelven los problemas derivados de alto tráfico.

Otra vez, ni siquiera actualizando el hardware del servidor de producción se podrá hacer frente a ciertos niveles de tráfico o carga.

#### 3.4 Problemas con la carga del sistema

Un sitio con poco tráfico funcionará con una sola máquina.

Ante un incremento del número de accesos, el hardware y software comenzarán a fallar.

Los recursos se verán sobreutilizados (uso de CPU por encima del 90%, uso de almacenamiento y de toda la memoria).

Los elementos hardware que primero suelen fallar son las fuentes de alimentación y los discos duros.

Una posible solución es configurar varias máquinas, dedicando una a cada aservicio que se esté ofreciendo.

- Configurar varias máquinas, una por servicio:
  - Ventajas:
    - Un fallo en una solo afecta a ese servicio.
  - Desventajas:
    - Aún así, el sitio no es escalable (no podrá dar soporte a un número creciente de usuarios para cierto servicio).

Aclaración: Si solo hay una máquina por servicio no es escalable.

![](./img/t1/17.png)

##### 3.4.1 Escalabilidad

La escalabilidad es la capacidad para dar soporte a un número creciente de usuarios.

Tanto el hardware y software de los servidores, pero sobre todo la estructura, organización y configuración de la red deben estar preparados para añadir recursos según sean necesarios.

- Tipos de escalabilidad:
  - **Escalabilidad vertical**: Mejorar el hardware metiedno más RAM u otros componentes similares a una máquina.
  - **Escalabilidad horizontal**: Meter más máquinas al mismo servicio.

#### 3.5 Solución final

Cuando los cambios de vuelven inmanejables, solo queda reestructurar todo el sistema.

No merece la pena parchear el sistema a varios niveles.

Supone una inversión continua en tiempo y dinero.

Importante analizar las necesidades y hacer unas buenas especificaciones -> capacity planning, modelos analíticos.

### 4. Un sitio web de éxito.

Según lo comentado, la estructura general para montar una granja web que escale correctamente sería:

![](./img/t1/18.png)
![](./img/t1/13.png)

Complejidad mayor que los sistemas basados en máquinas simples.

- Montar una granja web:
  - Ventajas:
    - Escalable
    - Con alta disponibilidad
  - Desventajas:
    - Complejidad en la instalación y configuración

En aquellos casos en que haya que hacer frente a un alto tráfico de red y dar servicio a millones de usuarios, es la mejor solución.

En la planificación deberemos tener en cuenta:

- Siempre habrá puntos débiles.
- Siempre habrá gente que ataque los puntos débiles.
- El tipo de red es fundamental (ancho de banda).
- La seguridad es muy importante.


