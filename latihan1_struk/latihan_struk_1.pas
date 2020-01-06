program double_circuler_linked_list;
{i.s:}
{f.s:}

{kamus}
    type
        point = ^data;
        mahasiswa = record
            nim,nama: string;
            nilai   : integer;
        end; //endrecord
        data = record
            info : mahasiswa;
            prev,next : point;
        end; //endrecord

    var
        awal,akhir : point;
        ulang : char;

procedure creat(var awal,akhir : point);

{kamus}


{algoritma}
begin
    awal := nil;
    akhir := nil;
end; //endprocedure


procedure sisip_depan(var awal,akhir:point);

{kamus}
var
    baru,bantu: point;

{algoritma}
begin
    new(baru);
    write('Nim : '); readln(baru^.info.nim);
    write('Nama : '); readln(baru^.info.nama);
    write('Nilai : '); readln(baru^.info.nilai);

    if(awal=nil)then
    begin
        awal := baru;
        akhir := baru;
        baru^.next := baru;
        baru^.prev := baru;
    end
    else
    begin
        baru^.next := awal;
        awal^.prev := baru;
        awal       := baru;
        akhir^.next:= baru;
        baru^.prev := akhir;        
    end;

    bantu := awal;
    repeat
        writeln('Nim : ',baru^.info.nim);
        writeln('Nama : ',baru^.info.nama);
        writeln('Nilai : ',baru^.info.nilai);
        writeln('---------------------------');
        bantu := bantu^.next;
    until(bantu=akhir);
    
    readln;
end;

begin
    repeat
        creat(awal,akhir);
        sisip_depan(awal,akhir);
        write('Y/t'); readln(ulang);
    until(ulang = 't');
end.