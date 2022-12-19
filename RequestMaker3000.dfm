object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'RequestMaker3000'
  ClientHeight = 740
  ClientWidth = 1125
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 1125
    Height = 185
    ActivePage = TabAnymarket
    Align = alTop
    TabOrder = 0
    OnChange = PageControlChange
    object TabAnymarket: TTabSheet
      Caption = 'Anymarket'
      object Label2: TLabel
        Left = 7
        Top = 11
        Width = 61
        Height = 13
        Caption = 'Autoriza'#231#227'o:'
      end
      object Label1: TLabel
        Left = 3
        Top = 59
        Width = 104
        Height = 13
        Alignment = taCenter
        Caption = 'O que deseja buscar?'
      end
      object btnLimpaCodigos: TButton
        Left = 639
        Top = 36
        Width = 89
        Height = 25
        Caption = 'Limpar C'#243'digos'
        TabOrder = 0
        OnClick = btnLimpaCodigosClick
      end
      object btnSalvar: TButton
        Left = 558
        Top = 36
        Width = 75
        Height = 25
        Caption = 'Salvar'
        TabOrder = 1
        OnClick = btnSalvarClick
      end
      object chkNome: TCheckBox
        Left = 742
        Top = 78
        Width = 80
        Height = 17
        Caption = 'Completo?'
        TabOrder = 2
        Visible = False
      end
      object edtToken: TEdit
        Left = 5
        Top = 30
        Width = 245
        Height = 21
        TabOrder = 3
        TextHint = 'Digite o Token'
      end
      object rdrArvore: TRadioButton
        Left = 273
        Top = 79
        Width = 103
        Height = 17
        Caption = 'Categorias Filhas'
        TabOrder = 4
        OnClick = rdrArvoreClick
      end
      object rdrCategorias: TRadioButton
        Left = 199
        Top = 78
        Width = 73
        Height = 19
        Caption = 'Categorias'
        TabOrder = 5
        OnClick = rdrCategoriasClick
      end
      object rdrFab: TRadioButton
        Left = 121
        Top = 78
        Width = 71
        Height = 17
        Caption = 'Fabricantes'
        TabOrder = 6
        OnClick = rdrFabClick
      end
      object rdrImages: TRadioButton
        Left = 375
        Top = 80
        Width = 61
        Height = 17
        Caption = 'Imagens'
        TabOrder = 7
        OnClick = rdrImagesClick
      end
      object rdrProduto: TRadioButton
        Left = 3
        Top = 78
        Width = 65
        Height = 17
        Caption = 'Produtos'
        TabOrder = 8
        OnClick = rdrProdutoClick
      end
      object rdrSkus: TRadioButton
        Left = 74
        Top = 78
        Width = 41
        Height = 17
        Caption = 'SKUs'
        TabOrder = 9
        OnClick = rdrSkusClick
      end
      object btnEnviar: TButton
        Left = 256
        Top = 27
        Width = 75
        Height = 23
        Caption = 'Enviar'
        TabOrder = 10
        OnClick = btnEnviarClick
      end
      object btnApagarResposta: TButton
        Left = 732
        Top = 36
        Width = 90
        Height = 25
        Caption = 'Limpar Resposta'
        TabOrder = 11
        OnClick = btnApagarRespostaClick
      end
      object rdrTipoGrade: TRadioButton
        Left = 435
        Top = 80
        Width = 113
        Height = 17
        Caption = 'TipoGrade/Grades'
        TabOrder = 12
      end
    end
    object TabSkyhub: TTabSheet
      Caption = 'Skyhub'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Edit1: TEdit
        Left = 24
        Top = 16
        Width = 257
        Height = 21
        TabOrder = 0
      end
      object Token: TEdit
        Left = 24
        Top = 43
        Width = 257
        Height = 21
        TabOrder = 1
      end
      object Button3: TButton
        Left = 896
        Top = 38
        Width = 75
        Height = 25
        Caption = 'Button3'
        TabOrder = 2
        OnClick = Button3Click
      end
    end
    object TabLojaIntegrada: TTabSheet
      Caption = 'Loja Integrada'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object edtChaveApi: TEdit
        Left = 3
        Top = 28
        Width = 174
        Height = 21
        TabOrder = 0
        Text = 'd01ddc9f921e86c241bd'
        TextHint = 'Chave Api'
      end
      object edtAplicacao: TEdit
        Left = 3
        Top = 55
        Width = 243
        Height = 21
        TabOrder = 1
        Text = 'a9a2e212-40e5-475b-97d4-9dba110fd8b6'
        TextHint = 'Chave Aplica'#231#227'o'
      end
      object btnEnviarLI: TButton
        Left = 252
        Top = 53
        Width = 75
        Height = 25
        Caption = 'Enviar'
        TabOrder = 2
        OnClick = btnEnviarLIClick
      end
      object rdrProdutoLI: TRadioButton
        Left = 416
        Top = 32
        Width = 113
        Height = 17
        Caption = 'Produto'
        TabOrder = 3
      end
      object rdrFoto: TRadioButton
        Left = 496
        Top = 32
        Width = 41
        Height = 17
        Caption = 'Foto'
        TabOrder = 4
      end
      object Button2: TButton
        Left = 984
        Top = 53
        Width = 75
        Height = 25
        Caption = 'Button2'
        TabOrder = 5
        OnClick = Button2Click
      end
      object edtId: TEdit
        Left = 720
        Top = 16
        Width = 121
        Height = 21
        TabOrder = 6
        Text = 'edtId'
      end
    end
    object TabOlist: TTabSheet
      Caption = 'Olist'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblolistAuth: TLabel
        Left = 3
        Top = -3
        Width = 57
        Height = 13
        Caption = 'Autoriza'#231#227'o'
      end
      object lblAuthMaster: TLabel
        Left = 848
        Top = 3
        Width = 104
        Height = 13
        Caption = 'Autoriza'#231#227'o (CTRL M)'
      end
      object lblStatus: TLabel
        Left = 848
        Top = 110
        Width = 3
        Height = 13
      end
      object Label3: TLabel
        Left = 847
        Top = 18
        Width = 36
        Height = 13
        Caption = 'Usu'#225'rio'
      end
      object Label4: TLabel
        Left = 848
        Top = 56
        Width = 30
        Height = 13
        Caption = 'Senha'
      end
      object Label5: TLabel
        Left = 1040
        Top = 18
        Width = 68
        Height = 13
        Caption = 'Integration ID'
      end
      object btnOlistBuscar: TButton
        Left = 750
        Top = 32
        Width = 75
        Height = 25
        Caption = 'Buscar'
        TabOrder = 0
        OnClick = btnOlistBuscarClick
      end
      object btnSave: TButton
        Left = 750
        Top = 99
        Width = 75
        Height = 25
        Caption = 'Salvar'
        TabOrder = 1
        OnClick = btnSaveClick
      end
      object edtOlistAuth: TMemo
        Left = 3
        Top = 32
        Width = 741
        Height = 92
        TabOrder = 2
      end
      object Executar: TButton
        Left = 1031
        Top = 97
        Width = 75
        Height = 25
        Caption = 'Executar'
        TabOrder = 3
        OnClick = ExecutarClick
      end
      object edtUser: TEdit
        Left = 847
        Top = 32
        Width = 177
        Height = 21
        TabOrder = 4
      end
      object edtSenha: TEdit
        Left = 847
        Top = 70
        Width = 266
        Height = 21
        TabOrder = 5
      end
      object btnLimpar: TButton
        Left = 750
        Top = 66
        Width = 75
        Height = 25
        Caption = 'Limpar'
        TabOrder = 6
        OnClick = btnLimparClick
      end
      object edtIntegrationID: TEdit
        Left = 1038
        Top = 32
        Width = 75
        Height = 21
        TabOrder = 7
      end
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 200
    Width = 1117
    Height = 545
    ActivePage = Dados
    TabOrder = 1
    OnChange = PageControl1Change
    object Dados: TTabSheet
      Caption = 'Dados'
      object Button1: TButton
        Left = 223
        Top = 0
        Width = 31
        Height = 517
        Align = alLeft
        Caption = '<'
        TabOrder = 0
        OnClick = Button1Click
      end
      object MemoCodigos: TMemo
        Left = 0
        Top = 0
        Width = 223
        Height = 517
        Align = alLeft
        ScrollBars = ssVertical
        TabOrder = 1
      end
      object MemoResposta: TMemo
        Left = 254
        Top = 0
        Width = 839
        Height = 517
        Align = alLeft
        ScrollBars = ssBoth
        TabOrder = 2
      end
    end
    object Anuncios: TTabSheet
      Caption = 'Anuncios'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object gdProduto: TStringGrid
        Left = 3
        Top = 3
        Width = 774
        Height = 544
        ColCount = 3
        DefaultColWidth = 125
        FixedCols = 0
        RowCount = 177
        FixedRows = 0
        TabOrder = 0
      end
      object memImport: TMemo
        Left = 848
        Top = 3
        Width = 258
        Height = 544
        TabOrder = 1
      end
    end
    object Status: TTabSheet
      Caption = 'Status'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object gdStatus: TStringGrid
        Left = 3
        Top = 0
        Width = 446
        Height = 534
        ColCount = 3
        FixedCols = 0
        RowCount = 23
        FixedRows = 0
        TabOrder = 0
      end
    end
  end
  object IdHTTP1: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    AllowCookies = True
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 1064
    Top = 680
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Method = sslvSSLv23
    SSLOptions.SSLVersions = [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2]
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 1064
    Top = 608
  end
  object NetHTTPClient1: TNetHTTPClient
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    HandleRedirects = True
    AllowCookies = True
    UserAgent = 'Embarcadero URI Client/1.0'
    OnAuthEvent = NetHTTPClient1AuthEvent
    Left = 1065
    Top = 636
  end
end
