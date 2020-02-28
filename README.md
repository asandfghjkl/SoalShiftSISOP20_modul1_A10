# SoalShiftSISOP20_modul1_A10
**Sandra Agnes Oktaviana  (05111840000124)**

**Adrian Danindra Indarto (05111840000068)**

## table of contents
* [soal1](https://github.com/asandfghjkl/SoalShiftSISOP20_modul1_A10#soal1)
* [soal2](https://github.com/asandfghjkl/SoalShiftSISOP20_modul1_A10#soal2)
* [soal3](https://github.com/asandfghjkl/SoalShiftSISOP20_modul1_A10#soal3)

## soal1
source code: [soal1.sh](https://github.com/asandfghjkl/SoalShiftSISOP20_modul1_A10/blob/master/soal1/soal1.sh)

### penyelesaian & penjelasan soal
Dari file “Sample-Superstore.tsv”, kemudian diminta laporan berupa:

**1a) Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling
sedikit**
```
a=$( awk -F '\t' '{if (NR>1) profit[$13]+=$21;}
END{min=10000000; for (i in profit) { 
	if (min > profit[i]){
		min=profit[i]; 
		region=i}
}print region}' Sample-Superstore.tsv )
echo "a) region dengan profit paling sedikit ialah $a"
```
* `awk -F '\t'` untuk membaca isi file Sample-Superstore.tsv digunakan default \t atau tab untuk memisahkan tiap kolom
* `{if (NR>1) profit[$13]+=$21;}` baris pertama file karena berisi nama kolom, maka akan dilewati. untuk tiap-tiap baris selanjutnya dicek untuk masing-masing region ($13) dihitung profitnya ($21)
* di bagian `END` 
	* dideklarasikan `min` dengan angka besar
	* kemudian untuk masing-masing profit, dicek satu sama lain apakah `min > profit[i]` 
	* apabila iya, maka `min` diganti profit region tersebut, dan region tersebut disimpan di `region`
* `print region` hasil region dengan profit minimum kemudian dikeluarkan
* `a` merupakan variabel untuk menyimpan hasil region dengan profit paling sedikit hasil `awk`
* `echo "a) region dengan profit paling sedikit ialah $a"` kemudian hasil dikeluarkan 

**1b) Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling
sedikit berdasarkan hasil poin a**

```
b=$( awk -F '\t' -v region="$a" '{if (NR>1) {if ($13 ~ region) profit[$11]+=$21;}} 
END{min1=1000000; min2=10000000; for (i in profit) {
		if (min1 > profit[i] || min2 > profit[i]){
		if (min2 > profit[i] && min1 < profit[i]){ min2=profit[i]; state2=i}
		else{ min2=min1;
			min1=profit[i]; 
                	state2=state1;
			state1=i}}
}print state1 " " state2}' Sample-Superstore.tsv )

echo "b) 2 state di region $a dengan profit terendah ialah "
for state in $b
do 
	echo "-"$state
done
```
* `awk -F '\t'` untuk membaca isi file Sample-Superstore.tsv digunakan default \t atau tab untuk memisahkan tiap kolom
* `-v region="$a"` untuk mendeklarasikan variabel region hasil dari soal 1a
* `{if (NR>1) {if ($13 ~ region) profit[$11]+=$21;}}` baris pertama file karena berisi nama kolom, maka akan dilewati. untuk tiap-tiap baris selanjutnya dicek untuk region ($13) yang sama dengan hasil soal 1a (Central) maka akan dihitung profit ($21) untuk masing-masing state ($11)
* di bagian `END` 
	* dideklarasikan `min1` dan `min2` dengan angka besar
	* kemudian untuk masing-masing profit per state, dicek satu sama lain apakah `min1 > profit[i] || min2 > profit[i]` 
	* apabila iya, kemudian diperiksa kembali apakah `min2 > profit[i] && min1 < profit[i]` jika iya, `min2` diganti dengan profit tersebut, dan state2 diganti state tersebut 
	* apabila tidak, `min2=min1; min1=profit[i]; state2=state1; state1=i` 
* `print state1 " " state2` keluarkan hasil 2 state dengan profit terendah
* `b` merupakan variabel untuk menyimpan hasil 2 state dengan profit paling sedikit hasil `awk`
* `echo "b) 2 state di region $a dengan profit terendah ialah "` kemudian kedua state dikeluarkan, `for state in $b do echo "-"$state done` 

**1c) Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling
sedikit berdasarkan 2 negara bagian (state) hasil poin b**

---revisi---
```
state=($b)

c=$( awk -F '\t' -v state1=${state[0]} -v state2=${state[1]} '{if (NR>1) {if ($11 ~ state1 || $11 ~ state2) profit[$17]+=$21;}} 
END{ for(ps in profit) {
	print profit[ps], ps}
}' Sample-Superstore.tsv | sort -g | head -10 )
echo -e "c) 10 produk dengan profit terendah di ${state[0]} dan ${state[1]} ialah \n$c"
```
* `state=($b)` hasil dari soal b kemudian disimpan dalam array state
* `awk -F '\t'` untuk membaca isi file Sample-Superstore.tsv digunakan default \t atau tab untuk memisahkan tiap kolom
* `-v state1=${state[0]} -v state2=${state[1]}` untuk mendeklarasikan variabel `state1` dan `state2` hasil dari soal 1b
* `{if (NR>1) {if ($11 ~ state1 || $11 ~ state2) profit[$17]+=$21;}}` baris pertama file karena berisi nama kolom, maka akan dilewati. untuk tiap-tiap baris selanjutnya dicek apabila state sama dengan hasil state soal 1b maka akan dihitung profit ($21) untuk masing-masing produk ($17)
* di bagian `END` 
	* `for(ps in profit) {print profit[ps], ps}` untuk setiap profit produk akan dikeluarkan
* `sort -g` untuk sorting hasil profit masing-masing produk
* `head -10` untuk mengeluarkan 10 baris hasil sorting
* `c` merupakan variabel untuk menyimpan hasil 10 produk dengan profit paling sedikit hasil `awk`
* `echo -e "c) 10 produk dengan profit terendah di ${state[0]} dan ${state[1]} ialah \n$c"` kemudian hasil kesepuluh produk dikeluarkan. `-e` disini untuk enable `\n`

**kendala**
- soal 1c belum selesai, maka perlu revisi
- revisi print state1 state2 soal 1b

## soal2
source code:
* [soal2.sh](https://github.com/asandfghjkl/SoalShiftSISOP20_modul1_A10/blob/master/soal2/soal2.sh)
* [soal2_enkripsi.sh](https://github.com/asandfghjkl/SoalShiftSISOP20_modul1_A10/blob/master/soal2/soal2_enkripsi.sh)
* [soal2_deskripsi.sh](https://github.com/asandfghjkl/SoalShiftSISOP20_modul1_A10/blob/master/soal2/soal2_deskripsi.sh)

### penyelesaian & penjelasan soal
**2a) Membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka**
```
password=$( cat  /dev/urandom | tr -dc '[:alnum:]' | fold -w 28 | head -n 1 )
```
* ```cat``` digunakan untuk membaca dan menampilkan file isi hasil dari command yang mengikutinya (```/dev/urandom```)
* ```/dev/urandom``` merupakan file yang dapat digunakan untuk menghasilkan bit secara acak
* ```tr -dc '[:alnum:]'``` untuk menghapus karakter lain selain ```[:alnum:]``` atau alphabets dan numeric
* ```fold -w 28``` menghasilkan 28 karakter
* ```head -n 1``` untuk menampilkan satu baris pertama hasil dari pengacakan password
* ```password``` merupakan variabel yang akan menyimpan hasil password

**2b) Password acak tersebut disimpan pada file berekstensi .txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.**
```
filename=$( echo $1 | tr -dc '[:alpha:]' )
echo $password > $filename.txt
```
* ```filename=$( echo $1 | tr -dc '[:alpha:]' )``` filename akan menyimpan argument pertama yang diinputkan dan membuang karakter selain alphabet dengan menambahkan ```tr -dc '[:alpha:]'```
* ```echo $password > $filename.txt``` hasil password kemudian disimpan dalam filename dengan ekstensi txt

**2c) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal: password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt dengan perintah ‘bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula seterusnya. Apabila melebihi z, akan kembali ke a, contoh: huruf w dengan jam 5.28, maka akan menjadi huruf b.)**

Dari persoalan di atas, diketahui bahwa argumen nama file yang diberikan sudah berekstensi .txt. 
Karena ekstensi tersebut tidak akan ikut dienkripsi, maka perlu dihapuskan dari argumen yang ada.
```
filename=$( echo $1 | sed 's/\.txt//g' )
```
* `filename` menyimpan argumen yang telah dihapuskan ekstensi .txt -nya

Kemudian diperlukan jam pembuatan file yang akan dienkripsi untuk mengetahui pola enkripsinya.
```
hour=$( date -r $filename.txt +"%H" )
```
* ```date -r $filename.txt +"%H"``` digunakan untuk membaca waktu pembuatan file serta %H ditambahkan karena kita hanya butuh jamnya saja
* `hour` menyimpan hasil jam pembuatan file

Untuk melakukan enkripsi sesuai jam pembuatan file, digunakan case untuk setiap jamnya (00-23). 
Mulai jam 01-23 maka akan dilakukan shift karakter sejumlah jamnya.
Dengan asumsi bahwa apabila file dibuat pukul 00.01-00.59 maka tidak berlaku string manipulasi.
```
case "$hour" in
        00)encrypted=$filename;; 
        01)encrypted=$( echo $filename | tr [:lower:] 'b-za' | tr [:upper:] 'B-ZA');;
        02)encrypted=$( echo $filename | tr [:lower:] 'c-za-b' | tr [:upper:] 'C-ZA-B' );;
        03)encrypted=$( echo $filename | tr [:lower:] 'd-za-c' | tr [:upper:] 'D-ZA-C' );;
        ...
        22)encrypted=$( echo $filename | tr [:lower:] 'w-za-v' | tr [:upper:] 'W-ZA-V' );;
        23)encrypted=$( echo $filename | tr [:lower:] 'x-za-w' | tr [:upper:] 'X-ZA-W' );;
esac

mv $filename.txt $encrypted.txt
```
* ```tr [:lower:] '...'``` untuk mengenkripsi huruf kecil
* ```tr [:upper:] '...'``` untuk mengenkripsi huruf besar
* `encrypted` digunakan untuk menyimpan hasil enkripsi
* ```mv $filename.txt $encrypted.txt``` nama file argumen kemudian diubah sesuai hasil enkripsi dengan ekstensi .txt

**2d) jangan lupa untuk membuat dekripsinya supaya nama file bisa kembali.**

Kebalikan dari enkripsi, deskripsi akan mengubah kembali hasil shift karakter sesuai jam pembuatan file.
```
filename=$( echo $1 | sed 's/\.txt//g' )
encrypted=$filename.txt

upper='A-Z'
lower='a-z'

hour=$( date -r $encrypted +"%H" )
case "$hour" in
	      00);; 
        01)filename=$( echo $filename | tr 'b-za' $lower | tr 'B-ZA' $upper );;
        02)filename=$( echo $filename | tr 'c-za-b' $lower | tr 'C-ZA-B' $upper );;
        ...
        22)filename=$( echo $filename | tr 'w-za-v' $lower | tr 'W-ZA-V' $upper );;
        23)filename=$( echo $filename | tr 'x-za-w' $lower | tr 'X-ZA-W' $upper );;
esac

mv $encrypted $filename.txt
```

**kendala**
- Karena kurang memahami bagaimana cara untuk mengubah karakter sesuai jam, maka dilakukan secara manual. 
- Untuk deskripsi, [:lower:] [:upper:] entah kenapa tidak bisa digunakan seperti di enkripsinya.

## soal3
source code:

[soal3.sh](https://github.com/asandfghjkl/SoalShiftSISOP20_modul1_A10/blob/master/soal3/soal3.sh)

### penyelesaian & penjelasan soal
**3a) membuat script untuk mendownload 28 gambar dari
"https://loremflickr.com/320/240/cat" menggunakan command wget dan menyimpan file
dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2,
pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam
sebuah file "wget.log"**
```
for (( i=1; i<29; i++))
do
	wget -O pdkt_kusuma_$i.jpg -a wget.log https://loremflickr.com/320/240/cat 
done
```
* ```for (( i=1; i<29; i++))``` untuk mendapatkan 28 gambar, maka dilakukan looping dengan i mulai dari 1. i kemudian bisa dipakai untuk memberi nomor file
* `wget` wget merupakan command yang bisa digunakan untuk mengunduh file di url yang mengikutinya (https://loremflickr.com/320/240/cat)
* ```-O pdkt_kusuma_$i.jpg``` untuk merubah nama file unduhan menjadi pdkt_kusuma_$i ($i merupakan penomoran file)
* ```-a wget.log``` untuk mendapatkan log activity wget dan menyimpannya ke dalam wget.log. -a disini berarti append atau selalu menambahkan dari yang sudah ada

**3b) setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu**
isi crontab:
```
5 6,*/8 * * 0-5 /home/sun/modul1/soal3/soal3.sh
```
* `5` berjalan pada menit ke 5
* `6,*/8` berjalan setiap 8 jam sesudah jam 6 
* `* *` berjalan pada tanggal apapun, bulan apapun
* `0-5` setiap hari kecuali sabtu
*  cron akan mengakses `/home/sun/soal3.sh` untuk itu diperlukan `$ chmod +x /home/sun/soal3.sh` sebelum cron berjalan untuk mengubah hak akses file

**3c) Maka dari itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan
gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka
sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate
dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201).
Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan
dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253).
Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi
ekstensi ".log.bak".**

Sebelum dilakukan pemindahan file, pastikan directory sudah tersedia. Maka perlu dilakukan pengecekan, apabila belum ada maka directory akan dibuat terlebih dahulu.
```
if [ ! -d ./kenangan ] 
then mkdir kenangan 
fi
if [ ! -d ./duplicate ] 
then mkdir duplicate 
fi
```
* `if [ ! -d ./kenangan ] ` untuk memeriksa apakah directory ./kenangan sudah ada. tanda `!` berarti apabila tidak memenuhi syarat (directory ada) maka akan dijalankan `then mkdir kenangan`
* begitu pula dengan directory duplicate

Kemudian untuk 28 file pdkt_kusuma_$nomor.jpg dilakukan pengecekan terhadap masing-masing file lain apakah terdapat file yang sama.
Dilakukan nested looping dimana untuk setiap keberadaan file pdkt_kusuma_$nomor.jpg akan dicek ke file nomor berikutnya hingga nomor 28 apakah ada yang sama. 
```
for ((i=1; i<=28; i++))
do
if [ -f "pdkt_kusuma_$i.jpg" ] 
then
	for ((j=i+1; j<=28; j++))
	do
	if [ -f "pdkt_kusuma_$j.jpg" ] 
	then
		...(1)
	fi
	done
	...(2)
fi
done
```

isi dari nested loop:

...(1)
```
		convert pdkt_kusuma_$i.jpg a.rgba
		convert pdkt_kusuma_$j.jpg b.rgba
		cmp -s {a,b}.rgba
		check=$?
		if [[ $check -eq 0 ]]
		then
			nd=$( ls duplicate | wc -l )
			mv pdkt_kusuma_$j.jpg ./duplicate/duplicate_$(($nd+1)).jpg
		fi
```
* `convert pdkt_kusuma_$i.jpg a.rgba`
`convert pdkt_kusuma_$j.jpg b.rgba` pengecekan dilakukan dengan `convert` file `pdkt_kusuma_$i` ke `a.rgba` dan `pdkt_kusuma_$j` ke `b.rgba`
* `cmp -s {a.b}.rgba` kedua file hasil convert dalam ekstensi .rgba tersebut dibandingkan untuk mengetahui apakah keduanya sama atau tidak. `-s` atau `--silent` dalam `cmp` berarti tidak akan dilakukan apa-apa selama proses pembandingan kedua file.
* `check=$?` menyimpan hasil `cmp`
* `if [[ $check -eq 0 ]]` apabila hasil check adalah 0, yang berarti kedua file tersebut sama maka;
	* `nd=$( ls duplicate | wc -l )` menghitung isi directory `duplicate` dan menyimpannya ke `nd`
	* `mv pdkt_kusuma_$j.jpg ./duplicate/duplicate_$(($nd+1)).jpg` file tersebut akan dipindahkan ke dalam `./duplikat` dengan nama file berubah menjadi `duplicate_$(($nd+1)).jpg`
	

...(2)
apabila sudah dicek ke semua file berikut-berikutnya (hingga file ke 28), maka;
```
	nk=$( ls kenangan | wc -l ) 
	mv pdkt_kusuma_$i.jpg ./kenangan/kenangan_$(($nk+1)).jpg
```
* `nk=$( ls kenangan | wc -l )` menghitung isi directory `kenangan` dan menyimpannya ke `nk`
* `mv pdkt_kusuma_$i.jpg ./kenangan/kenangan_$(($nk+1)).jpg` file tersebut akan dipindahkan ke dalam `./kenangan` dengan nama file berubah menjadi `kenangan_$(($nk+1)).jpg`


File pembantu untuk perbandingan, `a rgba` dan `b.rgba`, kemudian dihapus.
```
rm a.rgba b.rgba
```

**kendala**
- tidak menggunakan `awk`
