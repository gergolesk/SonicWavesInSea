program test;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const
  sat:real=5;

var
  f1, f2, f3: textfile;
  i, j, sumb, sumg: integer;
  w, sum:real;
  B, G: array[1..100,1..100] of integer;
  R: array[1..100,1..100] of real;
begin
  sumb:=0; sumg:=0;
  { TODO -oUser -cConsole Main : Insert code here }
  AssignFile(f1,'B.in');
  AssignFile(f2,'G.in');
  AssignFile(f3,'R.out');
  reset(f1);
  reset(f2);
  rewrite(f3);
  write('Input frequency ==> ');
  readln(w);
  {reading B from file}
  sum:=0;
  for i:=1 to 32 do
  begin
    for j:=1 to 11 do
    begin
      read(f1,B[i,j]);
      sumb:=sumb+B[i,j];
    end;
  end;
  {reading G from file}
  for i:=1 to 24 do
  begin
    for j:=1 to 11 do
    begin
      read(f2,G[i,j]);
      sumg:=sumg+G[i,j];
    end;
  end;
  CloseFile(f1);
  CloseFile(f2);


  for i:=1 to 24 do
  begin
    for j:=1 to 32 do
    begin
         if w=10 then   R[i,j]:=(B[j,1]+G[i,1])/2;
         if w=12.5 then R[i,j]:=(B[j,2]+G[i,2])/2;
         if w=16 then   R[i,j]:=(B[j,3]+G[i,3])/2;
         if w=20 then   R[i,j]:=(B[j,4]+G[i,4])/2;
         if w=25 then   R[i,j]:=(B[j,5]+G[i,5])/2;
         if w=31.6 then R[i,j]:=(B[j,6]+G[i,6])/2;
         if w=40 then   R[i,j]:=(B[j,7]+G[i,7])/2;
         if w=50 then   R[i,j]:=(B[j,8]+G[i,8])/2;
         if w=63 then   R[i,j]:=(B[j,9]+G[i,9])/2;
         if w=80 then   R[i,j]:=(B[j,10]+G[i,10])/2;
         if w=100 then  R[i,j]:=(B[j,11]+G[i,11])/2;
         //R[i,j]:=(B[j,5]+G[i,5])/2;
      if R[i,j]<sat then R[i,j]:=0;
      sum:=sum+R[i,j];
      write(f3,R[i,j]:3:4,'  ');
    end;
    writeln(f3,'');
  end;
  for j:=1 to 24 do
    writeln(R[j,1]:2:2,' ');
  writeln(sumb,'  ',sumg,'  ',sum:1:4);
  CloseFile(f3);
  readln;
end.
 