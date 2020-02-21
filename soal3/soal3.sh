#!/bin/bash

#3a) 
for (( i=1; i<29; i++))
do
	wget -O pdkt_kusuma_$i.jpg -a wget.log https://loremflickr.com/320/240/cat 
done

#3b) 	$ crontab -e
# 	5 6,*/8 * * 0-5 /home/sun/soal3.sh
# 	chmod +x /home/sun/soal3.sh

#3c) 
if [ ! -d ./kenangan ] 
then mkdir kenangan 
fi
if [ ! -d ./duplicate ] 
then mkdir duplicate 
fi

for ((i=1; i<=28; i++))
do
if [ -f "pdkt_kusuma_$i.jpg" ] 
then
	for ((j=i+1; j<=28; j++))
	do
	if [ -f "pdkt_kusuma_$j.jpg" ] 
	then
		convert pdkt_kusuma_$i.jpg a.rgba
		convert pdkt_kusuma_$j.jpg b.rgba
		cmp -s {a,b}.rgba
		check=$?
		if [[ $check -eq 0 ]]
		then
			nd=$( ls duplicate | wc -l )
			mv pdkt_kusuma_$j.jpg ./duplicate/duplicate_$(($nd+1)).jpg
		fi
	fi
	done
	nk=$( ls kenangan | wc -l )
	mv pdkt_kusuma_$i.jpg ./kenangan/kenangan_$(($nk+1)).jpg
fi
done

rm a.rgba b.rgba
