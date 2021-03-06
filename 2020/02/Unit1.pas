unit Unit1;

// My solution for https://adventofcode.com/2020/day/2

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Déclarations privées }
    procedure decoupe(input: string; var min, max: integer; var letter: char;
      var password: string);
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  RegularExpressions;

procedure TForm1.Button1Click(Sender: TObject);
var
  i: integer;
  nbMin, nbMax: integer;
  letter: char;
  password: string;
  nb: integer;
  nbOk: integer;
begin
  nbOk := 0;
  for i := 0 to Memo1.Lines.Count - 1 do
  begin
    try
      decoupe(Memo1.Lines[i], nbMin, nbMax, letter, password);
    except
      continue;
    end;
    nb := password.CountChar(letter);
    if (nb >= nbMin) and (nb <= nbMax) then
      inc(nbOk);
  end;
  Edit1.Text := nbOk.ToString;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i: integer;
  nbMin, nbMax: integer;
  letter: char;
  password: string;
  nb: integer;
  nbOk: integer;
begin
  nbOk := 0;
  for i := 0 to Memo1.Lines.Count - 1 do
  begin
    try
      decoupe(Memo1.Lines[i], nbMin, nbMax, letter, password);
    except
      continue;
    end;
    if (password.Chars[nbMin - 1] = letter)
      xor (password.Chars[nbMax - 1] = letter) then
      inc(nbOk);
  end;
  Edit1.Text := nbOk.ToString;
end;

procedure TForm1.decoupe(input: string; var min, max: integer; var letter: char;
  var password: string);
var
  resultats: tmatchcollection;
begin
  resultats := tregex.matches(input, '([0-9a-zA-Z]+)');
  if (resultats.Count <> 4) then
    raise exception.Create('no found');
  min := resultats[0].Value.ToInteger;
  max := resultats[1].Value.ToInteger;
  letter := resultats[2].Value.Chars[0];
  password := resultats[3].Value;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo1.Lines.Clear;
  Edit1.Text := '';
end;

end.
