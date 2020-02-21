#!/bin/bash

#2a) script bash untuk menghasilkan password acak 28 karakter up-low-num
password=$( cat  /dev/urandom | tr -dc '[:alnum:]' | fold -w 28 | head -n 1 )

#2b) menyimpan password ke file dg nama sesuai argumen (HANYA alphabets yang akan diolah dari argument)
filename=$( echo $1 | tr -dc '[:alpha:]' )
echo $password > $filename.txt

