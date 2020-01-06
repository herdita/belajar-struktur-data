program Perpustakaan;
uses crt;

// kamus global
type
    point = ^data;
    mahasiswa = record
        kode,nama,pengarang,nim:string;
        tahun,posisi: integer;
    end; //endrecord

    data = record
        info : mahasiswa;
        prev,next: point;
    end;

var
    awal,akhir : point;
    lagi       : char;
    pilihan_sisip,pilihan_hapus : integer;
    pilihan_cari,menu           : integer;



procedure SisipDepan(var awal,akhir:point);
{i.s: User memasukan data buku perpus}
{f.s: Menghasilkan data buku yang dimasukan}

var 
    baru : point;
    i,n: integer;

begin
    gotoxy(43,2); write('Jumlah data yang disisipkan Didepan: '); readln(n);
    gotoxy(33,4); writeln('-----------------------------------------------------');
    gotoxy(33,5); writeln('                      Sisip Depan                    ');
    gotoxy(33,6); writeln('-----------------------------------------------------');
    gotoxy(33,7); writeln('| Kode buku |    Nama buku    | Tahun |  Pengarang  |');
    gotoxy(33,8); writeln('-----------------------------------------------------');
    for i := 1 to n do
    begin
        new(baru);
        gotoxy(33,8+i); write('|           |                 |       |             |');
        gotoxy(35,8+i); readln(baru^.info.kode);
        gotoxy(47,8+i); readln(baru^.info.nama);
        gotoxy(65,8+i); readln(baru^.info.tahun);
        gotoxy(73,8+i); readln(baru^.info.pengarang);
       
        baru^.prev := nil;
        if(awal = nil) then
        begin
            baru^.next := nil;
            akhir := baru;
        end
        else
        begin
            baru^.next := awal;
            awal^.prev := baru;
        end;
        awal := baru;
    end; //endfor
    gotoxy(33,9+i); writeln('-----------------------------------------------------');
    readln;
end; //endprocedure    


procedure sisiptengah(var awal,akhir:point);
{i.s: User memasukan data buku perpus}
{f.s: Menghasilkan data buku yang dimasukan}

var
    baru,bantu: point;
    i,list : integer;
    
begin
    gotoxy(47,2); write('list keberapa yang akan dimasukan :'); readln(list);
    gotoxy(33,4); writeln('-----------------------------------------------------');
    gotoxy(33,5); writeln('                     Sisip Tengah                    ');
    gotoxy(33,6); writeln('-----------------------------------------------------');
    gotoxy(33,7); writeln('| Kode buku |    Nama buku    | Tahun |  Pengarang  |');
    gotoxy(33,8); writeln('-----------------------------------------------------');  
        new(baru);
        gotoxy(33,8); write('|           |                 |       |             |');
        gotoxy(35,8); readln(baru^.info.kode);
        gotoxy(47,8); readln(baru^.info.nama);
        gotoxy(65,8); readln(baru^.info.tahun);
        gotoxy(73,8); readln(baru^.info.pengarang);
        
        if(awal = nil) then
        begin
            baru^.next := nil;
            baru^.prev := nil;
            awal := baru;
            akhir := baru;
        end
        else
        begin         
            bantu := awal;
            i := 1;
            while(bantu <> akhir)do
            begin
                bantu^.info.posisi := i;
                if(bantu^.info.posisi <> list) then
                begin
                    bantu:= bantu^.next;
                    bantu^.info.posisi := i+1;
                    i:= i+1;
                end
                else
                begin
                    baru^.next := bantu;
                    baru^.prev := bantu^.prev;
                    bantu^.prev^.next := baru^.prev;
                    bantu^.next := baru^.next;
                end; //endfor
            end; //endwhile
        end; //endif         
    
    gotoxy(33,9+i); writeln('-----------------------------------------------------');
    readln;
end; //endprocedure


procedure sisipbelakang(var awal,akhir:point);
{i.s: User memasukan data buku perpus}
{f.s: Menghasilkan data buku yang dimasukan}

var
    baru: point;
    n,i : integer;

begin
    gotoxy(47,2); write('Jumlah data yang disisipkan : '); readln(n);
    gotoxy(33,4); writeln('-----------------------------------------------------');
    gotoxy(33,5); writeln('                    Sisip Belakang                   ');
    gotoxy(33,6); writeln('-----------------------------------------------------');
    gotoxy(33,7); writeln('| Kode buku |    Nama buku    | Tahun |  Pengarang  |');
    gotoxy(33,8); writeln('-----------------------------------------------------');
    for i := 1 to n do
    begin
        new(baru);
        gotoxy(33,8+i); write('|           |                 |       |             |');
        gotoxy(35,8+i); readln(baru^.info.kode);
        gotoxy(47,8+i); readln(baru^.info.nama);
        gotoxy(65,8+i); readln(baru^.info.tahun);
        gotoxy(73,8+i); readln(baru^.info.pengarang);       
        baru^.next := nil;
        if(akhir = nil) then
        begin
            baru^.prev := nil;
            awal := baru;
        end
        else
        begin
            baru^.prev := akhir;
            akhir^.next:= baru;
        end;
        akhir := baru;
    end; //endfor
    gotoxy(33,9+i); writeln('-----------------------------------------------------');
    readln;
end; //endprocedure


procedure hapussama(var awal,akhir:point);
{i.s: harga sudah terdefinisi}
{f.s: memproses dan menghapus kode buku yang nilainya sama}

var
    bantu, bantu2, phapus : point;

begin
    bantu := awal;
    while(bantu <> akhir) do
    begin
        phapus := bantu^.next;
        while(phapus <> nil) do
        begin
            if(phapus^.info.kode = bantu^.info.kode) then
            begin
                if(phapus = akhir) then
                begin
                    akhir       := akhir^.prev;
                    akhir^.next := nil;
                    dispose(phapus);
                    phapus      := nil; 
                end
                else
                begin
                    bantu2 := phapus^.next ;
                    phapus^.prev^.next := bantu2;
                    bantu2^.prev := phapus^.prev;
                    dispose(phapus);
                    phapus := bantu2;
                end;
            end
            else
                phapus := phapus^.next;
        end; //endwhile
        bantu := bantu^.next;
    end; //endwhile
end; //endprocedure


procedure hapusDepan(var awal,akhir:point);
{i.s: Data sudah terdefinisi}
{f.s: menghapus data yang awal / depan}

var
    phapus: point;
    
begin
    phapus:= awal;
    if(awal=akhir) then
    begin
        akhir := nil;
        awal  := nil;
        dispose(phapus);
    end
    else
    begin
        awal := awal^.next;
        awal^.prev := nil;
        dispose(phapus);   
    end; //endif
    gotoxy(40,7); writeln('-------------------------');
    gotoxy(40,8); writeln('Data Depan Sudah Di hapus');
    gotoxy(40,9); writeln('-------------------------');
    readln;
end; //endprocedure


procedure hapusTengah(var awal,akhir:point);
{i.s: user memasukan Kode buku yang akan dihapus}
{f.s: menghapus data buku tersebut}

var
    phapus : point;
    ketemu : boolean;
    kode_hapus: string;

begin
    gotoxy(43,8); write('Nim Yang akan di hapus : '); readln(kode_hapus);
    phapus := awal;
    ketemu := false;
    while(not ketemu) and (phapus <> nil)do
    begin
        if(phapus^.info.kode = kode_hapus) then
            ketemu := true
        else
            phapus := phapus^.next;
    end; //endwhile
    if(ketemu) then
    begin
        if(phapus = awal) then
        begin
            awal := awal^.next;
            awal^.prev := nil;
            dispose(phapus);
        end
        else
        begin
            if(phapus = akhir) then
            begin
                akhir := akhir^.prev;
                akhir^.next := nil;
                dispose(phapus);
            end
            else
            begin
                phapus^.prev^.next := phapus^.next;
                phapus^.next^.prev := phapus^.prev;
            end;
        end;
        gotoxy(43,8); writeln('Data Dengan Kode Buku ',kode_hapus,' Sudah dihapus');
    end
    else
        gotoxy(46,9); writeln('Nim ' ,kode_hapus,' Tidak ditemukan');
    readln;
end; //endprocedure


procedure hapusBelakang(var awal,akhir:point);
{i.s: Harga / data sudah terdefinisi}
{f.s: Menghapus data buku}

var
    phapus: point;

begin
    phapus:= akhir;
    if(awal=akhir) then
    begin
        akhir := nil;
        awal  := nil;
        dispose(phapus);
    end
    else
    begin
        akhir := akhir^.prev;
        akhir^.next := nil;
        dispose(phapus);   
    end; //endif
    gotoxy(43,7); writeln('-------------------------');
    gotoxy(43,8); writeln('Data Belakang Sudah Di hapus');
    gotoxy(43,9); writeln('-------------------------');
    readln;
end; //endprocedure


procedure tampildata(awal:point);
{i.s: harga sudah terdefinisi}
{f.s: menampilkan data yang telah disisipkan}

var 
    bantu: point;
    i: integer;

begin
    bantu := awal;
    i := 1;
    while(bantu <> nil) do
    begin
        gotoxy(33,4); writeln('-----------------------------------------------------');
        gotoxy(33,5); writeln('               Menampilkan Data Buku                 ');
        gotoxy(33,6); writeln('-----------------------------------------------------');
        gotoxy(33,7); writeln('| Kode buku |    Nama buku    | Tahun |  Pengarang  |');
        gotoxy(33,8); writeln('-----------------------------------------------------');
        gotoxy(33,8+i); write('|           |                 |       |             |');
        gotoxy(35,8+i); writeln(bantu^.info.kode);
        gotoxy(47,8+i); writeln(bantu^.info.nama);
        gotoxy(65,8+i); writeln(bantu^.info.tahun);
        gotoxy(73,8+i); writeln(bantu^.info.pengarang);
        bantu := bantu^.next;
        i := i+1
    end; //endwhile
    gotoxy(33,8+i); writeln('-----------------------------------------------------');
    readln;
end; //endprocedure


procedure Cari_kode(awal : point);
{i.s: user memasukan kode buku yang akan dicari}
{f.s: menampilkan data buku yang dicari}

var
    kodecari: string;
    ketemu : boolean;
    bantu  : point;

begin
    if(awal = nil) then
    begin
        gotoxy(33,3); writeln('Data masih Kosong');
    end
    else
    begin
        gotoxy(33,3); write('Kode buku yang dicari : '); readln(kodecari);
        bantu  := awal;
        ketemu := false;
        while(not ketemu) and (bantu <> nil) do
        begin
            if(bantu^.info.kode = kodecari) then
                ketemu := true
            else
                bantu := bantu^.next;
        end; //endwhile
        if(ketemu) then
        begin
            gotoxy(33,5); writeln('-----------------------------------------------------');
            gotoxy(33,6); writeln('                  Data yang dicari                   ');
            gotoxy(33,7); writeln('-----------------------------------------------------');
            gotoxy(33,8); writeln('| Kode buku |    Nama buku    | Tahun |  Pengarang  |');
            gotoxy(33,9); writeln('-----------------------------------------------------');            
            gotoxy(33,10); write('|           |                 |       |             |');
            gotoxy(35,10); writeln(bantu^.info.kode);
            gotoxy(47,10); writeln(bantu^.info.nama);
            gotoxy(65,10); writeln(bantu^.info.tahun);
            gotoxy(73,10); writeln(bantu^.info.pengarang);
            gotoxy(33,11); writeln('-----------------------------------------------------');  
        end
        else
        begin
            gotoxy(52,3); writeln('Kode Buku ',kodecari,' tidak di temukan');
        end;
    end;
    readln;
end; //endprocedure


procedure Cari_nama(awal : point);
{i.s: user memasukan nama buku yang akan dicari}
{f.s: menampilkan data buku yang dicari}

var
    kodecari: string;
    ketemu : boolean;
    bantu  : point;

begin
    if(awal = nil) then
    begin
        gotoxy(33,3); writeln('Data masih Kosong');
    end
    else
    begin
        gotoxy(33,3); write('Nama Buku yang dicari : '); readln(kodecari);
        bantu  := awal;
        ketemu := false;
        while(not ketemu) and (bantu <> nil) do
        begin
            if(bantu^.info.nama = kodecari) then
                ketemu := true
            else
                bantu := bantu^.next;
        end; //endwhile
        if(ketemu) then
        begin
            gotoxy(33,5); writeln('-----------------------------------------------------');
            gotoxy(33,6); writeln('                  Data yang dicari                   ');
            gotoxy(33,7); writeln('-----------------------------------------------------');
            gotoxy(33,8); writeln('| Kode buku |    Nama buku    | Tahun |  Pengarang  |');
            gotoxy(33,9); writeln('-----------------------------------------------------');            
            gotoxy(33,10); write('|           |                 |       |             |');
            gotoxy(35,10); writeln(bantu^.info.kode);
            gotoxy(47,10); writeln(bantu^.info.nama);
            gotoxy(65,10); writeln(bantu^.info.tahun);
            gotoxy(73,10); writeln(bantu^.info.pengarang);
            gotoxy(33,11); writeln('-----------------------------------------------------');  
        end
        else
        begin
            gotoxy(52,3); writeln('Kode Buku ',kodecari,' tidak di temukan');
        end;
    end;
    readln;
end; //endprocedure


procedure Cari_pengarang(awal : point);
{i.s: user memasukan nama pengarang buku yang akan dicari}
{f.s: menampilkan data buku yang dicari}
var
    kodecari: string;
    ketemu : boolean;
    bantu  : point;

begin
    if(awal = nil) then
    begin
        gotoxy(33,3); writeln('Data masih Kosong');
    end
    else
    begin
        gotoxy(33,3); write('pengarang Buku yang dicari : '); readln(kodecari);
        bantu  := awal;
        ketemu := false;
        while(not ketemu) and (bantu <> nil) do
        begin
            if(bantu^.info.pengarang = kodecari) then
                ketemu := true
            else
                bantu := bantu^.next;
        end; //endwhile
        if(ketemu) then
        begin
            gotoxy(33,5); writeln('-----------------------------------------------------');
            gotoxy(33,6); writeln('                  Data yang dicari                   ');
            gotoxy(33,7); writeln('-----------------------------------------------------');
            gotoxy(33,8); writeln('| Kode buku |    Nama buku    | Tahun |  Pengarang  |');
            gotoxy(33,9); writeln('-----------------------------------------------------');
            gotoxy(33,10); write('|           |                 |       |             |');
            gotoxy(35,10); writeln(bantu^.info.kode);
            gotoxy(47,10); writeln(bantu^.info.nama);
            gotoxy(65,10); writeln(bantu^.info.tahun);
            gotoxy(73,10); writeln(bantu^.info.pengarang);
            gotoxy(33,11); writeln('-----------------------------------------------------');  
        end
        else
        begin
            gotoxy(33,4); writeln('Pengarang Buku ',kodecari,' tidak di temukan');
        end;
    end;
    readln;
end; //endprocedure


procedure penghancuran(var awal,akhir:point);
{i.s: harga sudah terdefinisi}
{f.s: data linked list dihancurkan / dikembalikan nilainya yaitu (nil)}

var
    phapus : point;

begin //algoritma
    phapus := awal;
    while(phapus <> nil) do
    begin
        awal := awal^.next;
        dispose(phapus);
        phapus:= awal;
    end;
    akhir := nil;
end; //endprocedure


procedure menu_sisip(var pilihan_sisip:integer);
{i.s: user memasukan pilihan menu sisip data}
{f.s: memberikan pilihan yang akan dibuka}

//kamus tidak ada

begin
    gotoxy(38,3);  writeln('============================================');
    gotoxy(38,4);  writeln('|              Menu Sisip                  |');
    gotoxy(38,5);  writeln('--------------------------------------------');
    gotoxy(38,6);  writeln('|****       1. Sisip Depan             ****|');
    gotoxy(38,7);  writeln('|**         2. Sisip tengah              **|');
    gotoxy(38,8);  writeln('|*          3. Sisip Belakang             *|');
    gotoxy(38,9);  writeln('|**         4. Kembali ke Menu Utama     **|');
    gotoxy(38,10); writeln('--------------------------------------------');
    gotoxy(38,11); write('Daftar Pilihan : '); readln(pilihan_sisip);
    {validasi}
    while(pilihan_sisip < 0) or (pilihan_sisip > 4)do
    begin
        gotoxy(38,12); writeln('Pilihan anda tidak ada di daftar'); readln;
        gotoxy(38,12); clreol;
        gotoxy(55,11); clreol;
        readln(pilihan_sisip);
    end; //endwhile
end; //endprocedure



procedure menu_hapus(var pilihan_hapus:integer);
{i.s: user memasukan pilihan menu hapus data }
{f.s: memberikan pilihan yang akan dibuka}

//kamus tidak ada

begin
    gotoxy(38,3);  writeln('============================================');
    gotoxy(38,4);  writeln('|              Menu Hapus                  |');
    gotoxy(38,5);  writeln('--------------------------------------------');
    gotoxy(38,6);  writeln('|****       1. Hapus Depan             ****|');
    gotoxy(38,7);  writeln('|**         2. Hapus tengah              **|');
    gotoxy(38,8);  writeln('|*          3. Hapus Belakang             *|');
    gotoxy(38,9);  writeln('|**         4. Kembali ke Menu Utama     **|');
    gotoxy(38,10); writeln('--------------------------------------------');
    gotoxy(38,11); write('Daftar Pilihan : '); readln(pilihan_hapus);
    {validasi}
    while(pilihan_hapus < 0) or (pilihan_hapus > 4)do
    begin
        gotoxy(38,12); writeln('Pilihan anda tidak ada di daftar'); readln;
        gotoxy(38,12); clreol;
        gotoxy(55,11); clreol;
        readln(pilihan_hapus);
    end; //endwhile
end; //endprocedure


procedure menu_cari(var pilihan_cari:integer);
{i.s: user memasukan pilihan menu}
{f.s: memberikan pilihan yang akan dibuka}

//kamus tidak ada

begin
    gotoxy(38,3);  writeln('============================================');
    gotoxy(38,4);  writeln('|              Menu Cari                  |');
    gotoxy(38,5);  writeln('--------------------------------------------');
    gotoxy(38,6);  writeln('|****       1. Cari Kode Buku          ****|');
    gotoxy(38,7);  writeln('|**         2. Cari Nama Buku            **|');
    gotoxy(38,8);  writeln('|*          3. Cari Pengarang             *|');
    gotoxy(38,9);  writeln('|**         4. Kembali ke Menu Utama     **|');
    gotoxy(38,10); writeln('--------------------------------------------');
    gotoxy(38,11); write('Daftar Pilihan : '); readln(pilihan_cari);
    {validasi}
    while(pilihan_cari < 0) or (pilihan_cari > 4)do
    begin
        gotoxy(38,12); writeln('Pilihan anda tidak ada di daftar'); readln;
        gotoxy(38,12); clreol;
        gotoxy(55,11); clreol;
        readln(pilihan_cari);
    end; //endwhile
end; //endprocedure


procedure menu_utama(var menu:integer);
{i.s: user memasukan pilihan menu}
{f.s: memberikan pilihan yang akan dibuka}

//kamus tidak ada

begin
    gotoxy(38,3);  writeln('============================================');
    gotoxy(38,4);  writeln('|              Selamat Datang              |');
    gotoxy(38,5);  writeln('--------------------------------------------');
    gotoxy(38,6);  writeln('|               Perpustakaan               |');
    gotoxy(38,7);  writeln('--------------------------------------------');
    gotoxy(38,8);  writeln('|****         1. Sisip Data            ****|');
    gotoxy(38,9);  writeln('|**           2. Hapus Data              **|');
    gotoxy(38,10); writeln('|*            3. Cari Data                *|');
    gotoxy(38,11); writeln('|**           4. Tampil Data             **|');
    gotoxy(38,12); writeln('|****         5. Keluar                ****|');
    gotoxy(38,13); writeln('--------------------------------------------');
    gotoxy(38,14); write('Daftar Pilihan : '); readln(menu);
    {validasi}
    while(menu < 0) or (menu > 5)do
    begin
        gotoxy(38,15); writeln('Pilihan anda tidak ada di daftar'); readln;
        gotoxy(38,15); clreol;
        gotoxy(55,14); clreol;
        readln(menu);
    end; //endwhile
end; //endprocedure



// badan program utama
begin
    //penciptaan
    awal := nil;
    akhir:= nil;
    
    repeat
    clrscr;
    menu_utama(menu);
    clrscr;
    case(menu)of
        1: begin
                repeat
                    clrscr;
                    menu_sisip(pilihan_sisip);
                    clrscr;
                    case(pilihan_sisip)of
                        1: begin
                                SisipDepan(awal,akhir);
                           end;
                        2: begin
                                sisiptengah(awal,akhir);
                           end;
                        3: begin
                                sisipbelakang(awal,akhir);
                           end;
                    end; //endcase
                until(pilihan_sisip=4);
                hapussama(awal,akhir);    
            end;
        2: begin
                repeat
                    clrscr;
                    menu_hapus(pilihan_hapus);
                    clrscr;
                    case(pilihan_hapus)of
                        1: begin
                                hapusDepan(awal,akhir);
                           end;
                        2: begin
                                hapusTengah(awal,akhir);
                           end;
                        3: begin     
                                hapusBelakang(awal,akhir);
                           end;
                    end; //endcase
                until(pilihan_hapus=4);         
            end;
        3: begin
                repeat
                    clrscr;
                    menu_cari(pilihan_cari);
                    clrscr;
                    case(pilihan_cari)of
                        1: begin
                                cari_kode(awal);
                           end;
                        2: begin
                                Cari_nama(awal);
                           end;
                        3: begin
                                Cari_pengarang(awal);
                           end;
                    end; //endcase
                until(pilihan_hapus=4);
            end;
        4: begin
                tampildata(awal);
            end;
    end; //endcase
    until(menu=5);
        
    penghancuran(awal,akhir);
    if(awal = nil) then
    begin
        writeln('data sudah kosong');
        readln;;
    end; //endif
end.