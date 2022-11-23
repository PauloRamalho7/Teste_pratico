program Agenda;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {Form2},
  uDM in 'uDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
