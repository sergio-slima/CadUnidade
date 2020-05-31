unit UFacebook;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.WebBrowser;

type
  TFormFacebook = class(TForm)
    Rectangle1: TRectangle;
    SpeedButton1: TSpeedButton;
    WebBrowser1: TWebBrowser;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormFacebook: TFormFacebook;

implementation

{$R *.fmx}

end.
