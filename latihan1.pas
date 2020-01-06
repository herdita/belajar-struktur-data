program bilangan;
{i.s:}
{f.s:}

//kamus
    type
        point = ^data;
        data = record
            info : integer;
            prev,next : point;
        end; //endrecord

    var
        awal,akhir: point;

//algoritma
begin
    write('masukan jumlah angka yang di inputkan : '); readln(n);
    awal := nil;
    akhir := nil;
    new(baru);
    for i := 1 to n do
    write('Masukan angka : '); readln(baru^.info);
    
    if(awal = nil) then
        
    end; //endfor
end;