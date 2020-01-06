program DoubleLinkedList;
uses crt;
//kamus global
type
   Point = ^Data;
   Mahasiswa = record
      NIM, Nama : string;
   end;//record
   Data = record
     info : Mahasiswa;
     Prev,Next : Point;
   end;//record

var
   Awal, Akhir, Awal2, Akhir2 : Point;
   Elemen      : string;
   Lagi        : char;

procedure IsiData(var Elemen : string); //by reference Output
begin
   write('Masukkan NIM  : '); readln(Elemen);
end;//procedure isi data

procedure SisipDepan(Elemen : string; var Awal,Akhir : Point); //by value dari isidata (Elemen) & by reference
var
   Baru,Bantu : Point;
   Ketemu     : Boolean;
begin
   New(Baru);
   Baru^.Info.NIM := Elemen;  //nim tidak boleh sama
   if (Awal = Nil) then
   begin
      write('Masukkan Nama : ');
      readln(Baru^.Info.Nama);
      Baru^.Prev := Nil;
      Baru^.Next := Nil;
      Awal  := Baru;
      Akhir := Baru;
   end
   else
   begin
      Bantu  := Awal ;
      Ketemu := false;
      while(not Ketemu) and (Bantu <>Nil) do
      begin
        if (Bantu^.Info.NIM = Baru^.Info.Nim)
        then
           Ketemu := true
        else
           Bantu := Bantu^.Next;
      end; //while
      if(Ketemu)
      then
         writeln('Maaf , Nim ', Elemen ,' sudah ada')
      else
      begin
         write('Masukkan Nama : ');
         readln(Baru^.Info.Nama);
         Baru^.Prev := Nil;
         Baru^.Next := Awal;
         Awal^.Prev := Baru;
         Awal := Baru;
      end;//if(ketemu)

   end;//if
end; //procedure sisip depan

procedure TampilData(Awal : Point);
var
   Bantu : Point;
begin
   Bantu := Awal;
   while (Bantu <> Nil) do
   begin
     writeln(Bantu^.Info.NIM,' ', Bantu^.Info.Nama);
     Bantu := Bantu^.Next;
   end;
end;//procedure Tampil Data

//membuat pengurutan dengan cara list kedua
procedure UrutNIM(Awal:Point; var Awal2,Akhir2:Point);
var
   Bantu,Bantu2,Baru : Point;
begin
   Awal2 := Nil;
   Akhir2:= Nil;
   Bantu := Awal;
   while(Bantu <> Nil) do
   begin
      New(Baru);
      Baru^.Info := Bantu^.Info;
      if (Awal2 = Nil) then
      begin
         Baru^.Prev := Nil;
         Baru^.Next := Nil;
         Awal2  := Baru;
         Akhir2 := Baru;
      end
      else
      begin //bantu = NIL
         if(Baru^.Info.NIM < Awal2^.Info.NIM) then
         begin //sisip depan
            Baru^.Prev   := Nil;
            Baru^.Next   := Awal2;
            Awal2^.Prev  := Baru;
            Awal2 := Baru;
      
         end
         else
         begin  //sisip belakang & tengah
            if (Baru^.Info.Nim > Akhir^.Info.NIM) then
            begin //sisip belakang
               Baru^.Next   := Nil;
               Baru^.Prev   := Akhir2;
               Akhir2^.Next := Baru;
               Akhir2 := Baru
            end
            else
            begin //sisip tengah
               Bantu2 := Awal2;
               while(Bantu2^.Info.NIM < Baru^.Info.NIM) do
               begin
                  Bantu2 := Bantu2^.Next;
               end;//while
               Baru^.Next := Bantu2;
               Baru^.Prev := Bantu2^.Prev;
               Bantu2^.Prev^.Next := Baru;
               Bantu2^.Prev := Baru;
            end;//if sisip belakang & tengah
         end ; //if
      end;//if
      Bantu := Bantu^.Next;
   end;//while
end; //procedure

procedure HapusData(var Awal,Akhir : Point); //hapus depan., buat hapus belakang !!!!
var
  NIMHapus : string;
  Bantu    : Point;
  Ketemu   : Boolean;
begin
  write('Nim yang akan dihapus : ');
  readln(NIMHapus);
  Bantu := Awal;
  Ketemu := false;
  while(Not Ketemu) and (Bantu <>NIl) do
  begin
     if (Bantu^.Info.NIM = NIMHapus)
     then
       Ketemu := true
     else
       Bantu := Bantu^.Next;
  end;//while
  if (Ketemu) then
  begin
    if(Bantu = Awal) then
    begin
     //hapus depan
      Awal := Awal^.Next;
      Awal^.Prev := Nil;
      Dispose(Bantu);
    end
    else
    begin
      if (Bantu = Akhir) then
      begin   //hapus belakang
        Akhir := Akhir^.Prev;
        Akhir^.Next := Nil;
        Dispose(Bantu);
      end
      else
      begin//hapus tengah
        Bantu^.Prev^.Next := Bantu^.Next;
        Bantu^.Next^.Prev := Bantu^.Prev;
      end;//hapus belakang

    end;//if hapus depan

  end
  else
    writeln('Nim ' ,NIMHapus,' tidak ditemukan');

end;

procedure Penghancuran(Awal, Akhir : Point); //by reference I/O
var
   Phapus : Point;
begin
  Phapus := Awal;
  while (Phapus <> Nil) do
  begin
     Awal := Awal^.Next;
     Dispose(Phapus);
     Phapus := Awal;
  end;//while
  Akhir := Nil;
end;








//badan program utama
begin
  //penciptaan
  Awal := Nil;
  Akhir:= Nil;

  repeat  //menu
     IsiData(Elemen);
     SisipDepan(Elemen,Awal,Akhir);
     write('Mau memasukkan data lagi [Y/T] ? ');
     readln(Lagi);
     writeln;

  until(upcase(Lagi) = 'T');

  clrscr;
  TampilData(Awal);
  readln;

  UrutNIM(Awal,Awal2,Akhir2);
  TampilData(Awal2);
  readln;

  clrscr;
  HapusData(Awal,Akhir);
  TampilData(Awal);
  readln;

  Penghancuran(Awal,Akhir);
  if (Awal = Nil) then
  begin
     writeln('Data Sudah Kosong');
     readln;
  end;//if
end.
