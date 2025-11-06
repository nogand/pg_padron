# pg_padron

Script de shell y archivos auxiliares para descargar el padrón eletoral completo del TSE y meter la información en una BDD PostgreSQL.


Asume que existe una base de datos vacía que se llama padrón y el usuario actual, llamado admin, tiene acceso a ella.

Si se quiere otro nombre para la base de datos o el usuario, hay que editar el archivo esquema.sql y pg_padron.sh para reflejar los cambios.

Requiere que estén instalados wget, unzip, iconv y fromdos
