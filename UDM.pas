unit UDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.IOUtils;

type
  TDM = class(TDataModule)
    Connexao: TFDConnection;
    qryUsuarios: TFDQuery;
    qryPerfil: TFDQuery;
    qryReq: TFDQuery;
    qryRequisitos: TFDQuery;
    qryRequisitosid: TIntegerField;
    qryRequisitosdescricao: TStringField;
    procedure ConnexaoBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDM.ConnexaoBeforeConnect(Sender: TObject);
begin
  {$IF DEFINED(ANDROID)}
     Connexao.Params.Values['Database'] :=
                        TPath.Combine(TPath.GetDocumentsPath, 'banco.sqlite');
   {$ENDIF}
end;

end.
