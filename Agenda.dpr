program Agenda;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {frmPrincipal},
  uDM in 'uDM.pas' {DM: TDataModule},
  uDados in 'uDados.pas' {frmDados};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
