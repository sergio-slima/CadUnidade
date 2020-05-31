unit URequisitos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.DBScope, FMX.ListView, FMX.Edit, FMX.Layouts,
  FMX.VirtualKeyboard, FMX.Platform;

type
  TFormRequisitos = class(TForm)
    ToolBar5: TToolBar;
    Rectangle9: TRectangle;
    img_fechar: TImage;
    Label27: TLabel;
    Layout5: TLayout;
    edtRequisitos: TEdit;
    imgAdd: TImage;
    lvRequisitos: TListView;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    BindSourceDB1: TBindSourceDB;
    Rectangle1: TRectangle;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure img_fecharClick(Sender: TObject);
    procedure imgAddClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRequisitos: TFormRequisitos;

implementation

{$R *.fmx}

uses UPrincipal, UDM;

procedure TFormRequisitos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  FormRequisitos := nil;

  FormPrincipal.FloatAnimation.Start;
end;

procedure TFormRequisitos.FormKeyUp(Sender: TObject; var Key: Word;
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
      Key := 0;
      Close;
    end;
  end;
  {$ENDIF}
end;

procedure TFormRequisitos.imgAddClick(Sender: TObject);
begin
  with DM.qryReq do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert into requisitos (descricao) values (:descricao)');
    ParamByName('descricao').Value := edtRequisitos.Text;
    ExecSQL;

    DM.qryRequisitos.Refresh;
  end;
end;

procedure TFormRequisitos.img_fecharClick(Sender: TObject);
begin
  Close;
end;

end.
