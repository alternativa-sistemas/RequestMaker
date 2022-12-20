unit RequestMaker3000;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdIOHandler, IdIOHandlerSocket,JSON.Utils,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.StdCtrls, uJson, Vcl.ComCtrls,
  Vcl.ExtCtrls, IdIntercept, Vcl.Grids,System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  REST.Types, REST.Client, REST.Authenticator.Basic, Data.Bind.Components,IOUtils,
  Data.Bind.ObjectScope;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    MemoCodigos: TMemo;
    btnEnviar: TButton;
    edtToken: TEdit;
    rdrCategorias: TRadioButton;
    rdrImages: TRadioButton;
    rdrFab: TRadioButton;
    rdrProduto: TRadioButton;
    rdrSkus: TRadioButton;
    rdrArvore: TRadioButton;
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    MemoResposta: TMemo;
    btnLimpaCodigos: TButton;
    btnApagarResposta: TButton;
    Button1: TButton;
    chkNome: TCheckBox;
    btnSalvar: TButton;
    PageControl: TPageControl;
    TabAnymarket: TTabSheet;
    TabSkyhub: TTabSheet;
    TabLojaIntegrada: TTabSheet;
    edtChaveApi: TEdit;
    edtAplicacao: TEdit;
    btnEnviarLI: TButton;
    rdrTipoGrade: TRadioButton;
    rdrProdutoLI: TRadioButton;
    rdrFoto: TRadioButton;
    Button2: TButton;
    edtId: TEdit;
    Edit1: TEdit;
    Token: TEdit;
    Button3: TButton;
    TabOlist: TTabSheet;
    PageControl1: TPageControl;
    Dados: TTabSheet;
    Anuncios: TTabSheet;
    btnOlistBuscar: TButton;
    lblolistAuth: TLabel;
    gdProduto: TStringGrid;
    NetHTTPClient1: TNetHTTPClient;
    btnSave: TButton;
    edtOlistAuth: TMemo;
    memImport: TMemo;
    Executar: TButton;
    edtUser: TEdit;
    edtSenha: TEdit;
    btnLimpar: TButton;
    lblAuthMaster: TLabel;
    lblStatus: TLabel;
    edtIntegrationID: TEdit;
    Status: TTabSheet;
    gdStatus: TStringGrid;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure btnEnviarClick(Sender: TObject);
    procedure btnLimpaCodigosClick(Sender: TObject);
    procedure btnApagarRespostaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure rdrFabClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure btnEnviarLIClick(Sender: TObject);
    procedure rdrProdutoClick(Sender: TObject);
    procedure rdrSkusClick(Sender: TObject);
    procedure rdrImagesClick(Sender: TObject);
    procedure rdrCategoriasClick(Sender: TObject);
    procedure rdrArvoreClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOlistBuscarClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ExecutarClick(Sender: TObject);
    procedure NetHTTPClient1AuthEvent(const Sender: TObject;
      AnAuthTarget: TAuthTargetType; const ARealm, AURL: string; var AUserName,
      APassword: string; var AbortAuth: Boolean;
      var Persistence: TAuthPersistenceType);
    procedure PageControl1Change(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);

  private
    { Private declarations }
  public
      Arquivo:TStringList;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{$REGION 'CONTROLE'}
procedure TForm1.FormCreate(Sender: TObject);
begin
  PageControl.TabIndex:=0;
  Dados.tabvisible:=True;
  Anuncios.tabvisible:=False;
  Status.TabVisible:=False;
  Arquivo:=TStringList.Create;
  ForceDirectories('C:/Teste');
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
 FreeAndNil(Arquivo);
end;




procedure TForm1.PageControlChange(Sender: TObject);
begin
  Dados.TabVisible:=True;
  Anuncios.TabVisible:=False;
  Status.TabVisible:=False;
  IF PageControl.TabIndex = 2 then
  begin
    IdHTTP1.Request.ContentType:='application/json';
    IdHTTP1.Request.Host:='api.awsli.com.br';
    IdHTTP1.Request.Accept:='application/json';
    IdHTTP1.Request.AcceptEncoding:='identity';
    IdHTTP1.Request.UserAgent:='AS-Master';
  end
  else if PageControl.TabIndex = 3 then
  begin
    Dados.TabVisible:=False;
    Anuncios.TabVisible:=True;
    Status.TabVisible:=True;
    pagecontrol1.TabIndex := 0;
  end

  {$ENDREGION}
End;

{$REGION 'ANYMARKET'}


procedure TForm1.btnEnviarClick(Sender: TObject);
  var
  Resposta,IdImg, description,description1,SkuID, NomeTipoGrade, IdTipoGrade, VarId,VarId1,VarImage, principal, index, FabId, FabName, url, ProId, CatId, CatNome,
  ChaveApi, aplicacao, ProNome, NomeGrade, IdGrade, PrecoDe, PrecoPor, ProBarra, PartnerId, Peso, Altura, Largura,Profundidade,
  Path, Modelo, ProDescr, NBMId, Gender, WarrantyText, OriginId, WarrantyTime, PriceFactor,Ean:string;
  JSON: TJSONArray;
  JSONobj: TJSONObject;
  ListaCodigos: TStringList;
  I,x,y,Paginas,Incremento, linha:Integer;
  cabecalho: Boolean;
  pJsonObj: TJSONObject;
  SS: TStringStream;
begin
  ListaCodigos := TStringList.Create;
  description := '';
  ListaCodigos.Delimiter := ',';
  ListaCodigos.DelimitedText := MemoCodigos.Text;

  if rdrProduto.Checked then
  begin
    cabecalho := False;
    Incremento := 0;
    SS := TStringStream.Create('', TEncoding.UTF8);
    try
      IdHTTP1.get('http://api.anymarket.com.br/v2/products?gumgaToken='+edtToken.Text, SS);
      Resposta := (SS.DataString);
    finally
      SS.Free;
    end;
    JSONobj := TJSONObject.create(Resposta);
    try
      Paginas :=  JSONobj.getJSONObject('page').getInt('totalPages');
    finally
      FreeAndNil(JSONobj);
    end;
    for I := 0 to Paginas - 1 do
//    for I := 0 to 0 do
    begin
      SS := TStringStream.Create('', TEncoding.UTF8);
      try
        IdHTTP1.get('http://api.anymarket.com.br/v2/products?gumgaToken='+edtToken.Text+'&offset='+IntToStr(Incremento)+'&limit=100', SS);
        Resposta := (SS.DataString);
      finally
        SS.Free;
      end;
      JSONobj := TJSONObject.create(Resposta);
      if chkNome.Checked = true then
      begin
        if JSONobj.has('content') then
        begin
          if cabecalho = False then
          begin
            MemoResposta.Lines.Add('ID;TITLE;DESCRIPTION;IDdaCATEGORIA;IDdaMARCA;NBM>ID;ORIGIN>ID;MODEL;GENDER;WARRANTYTIME;WARRANTYTEXT;HEIGHT;WIDTH;WEIGHT;LENGTH;PRICEFACTOR');
            cabecalho := True;
          end;
          Incremento := Incremento+100;
          for x := 0 to JSONobj.getJSONArray('content').length - 1 do
          begin
            ProId := JSONobj.getJSONArray('content').getJSONObject(x).getString('id');
            Peso := JSONobj.getJSONArray('content').getJSONObject(x).getString('weight');
            Altura := JSONobj.getJSONArray('content').getJSONObject(x).getString('height');
            Largura := JSONobj.getJSONArray('content').getJSONObject(x).getString('width');
            Profundidade := JSONobj.getJSONArray('content').getJSONObject(x).getString('length');
            if JSONobj.getJSONArray('content').getJSONObject(x).has('model') then
            begin
              Modelo := (JSONobj.getJSONArray('content').getJSONObject(x).getString('model'));
            end
            else
            begin
              Modelo := '';
            end;
              ProNome := (JSONobj.getJSONArray('content').getJSONObject(x).getString('title'));
            if JSONobj.getJSONArray('content').getJSONObject(x).has('category') then
            begin
              CatId:= (JSONobj.getJSONArray('content').getJSONObject(x).getJSONObject('category').getString('id'));
            end
            else
            begin
              CatId:= 'Item não possui Categoria';
            end;
            if JSONobj.getJSONArray('content').getJSONObject(x).has('brand') then
            begin
              FabId:= (JSONobj.getJSONArray('content').getJSONObject(x).getJSONObject('brand').getString('id'));
            end
            else
            begin
              FabId:='Item não possui Marca';
            end;
            if JSONobj.getJSONArray('content').getJSONObject(x).has('nbm') then
            begin
              NBMId:= (JSONobj.getJSONArray('content').getJSONObject(x).getJSONObject('nbm').getString('id'));
            end
            else
            begin
              NBMId:='Não possui Ncm';
            end;
            if JSONobj.getJSONArray('content').getJSONObject(x).has('origin') then
            begin
              OriginId:= (JSONobj.getJSONArray('content').getJSONObject(x).getJSONObject('origin').getString('id'));
            end
            else
            begin
              OriginId:='Não possui Origem';
            end;
            if JSONobj.getJSONArray('content').getJSONObject(x).has('gender') then
            begin
              Gender:= (JSONobj.getJSONArray('content').getJSONObject(x).getString('gender'));
            end
            else
            begin
              Gender:='Não possui Genero';
            end;
            if JSONobj.getJSONArray('content').getJSONObject(x).has('warrantyTime') then
            begin
              WarrantyTime:= (JSONobj.getJSONArray('content').getJSONObject(x).getString('warrantyTime'));
            end
            else
            begin
              WarrantyTime:='Não possui Tempo de Garantia';
            end;
            if JSONobj.getJSONArray('content').getJSONObject(x).has('warrantyText') then
            begin
              WarrantyText:= (JSONobj.getJSONArray('content').getJSONObject(x).getString('warrantyText'));
            end
            else
            begin
              WarrantyText:='Não possui Termo de Garantia';
            end;
            if JSONobj.getJSONArray('content').getJSONObject(x).has('priceFactor') then
            begin
              PriceFactor:= (JSONobj.getJSONArray('content').getJSONObject(x).getString('priceFactor'));
            end
            else
            begin
              PriceFactor:='Não possui preço do fabricante';
            end;
            if JSONobj.getJSONArray('content').getJSONObject(x).has('description') then
            begin
              ProDescr:= (JSONobj.getJSONArray('content').getJSONObject(x).getString('description'));
              ProDescr:= StringReplace(ProDescr, ';', '.', [rfReplaceAll]);
            end
            else
            begin
              ProDescr:='Não possui Descrição';
            end;
            MemoResposta.Lines.Add(ProId+' ; '+ProNome+' ; '+ProDescr +' ; ' + CatId + ' ; '+FabID +' ; ' +NBMId+' ; '+OriginId+' ; '+ Modelo +' ; '+Gender+' ; '+WarrantyTime+' ; '+WarrantyText+' ; '+ Altura +' ; '+ Largura +' ; '+ Peso +' ; '+ Profundidade +' ; '+PriceFactor+' ; ');
            MemoResposta.Lines.SaveToFile('C:\Teste\Produtos.csv');
          end;
        end;
      end
      else
      begin
       IF JSONobj.has('content') then
       begin
          if cabecalho = False then
          begin
            MemoResposta.Lines.Add('ID;');
            cabecalho := True;
          end;
          Incremento := Incremento+100;
          for x := 0 to JSONobj.getJSONArray('content').length - 1 do
          begin
            ProId := JSONobj.getJSONArray('content').getJSONObject(x).getString('id');
            MemoResposta.Lines.Add(ProId+',');
            MemoResposta.Lines.SaveToFile('C:\Teste\Produtos.csv');
          end;
       end;
      end;
    end;
  end;

  IF rdrSkus.Checked = True then
  begin
    cabecalho := False;
    linha:=0;
    for I := 0 to ListaCodigos.Count -1 do
    begin
      IF chkNome.Checked then
        begin
        try
          SS := TStringStream.Create('', TEncoding.UTF8);
          try
            IdHTTP1.get('http://api.anymarket.com.br/v2/products/'+ListaCodigos[i]+'/skus?gumgaToken='+edtToken.Text+'', SS);
            Resposta := SS.DataString;
          finally
            SS.Free;
          end;
          JSON := TJSONArray.Create(Resposta);
          if cabecalho = False then
          begin
            MemoResposta.Lines.Add('ID do Produto;ID do Sku;Nome do Sku;Preço DE;Preço POR;ID da VariaçãoX;ID da Variação Y;Partner Id;Nome grade X;Nome grade Y;EAN');
            cabecalho := True;
          end;
          for x := 0 to JSON.length -1 do
          begin
            IF JSON.getJSONObject(0).has('variations') then
            begin
              if JSON.getJSONObject(x).has('partnerId') then
              begin
                PartnerId:=JSON.getJSONObject(x).getString('partnerId');
              end else
              begin
                PartnerId:= '';
              end;
              if (JSON.getJSONObject(x).getJSONArray('variations').length = 2 ) then
              begin
                SkuID:=JSON.getJSONObject(x).getString('id');
                description:=(JSON.getJSONObject(x).getJSONArray('variations').getJSONObject(0).getString('description'));
                VarId:=JSON.getJSONObject(x).getJSONArray('variations').getJSONObject(0).getString('id');
                description1:=(JSON.getJSONObject(x).getJSONArray('variations').getJSONObject(1).getString('description'));
                VarId1:=JSON.getJSONObject(x).getJSONArray('variations').getJSONObject(1).getString('id');
                ProNome:=(JSON.getJSONObject(x).getString('title'));
                PrecoDe:=JSON.getJSONObject(x).getString('price');
                PrecoPor:=JSON.getJSONObject(x).getString('sellprice');
                Ean:=JSON.getJSONObject(x).getString('ean');
                MemoResposta.Lines.Add(ListaCodigos[I]+' ; '+ SkuID + ' ; '+ProNome+' ; '+PrecoDe+' ; '+PrecoPor+' ; '+VarId+' ; '+VarId1+' ; '+PartnerId + ' ; ' +description+' ; '+description1+' ; '+Ean);
              end
              else
              begin
                description:=(JSON.getJSONObject(x).getJSONArray('variations').getJSONObject(0).getString('description'));
                VarId:=JSON.getJSONObject(x).getJSONArray('variations').getJSONObject(0).getString('id');
                ProNome:=(JSON.getJSONObject(x).getString('title'));
                PrecoDe:=JSON.getJSONObject(x).getString('price');
                PrecoPor:=JSON.getJSONObject(x).getString('sellprice');
                SkuID:=JSON.getJSONObject(x).getString('id');
                Ean:=JSON.getJSONObject(x).getString('ean');
                VarId1:='Sem Variação Y';
                description1:='Sem Variação Y';
                MemoResposta.Lines.Add(ListaCodigos[I]+' ; '+ SkuID + ' ; '+ProNome+' ; '+PrecoDe+' ; '+PrecoPor+' ; '+VarId+' ; '+VarId1+' ; '+PartnerId + ' ; ' +description+' ; '+description1+' ; '+Ean);
              end;
            end else
            begin
              SS := TStringStream.Create('', TEncoding.UTF8);
              try
                IdHTTP1.get('http://api.anymarket.com.br/v2/products/'+ListaCodigos[i]+'/skus?gumgaToken='+edtToken.Text+'', SS);
                Resposta := SS.DataString;
              finally
                SS.Free;
              end;
              JSON := TJSONArray.Create(Resposta);
              ProNome:=(JSON.getJSONObject(x).getString('title'));
              PrecoDe:=JSON.getJSONObject(x).getString('price');
              PrecoPor:=JSON.getJSONObject(x).getString('sellprice');
              PartnerId:=JSON.getJSONObject(x).getString('PartnerID');
              SkuID:=JSON.getJSONObject(x).getString('id');
              Ean:=JSON.getJSONObject(x).getString('ean');
              VarId:='Sem Variação X';
              description:='Sem Variação X';
              VarId1:='Sem Variação Y';
              description1:='Sem Variação Y';
              MemoResposta.Lines.Add(ListaCodigos[I]+' ; '+ SkuID + ' ; '+ProNome+' ; '+PrecoDe+' ; '+PrecoPor+' ; '+VarId+' ; '+VarId1+' ; '+PartnerId + ' ; ' +description+' ; '+description1+' ; '+Ean);
            end;
          MemoResposta.Lines.SaveToFile('C:\Teste\Skus.csv');
          end;
        except
          on e:exception do
          begin
            MemoResposta.Lines.Add(ListaCodigos[i]+' - Não Existe Sku para este produto - '+ e.message);
          end;
        end
      end
      ELSE
        begin
        try
        SS := TStringStream.Create('', TEncoding.UTF8);
        try
          IdHTTP1.get('http://api.anymarket.com.br/v2/products/'+ListaCodigos[i]+'/skus?gumgaToken='+edtToken.Text+'', SS);
          Resposta := SS.DataString;
        finally
          SS.Free;
        end;
        JSON := TJSONArray.Create(Resposta);
        for x := 0 to JSON.length -1 do
          begin
            IF JSON.getJSONObject(0).has('variations') then
            begin
              description:=(JSON.getJSONObject(x).getJSONArray('variations').getJSONObject(0).getString('description'));
              VarId:=JSON.getJSONObject(x).getJSONArray('variations').getJSONObject(0).getString('id');
              SkuID := JSON.getJSONObject(x).getString('id');
              MemoResposta.Lines.Add(ListaCodigos[I]+' | '+ SkuId +' | '+description + ' | '+VarId);
              MemoResposta.Lines.SaveToFile('C:\Teste\Skus.txt');
            end else
            begin
              Resposta := IdHTTP1.get('http://api.anymarket.com.br/v2/products/'+ListaCodigos[i]+'/skus?gumgaToken='+edtToken.Text+'' );
              JSON := TJSONArray.Create(Resposta);
              SkuId := JSON.getJSONObject(x).getString('id');
              MemoResposta.Lines.Add(ListaCodigos[I]+' | '+ SkuId +' | Sem Variação');
              MemoResposta.Lines.SaveToFile('C:\Teste\Skus.txt');
            end
          end;
        except
          on e:exception do
          begin
            MemoResposta.Lines.Add(ListaCodigos[i]+' - Não Existe Sku para este produto - '+ e.message);
          end;
        end;
      end;
    end;
  end;

  IF rdrFab.Checked = True then
  begin
    Incremento := 0;
    SS := TStringStream.Create('');
    try
      IdHTTP1.get('http://api.anymarket.com.br/v2/brands?gumgaToken='+edtToken.Text+'&offset='+IntToStr(Incremento)+'&limit=100', SS);
      Resposta := (SS.DataString);
    finally
      SS.Free;
    end;
    JSONobj:= TJSONObject.Create(Resposta);
    try
      Paginas :=  JSONobj.getJSONObject('page').getInt('totalPages');
    finally
      FreeAndNil(JSONobj);
    end;
    if cabecalho = False then
    begin
      MemoResposta.Lines.Add('ID do Fabricante;Nome do Fabricante');
      cabecalho := True;
    end;
    for I := 0 to Paginas -1 do
    begin
      JSONobj := TJSONObject.create(Resposta);
      IF chkNome.Checked then
      begin
        for x := 0 to JSONobj.getJSONArray('content').length -1 do
        begin
          FabId:=JSONobj.getJSONArray('content').getJSONObject(x).getString('id');
          FabName:=(JSONobj.getJSONArray('content').getJSONObject(x).getString('name'));
          MemoResposta.Lines.Add(FabId +' ; '+FabName);
          Incremento := Incremento + 100;
        end;
      end ELSE
        for x := 0 to JSONobj.getJSONArray('content').length -1 do
      begin
        FabId:=JSONobj.getJSONArray('content').getJSONObject(x).getString('id');
        FabName:=(JSONobj.getJSONArray('content').getJSONObject(x).getString('name'));
        MemoResposta.Lines.Add(FabId+',');
        MemoResposta.Lines.SaveToFile('C:\Teste\Fabricantes.csv');
        Incremento := Incremento + 100;
      end;
    end;
  end;

  IF rdrCategorias.Checked = True then
  begin
    Incremento := 0;
    SS := TStringStream.Create('', TEncoding.UTF8);
    try
      IdHTTP1.get('http://api.anymarket.com.br/v2/categories?gumgaToken='+edtToken.Text+'&offset='+IntToStr(Incremento)+'&limit=100', SS);
      Resposta := SS.DataString;
    finally
      SS.Free;
    end;
    JSONobj := TJSONObject.create(Resposta);
    try
      IF not chkNome.Checked then
      begin
        if cabecalho = False then
        begin
        MemoResposta.Lines.Add('ID da Categoria');
        cabecalho := True;
        end;
        Incremento := Incremento+100;
        for x := 0 to JSONobj.getJSONArray('content').length - 1 do
        begin
          CatId := JSONobj.getJSONArray('content').getJSONObject(x).getString('id');
          MemoResposta.Lines.Add(CatId+',');
          MemoResposta.Lines.SaveToFile('C:\Teste\Categorias.csv');
        end;
      end else
      begin
        if cabecalho = False then
        begin
        MemoResposta.Lines.Add('ID da Categoria;Nome da Categoria');
        cabecalho := True;
        end;
        for x := 0 to JSONobj.getJSONArray('content').length - 1 do
        begin
          CatId := JSONobj.getJSONArray('content').getJSONObject(x).getString('id');
          CatNome := (JSONobj.getJSONArray('content').getJSONObject(x).getString('name'));
          MemoResposta.Lines.Add(CatId +';'+CatNome);
          MemoResposta.Lines.SaveToFile('C:\Teste\Categorias.csv');
        end;
      end;
    finally
      JSONobj.Free;
    end;
  end;

  IF rdrArvore.Checked = True then
  for I := 0 to ListaCodigos.Count -1 do
  begin
    SS := TStringStream.Create('', TEncoding.UTF8);
    try
      IdHTTP1.get('http://api.anymarket.com.br/v2/categories/'+ListaCodigos[i]+'?gumgaToken='+edtToken.Text, SS);
      Resposta := SS.DataString;
    finally
      SS.Free;
    end;
    JSONobj := TJSONObject.Create(Resposta);
    IF chkNome.Checked then
      begin
      IF JSONobj.has('Children') then
      begin
        for x := 0 to JSONobj.getJSONArray('children').Length -1 do
        begin
         CatId:= JSONobj.getJSONArray('children').getJSONObject(x).getString('id');
         CatNome:= (JSONobj.getJSONArray('children').getJSONObject(x).getString('name'));
         Path:= (JSONobj.getJSONArray('children').getJSONObject(x).getString('path'));
         MemoResposta.Lines.Add(ListaCodigos[I]+' ; '+ CatId +' ; '+ CatNome + ' ; ' + ListaCodigos[I]+'/'+CatId + ' ; '+ Path);
        end;
        MemoResposta.Lines.SaveToFile('C:\Teste\Arvore de Categorias.csv');
      end
      ELSE
      begin
        MemoResposta.Lines.Add(ListaCodigos[I]+'; Não tem subCategoria');
      end;
    end
    ELSE
    begin
      IF JSONobj.has('Children') then
      begin
        for x := 0 to JSONobj.getJSONArray('children').Length -1 do
        begin
         CatId:= JSONobj.getJSONArray('children').getJSONObject(x).getString('id');
         CatNome:= (JSONobj.getJSONArray('children').getJSONObject(x).getString('name'));
         MemoResposta.Lines.Add(ListaCodigos[I]+' | '+ CatId);
        end;
        MemoResposta.Lines.SaveToFile('C:\Teste\Arvore de Categorias.csv');
      end else
      begin
        MemoResposta.Lines.Add(ListaCodigos[I]+'; Não tem subCategoria');
      end;
    end;
  end;

  if rdrTipoGrade.Checked then
  begin
    SS := TStringStream.Create('',TEncoding.UTF8);
    try
      MemoResposta.Lines.Add('TipoGradeId;NomeTipoGrade;GradeId;NomeGrade');
      Incremento := 0;
      IdHTTP1.get('http://api.anymarket.com.br/v2/variations?gumgaToken='+edtToken.Text+'&offset='+IntToStr(Incremento)+'&limit=100', SS);
      Resposta := SS.DataString;
    finally
      SS.Free;
    end;
    JSONobj := TJSONObject.create(Resposta);
    for x := 0 to JSONobj.getJSONArray('content').length - 1 do
    begin
      pJsonObj := JSONobj.getJSONArray('content').getJSONObject(x);
      for y := 0 to pJsonObj.getJSONArray('values').length -1 do
      begin
        IdTipoGrade := pJsonObj.getString('id');
        NomeTipoGrade := (pJsonObj.getString('name'));
        IdGrade := pJsonObj.getJSONArray('values').getJSONObject(y).getString('id');
        NomeGrade := (pJsonObj.getJSONArray('values').getJSONObject(y).getString('description'));
        MemoResposta.Lines.Add(IdTipoGrade+' ; '+NomeTipoGrade + ' ; ' + IdGrade +' ; '+ NomeGrade);
      end;
    end;
    MemoResposta.Lines.SaveToFile('C:\Teste\TipoGrades.csv');
  end;

  IF rdrImages.Checked = True then
  for I := 0 to ListaCodigos.Count -1 do
  begin
    if cabecalho = False then
    begin
      MemoResposta.Lines.Add('ID do Produto;ID Imagem;Principal?;Index;Variation;Url');
      cabecalho := True;
    end;
    SS := TStringStream.Create('', TEncoding.UTF8);
    try
      IdHTTP1.get('http://api.anymarket.com.br/v2/products/'+ListaCodigos[i]+'/images?gumgaToken='+edtToken.Text, SS);
      Resposta := SS.DataString;
    finally
      SS.Free;
    end;
    JSON := TJSONArray.Create(Resposta);
    for x := 0 to JSON.length -1 do
    begin
      IF JSON.getJSONObject(0).has('variation') then
      begin
        IdImg := StringReplace(JSON.getJSONObject(x).getString('id'),'"','',[rfReplaceAll]);
        IdImg := StringReplace(IdImg,'.00','',[rfReplaceAll]);
        url := JSON.getJSONObject(x).getString('url');
        VarImage := JSON.getJSONObject(x).getString('variation');
        principal := JSON.getJSONObject(x).getString('main');
        index := JSON.getJSONObject(x).getString('index');
        MemoResposta.Lines.Add(ListaCodigos[I]+' ; '+IdImg+' ; '+principal+' ; '+index+' ; '+VarImage+' ; '+url);
      end
      else
      begin

      end;
    end;
   MemoResposta.Lines.SaveToFile('C:\Teste\Urls.csv');
  end;
end;

procedure TForm1.btnLimpaCodigosClick(Sender: TObject);
begin
  MemoCodigos.Clear;
end;

procedure TForm1.btnSalvarClick(Sender: TObject);
begin
  IF rdrFab.Checked then
  begin
    memoresposta.Lines.SaveToFile('C:\Teste/Fabricante.csv');
  end;
  IF rdrCategorias.Checked then
  begin
    MemoResposta.Lines.SaveToFile('C:\Teste/Fabricante.csv');
  end;
  IF rdrSkus.Checked then
  begin
    MemoResposta.Lines.SaveToFile('C:\Teste/SKUS.csv');
  end;
  IF rdrProduto.checked then
  begin
    MemoResposta.Lines.SaveToFile('C:\Teste/Produto.csv');
  end;
  IF rdrArvore.Checked then
  begin
    MemoResposta.Lines.SaveToFile('C:\Teste/Arvore de Categorias.csv');
  end;
  IF rdrImages.Checked then
  begin
    MemoResposta.Lines.SaveToFile('C:\Teste/Imagens.csv');
  end;
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  MemoCodigos.Lines:=MemoResposta.Lines;
  MemoResposta.Clear;
end;



procedure TForm1.rdrArvoreClick(Sender: TObject);
begin
  chkNome.Visible := True;
end;

procedure TForm1.rdrCategoriasClick(Sender: TObject);
begin
  chkNome.Visible := True;
end;

procedure TForm1.rdrFabClick(Sender: TObject);
begin
  chkNome.Visible := True;
end;

procedure TForm1.rdrImagesClick(Sender: TObject);
begin
  chkNome.Visible := false;
end;

procedure TForm1.rdrProdutoClick(Sender: TObject);
begin
  chkNome.Visible := True;
end;

procedure TForm1.rdrSkusClick(Sender: TObject);
begin
  chkNome.Visible := True;
end;

procedure TForm1.btnApagarRespostaClick(Sender: TObject);
begin
  MemoResposta.Clear;
end;



{$ENDREGION}

{$REGION 'LOJA INTEGRADA'}



procedure TForm1.Button2Click(Sender: TObject);
  var
    Resposta,IdImg, description, VarId, FabId, FabName, url, ProId, CatId, CatNome, ChaveApi, aplicacao, ProNome, NomeGrade, IdGrade, PrecoDe, PrecoPor, ProBarra:string;
    JSON: TJSONArray;
    JSONobj: TJSONObject;
    ListaCodigos: TStringList;
    I,x,Paginas,Incremento, linha:Integer;
begin
 ChaveApi:=edtChaveApi.Text;
 aplicacao:=edtAplicacao.Text;
 IF IdHTTP1.Request.CustomHeaders.Text = '' then
  begin
    IdHTTP1.Request.CustomHeaders.AddValue('authorization','chave_api '+ ChaveApi + ' aplicacao '+ Aplicacao);
    resposta:= IdHTTP1.get('http://api.awsli.com.br/v1/pedido/'+ edtid.Text);
    JSONobj := TJSONObject.create(Resposta);

    //try
     // Paginas :=  JSONobj.getJSONObject('meta').getInt('total_count');
    //finally
      //FreeAndNil(JSONobj);
  end;
end;




procedure TForm1.btnEnviarLIClick(Sender: TObject);
var
ChaveApi, aplicacao, resposta, url, IdLi, NomeLi, urlLI:string;
ListaCodigos: TStringList;
i,x,Paginas, Incremento, counter:integer;
JSONobj: TJSONObject;
begin
  ListaCodigos := TStringList.Create;
  Incremento:=0;
  ChaveApi:=edtChaveApi.Text;
  aplicacao:=edtAplicacao.Text;
  IF rdrProdutoLI.checked then
  begin
    ListaCodigos := TStringList.Create;
    ListaCodigos.Delimiter := ',';
    ListaCodigos.DelimitedText := MemoCodigos.Text;
    IF IdHTTP1.Request.CustomHeaders.Text = '' then
      begin
      IdHTTP1.Request.CustomHeaders.AddValue('authorization','chave_api '+ ChaveApi + ' aplicacao '+ Aplicacao);
      resposta:= IdHTTP1.get('http://api.awsli.com.br/v1/produto');
      JSONobj := TJSONObject.create(Resposta);
      try
        Paginas :=  JSONobj.getJSONObject('meta').getInt('total_count');
      finally
        FreeAndNil(JSONobj);
      end;
    end
    ELSE
    begin
      resposta:= IdHTTP1.get('http://api.awsli.com.br/v1/produto');
      JSONobj := TJSONObject.create(Resposta);
      try
        Paginas :=  JSONobj.getJSONObject('meta').getInt('total_count');
      finally
        FreeAndNil(JSONobj);
      end;
    end;
    Paginas:= (round(Paginas/20+1));

    for I := 0 to Paginas -1 do
    begin
      Resposta := IdHTTP1.get('http://api.awsli.com.br/v1/produto?limit=20&offset='+IntToStr(incremento));
      JSONobj := TJSONObject.Create(Resposta);
      try
      for x := 0 to JSONObj.getJSONArray('objects').length -1  do
        begin
          IdLi:= JSONobj.getJSONArray('objects').getJSONObject(x).getString('id');
          NomeLi:= JSONobj.getJSONArray('objects').getJSONObject(x).getString('nome');
          MemoResposta.Lines.Add(IdLi+' - ' + Nomeli);
        end;
        Incremento := Incremento+10;
      finally
      end;
    end;
  end;

  IF rdrFoto.Checked then
  IF IdHTTP1.Request.CustomHeaders.Text = '' then
  begin
    begin
      ListaCodigos := TStringList.Create;
      ListaCodigos.Delimiter := ',';
      ListaCodigos.DelimitedText := MemoCodigos.Text;
      IF IdHTTP1.Request.CustomHeaders.Text = '' then
        begin
        IdHTTP1.Request.CustomHeaders.AddValue('authorization','chave_api '+ ChaveApi + ' aplicacao '+ Aplicacao);
        resposta:= IdHTTP1.get('http://api.awsli.com.br/v1/produto');
        JSONobj := TJSONObject.create(Resposta);
        try
          Paginas :=  JSONobj.getJSONObject('meta').getInt('total_count');
        finally
          FreeAndNil(JSONobj);
        END;
      END
      ELSE
      begin
        resposta:= IdHTTP1.get('http://api.awsli.com.br/v1/produto');
        JSONobj := TJSONObject.create(Resposta);
        counter:=0;
        try
          Paginas :=  JSONobj.getJSONObject('meta').getInt('total_count');
        finally
          FreeAndNil(JSONobj);
        END;
      END;
      for I := 0 to ListaCodigos.Count -1 do
      begin
        Resposta := IdHTTP1.get('http://api.awsli.com.br/v1/produto_imagem/?produto='+ListaCodigos[i]);
        JSONobj := TJSONObject.Create(Resposta);

        try
        for x := 0 to JSONObj.getJSONArray('objects').length -1  do
          begin
            urlLi:= JSONobj.getJSONArray('objects').getJSONObject(x).getString('caminho');
            MemoResposta.Lines.Add(ListaCodigos[i]+' - ' + urlli);
            counter:=counter+1;
            IF counter > 20 then
            begin
              //MemoResposta.Lines.Add('Aguarde 10 Segundos');
              sleep(40000);
              counter:=0;
            END;
          END;
          finally
          //FreeAndNil(JSONobj);
        END;
      END;
      IdHTTP1.Request.CustomHeaders.Text := '';
    END;
  END;
END;

{$ENDREGION}

{$REGION 'SKYHUB'}

procedure TForm1.Button3Click(Sender: TObject);
var
resposta, IDSKU:string ;
begin
  resposta:=IdHTTP1.get('https://api.skyhub.com.br/products/'+IDSKU);
  IdHTTP1.Request.CustomHeaders.AddValue('X-User-Email:', edtChaveApi.Text);
  IdHTTP1.Request.CustomHeaders.AddValue( 'X-Api-Key:', edtAplicacao.Text);
end;





{$ENDREGION}

{$REGION 'OLIST'}

procedure TForm1.NetHTTPClient1AuthEvent(const Sender: TObject;
  AnAuthTarget: TAuthTargetType; const ARealm, AURL: string; var AUserName,
  APassword: string; var AbortAuth: Boolean;
  var Persistence: TAuthPersistenceType);
begin
   if AnAuthTarget = TAuthTargetType.Server then
  begin
    AUserName := edtUser.Text;
    APassword := edtSenha.Text;
  end;
end;

procedure TForm1.btnSaveClick(Sender: TObject);

begin
  if not TDirectory.Exists('C:\RequestMaker3000') then
    TDirectory.CreateDirectory('C:\RequestMaker3000');
    Arquivo.SaveToFile('C:\RequestMaker3000\Export.csv');
end;

procedure TForm1.btnOlistBuscarClick(Sender: TObject);

  var headers, CustomHeaders, resposta, Auth, host, Dados, produto_nome, produto_group, produto_ean, count:string;
  Obj: TJSONObject;
  x,y,z:Integer;
  Response:iHTTPResponse;

begin
  gdProduto.ColWidths[0]:= 500;
  Auth:='JWT '+edtOlistAuth.Text;
  NetHTTPClient1.CustomHeaders['Authorization']:=Auth;
  host:='http://partners-api.olist.com/v1/seller-products/';
  Arquivo.Clear;
  y:=0;
  repeat
    Response:=NetHTTPClient1.Get(host);
    Resposta:=Response.ContentAsString;
    Obj:=TJSONObject.create(Resposta);
    count:=obj.getString('count');
    gdProduto.RowCount:=count.ToInteger;
    try
      if Obj.has('results') then
      begin
        for x := 0 to Obj.getJSONArray('results').length - 1 do
        begin
          produto_nome:=Obj.getJSONArray('results').getJSONObject(x).getString('name');
          produto_group:=Obj.getJSONArray('results').getJSONObject(x).getString('group');;
          produto_ean:=Obj.getJSONArray('results').getJSONObject(x).getString('gtin');;
          Dados := produto_nome+' | '+produto_ean+' | '+produto_group;
          gdProduto.Cells[0, y]:=produto_nome;
          gdProduto.Cells[1, y]:=produto_group;
          gdProduto.Cells[2, y]:=produto_ean;
          y:=y+1;
          Arquivo.add(Dados);

        end;
        end;
      if Obj.has('next') then
      begin
        host:=Obj.getString('next');
      end else
      begin
        host:='null';
      end;
    finally
      FreeAndNil(Obj);
    end;
  until (host = 'null') or (host = '');
end;

procedure TForm1.ExecutarClick(Sender: TObject);
var
  host,Auth2,resposta:String;
  Obj: TJSONObject;
  Response:iHTTPResponse;
  Body:TJSONObject;
  i:integer;
  PRD:TStringList;
  SS:TStringStream;
begin
  Body:=TJSONObject.create;
  PRD:=TStringList.Create;
  try
    PRD.Assign(memImport.lines);
    Body.put('integracaoId',edtIntegrationID.text);
    Body.put('codigosExternos',TJSONArray.create);
    host:='https://web.alternativa.net.br/api/catalogo/anuncio/import';
    for I := 0 to PRD.Count-1 do
    begin
      Body.getJSONArray('codigosExternos').put(i,PRD[i]);
    end;
    SS:=TStringStream.Create(Body.toString);
    NetHTTPClient1.ContentType:='application/json';
    Response:=NetHTTPClient1.Patch(host,SS);
    if response.StatusCode = 200 then
    begin
      lblStatus.Caption:='Status:' +response.StatusCode.ToString+'- Ok';
    end
    else
    lblStatus.Caption:='Status:' +response.StatusCode.ToString;
  finally
    FreeAndNil(Body);
    FreeAndNil(PRD);
  end;
end;

procedure TForm1.btnLimparClick(Sender: TObject);
var
  clear: Integer;
  host,Auth,count,resposta:string;
  obj:TJSONObject;
  response:IHTTPResponse;
begin
  Auth:='JWT '+edtOlistAuth.Text;
  NetHTTPClient1.CustomHeaders['Authorization']:=Auth;
  host:='http://partners-api.olist.com/v1/seller-products/';
  Response:=NetHTTPClient1.Get(host);
  Resposta:=Response.ContentAsString;
  Obj:=TJSONObject.create(Resposta);
  count:=obj.getString('count');
  for clear := 0 to gdPRODUTO.ColCount - 1 do
    gdProduto.Cols[clear].Clear;
    gdProduto.RowCount:=count.ToInteger;

end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin
  gdStatus.Cells[0,0]:='1';
  gdStatus.Cells[0,1]:='2';
  gdStatus.Cells[0,2]:='3';
  gdStatus.Cells[0,3]:='4';
  gdStatus.Cells[0,4]:='5';
  gdStatus.Cells[0,5]:='6';
  gdStatus.Cells[0,6]:='7';
  gdStatus.Cells[0,7]:='8';
  gdStatus.Cells[0,8]:='9';
  gdStatus.Cells[0,9]:='10';
  gdStatus.Cells[0,10]:='11';
  gdStatus.Cells[0,11]:='12';
  gdStatus.Cells[0,12]:='13';
  gdStatus.Cells[0,13]:='14';
  gdStatus.Cells[0,14]:='15';
  gdStatus.Cells[0,15]:='16';
  gdStatus.Cells[0,16]:='17';
  gdStatus.Cells[0,17]:='18';
  gdStatus.Cells[0,18]:='19';
  gdStatus.Cells[0,19]:='20';
  gdStatus.Cells[0,20]:='21';
  gdStatus.Cells[0,21]:='22';
  gdStatus.Cells[0,22]:='23';
  gdStatus.Cells[1,0]:='Aguardando captura';
  gdStatus.Cells[1,1]:='Aguardando verificacao';
  gdStatus.Cells[1,2]:='Aguardando pagamento';
  gdStatus.Cells[1,3]:='Pagamento nao selecionado';
  gdStatus.Cells[1,4]:='Transacao nao finalizada';
  gdStatus.Cells[1,5]:='Financiamento nao finalizado';
  gdStatus.Cells[1,6]:='Boleto nao gerado';
  gdStatus.Cells[1,7]:='Transferencia nao concluida';
  gdStatus.Cells[1,8]:='Cancelado pelo cliente';
  gdStatus.Cells[1,9]:='Cancelado pela loja';
  gdStatus.Cells[1,10]:='A enviar';
  gdStatus.Cells[1,11]:='Enviado';
  gdStatus.Cells[1,12]:='Finalizado';
  gdStatus.Cells[1,13]:='Nota Fiscal Emitida';
  gdStatus.Cells[1,14]:='Em compra';
  gdStatus.Cells[1,15]:='Aguardando estoque';
  gdStatus.Cells[1,16]:='Estornado';
  gdStatus.Cells[1,17]:='Central de Trocas';
  gdStatus.Cells[1,18]:='Em Conflito/Disputa';
  gdStatus.Cells[1,19]:='Retornado';
  gdStatus.Cells[1,20]:='Aguardando dados de entrega';
  gdStatus.Cells[1,21]:='Congelado';
  gdStatus.Cells[1,22]:='Em analise';
end;



{$ENDREGION}


END.


