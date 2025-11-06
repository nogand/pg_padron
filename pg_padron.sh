#!/bin/bash
# Asume que existe una base de datos vacía que se llama padrón y el usuario actual, llamado admin, tiene acceso a ella.
# No tiene nada de control de errores, en este momento.
# Requiere que estén instalados wget, unzip, iconv y fromdos
# Asume que awk es gawk
psql < esquema.sql
wget https://tse.go.cr/zip/padron/padron_completo.zip
unzip padron_completo.zip
iconv -f iso-8859-1 -t utf-8 -o distelec.txt.utf8 distelec.txt
iconv -f iso-8859-1 -t utf-8 -o PADRON_COMPLETO.txt.utf8 PADRON_COMPLETO.txt
fromdos distelec.txt.utf8
fromdos PADRON_COMPLETO.txt.utf8
awk -f ./separardist.awk distelec.txt.utf8
awk -f prepararpersonas.awk PADRON_COMPLETO.txt.utf8
psql padron <<eow
\copy provincia FROM './provincias.txt' CSV ;
\copy canton FROM './cantones.txt' CSV ;
\copy distrito FROM './distritos.txt' CSV;
\copy ciudadano FROM './personas.txt' CSV;
eow
