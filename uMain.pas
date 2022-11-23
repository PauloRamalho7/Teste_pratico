unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
  TForm2 = class(TForm)
    lyt_top: TLayout;
    Rectangle1: TRectangle;
    Label1: TLabel;
    lyt_principal: TLayout;
    RoundRect1: TRoundRect;
    Image1: TImage;
    RoundRect2: TRoundRect;
    Image2: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses uDM;

end.
