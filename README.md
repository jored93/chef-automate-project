# Actividad: Instalación completa de WordPress con Chef y pruebas unitarias y de integración


## Requisitos en Ubuntu/Debian

  ```bash
  sudo apt-get update
  ```
  
  1. Instalar vagrant:
  ```bash
  sudo apt-get install vagrant
  ```

  2. Instalar Ruby on Rails:
  ```bash
  sudo apt-get install ruby-full
  ```

  3. Instalar plugins:
  ```bash
  vagrant plugin install vagrant-env
  ```
  ```bash
  gem install serverspec
  ```

## Iniciar las VM

```bash
 vagrant up
```

## Wordpress con Ubuntu y MySQL con CentOS:

```bash
 vagrant up wordpress
 BOX_NAME="generic/centos8" vagrant up database
```

## Wordpress con CentOS y MySQL con Ubuntu:

```bash
 BOX_NAME="generic/centos8" vagrant up wordpress
 vagrant up database
```

## Unit tests

Para ejecutar las pruebas unitarias usa el script `tests.sh` alojado en la carpeta UniTest si estás en Linux o Mac.

```bash
 UnitTest/tests.sh
 Seleccione una opción:
 1. UnitTest en Máquina Virtual (VM)
 2. UnitTest en Docker
 3. UnitTest de integración e infraestructura
 4. Exit
 Opción: 
```

Si deseas ejecutar una a una las pruebas de integración e infraestructura entonces envíale el nombre de la receta al script `tests.sh`:

```bash
 # UnitTest base de datos (DB)
 UnitTest/tests.sh database

 # UnitTest Wordpress
 UnitTest/tests.sh wordpress

# UnitTest proxy
 UnitTest/tests.sh proxy
```

# Reference:
 - https://github.com/OscarJimenezFlores/Chef_Vagrant_Wp