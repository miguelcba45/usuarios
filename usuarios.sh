#! /bin/bash
clear
echo "   #################################################################"
echo "   #################################################################"
echo "   ############################ REGISTRO ###########################"
echo "   ############################  NUEVO   ###########################"
echo "   ############################ USUARIO  ###########################"
echo "   #################################################################"
echo "   #################################################################"
echo "   _________________________________________________________________"
echo "                                                                    "
#lectura del Usuario
read -p "Introduce el nuevo Usuario: " nombre
echo "________________________________________________"
echo "________________________________________________"
echo "________________________________________________"
echo "________________________________________________"
echo "________________________________________________"
echo "________________________________________________"
echo " introduce una la direccion web de tu servidor"

read -p "Introduce dirección Web: " web

#creacion de usuario
mkdir /home/ftp/$nombre
chmod 755 /home/ftp/$nombre
mkdir /home/ftp/$nombre/pag
chmod 755 /home/ftp/$nombre/pag
touch /home/ftp/$nombre/index.html
echo "<META HTTP-EQUIV='REFRESH' CONTENT='1;URL=http://150.186.39.9/$nombre/pag'>" >> /home/ftp/$nombre/index.html
echo "<html><body>" >> /home/ftp/$nombre/index.html
echo "</body></html>" >> /home/ftp/$nombre/index.html
useradd -g ftp -s /bin/fake -d /home/ftp/$nombre $nombre
echo "Introduzca su Contraseña"
passwd $nombre
chown $nombre:ftp /home/ftp/$nombre/pag

#se crea el enlace simbolico
ln -s /home/ftp/$nombre /var/www

#configuracion del archivo sshd
echo "# Usuario ======= $nombre" >> /etc/ssh/sshd_config
echo "Match user $nombre" >> /etc/ssh/sshd_config
echo "		ChrootDirectory /home/ftp/$nombre" >> /etc/ssh/sshd_config
echo "		ForceCommand internal-sftp" >> /etc/ssh/sshd_config
/etc/init.d/ssh restart
echo "Usuario Creado"
echo "¡FELICIDADES!"



