#!/bin/bash

#2d deskripsi berdasarkan jam dibuatnya file di argumen
filename=$( echo $1 | sed 's/\.txt//g' )
encrypted=$filename.txt

upper='A-Z'
lower='a-z'

hour=$( date -r $encrypted +"%H" )
case "$hour" in
	00);; 
        01)filename=$( echo $filename | tr 'b-za' $lower | tr 'B-ZA' $upper );;
        02)filename=$( echo $filename | tr 'c-za-b' $lower | tr 'C-ZA-B' $upper );;
        03)filename=$( echo $filename | tr 'd-za-c' $lower | tr 'D-ZA-C' $upper );;
        04)filename=$( echo $filename | tr 'e-za-d' $lower | tr 'E-ZA-D' $upper );;
        05)filename=$( echo $filename | tr 'f-za-e' $lower | tr 'F-ZA-E' $upper );;
        06)filename=$( echo $filename | tr 'g-za-f' $lower | tr 'G-ZA-F' $upper );;
        07)filename=$( echo $filename | tr 'h-za-g' $lower | tr 'H-ZA-G' $upper );;
        08)filename=$( echo $filename | tr 'i-za-h' $lower | tr 'I-ZA-H' $upper );;
        09)filename=$( echo $filename | tr 'j-za-i' $lower | tr 'J-ZA-I' $upper );;
        10)filename=$( echo $filename | tr 'k-za-j' $lower | tr 'K-ZA-J' $upper );;
        11)filename=$( echo $filename | tr 'l-za-k' $lower | tr 'L-ZA-K' $upper );;
        12)filename=$( echo $filename | tr 'm-za-l' $lower | tr 'M-ZA-L' $upper );;
        13)filename=$( echo $filename | tr 'n-za-m' $lower | tr 'N-ZA-M' $upper );;
        14)filename=$( echo $filename | tr 'o-za-n' $lower | tr 'O-ZA-N' $upper );;
        15)filename=$( echo $filename | tr 'p-za-o' $lower | tr 'P-ZA-O' $upper );;
        16)filename=$( echo $filename | tr 'q-za-p' $lower | tr 'Q-ZA-P' $upper );;
        17)filename=$( echo $filename | tr 'r-za-q' $lower | tr 'R-ZA-Q' $upper );;
        18)filename=$( echo $filename | tr 's-za-r' $lower | tr 'S-ZA-R' $upper );;
        19)filename=$( echo $filename | tr 't-za-s' $lower | tr 'T-ZA-S' $upper );;
        20)filename=$( echo $filename | tr 'u-za-t' $lower | tr 'U-ZA-T' $upper );;
        21)filename=$( echo $filename | tr 'v-za-u' $lower | tr 'V-ZA-U' $upper );;
        22)filename=$( echo $filename | tr 'w-za-v' $lower | tr 'W-ZA-V' $upper );;
        23)filename=$( echo $filename | tr 'x-za-w' $lower | tr 'X-ZA-W' $upper );;
esac

mv $encrypted $filename.txt
