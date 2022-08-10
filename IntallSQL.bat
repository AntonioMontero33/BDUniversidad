echo Instalador de la Base de datos Universidad
echo Autor: Jose Antonio Montero
echo Fecha: 08 de Agosto del 2022

sqlcmd -S. -E -i BDUniversidad.sql
sqlcmd -S. -E -i BDUniversidadPA.sql

echo Se ejecuto correctamente la base de datos
pause