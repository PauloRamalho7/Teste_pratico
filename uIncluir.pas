unit uIncluir;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,
  uFormat;

type
  TfrmIncluir = class(TForm)
    Rectangle1: TRectangle;
    lbl_titulo: TLabel;
    img_salvar: TImage;
    img_voltar: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtNome: TEdit;
    edtIdade: TEdit;
    edtCelular: TEdit;
    edtFone1: TEdit;
    edtFone2: TEdit;
    procedure edtCelularTyping(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure img_voltarClick(Sender: TObject);
    procedure edtFone1Typing(Sender: TObject);
    procedure edtFone2Typing(Sender: TObject);
    procedure img_salvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    modo : char;
  end;

var
  frmIncluir: TfrmIncluir;

implementation

{$R *.fmx}

uses uDM;

procedure TfrmIncluir.edtCelularTyping(Sender: TObject);
begin
    Formatar(edtCelular, TFormato.Celular);
end;

procedure TfrmIncluir.edtFone1Typing(Sender: TObject);
begin
    Formatar(edtFone1, TFormato.TelefoneFixo);
end;

procedure TfrmIncluir.edtFone2Typing(Sender: TObject);
begin
    Formatar(edtFone2, TFormato.TelefoneFixo);
end;

procedure TfrmIncluir.FormCreate(Sender: TObject);
begin
    edtNome.SetFocus;
end;

procedure IncluirFone (idContato,Numero:String);
var
  IdNovo : Integer;
begin
    DM.qry_fone.Active := false;
    DM.qry_fone.SQL.Clear;
    DM.qry_fone.SQL.Add('SELECT * FROM TELEFONE WHERE  ID = (SELECT MAX(ID)  FROM TELEFONE)');
    DM.qry_fone.Active := true;
    IdNovo := DM.qry_fone.FieldByName('ID').AsInteger;
    IdNovo := IdNovo + 1;

    DM.qry_fone.Active := false;
    DM.qry_fone.SQL.Clear;

    DM.qry_fone.SQL.Add('INSERT INTO TELEFONE(ID, IDCONTATO, NUMERO)');
    DM.qry_fone.SQL.Add('VALUES(:ID, :IDCONTATO, :NUMERO) ');

    DM.qry_fone.ParamByName('ID').Value         := IntToStr(IDNovo);
    DM.qry_fone.ParamByName('IDCONTATO').Value  := idContato;
    DM.qry_fone.ParamByName('NUMERO').Value     := Numero;

    DM.qry_fone.ExecSQL;

end;
procedure TfrmIncluir.img_salvarClick(Sender: TObject);
var
  erro: String;
  NovoID : Integer;

begin
    erro := '';
    if (edtCelular.Text = '') and (edtFone1.Text = '') and (edtFone2.Text = '')  then
      erro := 'Pelo menos 1 telefone deve estar preenchido!';
    if edtNome.Text = '' then
      erro := 'Nome deve estar preenchido!';
    if erro <> '' then
    begin
      showmessage(erro);
      exit;
    end;

    DM.qry_contato.Active := false;
    DM.qry_contato.SQL.Clear;
    DM.qry_contato.SQL.Add('SELECT * FROM CONTATO WHERE  ID = (SELECT MAX(ID)  FROM CONTATO)');
    DM.qry_contato.Active := true;
    NovoID := DM.qry_contato.FieldByName('ID').AsInteger;
    NovoID := NovoID + 1;

    DM.qry_contato.Active := false;
    DM.qry_contato.SQL.Clear;

    DM.qry_contato.SQL.Add('INSERT INTO CONTATO(ID, NOME, IDADE)');
    DM.qry_contato.SQL.Add('VALUES(:ID, :NOME, :IDADE) ');

    DM.qry_contato.ParamByName('ID').Value    := IntToStr(NovoID);
    DM.qry_contato.ParamByName('NOME').Value  := edtNome.Text;
    DM.qry_contato.ParamByName('IDADE').Value := edtIdade.Text;

    DM.qry_contato.ExecSQL;

    if edtCelular.Text <> '' then
      incluirFone(IntToStr(NovoID),edtCelular.Text);
    if edtFone1.Text <> '' then
      incluirFone(IntToStr(NovoID),edtFone1.Text);
    if edtFone2.Text <> '' then
      incluirFone(IntToStr(NovoID),edtFone2.Text);

    close;
end;

procedure TfrmIncluir.img_voltarClick(Sender: TObject);
begin
    close;
end;

end.
