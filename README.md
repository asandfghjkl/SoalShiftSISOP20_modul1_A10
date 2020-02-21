# SoalShiftSISOP20_modul1_A10
### Sandra Agnes Oktaviana  (05111840000124)
### Adrian Danindra Indarto (05111840000068)

## soal1
source code:

### penyelesaian & penjelasan soal


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

### kendala
- Karena kurang memahami bagaimana cara untuk mengubah karakter sesuai jam, maka dilakukan secara manual. 
- Untuk deskripsi, [:lower:] [:upper:] entah kenapa tidak bisa digunakan seperti di enkripsinya.

## soal3
source code:

### penyelesaian & penjelasan soal
