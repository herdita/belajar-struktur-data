program perpustakaan;
{i.s:}
{f.s:}

uses crt;
{kamus}
    const
        maks_data = 5; //maksimal data buku
        user      = 'kelompok1';
        pass      = '1';

    type
        dt_buku= record
            kode_bk,nama_bk,pengarang : string;
            tahun : integer;
        end; //endrecord

        dt_identitas= record
            nama,kelamin,alamat : string;
        end; //endrecord

        dt_pinjam= record
            tgl,bulan,tahun : integer;
        end; //endrecord

        arr_bk = array[1..maks_data]of dt_buku;
    
    var
        buku             : arr_bk;
        identitas        : dt_identitas;
        pinjam           : dt_pinjam;
        np,ks            : string;
        pilihan,n,jumlah : integer;
        tahap,langkah,p  : integer;

function login(np,ks:string):boolean;
{i.s:}
{f.s:}

{kamus}
var
    i: integer;

{algoritma}
begin
    i:=1;
    while((np<>user) or (ks<>pass)) and (i<>3)do
    begin
        gotoxy(48,15); write('Login failed');
        readln; gotoxy(45,15); clreol; gotoxy(57,11); clreol;
        gotoxy(57,12); clreol;
        gotoxy(58,11); readln(np); gotoxy(58,12); readln(ks);
        i:= i+1;
    end; //endwhile
    if(i<=3) and (np=user) and (ks=pass)
        then
            login:= true
        else
            login:= false;
end; //endfunction


procedure creat(var buku:arr_bk);
{i.s:}
{f.s:}

{kamus}
var
    i: integer;

{algoritma}
begin
    for i := 1 to maks_data do
    begin
        buku[i].kode_bk := '/';
        buku[i].nama_bk := '/';
        buku[i].tahun   := 0;
        buku[i].pengarang := '/';
    end; //endfor
    clrscr;
    gotoxy(33,4); writeln('Data berhasil diciptakan');
    readln;
end; //endprocedure


procedure input_data(var n:integer; var buku:arr_bk);
{i.s:}
{f.s:}

{kamus}
var
    i,baris:integer;

{algoritma}
begin
    clrscr;
    gotoxy(45,4); writeln('-----------------------------');
    gotoxy(45,5); writeln(' Masukan banyaknya data : ');
    gotoxy(45,6); writeln('-----------------------------');
    gotoxy(71,5); readln(n);
    while(n > maks_data)do
    begin
        gotoxy(40,7); writeln('maaf data yang di inputkan min 100 data'); readln;
        gotoxy(40,7); clreol;
        gotoxy(71,5); clreol;
        readln(n);
    end; //endwhile
    gotoxy(35,9);  writeln('-------------------------------------------------------');
    gotoxy(35,10); writeln('                  Pemasukan Data Buku                  ');
    gotoxy(35,11); writeln('-------------------------------------------------------');
    gotoxy(35,12); writeln('| Kode buku |    Nama buku    | Tahun |   Pengarang   |');
    gotoxy(35,13); writeln('-------------------------------------------------------');
    baris:= 13;
    for i := 1 to n do
    begin
        gotoxy(35,baris+1); writeln('|           |                 |       |               |');
        gotoxy(37,baris+1); readln(buku[i].kode_bk);
        gotoxy(49,baris+1); readln(buku[i].nama_bk);
        gotoxy(67,baris+1); readln(buku[i].tahun);
        gotoxy(75,baris+1); readln(buku[i].pengarang);
        baris:= baris+1;
    end; //endfor
    gotoxy(35,baris+1); writeln('-------------------------------------------------------');
    readln;
end; //endprocedure

     

procedure merge(var buku:arr_bk; var langkah:integer; awal, tengah, akhir:integer);
{i.s:}
{f.s:}

{kamus} 
var
    k, i, j, l:integer;
    data_temp:arr_bk;

{algoritma} 
begin
    i := awal;
    j := tengah + 1;
    k := awal;
    repeat
    if (buku[i].kode_bk >= buku[j].kode_bk) then
    begin
        data_temp[k] := buku[i];
        inc(i);
    end
    else
    begin
        data_temp[k] := buku[j];
        inc(j);
    end; //endif
 
    inc(k);
    inc(langkah);
    until (i > tengah) or (j > akhir);
 
    if (i > tengah) then
    begin
        for l := j to akhir do
        begin
            data_temp[k] := buku[l];
            inc(k);
        end; //endfor
    end
    else
    begin
        for l := i to tengah do
        begin
            data_temp[k] := buku[l];
            inc(k);
        end; //endfor
    end; //endif

    for k := awal to akhir do
    begin
        buku[k] := data_temp[k];
    end; //endfor
end; //endprocedure
 

procedure insert_data(n:integer; var buku:arr_bk);
{i.s:}
{f.s:}

{kamus} 
var
    i:integer;

{algoritma} 
begin
    for i := 1 to n do
    begin
        write(buku[i].kode_bk,',');
    end; //endfor
end; //endprocedure
 

procedure show_data(n:integer; buku:arr_bk);
{i.s:}
{f.s:}

{kamus} 
var
    i:integer;

{algoritma} 
begin
    for i := 1 to n do
    begin
        write(buku[i].kode_bk, ' ');
    end; //endfor
end; //endprocedure 
    

procedure merge_sort(var buku:arr_bk; awal, akhir:integer);
{i.s:}
{f.s:}

{kamus} 
var
    tengah:integer;

{algoritma} 
begin
    inc(p);
    if (awal < akhir) then
    begin
        tengah := (awal + akhir) div 2;
        merge_sort(buku, awal, tengah);
        merge_sort(buku, tengah + 1, akhir);
        merge(buku,langkah, awal, tengah, akhir);
            delay(300);
            inc(tahap);
            textcolor(14);gotoxy(37,11+tahap+langkah);write('TAHAP ',tahap);
            textcolor(15);gotoxy(25,12+tahap+langkah);show_data(n,buku);
    end; //endif
end; //endprocedure


procedure tampil(n:integer; buku:arr_bk);
{i.s:}
{f.s:}

{kamus}
    //tidak ada

{algoritma}        
begin
    textcolor(15);gotoxy(35,2);write('MERGE SORT');
    textcolor(14);gotoxy(30,3);write('--------------------');
    textcolor(10);gotoxy(29,5);writeln('DATA SEBELUM DIURUTKAN');
    textcolor(15);gotoxy(25,7);
    insert_data(n,buku);
    textcolor(10);gotoxy(29,10);write('PROSES PENGURUTAN DATA');
    textcolor(15);merge_sort(buku, 1, n);
    textcolor(10);gotoxy(29,14+tahap+langkah);write('DATA SESUDAH DIURUTKAN');
    textcolor(15);gotoxy(25,16+tahap+langkah);show_data(n,buku);
    textcolor(15);gotoxy(16,18+tahap+langkah);write('Pengurutan Terdiri Dari : ',tahap, ' Tahap & ',langkah,' Langkah');
    readln;
end; //endprocedure


procedure search_kode_bk(n:integer; var buku:arr_bk);
{i.s:}
{f.s:}

{kamus}
var
    search  : string;
    ketemu  : boolean;
    k,ia,ib : integer;

{algoritma}
begin
    //metode binary search
    clrscr; 
    gotoxy(45,4); writeln('-----------------------------');
    gotoxy(45,5); writeln(' Kode buku yang di cari : ');
    gotoxy(45,6); writeln('-----------------------------');
    gotoxy(71,5); readln(search);
    ia:= 1;
    ib:= n;
    ketemu:= false;
    while(not ketemu)and(ia <= ib)do
    begin
        k:= (ia+ib) div 2;
        if(search = buku[k].kode_bk)
            then
                ketemu := true
            else
                if(search > buku[k].kode_bk)
                    then
                        ia := k+1
                    else
                        ib := k-1; //Endif
    end; //endwhile
    if(ketemu)then
        begin
            gotoxy(35,8);  writeln('                  Pencarian Data Buku                  ');
            gotoxy(35,10); writeln('-------------------------------------------------------');
            gotoxy(35,11); writeln('| Kode buku |    Nama buku    | Tahun |   Pengarang   |');
            gotoxy(35,12); writeln('-------------------------------------------------------');
            gotoxy(35,13); writeln('|           |                 |       |               |');
            gotoxy(37,13); write(buku[k].kode_bk);
            gotoxy(49,13); write(buku[k].nama_bk);
            gotoxy(67,13); write(buku[k].tahun);
            gotoxy(75,13); write(buku[k].pengarang);
            gotoxy(35,14); writeln('-------------------------------------------------------');       
        end
         else
            begin
                gotoxy(45,7); write('Maaf data yang anda cari tidak ada');
            end; //endif
        readln;
end; //endprocedure



procedure peminjaman(n:integer; var identitas:dt_identitas; var buku:arr_bk; var jumlah:integer; var pinjam:dt_pinjam);
{i.s:}
{f.s:}

{kamus}
var
    i,k,baris        : integer;
    ketemu           : boolean;
    search           : string;
    
{algoritma}
begin
    clrscr;
    gotoxy(33,3);  writeln('         Peminjaman Buku Perpustakaan         ');
    gotoxy(33,5);  writeln('            Masukan Identitas Anda            ');
    gotoxy(33,6);  writeln('----------------------------------------------');
    gotoxy(33,7);  writeln(' Nama Lengkap  : ');
    gotoxy(33,8);  writeln(' Jenis Kelamin : ');
    gotoxy(33,9);  writeln(' Alamat        : ');
    gotoxy(33,10); writeln('----------------------------------------------');
    gotoxy(50,7);  readln(identitas.nama);
    gotoxy(50,8);  readln(identitas.kelamin);
    gotoxy(50,9);  readln(identitas.alamat);
    
    gotoxy(33,12);  write('Jumlah Buku Yang di Pinjam : '); readln(jumlah);
    //validasi
    while(jumlah > 3)do
    begin    
        gotoxy(33,13); writeln('Maaf Jumlah Peminjaman tidak boleh lebih dari 3'); readln;
        gotoxy(33,13); clreol;
        gotoxy(62,12); clreol;
        readln(jumlah);
    end;

    gotoxy(30,13); writeln('-----------------------------------------------------');
    gotoxy(30,14); writeln('| Kode buku |    Nama buku    | Tahun |  Pengarang  |');
    gotoxy(30,15); writeln('-----------------------------------------------------');
        for i:= 1 to jumlah do
        begin
            repeat
                gotoxy(30,15+i); write('|           |                 |       |             |');
                gotoxy(32,15+i); readln(search);
                ketemu:=false;
                k:= 1;
                while(buku[k].kode_bk <> search) and (k < n)do
                begin
                    k:= k+1;
                end; //endwile
                if(buku[k].kode_bk = search) then
                 begin
                    gotoxy(44,15+i); write(buku[k].nama_bk);
                    gotoxy(62,15+i); write(buku[k].tahun);
                    gotoxy(70,15+i); write(buku[k].pengarang);
                    ketemu:= true;    
                end
                else
                 begin
                    gotoxy(44,15+i); write('Maaf Kode buku Yang anda cari tidak Ada'); readln;
                    gotoxy(32,15+i); clreol;
                 end; //endif 
            until ketemu=true;
            gotoxy(30,16+i); writeln('-----------------------------------------------------');
            baris:= 18+i;                     
        end; //endfor

    gotoxy(44,baris+1); writeln('Tanggal Peminjaman buku');
    gotoxy(40,baris+2); writeln('-------------------------------');
    gotoxy(44,baris+3); writeln(' Contoh 24 - 2 - 2017  ');  
    gotoxy(44,baris+4); writeln('-----------------------');
    gotoxy(44,baris+5); writeln('| Tgl | Bulan | Tahun |');
    gotoxy(44,baris+6); writeln('-----------------------');
    gotoxy(44,baris+7); writeln('|     |       |       |');
    gotoxy(44,baris+8); writeln('-----------------------');
    gotoxy(47,baris+7); readln(pinjam.tgl);
    gotoxy(54,baris+7); readln(pinjam.bulan);
    gotoxy(60,baris+7); readln(pinjam.tahun);
    gotoxy(39,baris+10);  writeln(' Terima kasih Atas Kunjungannya ');
    readln;
end; //endprocedure
  


procedure konversi_data(var pinjam:dt_pinjam);
{i.s:}
{f.s:}

{kamus}
var
    sisa,konversi    : integer;
{algoritma}
begin
    konversi:= ((pinjam.tahun * 365) + (pinjam.bulan * 30) + pinjam.tgl + 14);
    pinjam.tahun  := konversi div 365;
    sisa          := konversi mod 365;
    pinjam.bulan  := sisa div 30;
    pinjam.tgl    := sisa mod 30;
end; //endprocedure


procedure tampil_data(buku:arr_bk; identitas:dt_identitas; jumlah:integer; pinjam:dt_pinjam);
{i.s:}
{f.s:}

{kamus}
var
    i,baris:integer;

{algoritma}
begin
    clrscr;
    gotoxy(35,3); writeln('-------------------------------------------------------');
    gotoxy(35,4); writeln('                 Keseluruhan Data Buku                 ');
    gotoxy(35,5); writeln('-------------------------------------------------------');
    gotoxy(35,6); writeln('| Kode buku |    Nama buku    | Tahun |   Pengarang   |');
    gotoxy(35,7); writeln('-------------------------------------------------------');
    baris:= 7;
    for i := 1 to maks_data do
    begin
        gotoxy(35,baris+i); writeln('|           |                 |       |               |');
        gotoxy(37,baris+i); write(buku[i].kode_bk);
        gotoxy(49,baris+i); write(buku[i].nama_bk);
        gotoxy(67,baris+i); write(buku[i].tahun);
        gotoxy(75,baris+i); write(buku[i].pengarang);
    end; //endfor
    baris:= baris+i;
    gotoxy(35,baris+1); writeln('-------------------------------------------------------');

    gotoxy(42,baris+3); writeln('               Identitas Anda            ');
    gotoxy(42,baris+4); writeln('-----------------------------------------');
    gotoxy(42,baris+5); writeln(' Nama Lengkap  : ',identitas.nama);
    gotoxy(42,baris+6); writeln(' Jenis Kelamin : ',identitas.kelamin);
    gotoxy(42,baris+7); writeln(' Alamat        : ',identitas.alamat);
    gotoxy(42,baris+8); writeln('-----------------------------------------');
    gotoxy(42,baris+9); writeln('  Jumlah Buku yang di pinjam : ',jumlah);
    konversi_data(pinjam);
    gotoxy(30,baris+11); writeln(' Batas Akhir Pengembalian buku Tanggal: ',pinjam.tgl,',  bulan: ',pinjam.bulan,', Tahun: ',pinjam.tahun);
    gotoxy(30,baris+12); writeln(' Note : jika buku terlambat di kembalikan, Maka di Denda, 1 buku perhari Rp.300 ');
    readln;
end; //endprocedure


procedure destroy (var buku : arr_bk);
{I.S.:}
{F.S.:}
var
   i        :integer;
   pilihan  :string;

begin
   clrscr;
   gotoxy(50,5);write('Apakah Anda Yakin Untuk Menghapus Semua Data?');
   gotoxy(50,6);write('Pilihan hanya ada y(Ya) dan t(Tidak),coba lagi = ');
   gotoxy(98,6);readln(pilihan);

   if(pilihan = 'y')
   then
   begin
        for i:=1 to maks_data do
            begin
                buku[i].kode_bk   := '/';
                buku[i].nama_bk   := '/';
                buku[i].tahun     := 0;
                buku[i].pengarang := '/';
            end;
        gotoxy(50,8);write('Data berhasil dihapus');
        readln;
    end;
    if(pilihan = 't') then
      begin;
        gotoxy(50,6);write('Akan dikembalikan kepada tampilan menu,klik ENTER!');
        readln;
      end;
end;//endprocedure
 

Procedure menu_perpus(var pilihan:integer);
{I.S. : Menampilkan Menu Utama dari program perpustakaan}
{F.S. : Mengeksekusi menu yang telah  dipilih}

{kamus lokal}
    {tidak ada}

{Algoritma}
begin
    clrscr;
    gotoxy(38,3);  writeln('============================================');
    gotoxy(38,4);  writeln('|              Selamat Datang              |');
    gotoxy(38,5);  writeln('--------------------------------------------');
    gotoxy(38,6);  writeln('|               Perpustakaan               |');
    gotoxy(38,7);  writeln('--------------------------------------------');
    gotoxy(38,8);  writeln('|****      1. Create Array             ****|');
    gotoxy(38,9);  writeln('|****      2. Input Data Buku          ****|');
    gotoxy(38,10); writeln('|**        3. Pengurutan Data Buku       **|');
    gotoxy(38,11); writeln('|*         4. Pencarian Data Kode Buku    *|');
    gotoxy(38,12); writeln('|*         5. Peminjaman Buku             *|');
    gotoxy(38,13); writeln('|**        6. Tampil data Buku           **|');
    gotoxy(38,14); writeln('|****      0. Keluar & destroy         ****|');
    gotoxy(38,15); writeln('--------------------------------------------');
    gotoxy(38,16); write('Daftar Pilihan : '); readln(pilihan);
    
    {validasi}
    while(pilihan < 0) or (pilihan > 6)do
    begin
        gotoxy(38,18); writeln('Pilihan anda tidak ada di daftar'); readln;
        gotoxy(38,18); clreol;
        gotoxy(55,16); clreol;
        readln(pilihan);
    end; //endwhile
end; //endProcedure


{algoritma utama}
begin
    gotoxy(40,9); writeln('           LOGIN           ');
    gotoxy(40,10); writeln('---------------------------');
    gotoxy(40,11); write(' Nama pengguna  : '); readln(np);
    gotoxy(40,12); write(' kata Sandi     : '); readln(ks);
    gotoxy(40,13); writeln('---------------------------');
    if(login(np,ks)) 
      then  //login succes
        begin
            repeat
                menu_perpus(pilihan);
                case(pilihan)of
                    1: creat(buku);
                    2: begin
                        input_data(n,buku);
                       end;
                    3: begin
                        clrscr;
                        tampil(n,buku);
                       end;
                    4:  search_kode_bk(n,buku);
                    5:  peminjaman(n,identitas,buku,jumlah,pinjam);
                    6: begin
                        tampil_data(buku,identitas,jumlah,pinjam);
                       end;
                    0: destroy(buku);
                end;
            until(pilihan=0);
        end    
      else
        begin
            gotoxy(40,14); write('Maaf,sudah 3 kali salah login');
            readln;
        end; //endif
end.       
