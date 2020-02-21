#!/bin/bash

#2c enkripsi berdasarkan jam dibuatnya file di argument
filename=$( echo $1 | sed 's/[[:digit:]]//g' )
filename=$( echo $filename | sed 's/\.txt//g' )

hour=$( date -r $filename.txt +"%H" )
case "$hour" in
	00)encrypted=$filename;; 
        01)encrypted=$( echo $filename | tr [:lower:] 'b-za' | tr [:upper:] 'B-ZA');;
        02)encrypted=$( echo $filename | tr [:lower:] 'c-za-b' | tr [:upper:] 'C-ZA-B' );;
        03)encrypted=$( echo $filename | tr [:lower:] 'd-za-c' | tr [:upper:] 'D-ZA-C' );;
        04)encrypted=$( echo $filename | tr [:lower:] 'e-za-d' | tr [:upper:] 'E-ZA-D' );;
        05)encrypted=$( echo $filename | tr [:lower:] 'f-za-e' | tr [:upper:] 'F-ZA-E' );;
        06)encrypted=$( echo $filename | tr [:lower:] 'g-za-f' | tr [:upper:] 'G-ZA-F' );;
        07)encrypted=$( echo $filename | tr [:lower:] 'h-za-g' | tr [:upper:] 'H-ZA-G' );;
        08)encrypted=$( echo $filename | tr [:lower:] 'i-za-h' | tr [:upper:] 'I-ZA-H' );;
        09)encrypted=$( echo $filename | tr [:lower:] 'j-za-i' | tr [:upper:] 'J-ZA-I' );;
        10)encrypted=$( echo $filename | tr [:lower:] 'k-za-j' | tr [:upper:] 'K-ZA-J' );;
        11)encrypted=$( echo $filename | tr [:lower:] 'l-za-k' | tr [:upper:] 'L-ZA-K' );;
        12)encrypted=$( echo $filename | tr [:lower:] 'm-za-l' | tr [:upper:] 'M-ZA-L' );;
        13)encrypted=$( echo $filename | tr [:lower:] 'n-za-m' | tr [:upper:] 'N-ZA-M' );;
        14)encrypted=$( echo $filename | tr [:lower:] 'o-za-n' | tr [:upper:] 'O-ZA-N' );;
        15)encrypted=$( echo $filename | tr [:lower:] 'p-za-o' | tr [:upper:] 'P-ZA-O' );;
        16)encrypted=$( echo $filename | tr [:lower:] 'q-za-p' | tr [:upper:] 'Q-ZA-P' );;
        17)encrypted=$( echo $filename | tr [:lower:] 'r-za-q' | tr [:upper:] 'R-ZA-Q' );;
        18)encrypted=$( echo $filename | tr [:lower:] 's-za-r' | tr [:upper:] 'S-ZA-R' );;
        19)encrypted=$( echo $filename | tr [:lower:] 't-za-s' | tr [:upper:] 'T-ZA-S' );;
        20)encrypted=$( echo $filename | tr [:lower:] 'u-za-t' | tr [:upper:] 'U-ZA-T' );;
        21)encrypted=$( echo $filename | tr [:lower:] 'v-za-u' | tr [:upper:] 'V-ZA-U' );;
        22)encrypted=$( echo $filename | tr [:lower:] 'w-za-v' | tr [:upper:] 'W-ZA-V' );;
        23)encrypted=$( echo $filename | tr [:lower:] 'x-za-w' | tr [:upper:] 'X-ZA-W' );;
esac
mv $filename.txt $encrypted.txt
