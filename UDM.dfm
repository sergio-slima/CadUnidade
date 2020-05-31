object DM: TDM
  OldCreateOrder = False
  Height = 369
  Width = 427
  object Connexao: TFDConnection
    Params.Strings = (
      
        'Database=D:\Users\Desenvolvimento\Documents\Embarcadero\Studio\P' +
        'rojects\CadUnidade\banco.sqlite'
      'User_Name=root'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    BeforeConnect = ConnexaoBeforeConnect
    Left = 48
    Top = 16
  end
  object qryUsuarios: TFDQuery
    Connection = Connexao
    SQL.Strings = (
      'select * from usuarios')
    Left = 48
    Top = 80
  end
  object qryPerfil: TFDQuery
    Connection = Connexao
    SQL.Strings = (
      'select * from perfil')
    Left = 48
    Top = 136
  end
  object qryReq: TFDQuery
    Connection = Connexao
    SQL.Strings = (
      '')
    Left = 48
    Top = 256
  end
  object qryRequisitos: TFDQuery
    Connection = Connexao
    SQL.Strings = (
      'select * from requisitos')
    Left = 48
    Top = 200
    object qryRequisitosid: TIntegerField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryRequisitosdescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Required = True
    end
  end
end
