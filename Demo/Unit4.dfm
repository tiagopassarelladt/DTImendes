object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Demo - DTImendes - API v2.23.1.0'
  ClientHeight = 600
  ClientWidth = 900
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 900
    Height = 600
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Configuracao'
      object Panel15: TPanel
        Left = 0
        Top = 0
        Width = 892
        Height = 120
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label14: TLabel
          Left = 16
          Top = 16
          Width = 29
          Height = 13
          Caption = 'Login'
        end
        object Label15: TLabel
          Left = 160
          Top = 16
          Width = 32
          Height = 13
          Caption = 'Senha'
        end
        object Label1: TLabel
          Left = 304
          Top = 16
          Width = 24
          Height = 13
          Caption = 'CNPJ'
        end
        object Label2: TLabel
          Left = 448
          Top = 16
          Width = 28
          Height = 13
          Caption = 'CNAE'
        end
        object Label3: TLabel
          Left = 592
          Top = 16
          Width = 14
          Height = 13
          Caption = 'UF'
        end
        object Label16: TLabel
          Left = 16
          Top = 64
          Width = 19
          Height = 13
          Caption = 'CRT'
        end
        object Label17: TLabel
          Left = 160
          Top = 64
          Width = 50
          Height = 13
          Caption = 'Cod Faixa'
        end
        object Label18: TLabel
          Left = 304
          Top = 64
          Width = 90
          Height = 13
          Caption = 'Regime Tributario'
        end
        object Label19: TLabel
          Left = 448
          Top = 64
          Width = 49
          Height = 13
          Caption = 'Ambiente'
        end
        object edtLogin: TEdit
          Left = 16
          Top = 32
          Width = 129
          Height = 21
          TabOrder = 0
        end
        object edtSenha: TEdit
          Left = 160
          Top = 32
          Width = 129
          Height = 21
          PasswordChar = '*'
          TabOrder = 1
        end
        object edtCNPJ: TEdit
          Left = 304
          Top = 32
          Width = 129
          Height = 21
          TabOrder = 2
        end
        object edtCnae: TEdit
          Left = 448
          Top = 32
          Width = 129
          Height = 21
          TabOrder = 3
        end
        object edtUF: TEdit
          Left = 592
          Top = 32
          Width = 57
          Height = 21
          TabOrder = 4
        end
        object Button8: TButton
          Left = 688
          Top = 24
          Width = 177
          Height = 73
          Caption = 'Salvar Configuracoes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          OnClick = Button8Click
        end
        object edtCRT: TEdit
          Left = 16
          Top = 80
          Width = 129
          Height = 21
          TabOrder = 6
        end
        object edtCodFaixa: TEdit
          Left = 160
          Top = 80
          Width = 129
          Height = 21
          TabOrder = 7
        end
        object ComboBox1: TComboBox
          Left = 304
          Top = 80
          Width = 129
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 8
          Text = 'Simples Nacional'
          Items.Strings = (
            'Simples Nacional'
            'Lucro Presumido'
            'Lucro Real')
        end
        object ComboBox2: TComboBox
          Left = 448
          Top = 80
          Width = 129
          Height = 21
          Style = csDropDownList
          ItemIndex = 1
          TabOrder = 9
          Text = 'Producao'
          Items.Strings = (
            'Homologacao'
            'Producao')
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 120
        Width = 892
        Height = 452
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object Memo1: TMemo
          Left = 0
          Top = 0
          Width = 892
          Height = 452
          Align = alClient
          Color = 4276545
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Consolas'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Consulta Tributos'
      ImageIndex = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 892
        Height = 80
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label6: TLabel
          Left = 16
          Top = 16
          Width = 100
          Height = 13
          Caption = 'Codigo do Produto'
        end
        object Label7: TLabel
          Left = 224
          Top = 16
          Width = 111
          Height = 13
          Caption = 'Descricao do Produto'
        end
        object edtCodigo: TEdit
          Left = 16
          Top = 32
          Width = 185
          Height = 21
          TabOrder = 0
        end
        object edtDescricao: TEdit
          Left = 224
          Top = 32
          Width = 441
          Height = 21
          TabOrder = 1
        end
        object Button1: TButton
          Left = 688
          Top = 16
          Width = 177
          Height = 49
          Caption = 'Consultar Tributos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnClick = Button1Click
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 80
        Width = 892
        Height = 492
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object Memo2: TMemo
          Left = 0
          Top = 0
          Width = 892
          Height = 492
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Consolas'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Status Cliente'
      ImageIndex = 2
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 892
        Height = 80
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Button3: TButton
          Left = 16
          Top = 16
          Width = 849
          Height = 49
          Caption = 'Consultar Status do Cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = Button3Click
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 80
        Width = 892
        Height = 492
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object Memo3: TMemo
          Left = 0
          Top = 0
          Width = 892
          Height = 492
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Consolas'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Consulta Lote'
      ImageIndex = 3
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 892
        Height = 120
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label8: TLabel
          Left = 16
          Top = 16
          Width = 98
          Height = 13
          Caption = 'Produto 1 (Codigo)'
        end
        object Label9: TLabel
          Left = 224
          Top = 16
          Width = 109
          Height = 13
          Caption = 'Produto 1 (Descricao)'
        end
        object Label10: TLabel
          Left = 16
          Top = 64
          Width = 98
          Height = 13
          Caption = 'Produto 2 (Codigo)'
        end
        object Label11: TLabel
          Left = 224
          Top = 64
          Width = 109
          Height = 13
          Caption = 'Produto 2 (Descricao)'
        end
        object edtCodigoLote1: TEdit
          Left = 16
          Top = 32
          Width = 185
          Height = 21
          TabOrder = 0
        end
        object edtDescricaoLote1: TEdit
          Left = 224
          Top = 32
          Width = 441
          Height = 21
          TabOrder = 1
        end
        object edtCodigoLote2: TEdit
          Left = 16
          Top = 80
          Width = 185
          Height = 21
          TabOrder = 2
        end
        object edtDescricaoLote2: TEdit
          Left = 224
          Top = 80
          Width = 441
          Height = 21
          TabOrder = 3
        end
        object Button2: TButton
          Left = 688
          Top = 16
          Width = 177
          Height = 89
          Caption = 'Consultar Lote'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          OnClick = Button2Click
        end
      end
      object Panel7: TPanel
        Left = 0
        Top = 120
        Width = 892
        Height = 452
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object Memo4: TMemo
          Left = 0
          Top = 0
          Width = 892
          Height = 452
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Consolas'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Historico'
      ImageIndex = 4
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 892
        Height = 80
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Button4: TButton
          Left = 16
          Top = 16
          Width = 849
          Height = 49
          Caption = 'Consultar Historico de Acessos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = Button4Click
        end
      end
      object Panel9: TPanel
        Left = 0
        Top = 80
        Width = 892
        Height = 492
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object Memo5: TMemo
          Left = 0
          Top = 0
          Width = 892
          Height = 492
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Consolas'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Remove Devolvidos'
      ImageIndex = 5
      object Panel10: TPanel
        Left = 0
        Top = 0
        Width = 892
        Height = 80
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label12: TLabel
          Left = 16
          Top = 16
          Width = 73
          Height = 13
          Caption = 'ID do Produto'
        end
        object edtIDRemover: TEdit
          Left = 16
          Top = 32
          Width = 441
          Height = 21
          TabOrder = 0
        end
        object Button5: TButton
          Left = 480
          Top = 16
          Width = 385
          Height = 49
          Caption = 'Remover Devolvidos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = Button5Click
        end
      end
      object Panel11: TPanel
        Left = 0
        Top = 80
        Width = 892
        Height = 492
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object Memo6: TMemo
          Left = 0
          Top = 0
          Width = 892
          Height = 492
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Consolas'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Altera Dados / Lista'
      ImageIndex = 6
      object Panel12: TPanel
        Left = 0
        Top = 0
        Width = 892
        Height = 80
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label13: TLabel
          Left = 448
          Top = 16
          Width = 79
          Height = 13
          Caption = 'Buscar Produto'
        end
        object Button6: TButton
          Left = 16
          Top = 16
          Width = 401
          Height = 49
          Caption = 'Retornar Alterados'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = Button6Click
        end
        object edtBuscaProduto: TEdit
          Left = 448
          Top = 32
          Width = 217
          Height = 21
          TabOrder = 1
        end
        object Button7: TButton
          Left = 688
          Top = 15
          Width = 177
          Height = 49
          Caption = 'Listar Produtos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnClick = Button7Click
        end
      end
      object Panel13: TPanel
        Left = 0
        Top = 80
        Width = 892
        Height = 244
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel13'
        TabOrder = 1
        object Memo7: TMemo
          Left = 0
          Top = 0
          Width = 892
          Height = 244
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Consolas'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
        end
      end
      object Panel14: TPanel
        Left = 0
        Top = 324
        Width = 892
        Height = 248
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel14'
        TabOrder = 2
        object Memo8: TMemo
          Left = 0
          Top = 0
          Width = 892
          Height = 248
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Consolas'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
        end
      end
    end
  end
  object DTImendes1: TDTImendes
    Ambiente = Homologacao
    RegimeTributario = SimplesNacional
    GravaLog = False
    Left = 412
    Top = 304
  end
end
