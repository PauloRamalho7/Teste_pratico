unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
  TfrmPrincipal = class(TForm)
    lyt_top: TLayout;
    Rectangle1: TRectangle;
    Label1: TLabel;
    lyt_principal: TLayout;
    rctIncluir: TRoundRect;
    Image1: TImage;
    rctPesquisar: TRoundRect;
    Image2: TImage;
    lblIncluir: TLabel;
    lblPesq: TLabel;
    procedure rctIncluirClick(Sender: TObject);
    procedure rctPesquisarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses uDM, uIncluir, uDados;

procedure TfrmPrincipal.rctIncluirClick(Sender: TObject);
begin
        if NOT Assigned(frmDados) then
            Application.CreateForm(TfrmDados, frmDados);
        frmDados.modo                := 'I';
        frmDados.rctBotton.Visible   := false;
        frmDados.img_excluir.Visible := false;
        frmDados.Show;
end;

procedure TfrmPrincipal.rctPesquisarClick(Sender: TObject);
begin
        if NOT Assigned(frmDados) then
            Application.CreateForm(TfrmDados, frmDados);
        frmDados.modo                := 'P';
        frmDados.rctBotton.Visible   := true;
        frmDados.img_excluir.Visible := true;
        frmDados.Show;

end;

end.
