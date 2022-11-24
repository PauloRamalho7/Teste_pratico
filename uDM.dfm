object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 398
  object FDConn: TFDConnection
    Params.Strings = (
      'Database=D:\Projetos\davinTI\Teste_pratico\dbAgenda.db'
      'OpenMode=ReadWrite'
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 56
    Top = 32
  end
  object FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink
    Left = 56
    Top = 88
  end
  object qry_contato: TFDQuery
    Connection = FDConn
    Left = 128
    Top = 32
  end
  object qry_fone: TFDQuery
    Connection = FDConn
    Left = 192
    Top = 32
  end
end
