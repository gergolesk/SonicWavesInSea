unit uplot3d;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, SDL_sdlbase, Menus,
  SDL_Colsel, SDL_NumLab, SDL_plot3d, ComCtrls, jpeg, math, CheckLst, acc;

type
  TForm1 = class(TForm)
    Plot3D1: TPlot3D;
    Panel2: TPanel;
    popMenMouse: TPopupMenu;
    Rotate1: TMenuItem;
    Pan1: TMenuItem;
    Zoom1: TMenuItem;
    RotateandZoom1: TMenuItem;
    RotXOnly1: TMenuItem;
    RotZOnly1: TMenuItem;
    NLabCellX: TNumLab;
    NLabCellY: TNumLab;
    LabeledEdit1: TLabeledEdit;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Panel1: TPanel;
    Panel3: TPanel;
    StatusBar1: TStatusBar;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    PaintBox1: TPaintBox;
    PaintBox2: TPaintBox;
    PaintBox3: TPaintBox;
    MainMenu1: TMainMenu;
    A1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    XYZ1: TMenuItem;
    XYZ2: TMenuItem;
    N8: TMenuItem;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    CheckListBox1: TCheckListBox;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label3: TLabel;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    Label4: TLabel;
    Label5: TLabel;
    Button4: TButton;
    Button5: TButton;
    procedure BButExitClick(Sender: TObject);
    procedure ScrBarAngleXChange(Sender: TObject);
    procedure ScrBarAngleZChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CSelHighChange(Sender: TObject);
    procedure CSelLowChange(Sender: TObject);
    procedure CSelGridChange(Sender: TObject);

    procedure Rotate1Click(Sender: TObject);
    procedure Pan1Click(Sender: TObject);
    procedure Zoom1Click(Sender: TObject);
    procedure RotateandZoom1Click(Sender: TObject);
    procedure RotXOnly1Click(Sender: TObject);
    procedure RotZOnly1Click(Sender: TObject);
    procedure Plot3D1MouseAction(Sender: TObject; var CenterX,
      CenterY: Integer; var RotXAngle, RotZAngle, Magnification: Double;
      Shift: TShiftState);
    procedure CselMidChange(Sender: TObject);
    procedure ScrBarColorHighChange(Sender: TObject);
    procedure CBox3colmodClick(Sender: TObject);
    procedure ScrBarSclZChange(Sender: TObject);
    procedure ScrBarSclXChange(Sender: TObject);
    procedure ScrBarSclYChange(Sender: TObject);
    procedure SBResetClick(Sender: TObject);
    procedure Plot3D1BeforeRenderPolygon(Sender: TObject;
      canvas: Tcanvas; var Handled: Boolean; CellX, CellY: Integer;
      quad: TQuad; var color: TColor);
    procedure Plot3D1DataRendered(Sender: TObject; canvas: Tcanvas);
    procedure Plot3D1MouseMoveOverPlot(Sender: TObject; OverPlot: Boolean;
      Shift: TShiftState; MouseCellX, MouseCellY: Integer);
    procedure CBoxZcoordsClick(Sender: TObject);
    procedure ColSelXChange(Sender: TObject);
    procedure ColSelYChange(Sender: TObject);
    procedure ColSelZChange(Sender: TObject);
    procedure RGFrameModeClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure XYZ1Click(Sender: TObject);
    procedure XYZ2Click(Sender: TObject);
    procedure CheckListBox1Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);


  private
    MCellX, MCellY : integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  w:real;
  R: array[1..100,1..100] of real;
  fix:boolean;

implementation

uses Unit2;

const
  Bmax:integer=32;
  Gmax:integer=24;
  w_c:integer=11;

{$R *.DFM}

(**************************************************************************)
procedure TForm1.BButExitClick(Sender: TObject);
(**************************************************************************)

begin
close;
end;

(******************************************************************************)
procedure TForm1.ScrBarAngleXChange(Sender: TObject);
(******************************************************************************)

begin

end;

(******************************************************************************)
procedure TForm1.ScrBarAngleZChange(Sender: TObject);
(******************************************************************************)

begin

end;

(******************************************************************************)
procedure set_point(x,y:integer);
var
  xs,ys:integer;
  xm,ym,yt,angle,angler,R,c:real;
begin
  Form1.PaintBox1.Repaint;
  Form1.PaintBox2.Repaint;
  Form1.PaintBox3.Repaint;

  Form1.PaintBox1.Canvas.Pen.Color:=clBlack;
  Form1.PaintBox1.Canvas.Brush.Color:=clRed;
  Form1.PaintBox2.Canvas.Pen.Color:=clBlack;
  Form1.PaintBox2.Canvas.Brush.Color:=clRed;
  Form1.PaintBox3.Canvas.Pen.Color:=clBlack;
  Form1.PaintBox3.Canvas.Brush.Color:=clRed;

  R:=2*Gmax/pi;
  xm:=Form1.PaintBox1.Width/Bmax;
  ym:=Form1.PaintBox1.Height/(2*R);
  xs:=round(x*xm);
  
  angle:=360*y/Gmax;
  angler:=angle*pi/180;
  yt:=R-cos(angler)*R;
  ys:=round(yt*ym);
  //���� ������� ���� +, �� ����� ����, ����� ������
  if (angle>0) and (angle<=180) then
    Form1.PaintBox1.Canvas.Ellipse(xs-5,ys-5,xs+5,ys+5)
    //Form1.Label2.Caption:='left  '+floattostr(angle)
  else
    Form1.PaintBox2.Canvas.Ellipse(Form1.PaintBox2.Width-xs-5,ys-5,Form1.PaintBox2.Width-xs+5,ys+5);

  yt:=R-sin(angler)*R;
  ys:=round(yt*ym);
  //���� ����� ���� +, �� ����, ����� ���
  if ((angle>=270) and (angle<=360)) or ((angle>=0) and (angle<=90)) then
    Form1.PaintBox3.Canvas.Ellipse(xs-5,ys-5,xs+5,ys+5);

  
end;


procedure field_calc;

var
  f1, f2, f3: textfile;
  i, j: integer;
  B, G: array[1..100,1..100] of integer;
  max,sat:real;

begin
  w:=strtofloat(Form1.ComboBox1.Text);
  sat:=strtofloat(Form1.LabeledEdit1.Text);
  { TODO -oUser -cConsole Main : Insert code here }
  AssignFile(f1,'B.in');
  AssignFile(f2,'G.in');
  AssignFile(f3,'R.out');
  reset(f1);
  reset(f2);
  rewrite(f3);

  {reading B from file}
  for i:=1 to Bmax do
  begin
    for j:=1 to w_c do
    begin
      read(f1,B[i,j]);
    end;

  end;

  {reading G from file}
  for i:=1 to Gmax do
  begin
    for j:=1 to w_c do
    begin
      read(f2,G[i,j]);
    end;

  end;
  CloseFile(f1);
  CloseFile(f2);

  max:=0;
  for i:=1 to Gmax do
  begin
    for j:=1 to Bmax do
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

      if R[i,j]<sat then R[i,j]:=0;
      if R[i,j]>max then max:=R[i,j];
      write(f3,R[i,j]:3:4,'  ');
    end;
    writeln(f3,'');
  end;
  Form1.Plot3D1.RangeXLow:=0;
  Form1.Plot3D1.RangeXHigh:=Bmax;
  Form1.Plot3D1.RangeYLow:=0;
  Form1.Plot3D1.RangeYHigh:=Gmax;
  Form1.Plot3D1.RangeZLow:=0;
  Form1.Plot3D1.RangeZHigh:=max;
  CloseFile(f3);
end;

procedure drawing;
var
  i,j : integer;
  max,min:Real;
begin
  calc(Form1.ComboBox1.ItemIndex+1);
  max:=0; min:=100000;
  Form1.Plot3D1.GridMat.Resize (Bmax,Gmax);
  for i:=1 to Gmax do
    for j:=1 to Bmax do
    begin
      Form1.Plot3D1.GridMat[j,i] := La[i,j];
      if max<La[i,j] then max:=La[i,j];
      if min>La[i,j] then min:=La[i,j];
      if La[i,j]<strtofloat(Form1.LabeledEdit1.Text) then Form1.Plot3D1.GridMat[j,i]:=strtofloat(Form1.LabeledEdit1.Text);
    end;
  Form1.Plot3D1.RangeZLow:=strtofloat(Form1.LabeledEdit1.Text);
  Form1.Plot3D1.RangeZHigh:=max;
  Form1.Plot3D1.ColorScaleHigh:=max;
  Form1.Plot3D1.ColorScaleLow:=min;

end;

(******************************************************************************)
procedure TForm1.FormShow(Sender: TObject);
(******************************************************************************)

begin
  drawing;
end;


(******************************************************************************)
procedure TForm1.CSelHighChange(Sender: TObject);
(******************************************************************************)

begin

end;

(******************************************************************************)
procedure TForm1.CSelLowChange(Sender: TObject);
(******************************************************************************)

begin

end;


(******************************************************************************)
procedure TForm1.CselMidChange(Sender: TObject);
(******************************************************************************)

begin

end;


(******************************************************************************)
procedure TForm1.CSelGridChange(Sender: TObject);
(******************************************************************************)

begin

end;




(******************************************************************************)
procedure TForm1.Rotate1Click(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.MouseAction := maRotate;
Form1.popMenMouse.Items[0].Checked:=true;
Form1.popMenMouse.Items[1].Checked:=false;
Form1.popMenMouse.Items[2].Checked:=false;
Form1.popMenMouse.Items[3].Checked:=false;
Form1.popMenMouse.Items[4].Checked:=false;
Form1.popMenMouse.Items[5].Checked:=false;
end;

(******************************************************************************)
procedure TForm1.Pan1Click(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.MouseAction := maPan;
Form1.popMenMouse.Items[0].Checked:=false;
Form1.popMenMouse.Items[1].Checked:=true;
Form1.popMenMouse.Items[2].Checked:=false;
Form1.popMenMouse.Items[3].Checked:=false;
Form1.popMenMouse.Items[4].Checked:=false;
Form1.popMenMouse.Items[5].Checked:=false;

end;

(******************************************************************************)
procedure TForm1.Zoom1Click(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.MouseAction := maZoom;
Form1.popMenMouse.Items[0].Checked:=false;
Form1.popMenMouse.Items[1].Checked:=false;
Form1.popMenMouse.Items[2].Checked:=true;
Form1.popMenMouse.Items[3].Checked:=false;
Form1.popMenMouse.Items[4].Checked:=false;
Form1.popMenMouse.Items[5].Checked:=false;
end;

(******************************************************************************)
procedure TForm1.RotateandZoom1Click(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.MouseAction := maRotAndZoom;
Form1.popMenMouse.Items[0].Checked:=false;
Form1.popMenMouse.Items[1].Checked:=false;
Form1.popMenMouse.Items[2].Checked:=false;
Form1.popMenMouse.Items[3].Checked:=true;
Form1.popMenMouse.Items[4].Checked:=false;
Form1.popMenMouse.Items[5].Checked:=false;
end;

(******************************************************************************)
procedure TForm1.RotXOnly1Click(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.MouseAction := maRotXOnly;
Form1.popMenMouse.Items[0].Checked:=false;
Form1.popMenMouse.Items[1].Checked:=false;
Form1.popMenMouse.Items[2].Checked:=false;
Form1.popMenMouse.Items[3].Checked:=false;
Form1.popMenMouse.Items[4].Checked:=true;
Form1.popMenMouse.Items[5].Checked:=false;
end;

(******************************************************************************)
procedure TForm1.RotZOnly1Click(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.MouseAction := maRotZOnly;
Form1.popMenMouse.Items[0].Checked:=false;
Form1.popMenMouse.Items[1].Checked:=false;
Form1.popMenMouse.Items[2].Checked:=false;
Form1.popMenMouse.Items[3].Checked:=false;
Form1.popMenMouse.Items[4].Checked:=false;
Form1.popMenMouse.Items[5].Checked:=true;
end;


(******************************************************************************)
procedure TForm1.Plot3D1MouseAction(Sender: TObject; var CenterX,
  CenterY: Integer; var RotXAngle, RotZAngle, Magnification: Double;
  Shift: TShiftState);
(******************************************************************************)

begin

end;


(******************************************************************************)
procedure TForm1.ScrBarColorHighChange(Sender: TObject);
(******************************************************************************)

begin

end;

(******************************************************************************)
procedure TForm1.CBox3colmodClick(Sender: TObject);
(******************************************************************************)

begin

end;


(******************************************************************************)
procedure TForm1.ScrBarSclZChange(Sender: TObject);
(******************************************************************************)

begin

end;

(******************************************************************************)
procedure TForm1.ScrBarSclXChange(Sender: TObject);
(******************************************************************************)

begin

end;

(******************************************************************************)
procedure TForm1.ScrBarSclYChange(Sender: TObject);
(******************************************************************************)

begin

end;

(******************************************************************************)
procedure TForm1.SBResetClick(Sender: TObject);
(******************************************************************************)

begin
//Plot3D1.Reset;
Plot3D1.ViewAngleX:=66;
Plot3D1.ViewAngleZ:=315;
end;



(******************************************************************************)
procedure TForm1.Plot3D1BeforeRenderPolygon(Sender: TObject;
  canvas: Tcanvas; var Handled: Boolean; CellX, CellY: Integer;
  quad: TQuad; var color: TColor);
(******************************************************************************)

begin

if Form1.popMenMouse.Items[7].Checked then
  if (CellX = MCellX) or (CellY = MCellY) then
    color := clBlue;

if ((CellX =16) or (CellX = 19)) and (CellY = 7) then
  Handled := true;

end;

(******************************************************************************)
procedure TForm1.Plot3D1DataRendered(Sender: TObject; canvas: Tcanvas);
(******************************************************************************)

begin
Canvas.Brush.Style := bsClear;
Canvas.Font.Color := clWhite;
//Canvas.TextOut(50,50,'This is a text drawn in the OnDataRendered event');
end;

(******************************************************************************)
procedure TForm1.Plot3D1MouseMoveOverPlot(Sender: TObject;
  OverPlot: Boolean; Shift: TShiftState; MouseCellX, MouseCellY: Integer);
(******************************************************************************)

begin
MCellX := MouseCellX;
MCellY := MouseCellY;
if OverPlot
  then begin
       NLabCellX.Value := MouseCellX;
       NLabCellY.Value := MouseCellY;
       set_point(MouseCellX,MouseCellY);
       NLabCellX.Empty := false;
       NLabCellY.Empty := false;
       end
  else begin
       NLabCellX.Empty := true;
       NLabCellY.Empty := true;
       end;
Plot3d1.Repaint;
end;

(******************************************************************************)
procedure TForm1.CBoxZcoordsClick(Sender: TObject);
(******************************************************************************)

begin

end;

(******************************************************************************)
procedure TForm1.ColSelXChange(Sender: TObject);
(******************************************************************************)

begin

end;

(******************************************************************************)
procedure TForm1.ColSelYChange(Sender: TObject);
(******************************************************************************)

begin

end;

(******************************************************************************)
procedure TForm1.ColSelZChange(Sender: TObject);
(******************************************************************************)

begin

end;

(******************************************************************************)
procedure TForm1.RGFrameModeClick(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.SuppressPaint := true;

end;




procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  Form1.BitBtn1.Enabled:=False;
  Plot3D1.Clear;

  drawing;
  Form1.BitBtn1.Enabled:=True;
  
end;

procedure TForm1.N1Click(Sender: TObject);
begin
  close;
end;



procedure TForm1.N5Click(Sender: TObject);
begin
  if Form1.popMenMouse.Items[6].Checked=True then Form1.popMenMouse.Items[6].Checked:=False
  else Form1.popMenMouse.Items[6].Checked:=True;

  Form1.Plot3D1.MeshVisible:=Form1.popMenMouse.Items[6].Checked;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
  if Form1.popMenMouse.Items[7].Checked=True then Form1.popMenMouse.Items[7].Checked:=False
  else Form1.popMenMouse.Items[7].Checked:=True;
end;

procedure TForm1.FormActivate(Sender: TObject);
var
  i:integer;
begin
  CheckListBox1.Clear;
  if CheckListBox1.ItemIndex=-1 then Button2.Enabled:=False;
  Plot3D1.ScaleFactX:=Bmax/Gmax;
  CheckListBox1.Items.AddStrings(mech_read);

  ScrollBar1.Enabled:=False;
  ScrollBar2.Enabled:=False;

  //drawing;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  Plot3D1.ViewAngleX:=0;
  Plot3D1.ViewAngleZ:=0;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  Plot3D1.ViewAngleX:=66;
  Plot3D1.ViewAngleZ:=315;
end;

procedure TForm1.XYZ1Click(Sender: TObject);
begin
  Plot3D1.ViewAngleX:=0;
  Plot3D1.ViewAngleZ:=0;
end;

procedure TForm1.XYZ2Click(Sender: TObject);
begin
  Plot3D1.ViewAngleX:=66;
  Plot3D1.ViewAngleZ:=315;
end;

procedure TForm1.CheckListBox1Click(Sender: TObject);
begin
  ScrollBar1.Position:=mech[CheckListBox1.ItemIndex+1].x;
  ScrollBar2.Position:=mech[CheckListBox1.ItemIndex+1].y;
  Label4.Caption:='X='+inttostr(mech[CheckListBox1.ItemIndex+1].x);
  Label5.Caption:='Y='+inttostr(mech[CheckListBox1.ItemIndex+1].y);
  Button2.Enabled:=True;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  mech[CheckListBox1.ItemIndex+1].x:=ScrollBar1.Position;
  Label4.Caption:='X='+inttostr(ScrollBar1.Position);
end;

procedure TForm1.ScrollBar2Change(Sender: TObject);
begin
  mech[CheckListBox1.ItemIndex+1].y:=ScrollBar2.Position;
  Label5.Caption:='Y='+inttostr(ScrollBar2.Position);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i:integer;
begin
  for i:=1 to 31 do
    Form2.ValueListEditor1.Cells[1,i]:=floattostr(mech[CheckListBox1.ItemIndex+1].a[i]);
  Form2.LabeledEdit1.Text:=CheckListBox1.Items[CheckListBox1.ItemIndex];
  Form2.Visible:=True;
  Form2.Left:=Form1.Left+round(Form1.Width/2)-round(Form2.Width/2);
  Form1.Enabled:=False;  
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to CheckListBox1.Items.Count-1 do
    CheckListBox1.Checked[i]:=True;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to CheckListBox1.Items.Count-1 do
    CheckListBox1.Checked[i]:=False;
end;

end.
