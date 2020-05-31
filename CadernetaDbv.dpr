program CadernetaDbv;

uses
  System.StartUpCopy,
  FMX.Forms,
  UInicio in 'UInicio.pas' {FormInicio},
  ULogin in 'ULogin.pas' {FormLogin},
  UFacebook in 'UFacebook.pas' {FormFacebook},
  UDM in 'UDM.pas' {DM: TDataModule},
  UPrincipal in 'UPrincipal.pas' {FormPrincipal},
  UPerfil in 'UPerfil.pas' {FormPerfil},
  URequisitos in 'URequisitos.pas' {FormRequisitos};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormInicio, FormInicio);
  Application.Run;
end.
