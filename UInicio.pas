unit UInicio;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, REST.Types, REST.Client,
  REST.Authenticator.OAuth, Data.Bind.Components, Data.Bind.ObjectScope,
  FMX.TabControl, FMX.Edit, System.Actions, FMX.ActnList, FMX.Ani;

type
  TFormInicio = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout5: TLayout;
    Image1: TImage;
    Layout6: TLayout;
    btnLogin: TRectangle;
    Layout7: TLayout;
    Label2: TLabel;
    Line1: TLine;
    Line2: TLine;
    Line3: TLine;
    Layout8: TLayout;
    RESTRequest: TRESTRequest;
    RESTClient: TRESTClient;
    RESTResponse: TRESTResponse;
    OAuth2Facebook: TOAuth2Authenticator;
    TabControl: TTabControl;
    TabLogin: TTabItem;
    TabCadastrar: TTabItem;
    lblCadastrar: TLabel;
    Layout9: TLayout;
    Layout11: TLayout;
    Layout21: TLayout;
    Layout22: TLayout;
    Rectangle4: TRectangle;
    btnFacebook: TSpeedButton;
    Path3: TPath;
    Layout26: TLayout;
    Line6: TLine;
    lblLogin: TLabel;
    Layout16: TLayout;
    Layout17: TLayout;
    Rectangle2: TRectangle;
    btnCadastrar: TSpeedButton;
    Layout12: TLayout;
    Image3: TImage;
    Layout13: TLayout;
    Image4: TImage;
    ActionList1: TActionList;
    actLogin: TChangeTabAction;
    actCadastrar: TChangeTabAction;
    Rectangle3: TRectangle;
    Image5: TImage;
    edtUsuario: TEdit;
    StyleBook1: TStyleBook;
    Layout4: TLayout;
    Layout10: TLayout;
    Rectangle5: TRectangle;
    Image6: TImage;
    edtSenha: TEdit;
    Layout27: TLayout;
    Label4: TLabel;
    Layout20: TLayout;
    Layout23: TLayout;
    Rectangle6: TRectangle;
    Image8: TImage;
    EdtEmail: TEdit;
    Layout24: TLayout;
    Layout25: TLayout;
    Rectangle7: TRectangle;
    Image9: TImage;
    EdtNovaSenha: TEdit;
    Layout18: TLayout;
    Layout19: TLayout;
    Rectangle8: TRectangle;
    Image10: TImage;
    EdtConfirmaSenha: TEdit;
    vsLogin: TVertScrollBox;
    vsCadastrar: TVertScrollBox;
    Label5: TLabel;
    Image2: TImage;
    Layout28: TLayout;
    SpeedButton1: TSpeedButton;
    lytLogin: TLayout;
    FloatAnimation1: TFloatAnimation;
    imgLoading: TImage;
    FloatAnimation2: TFloatAnimation;
    FloatAnimation3: TFloatAnimation;
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure btnCadastrarClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lblCadastrarClick(Sender: TObject);
    procedure lblLoginClick(Sender: TObject);
    procedure btnFacebookClick(Sender: TObject);
    procedure btnLoginMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure btnLoginMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure EdtNomeEnter(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure EdtEmailExit(Sender: TObject);
    procedure EdtEmailEnter(Sender: TObject);
    procedure EdtNovaSenhaEnter(Sender: TObject);
    procedure EdtConfirmaSenhaEnter(Sender: TObject);
    procedure FloatAnimation1Finish(Sender: TObject);
  private
    { Private declarations }
    foco: TControl;
  public
    { Public declarations }
  end;

var
  FormInicio: TFormInicio;

implementation

{$R *.fmx}

uses ULogin, UDM, UPrincipal, UPerfil;

procedure Ajustar_Scroll();
var
  x : integer;
begin
  with FormInicio do
  begin
    vsLogin.Margins.Bottom := 250;
    vsLogin.ViewportPosition := PointF(vsLogin.ViewportPosition.X,
                                TControl(foco).Position.Y - 90);

    vsCadastrar.Margins.Bottom := 250;
    vsCadastrar.ViewportPosition := PointF(vsCadastrar.ViewportPosition.X,
                                TControl(foco).Position.Y - 90);
  end;
end;

function ValidarEMail(email: string): Boolean;
begin
 email := Trim(UpperCase(email));
 if Pos('@', email) > 1 then
 begin
   Delete(email, 1, pos('@', email));
   Result := (Length(email) > 0) and (Pos('.', email) > 2);
 end
 else
   Result := False;
end;

procedure TFormInicio.btnCadastrarClick(Sender: TObject);
begin
  // valida�oes de campos obrigat�rios
  if edtEmail.Text = '' then
  begin
    ShowMessage('Digite seu email');
    exit;
  end;
  if edtNovaSenha.Text = '' then
  begin
    ShowMessage('Digite uma senha');
    exit;
  end;
  if edtConfirmaSenha.Text = '' then
  begin
    ShowMessage('Confirme a senha');
    exit;
  end;

  // Verificar se usuario existe
  DM.qryUsuarios.Active := False;
  DM.qryUsuarios.SQL.Clear;
  DM.qryUsuarios.SQL.Add('SELECT * FROM USUARIOS');
  DM.qryUsuarios.SQL.Add('WHERE EMAIL = :EMAIL');
  DM.qryUsuarios.ParamByName('EMAIL').Value := edtEmail.Text;
  DM.qryUsuarios.Active := True;

  if DM.qryUsuarios.RecordCount > 0 then
  begin
    ShowMessage('Email j� cadastrado.');
    Exit;
  end;

  // Cadastrar Usuario
  try
    DM.qryUsuarios.Active := False;
    DM.qryUsuarios.SQL.Clear;
    DM.qryUsuarios.SQL.Add('INSERT INTO USUARIOS (USUARIO, EMAIL, SENHA)');
    DM.qryUsuarios.SQL.Add('VALUES (:USUARIO, :EMAIL, :SENHA)');
    DM.qryUsuarios.ParamByName('USUARIO').Value := Copy(EdtEmail.Text,1,Pos('@',EdtEmail.Text)-1);
    DM.qryUsuarios.ParamByName('EMAIL').Value := edtEmail.Text;
    if edtNovaSenha.Text = edtConfirmaSenha.Text then
    begin
      DM.qryUsuarios.ParamByName('SENHA').Value := edtNovaSenha.Text;
    end else
    begin
      ShowMessage('Senha n�o confere!');
      edtNovaSenha.Text:='';
      edtConfirmaSenha.Text:='';
      Exit;
    end;
    DM.qryUsuarios.ExecSQL;

    ShowMessage('Email cadastrado com sucesso!');
    actLogin.Execute;
    edtEmail.Text:= '';
    edtNovaSenha.Text:= '';
    edtConfirmaSenha.Text:= '';
  except
    ShowMessage('Erro ao criar nova conta');
    Exit;
  end;
end;

procedure TFormInicio.btnFacebookClick(Sender: TObject);
begin
  ShowMessage('Op��o n�o programada!');
end;

procedure TFormInicio.btnLoginClick(Sender: TObject);
begin
// valida�oes de campos obrigat�rios
  if edtUsuario.Text = '' then
  begin
    ShowMessage('Digite seu Usu�rio ou Email!');
    exit;
  end else if edtSenha.Text = '' then
  begin
    ShowMessage('Digite sua senha');
    exit;
  end;

  // Verificar se email existe
  DM.qryUsuarios.Active := False;
  DM.qryUsuarios.SQL.Clear;
  DM.qryUsuarios.SQL.Add('SELECT * FROM USUARIOS');
  DM.qryUsuarios.SQL.Add('WHERE EMAIL = :EMAIL OR USUARIO = :USUARIO');
  if ValidarEMail(edtUsuario.Text) then
  begin
    DM.qryUsuarios.ParamByName('EMAIL').Value := edtUsuario.Text;
    DM.qryUsuarios.ParamByName('USUARIO').Value := '';
  end
  else
  begin
    DM.qryUsuarios.ParamByName('USUARIO').Value := edtUsuario.Text;
    DM.qryUsuarios.ParamByName('EMAIL').Value := '';
  end;
  DM.qryUsuarios.Active := True;

  if DM.qryUsuarios.RecordCount <> 0 then
  begin
    if not Assigned(FormPrincipal) then
      Application.CreateForm(TFormPrincipal, FormPrincipal);

    Application.MainForm := FormPrincipal;
    FormPrincipal.Show;
    FormInicio.Close;
  end;

  if DM.qryUsuarios.RecordCount = 0 then
  begin
    ShowMessage('Usu�rio n�o existe!');
    Exit;
  end;

  FloatAnimation1.Start;
end;

procedure TFormInicio.EdtConfirmaSenhaEnter(Sender: TObject);
begin
//  foco := TControl(TEdit(sender).Parent);
//  Ajustar_Scroll();
end;

procedure TFormInicio.EdtEmailEnter(Sender: TObject);
begin
//  foco := TControl(TEdit(sender).Parent);
//  Ajustar_Scroll();
end;

procedure TFormInicio.EdtEmailExit(Sender: TObject);
begin
  if not ValidarEMail(EdtEmail.Text) then
  begin
    ShowMessage('Email Inv�lido!');
    EdtEmail.SetFocus;
  end;
end;

procedure TFormInicio.EdtNomeEnter(Sender: TObject);
begin
//  foco := TControl(TEdit(sender).Parent);
//  Ajustar_Scroll();
end;

procedure TFormInicio.EdtNovaSenhaEnter(Sender: TObject);
begin
//  foco := TControl(TEdit(sender).Parent);
//  Ajustar_Scroll();
end;

procedure TFormInicio.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  vsLogin.Margins.Bottom := 0;
end;

procedure TFormInicio.btnLoginMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  TRectangle(Sender).Opacity := 0.8;
end;

procedure TFormInicio.btnLoginMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  TRectangle(Sender).Opacity := 1;
end;

procedure TFormInicio.SpeedButton1Click(Sender: TObject);
begin
  try
    DM.qryPerfil.Active := False;
    DM.qryPerfil.SQL.Clear;
    DM.qryPerfil.SQL.Add('DELETE FROM PERFIL');

    DM.qryPerfil.ExecSQL;

    ShowMessage('Perfil Deletado com sucesso!');
  except
    ShowMessage('Erro ao deletar perfil!');
    Exit;
  end;

  try
    DM.qryPerfil.Active := False;
    DM.qryPerfil.SQL.Clear;
    DM.qryPerfil.SQL.Add('DELETE FROM USUARIOS');

    DM.qryPerfil.ExecSQL;

    ShowMessage('Usuario Deletado com sucesso!');
  except
    ShowMessage('Erro ao deletar usuario!');
    Exit;
  end;
end;

procedure TFormInicio.FloatAnimation1Finish(Sender: TObject);
begin
  lytLogin.Visible:= False;
  imgLoading.Visible:= True;

  FloatAnimation2.Start;
  FloatAnimation3.Start;
end;

procedure TFormInicio.FormCreate(Sender: TObject);
begin
  TabControl.TabPosition := TTabPosition.None;
  TabControl.ActiveTab := TabLogin;
  edtUsuario.Text := '';
  edtSenha.Text := '';
end;

procedure TFormInicio.lblCadastrarClick(Sender: TObject);
begin
  actCadastrar.Execute;
end;

procedure TFormInicio.lblLoginClick(Sender: TObject);
begin
  actLogin.Execute;
end;

end.
