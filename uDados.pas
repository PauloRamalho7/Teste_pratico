unit uDados;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,
  uFormat, System.Math.Vectors, FMX.Controls3D, FMX.Layers3D, FMX.Layouts;

type
  TfrmDados = class(TForm)
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
    Layout3: TLayout;
    img_excluir: TImage;
    Layout3D1: TLayout3D;
    rctBotton: TRectangle;
    imgPesquisa: TImage;
    Layout1: TLayout;
    edtPesqNome: TEdit;
    edtPesqFone: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    procedure edtCelularTyping(Sender: TObject);
    procedure img_voltarClick(Sender: TObject);
    procedure edtFone1Typing(Sender: TObject);
    procedure edtFone2Typing(Sender: TObject);
    procedure img_salvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgPesquisaClick(Sender: TObject);
  private
    { Private declarations }
    IDAtual : String;
  public
    { Public declarations }
    modo : char;
  end;

var
  frmDados: TfrmDados;

implementation

{$R *.fmx}

uses uDM;

procedure TfrmDados.edtCelularTyping(Sender: TObject);
begin
    Formatar(edtCelular, TFormato.Celular);
end;

procedure TfrmDados.edtFone1Typing(Sender: TObject);
begin
    Formatar(edtFone1, TFormato.TelefoneFixo);
end;

procedure TfrmDados.edtFone2Typing(Sender: TObject);
begin
    Formatar(edtFone2, TFormato.TelefoneFixo);
end;

procedure TfrmDados.FormShow(Sender: TObject);
begin
  edtNome.Text       := '';
  edtIdade.Text      := '';
  edtCelular.Text    := '';
  edtCelular.Tag     := 0;
  edtFone1.Text      := '';
  edtFone1.Tag       := 0;
  edtFone2.Text      := '';
  edtFone2.Tag       := 0;
  edtPesqNome.Text   := '';
  edtPesqFone.Text   := '';
  IDAtual            := '';

  if modo='I' then
  begin
    lbl_Titulo.Text  := 'Incluir Contato';
    frmDados.Caption := 'Incluir Contato';
    edtNome.SetFocus;
  end else
  begin
    lbl_Titulo.Text  := 'Contato';
    frmDados.Caption := 'Contato';
    edtPesqNome.SetFocus;
  end;
end;

procedure TfrmDados.imgPesquisaClick(Sender: TObject);
begin
  IDAtual := '';
  if edtPesqNome.Text <> '' then
  begin
        DM.qry_contato.Active := false;
        DM.qry_contato.SQL.Clear;
        DM.qry_contato.SQL.Add('SELECT * FROM CONTATO WHERE  NOME LIKE :NOME  ');
        DM.qry_contato.ParamByName('NOME').Value := '%'+edtPesqNome.Text+'%';
        DM.qry_contato.Active := true;
        if DM.qry_contato.IsEmpty then
        begin
          showmessage('Não foi encontrado nenhum registro com esse nome!');
          exit;
        end;
        edtNome.Text  := DM.qry_contato.FieldByName('NOME').AsString;
        edtIdade.Text := DM.qry_contato.FieldByName('IDADE').AsString;
        IDAtual       := DM.qry_contato.FieldByName('ID').AsString;

        DM.qry_fone.Active := false;
        DM.qry_fone.SQL.Clear;
        DM.qry_fone.SQL.Add('SELECT * FROM TELEFONE WHERE  IDCONTATO = :IDCONTATO');
        DM.qry_fone.ParamByName('IDCONTATO').Value := IDAtual;
        DM.qry_fone.Active := true;
        while not DM.qry_fone.Eof do
        begin
          if DM.qry_fone.FieldByName('TIPO').AsString = 'C' then
          begin
            edtCelular.Text := DM.qry_fone.FieldByName('NUMERO').AsString;
            edtCelular.Tag  := DM.qry_fone.FieldByName('ID').AsInteger;
          end;
          if DM.qry_fone.FieldByName('TIPO').AsString = '1' then
          begin
            edtFone1.Text := DM.qry_fone.FieldByName('NUMERO').AsString;
            edtFone1.Tag  := DM.qry_fone.FieldByName('ID').AsInteger;
          end;
          if DM.qry_fone.FieldByName('TIPO').AsString = '2' then
          begin
            edtFone2.Text := DM.qry_fone.FieldByName('NUMERO').AsString;
            edtFone2.Tag  := DM.qry_fone.FieldByName('ID').AsInteger;
          end;
          DM.qry_fone.Next;
        end;

  end;
end;

procedure IncluirFone (idContato,Numero,Tipo:String);
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

    DM.qry_fone.SQL.Add('INSERT INTO TELEFONE(ID, IDCONTATO, NUMERO, TIPO)');
    DM.qry_fone.SQL.Add('VALUES(:ID, :IDCONTATO, :NUMERO, :TIPO) ');

    DM.qry_fone.ParamByName('ID').Value         := IntToStr(IDNovo);
    DM.qry_fone.ParamByName('IDCONTATO').Value  := idContato;
    DM.qry_fone.ParamByName('NUMERO').Value     := Numero;
    DM.qry_fone.ParamByName('TIPO').Value       := Tipo;

    DM.qry_fone.ExecSQL;

end;

procedure AlterarFone (id,idContato,Numero,Tipo:String);
begin

    DM.qry_fone.Active := false;
    DM.qry_fone.SQL.Clear;

    DM.qry_fone.SQL.Add('UPDATE TELEFONE SET IDCONTATO=:IDCONTATO, NUMERO=:NUMERO, TIPO=:TIPO');
    DM.qry_fone.SQL.Add('WHERE ID = :ID');

    DM.qry_fone.ParamByName('ID').Value         := id;
    DM.qry_fone.ParamByName('IDCONTATO').Value  := idContato;
    DM.qry_fone.ParamByName('NUMERO').Value     := Numero;
    DM.qry_fone.ParamByName('TIPO').Value       := Tipo;

    DM.qry_fone.ExecSQL;
end;

procedure ExcluirFone(id: String);
begin

    DM.qry_fone.Active := false;
    DM.qry_fone.SQL.Clear;

    DM.qry_fone.SQL.Add('DELETE FROM TELEFONE ');
    DM.qry_fone.SQL.Add('WHERE ID = :ID');

    DM.qry_fone.ParamByName('ID').Value := id;

    DM.qry_fone.ExecSQL;
end;


procedure TfrmDados.img_salvarClick(Sender: TObject);
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
    if modo = 'I' then
    begin
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
          incluirFone(IntToStr(NovoID),edtCelular.Text,'C');
        if edtFone1.Text <> '' then
          incluirFone(IntToStr(NovoID),edtFone1.Text,'1');
        if edtFone2.Text <> '' then
          incluirFone(IntToStr(NovoID),edtFone2.Text,'2');

        showmessage ('Contato Incluído!');
    end else
    begin
        if IDAtual = '' then
        begin
          showmessage('Não tem contato selecionado!');
          exit
        end;
        DM.qry_contato.Active := false;
        DM.qry_contato.SQL.Clear;
        dm.qry_contato.SQL.Add('UPDATE CONTATO SET NOME=:NOME, IDADE =:IDADE');
        dm.qry_contato.SQL.Add('WHERE ID = :ID');

        DM.qry_contato.ParamByName('NOME').Value  := edtNome.Text;
        DM.qry_contato.ParamByName('IDADE').Value := edtIdade.Text;
        DM.qry_contato.ParamByName('ID').Value    := IDAtual;

        DM.qry_Contato.ExecSQL;

        if edtCelular.Text <> '' then
        begin
          if edtCelular.tag = 0 then
            incluirFone(IDAtual,edtCelular.Text,'C')
          else
            alterarfone(IntToStr(edtCelular.tag), IDAtual,edtCelular.Text,'C');
        end else
        begin
          if edtCelular.tag <> 0 then
            excluirFone(IntToStr(edtCelular.tag));
        end;

        if edtFone1.Text <> '' then
        begin
          if edtFone1.tag = 0 then
            incluirFone(IDAtual,edtFone1.Text,'1')
          else
            alterarfone(IntToStr(edtFone1.tag), IDAtual,edtFone1.Text,'1');
        end else
        begin
          if edtFone1.tag <> 0 then
            excluirFone(IntToStr(edtFone1.tag));
        end;

        if edtFone2.Text <> '' then
        begin
          if edtFone2.tag = 0 then
            incluirFone(IDAtual,edtFone2.Text,'2')
          else
            alterarfone(IntToStr(edtFone2.tag), IDAtual,edtFone2.Text,'2');
        end else
        begin
          if edtFone2.tag <> 0 then
            excluirFone(IntToStr(edtFone2.tag));
        end;

    end;
    close;
end;

procedure TfrmDados.img_voltarClick(Sender: TObject);
begin
    close;
end;

end.
