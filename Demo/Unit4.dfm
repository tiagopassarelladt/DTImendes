object Form4: TForm4
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Demo - Integra'#231#227'o com Imendes'
  ClientHeight = 540
  ClientWidth = 724
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 25
    Height = 13
    Caption = 'CNPJ'
  end
  object Label2: TLabel
    Left = 151
    Top = 8
    Width = 27
    Height = 13
    Caption = 'CNAE'
  end
  object Label3: TLabel
    Left = 231
    Top = 8
    Width = 13
    Height = 13
    Caption = 'UF'
  end
  object Label4: TLabel
    Left = 311
    Top = 8
    Width = 41
    Height = 13
    Caption = 'CODIGO'
  end
  object Label5: TLabel
    Left = 466
    Top = 8
    Width = 59
    Height = 13
    Caption = 'DESCRICAO'
  end
  object Memo1: TMemo
    Left = 0
    Top = 126
    Width = 724
    Height = 414
    Cursor = crHandPoint
    Align = alBottom
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object edtCNPJ: TEdit
    Left = 8
    Top = 24
    Width = 137
    Height = 21
    TabOrder = 1
  end
  object edtCnae: TEdit
    Left = 151
    Top = 24
    Width = 74
    Height = 21
    TabOrder = 2
  end
  object Button1: TButton
    Left = 8
    Top = 64
    Width = 137
    Height = 25
    Cursor = crHandPoint
    Caption = 'Consulta Produtos'
    TabOrder = 3
    OnClick = Button1Click
  end
  object edtUF: TEdit
    Left = 231
    Top = 24
    Width = 74
    Height = 21
    TabOrder = 4
  end
  object edtCodigo: TEdit
    Left = 311
    Top = 24
    Width = 149
    Height = 21
    TabOrder = 5
  end
  object edtDescricao: TEdit
    Left = 466
    Top = 24
    Width = 250
    Height = 21
    TabOrder = 6
  end
  object Button2: TButton
    Left = 311
    Top = 64
    Width = 149
    Height = 25
    Cursor = crHandPoint
    Caption = 'Consulta Situacao do Cliente'
    TabOrder = 7
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 151
    Top = 64
    Width = 154
    Height = 25
    Cursor = crHandPoint
    Caption = 'Consulta em lote'
    TabOrder = 8
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 95
    Width = 137
    Height = 25
    Cursor = crHandPoint
    Caption = 'Consulta Historico Acessos'
    TabOrder = 9
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 151
    Top = 95
    Width = 154
    Height = 25
    Cursor = crHandPoint
    Caption = 'Remove Devolvidos'
    TabOrder = 10
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 311
    Top = 95
    Width = 149
    Height = 25
    Cursor = crHandPoint
    Caption = 'Retorna Alterados'
    TabOrder = 11
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 466
    Top = 95
    Width = 159
    Height = 25
    Cursor = crHandPoint
    Caption = 'Lista Produtos'
    TabOrder = 12
    OnClick = Button7Click
  end
  object DTImendes1: TDTImendes
    Ambiente = Homologacao
    RegimeTributario = SimplesNacional
    GravaLog = True
    CaminhoLog = 'C:\temp\'
    Left = 668
    Top = 50
  end
end
