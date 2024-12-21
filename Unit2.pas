unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, ValEdit, acc;

type
  TForm2 = class(TForm)
    ValueListEditor1: TValueListEditor;
    LabeledEdit1: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses uplot3d;

{$R *.dfm}

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Form1.Enabled:=True;
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  i:integer;
begin
  for i:=1 to 31 do
    mech[Form1.CheckListBox1.ItemIndex+1].a[i]:=strtofloat(Form2.ValueListEditor1.Cells[1,i]);
  for i:=1 to length(LabeledEdit1.Text) do
    mech[Form1.CheckListBox1.ItemIndex+1].name[i]:=Form2.LabeledEdit1.Text[i];
  saving_mech;
  Form2.Close;
end;

end.
