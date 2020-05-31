unit UPerfil;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts,
  FMX.ScrollBox, FMX.Memo, FMX.DateTimeCtrls, FMX.MediaLibrary.Actions,
  System.Actions, FMX.ActnList, FMX.StdActns, FMX.VirtualKeyboard, FMX.Platform,
  System.Permissions, Data.DB, FGX.ActionSheet;

type
  TFormPerfil = class(TForm)
    TabControl: TTabControl;
    TabItemDados: TTabItem;
    TabItemHistorico: TTabItem;
    TabItemFoto: TTabItem;
    TabItemConsulta: TTabItem;
    ToolBar1: TToolBar;
    Rectangle5: TRectangle;
    ToolBar2: TToolBar;
    Rectangle1: TRectangle;
    ToolBar3: TToolBar;
    Rectangle2: TRectangle;
    ToolBar4: TToolBar;
    Rectangle3: TRectangle;
    Layout11: TLayout;
    edtUniao: TEdit;
    Label4: TLabel;
    Rectangle4: TRectangle;
    Label5: TLabel;
    Label6: TLabel;
    Layout1: TLayout;
    Label7: TLabel;
    Layout2: TLayout;
    Rectangle6: TRectangle;
    EdtRegiao: TEdit;
    Rectangle7: TRectangle;
    EdtAssoc: TEdit;
    Label8: TLabel;
    Rectangle8: TRectangle;
    edtUnidade: TEdit;
    Layout3: TLayout;
    TabItemAbertura: TTabItem;
    ToolBar5: TToolBar;
    Rectangle9: TRectangle;
    Layout4: TLayout;
    Label10: TLabel;
    Label11: TLabel;
    Layout5: TLayout;
    Label12: TLabel;
    Label16: TLabel;
    Layout8: TLayout;
    Rectangle13: TRectangle;
    edtHistorico: TMemo;
    Rectangle10: TRectangle;
    edtGrito: TMemo;
    Layout6: TLayout;
    Layout7: TLayout;
    Label14: TLabel;
    Layout9: TLayout;
    Label15: TLabel;
    imgFotoUnidade: TImage;
    Label17: TLabel;
    Layout10: TLayout;
    Rectangle11: TRectangle;
    EdtClube: TEdit;
    Label18: TLabel;
    Rectangle15: TRectangle;
    imgBrasaoUnidade: TImage;
    Layout12: TLayout;
    Rectangle12: TRectangle;
    Layout13: TLayout;
    imgBrasaoPerfil: TImage;
    Layout14: TLayout;
    Label22: TLabel;
    lblUnidade: TLabel;
    lblClube: TLabel;
    lblData: TLabel;
    Layout15: TLayout;
    Label26: TLabel;
    edtData: TDateEdit;
    ActionFoto: TActionList;
    btnSalvar: TRectangle;
    Image1: TImage;
    Label3: TLabel;
    btnHistorico: TRectangle;
    Image2: TImage;
    Label2: TLabel;
    btnDados: TRectangle;
    Image6: TImage;
    Label1: TLabel;
    btnAbertura: TRectangle;
    Image7: TImage;
    Label27: TLabel;
    btnEditar: TRectangle;
    Image8: TImage;
    Label9: TLabel;
    fgActionBrasao: TfgActionSheet;
    ActFotoLibrary: TTakePhotoFromLibraryAction;
    ActFotoCamera: TTakePhotoFromCameraAction;
    fgActionFoto: TfgActionSheet;
    ActionBrasao: TActionList;
    ActBrasaoLibrary: TTakePhotoFromLibraryAction;
    Label19: TLabel;
    Label20: TLabel;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image9: TImage;
    Image10: TImage;
    btnConcluir: TImage;
    procedure btnAberturaClick(Sender: TObject);
    procedure btnDadosClick(Sender: TObject);
    procedure btnHistoricoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure ActPhotoCameraDidFinishTaking(Image: TBitmap);
    procedure ActPhotoLibraryDidFinishTaking(Image: TBitmap);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ActPhotoLibrary2DidFinishTaking(Image: TBitmap);
    procedure imgBrasaoUnidadeClick(Sender: TObject);
    procedure ActFotoLibraryDidFinishTaking(Image: TBitmap);
    procedure ActFotoCameraDidFinishTaking(Image: TBitmap);
    procedure ActBrasaoLibraryDidFinishTaking(Image: TBitmap);
    procedure imgFotoUnidadeClick(Sender: TObject);
    procedure ListarPerfil;
    procedure FormShow(Sender: TObject);
    procedure fgActionFotoActions0Click(Sender: TObject);
    procedure fgActionFotoActions1Click(Sender: TObject);
    procedure btnConcluirClick(Sender: TObject);
    procedure ActBrasaoLibraryCanActionExec(Sender: TCustomAction;
      var CanExec: Boolean);
  private
    { Private declarations }
    {$IFDEF ANDROID}
    PermissaoCamera, PermissaoReadStorage, PermissaoWriteStorage: string;
    procedure TakePicturePermissionRequestResult(
        Sender: TObject; const APermissions: TArray<string>;
        const AGrantResults: TArray<TPermissionStatus>);
    procedure DisplayMessageCamera(Sender: TObject;
                      const APermissions: TArray<string>;
                      const APostProc: TProc);
    procedure LibraryPermissionRequestResult(
        Sender: TObject; const APermissions: TArray<string>;
        const AGrantResults: TArray<TPermissionStatus>);
    procedure DisplayMessageLibrary(Sender: TObject;
                      const APermissions: TArray<string>;
                      const APostProc: TProc);
    {$ENDIF}

  public
    { Public declarations }
    sAcao: String;
  end;

var
    FormPerfil: TFormPerfil;
    vsDados: TVertScrollBox;

implementation

{$R *.fmx}

uses UPrincipal, UDM, FMX.DialogService

{$IFDEF ANDROID}
, Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
{$ENDIF}
, UInicio;

{$IFDEF ANDROID}
procedure TFormPerfil.TakePicturePermissionRequestResult(
        Sender: TObject; const APermissions: TArray<string>;
        const AGrantResults: TArray<TPermissionStatus>);
begin
  if (Length(AGrantResults) = 3) and
     (AGrantResults[0] = TPermissionStatus.Granted) and
     (AGrantResults[1] = TPermissionStatus.Granted) and
     (AGrantResults[2] = TPermissionStatus.Granted) then
        ActFotoCamera.Execute
  else
        TDialogService.ShowMessage('N�o tem permiss�o pra tirar fotos!');
end;

procedure TFormPerfil.DisplayMessageCamera(Sender: TObject;
                      const APermissions: TArray<string>;
                      const APostProc: TProc);
begin
    TDialogService.ShowMessage('O app precisa acessar a c�mera e a galeria',
                      procedure(const AResult: TModalResult)
                      begin
                          APostProc;
                      end);
end;

procedure TFormPerfil.LibraryPermissionRequestResult(
        Sender: TObject; const APermissions: TArray<string>;
        const AGrantResults: TArray<TPermissionStatus>);
begin
  if (Length(AGrantResults) = 2) and
     (AGrantResults[0] = TPermissionStatus.Granted) and
     (AGrantResults[1] = TPermissionStatus.Granted) then
        ActFotoLibrary.Execute
  else
        TDialogService.ShowMessage('N�o tem permiss�o para acessar galeria!');
end;

procedure TFormPerfil.DisplayMessageLibrary(Sender: TObject;
                      const APermissions: TArray<string>;
                      const APostProc: TProc);
begin
    TDialogService.ShowMessage('O app precisa acessar a galeria',
                      procedure(const AResult: TModalResult)
                      begin
                          APostProc;
                      end);
end;

{$ENDIF}

procedure TFormPerfil.ListarPerfil;
var
  BlobStream : TStream;
  SaveParam : TBitmapCodecSaveParams;
begin
  DM.qryPerfil.Active := false;
  DM.qryPerfil.SQL.Clear;
  DM.qryPerfil.SQL.Add('SELECT * FROM PERFIL');
  DM.qryPerfil.Active := true;
  if DM.qryPerfil.RecordCount <> 0 then
  begin
    lblUnidade.Text := DM.qryPerfil.FieldByName('UNIDADE').AsString;
    lblData.Text := 'Desde: '+DateToStr(DM.qryPerfil.FieldByName('DATA').AsDateTime);
    lblClube.Text := 'CLUBE: '+DM.qryPerfil.FieldByName('CLUBE').AsString;
    BlobStream := DM.qryPerfil.CreateBlobStream(
                    DM.qryPerfil.FieldByName('BRASAO'),TBlobStreamMode.bmRead
                  );
    imgBrasaoPerfil.Bitmap.LoadFromStream(BlobStream);
  end;
end;

procedure TFormPerfil.ActBrasaoLibraryCanActionExec(Sender: TCustomAction;
  var CanExec: Boolean);
begin
  {$IFDEF ANDROID}
  PermissionsService.RequestPermissions([PermissaoReadStorage,
                                         PermissaoWriteStorage],
                                         LibraryPermissionRequestResult,
                                         DisplayMessageLibrary
                                         );
  {$ENDIF}
  {$IFDEF IOS}
    ActPhotoLibrary.Execute;
  {$ENDIF}
end;

procedure TFormPerfil.ActBrasaoLibraryDidFinishTaking(Image: TBitmap);
begin
  imgBrasaoUnidade.Bitmap.Assign(Image);
end;

procedure TFormPerfil.ActFotoCameraDidFinishTaking(Image: TBitmap);
begin
  imgFotoUnidade.Bitmap.Assign(Image);
end;

procedure TFormPerfil.ActFotoLibraryDidFinishTaking(Image: TBitmap);
begin
  imgFotoUnidade.Bitmap.Assign(Image);
end;

procedure TFormPerfil.ActPhotoCameraDidFinishTaking(Image: TBitmap);
begin
  imgFotoUnidade.Bitmap.Assign(Image);
end;

procedure TFormPerfil.ActPhotoLibrary2DidFinishTaking(Image: TBitmap);
begin
  imgFotoUnidade.Bitmap.Assign(Image);
end;

procedure TFormPerfil.ActPhotoLibraryDidFinishTaking(Image: TBitmap);
begin
  imgBrasaoUnidade.Bitmap.Assign(Image);
end;

procedure TFormPerfil.btnDadosClick(Sender: TObject);
begin
  TabControl.ActiveTab := TabItemHistorico;
end;

procedure TFormPerfil.btnHistoricoClick(Sender: TObject);
begin
  TabControl.ActiveTab := TabItemFoto;
end;

procedure TFormPerfil.btnSalvarClick(Sender: TObject);
var
  gravarBrasao, gravarFoto : TMemoryStream;
begin
  //gravar perfil
  if (edtUnidade.Text = '') or (EdtClube.Text = '') or (EdtRegiao.Text = '') or
     (EdtAssoc.Text = '') or (edtUniao.Text = '') then
  begin
    ShowMessage('Preencha os campos de Dados da Unidade!');
    TabControl.ActiveTab := TabItemDados;
    Exit;
  end;

  DM.qryPerfil.Active := false;
  DM.qryPerfil.SQL.Clear;
  DM.qryPerfil.SQL.Add('SELECT * FROM PERFIL');
  DM.qryPerfil.Active := true;
  if DM.qryPerfil.RecordCount <> 0 then
  begin
    try
      DM.qryPerfil.Active := False;
      DM.qryPerfil.SQL.Clear;
      DM.qryPerfil.SQL.Add('UPDATE PERFIL SET UNIDADE = :UNIDADE, CLUBE = :CLUBE, REGIAO = :REGIAO, ASSOCIACAO = :ASSOCIACAO,');
      DM.qryPerfil.SQL.Add('UNIAO = :UNIAO, DATA = :DATA, GRITO = :GRITO, HISTORICO = :HISTORICO, BRASAO = :BRASAO, FOTO = :FOTO');
      DM.qryPerfil.ParamByName('UNIDADE').Value := edtUnidade.Text;
      DM.qryPerfil.ParamByName('CLUBE').Value := EdtClube.Text;
      DM.qryPerfil.ParamByName('REGIAO').Value := EdtRegiao.Text;
      DM.qryPerfil.ParamByName('ASSOCIACAO').Value := EdtAssoc.Text;
      DM.qryPerfil.ParamByName('UNIAO').Value := edtUniao.Text;
      DM.qryPerfil.ParamByName('DATA').Value := FormatDateTime('DD/MM/YYYY', edtData.Date);
      DM.qryPerfil.ParamByName('GRITO').Value := edtGrito.Text;
      DM.qryPerfil.ParamByName('HISTORICO').Value := edtHistorico.Text;

      gravarBrasao := TMemoryStream.Create;
      imgBrasaoUnidade.Bitmap.SaveToStream(gravarBrasao);
      gravarBrasao.Seek(0,0);
      DM.qryPerfil.ParamByName('BRASAO').LoadFromStream(gravarBrasao, ftBlob);

      gravarFoto := TMemoryStream.Create;
      imgFotoUnidade.Bitmap.SaveToStream(gravarFoto);
      gravarFoto.Seek(0,0);
      DM.qryPerfil.ParamByName('FOTO').LoadFromStream(gravarFoto, ftBlob);

      DM.qryPerfil.ExecSQL;

      ShowMessage('Perfil alterado com sucesso!');
    except
      ShowMessage('Erro ao alterar perfil!');
      Exit;
    end;
  end else
  begin
    try
      DM.qryPerfil.Active := False;
      DM.qryPerfil.SQL.Clear;
      DM.qryPerfil.SQL.Add('INSERT INTO PERFIL (UNIDADE, CLUBE, REGIAO, ASSOCIACAO,');
      DM.qryPerfil.SQL.Add('UNIAO, DATA, GRITO, HISTORICO, BRASAO, FOTO)');
      DM.qryPerfil.SQL.Add('VALUES (:UNIDADE, :CLUBE, :REGIAO, :ASSOCIACAO,');
      DM.qryPerfil.SQL.Add(':UNIAO, :DATA, :GRITO, :HISTORICO, :BRASAO, :FOTO)');
      DM.qryPerfil.ParamByName('UNIDADE').Value := edtUnidade.Text;
      DM.qryPerfil.ParamByName('CLUBE').Value := EdtClube.Text;
      DM.qryPerfil.ParamByName('REGIAO').Value := EdtRegiao.Text;
      DM.qryPerfil.ParamByName('ASSOCIACAO').Value := EdtAssoc.Text;
      DM.qryPerfil.ParamByName('UNIAO').Value := edtUniao.Text;
      DM.qryPerfil.ParamByName('DATA').Value := FormatDateTime('DD/MM/YYYY', edtData.Date);
      DM.qryPerfil.ParamByName('GRITO').Value := edtGrito.Text;
      DM.qryPerfil.ParamByName('HISTORICO').Value := edtHistorico.Text;

      gravarBrasao := TMemoryStream.Create;
      imgBrasaoUnidade.Bitmap.SaveToStream(gravarBrasao);
      gravarBrasao.Seek(0,0);
      DM.qryPerfil.ParamByName('BRASAO').LoadFromStream(gravarBrasao, ftBlob);

      gravarFoto := TMemoryStream.Create;
      imgFotoUnidade.Bitmap.SaveToStream(gravarFoto);
      gravarFoto.Seek(0,0);
      DM.qryPerfil.ParamByName('FOTO').LoadFromStream(gravarFoto, ftBlob);

      DM.qryPerfil.ExecSQL;

      ShowMessage('Perfil cadastrado com sucesso!');
    except
      ShowMessage('Erro ao gravar perfil!');
      Exit;
    end;
  end;

  imgBrasaoUnidade.Bitmap := nil;
  imgFotoUnidade.Bitmap := nil;

  ListarPerfil;
  TabControl.ActiveTab := TabItemConsulta;
end;

procedure TFormPerfil.fgActionFotoActions0Click(Sender: TObject);
begin
  {$IFDEF ANDROID}
  PermissionsService.RequestPermissions([PermissaoReadStorage,
                                         PermissaoWriteStorage],
                                         LibraryPermissionRequestResult,
                                         DisplayMessageLibrary
                                         );
  {$ENDIF}
  {$IFDEF IOS}
    ActPhotoLibrary.Execute;
  {$ENDIF}
end;

procedure TFormPerfil.fgActionFotoActions1Click(Sender: TObject);
begin
  {$IFDEF ANDROID}
  PermissionsService.RequestPermissions([PermissaoCamera,
                                         PermissaoReadStorage,
                                         PermissaoWriteStorage],
                                         TakePicturePermissionRequestResult,
                                         DisplayMessageCamera
                                         );
  {$ENDIF}
  {$IFDEF IOS}
  ActPhotoCamera.Execute;
  {$ENDIF}
end;

procedure TFormPerfil.btnAberturaClick(Sender: TObject);
begin
  TabControl.ActiveTab := TabItemDados;
end;

procedure TFormPerfil.btnConcluirClick(Sender: TObject);
begin
  Close;
end;

procedure TFormPerfil.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  FormPerfil := nil;

  FormPrincipal.FloatAnimation.Start;
end;

procedure TFormPerfil.FormCreate(Sender: TObject);
begin
  TabControl.TabPosition := TTabPosition.None;
  TabControl.ActiveTab := TabItemConsulta;

  ListarPerfil;

  {$IFDEF ANDROID}
  PermissaoCamera := JStringToString(TJManifest_permission.JavaClass.CAMERA);
  PermissaoReadStorage := JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
  PermissaoWriteStorage := JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);
  {$ENDIF}
end;

procedure TFormPerfil.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
{$IFDEF ANDROID}
var
  FService : IFMXVirtualKeyboardService;
{$ENDIF}
begin
  {$IFDEF ANDROID}
  if (Key = vkHardwareBack) then
  begin
    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));

    if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyboardState) then
    begin
      // Botao back pressionado e teclado visivel...
      // (Apenas fecha o teclado)
    end else
    begin
      // Botao back pressionado e teclado n�o visivel...
      if TabControl.ActiveTab = TabItemDados then
      begin
        Key := 0;                                     // "Cancela" o efeito do botao back para nao fechar o app...
        TabControl.ActiveTab := TabItemAbertura;      // Volta para a aba anterior..
      end else
      if TabControl.ActiveTab = TabItemHistorico then
      begin
        Key := 0;
        TabControl.ActiveTab := TabItemDados;
      end else
      if TabControl.ActiveTab = TabItemFoto then
      begin
        Key := 0;
        TabControl.ActiveTab := TabItemHistorico;
      end else
      if TabControl.ActiveTab = TabItemAbertura then
      begin
        Key := 0;
        if not Assigned(FormInicio) then
          Application.CreateForm(TFormInicio, FormInicio);

        Application.MainForm := FormInicio;
        FormInicio.Show;
        FormPerfil.Close;
      end else
      if TabControl.ActiveTab = TabItemConsulta then
      begin
        Key := 0;
        Close;
      end;
    end;
  end;
  {$ENDIF}

end;

procedure TFormPerfil.FormShow(Sender: TObject);
begin
  TabControl.ActiveTab := TabItemAbertura;
end;

procedure TFormPerfil.imgBrasaoUnidadeClick(Sender: TObject);
begin
  fgActionBrasao.Show;
end;

procedure TFormPerfil.imgFotoUnidadeClick(Sender: TObject);
begin
  fgActionFoto.Show;
end;

procedure TFormPerfil.btnEditarClick(Sender: TObject);
var
  BlobStream : TStream;
  SaveParam : TBitmapCodecSaveParams;
begin
  DM.qryPerfil.Active := false;
  DM.qryPerfil.SQL.Clear;
  DM.qryPerfil.SQL.Add('SELECT * FROM PERFIL');
  DM.qryPerfil.Active := true;
  if DM.qryPerfil.RecordCount <> 0 then
  begin
    edtUnidade.Text := DM.qryPerfil.FieldByName('UNIDADE').AsString;
    EdtClube.Text := DM.qryPerfil.FieldByName('CLUBE').AsString;
    EdtRegiao.Text := DM.qryPerfil.FieldByName('REGIAO').AsString;
    EdtAssoc.Text := DM.qryPerfil.FieldByName('ASSOCIADO').AsString;
    edtUniao.Text := DM.qryPerfil.FieldByName('UNIAO').AsString;
    edtData.Date := DM.qryPerfil.FieldByName('DATA').AsDateTime;
    edtGrito.Text := DM.qryPerfil.FieldByName('GRITO').AsString;
    edtHistorico.Text := DM.qryPerfil.FieldByName('HISTORICO').AsString;
    BlobStream := DM.qryPerfil.CreateBlobStream(
                    DM.qryPerfil.FieldByName('BRASAO'),TBlobStreamMode.bmRead
                  );
    imgBrasaoUnidade.Bitmap.LoadFromStream(BlobStream);
    BlobStream := DM.qryPerfil.CreateBlobStream(
                    DM.qryPerfil.FieldByName('FOTO'),TBlobStreamMode.bmRead
                  );
    imgFotoUnidade.Bitmap.LoadFromStream(BlobStream);
  end;

  TabControl.ActiveTab := TabItemAbertura;
end;

end.
