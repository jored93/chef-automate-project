# Instalar WP CLI
remote_file '/tmp/wp' do
  source 'https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Asegurarse de que el directorio wp-content tiene los permisos correctos
directory '/opt/wordpress/wp-content/' do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  recursive true
  action :create
end

# Asegurarse de que el directorio upgrade existe y tiene los permisos correctos
directory '/opt/wordpress/wp-content/upgrade/' do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  recursive true
  action :create
end

# Asegurarse de que el directorio languages existe y tiene los permisos correctos
directory '/opt/wordpress/wp-content/languages/' do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  recursive true
  action :create
end

# Mover WP CLI a /bin
execute 'Move WP CLI' do
  command 'mv /tmp/wp /bin/wp'
  not_if { ::File.exist?('/bin/wp') }
end

# Hacer WP CLI ejecutable
file '/bin/wp' do
  mode '0755'
end

# Instalar Wordpress y configurar
execute 'Finish Wordpress installation' do
  command 'sudo -u vagrant -i -- wp core install --path=/opt/wordpress/ --url=http://192.168.56.2 --title="EPNEWMAN - Herramientas de automatización de despliegues" --admin_user=admin --admin_password="Epnewman123" --admin_email=admin@epnewman.edu.pe'
  not_if 'wp core is-installed --path=/opt/wordpress/', environment: { 'PATH' => '/bin:/usr/bin:/usr/local/bin' }
end

# Instalar el paquete de idioma español
execute 'Install Spanish language pack' do
  command 'sudo -u vagrant -i -- wp language core install es_ES --path=/opt/wordpress/ --allow-root'
  not_if 'wp language core is-installed es_ES --path=/opt/wordpress/', environment: { 'PATH' => '/bin:/usr/bin:/usr/local/bin' }
end

# Activar el idioma español
execute 'Activate Spanish language' do
  command 'sudo -u vagrant -i -- wp language core activate es_ES --path=/opt/wordpress/ --allow-root'
  not_if 'wp option get blog_charset --path=/opt/wordpress/ | grep -q "es_ES"', environment: { 'PATH' => '/bin:/usr/bin:/usr/local/bin' }
end