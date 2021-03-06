unit DTImendes;

interface

uses
  System.SysUtils, System.Classes,REST.Types, REST.Client,
  REST.Response.Adapter, System.Generics.Collections;

type TAmbiente = (Homologacao,Producao);
type TRegime = (SimplesNacional,LucroPresumidoReal);

type Tretorno = record
  StatusCode:integer;
  Mensagem:string;
end;

type TRetornoTributos=class
  StatusCode:integer;
  Mensagem:String;
  Codigo:string;
  Descricao:string;
  Ncm:string;
  Cest:string;
  CodAnp:string;
  CstPisCofins:string;
  AliqPis:Extended;
  AliqCofins:Extended;
  CodEFD:string;
  CstIPI:string;
  AliqIPI:Extended;
  Cst:string;
  AliqICMS:Extended;
  Fcp:Extended;
  CFOPVenda:string;
  CFOPCompra:string;
end;

type TRetornoConsulta = class
  ProdutosPendentes_Interno:integer;
  ProdutosPendentes_EAN:integer;
  ProdutosPendentes_Devolvidos:integer;
  ProdutosPendentes_DataInicio:TDate;
  ProdutosPendentes_DataUltConsumo:TDate;

  Requisicoes:Integer;
  Enviados:Integer;
  Retornados:integer;
end;

type TRetornoProdDevovido = class
  Dev_ID:string;
  Dev_Codigo:string;
  Dev_Descricao:string;
  Dev_dtinclusao:TDate;
  Dev_dtdevolucao:tdate;
  Dev_motivo:string;
end;

type TRetornoAlterados = class
    Retornados:integer;
    Codigo:string;
    dtultcons:TDate;
    dtrev:TDate;
end;

type TRetornaProdutos = class
    ProdutosRetornados:Integer;
    id:string;
    descricao:string;
    Ean:string;
end;

const
 Url_Consulta      = 'http://consultatributos.com.br:8080/api/v1/public/RegrasFiscais';
 Url_Stratus       = 'http://consultatributos.com.br:8080/api/v1/public/GetStatusCliente/{cnpj}';
 Url_ConsultaDados = 'http://consultatributos.com.br:8080/api/v1/public/EnviaRecebeDados';

type
  TDTImendes = class(TComponent)
  private
    FCNAE: string;
    FCNPJ: string;
    FUF: string;
    FSenha: string;
    FAmbiente: TAmbiente;
    FLogin: string;
    FRegime: TRegime;
    FCodFaixa: string;
    FCRT: string;
    FCaminhoLog: string;
    FGravaLog: Boolean;
    procedure setCNAE(const Value: string);
    procedure setCNPJ(const Value: string);
    procedure setUF(const Value: string);
    procedure setAmbiente(const Value: TAmbiente);
    procedure setLogin(const Value: string);
    procedure setSenha(const Value: string);
    procedure setRegime(const Value: TRegime);
    procedure setCodfaixa(const Value: string);
    procedure setCRT(const Value: string);
    procedure setCaminhoLog(const Value: string);
    procedure Log(Mensagem:string);
    procedure setGravaLog(const Value: Boolean);
  protected

  public
    Retorno:Tretorno;
    RetornoTributos:TList<TRetornoTributos>;
    RetornoConsulta:TList<TRetornoConsulta>;
    RetornoProdDevolvido:TList<TRetornoProdDevovido>;
    RetornaAlterados:TList<TRetornoAlterados>;
    RetornaProdutos:TList<TRetornaProdutos>;
    function ConsultaStatusCliente:Tretorno;
    function ConsultaTributos(Codigo:string; Descricao:string):TRetornoTributos;
    function ConsultaTributosEmLote(CodigoDescricao:Tstringlist):TRetornoTributos;
    function ConsultaHistoricodeAcessos:TRetornoConsulta;
    function RemoveDevolvidos(IdsDosProdutos:TStringList):Tretorno;
    function AlteraDados:TRetornoAlterados;
    function ListaProdutos(Descricao:string):TRetornaProdutos;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property CNPJ:string read FCNPJ write setCNPJ;
    property CNAE:string read FCNAE write setCNAE;
    property UF:string read FUF write setUF;
    property Login:string read FLogin write setLogin;
    property Senha:string read FSenha write setSenha;
    property Ambiente:TAmbiente read FAmbiente write setAmbiente;
    property RegimeTributario:TRegime read FRegime write setRegime;
    property CRT:string read FCRT write setCRT;
    property CodFaixa:string read FCodFaixa write setCodfaixa;
    property GravaLog:Boolean read FGravaLog write setGravaLog;
    property CaminhoLog:string read FCaminhoLog write setCaminhoLog;
  end;

procedure Register;

implementation

uses
  System.JSON;

procedure Register;
begin
  RegisterComponents('DT Inovacao', [TDTImendes]);
end;

{ TDTImendes }

{ TDTImendes }

function TDTImendes.AlteraDados: TRetornoAlterados;
var
  Request: TRESTRequest;
  RestClient: TRESTClient;
  RestAdapter:TRESTResponseDataSetAdapter;
  RestResponse1:TRESTResponse;
  vBody:string;
  ret:TRetornoAlterados;
  retProd:TRetornoProdDevovido;
  Json,Resumo,DetalheObj,ProdDevolvidoOBJ:TJSONObject;
  Detalhes,ProdDevolvido:TJSONArray;
  I:Integer;
  vData:string;
begin
   vBody :=
   '{' +
   '  "nomeServico": "ALTERADOS",' +
   '  "dados": "' + FCNPJ + '|' + FUF + '|"' +
   '}';
    try
       Request                := TRESTRequest.Create(nil);
       RestResponse1          := TRESTResponse.Create(nil);
       RestClient             := TRESTClient.Create(Request);
       Request.Client         := RestClient;
       Request.Method         := TRESTRequestMethod.rmPOST;
       Request.Client.BaseURL := Url_ConsultaDados;
       Request.Timeout        := 180000;
       RestAdapter            := TRESTResponseDataSetAdapter.Create(nil);
       Request.Response       := RestResponse1;
       RestAdapter.Response   := RestResponse1;

       With Request.Params do
       Begin
          Clear;
          AddHeader('login',FLogin);
          AddHeader('senha',FSenha);
          AddBody(vBody, TRESTContentType.ctAPPLICATION_JSON);
       End;
       Try
          Request.Execute;
       Except
          on E: Exception do
          Begin
             Log(e.Message);
             Log('JsonContent: ' + Request.Response.Content);
             raise Exception.Create(e.Message);
             Exit;
          End;
       End;
       Request.Response.ContentType := 'application/json';

       if Assigned(RetornaAlterados) then
       FreeAndNil(RetornaAlterados);

       RetornaAlterados      := TList<TRetornoAlterados>.Create;

       if Request.Response.StatusCode = 200 then
       begin
             Retorno.StatusCode :=  Request.Response.StatusCode;
             Retorno.Mensagem   :=  Request.Response.JSONText;

             Json          := TJSONObject.ParseJSONValue(Request.Response.Content) as TJSONObject;

             Resumo        := Json.GetValue<TJSONObject>('cabecalho') as TJSONObject;
             Detalhes      := Json.GetValue<TJSONArray>('produto') as TJSONArray;

             for I := 0 to Pred(Detalhes.Count) do
             begin
                    DetalheObj := Detalhes.Items[I] as TJsonObject;

                    ret := TRetornoAlterados.Create;
                    ret.Retornados := StrToInt( Resumo.Values['produtosRetornados'].Value );
                    vdata          := Copy( DetalheObj.Values['dtultcons'].Value,9,2) + '/' + Copy( DetalheObj.Values['dtultcons'].Value,6,2) + '/' + Copy( DetalheObj.Values['dtultcons'].Value,1,4);
                    ret.dtultcons  := StrToDate(vdata);
                    vdata          := Copy( DetalheObj.Values['dtrev'].Value,9,2) + '/' + Copy( DetalheObj.Values['dtrev'].Value,6,2) + '/' + Copy( DetalheObj.Values['dtrev'].Value,1,4);
                    ret.dtrev      := StrToDate(vdata);
                    ret.Codigo     := DetalheObj.Values['codigo'].Value;

                    RetornaAlterados.Add(ret);
             end;
       end else
       begin
            Retorno.StatusCode :=  Request.Response.StatusCode;
            Retorno.Mensagem   :=  Request.Response.JSONText;
       end;
    finally
          Freeandnil(RestClient);
          Freeandnil(Request);
    End;
end;

function TDTImendes.ConsultaHistoricodeAcessos: TRetornoConsulta;
var
  Request: TRESTRequest;
  RestClient: TRESTClient;
  RestAdapter:TRESTResponseDataSetAdapter;
  RestResponse1:TRESTResponse;
  vBody:string;
  ret:TRetornoConsulta;
  retProd:TRetornoProdDevovido;
  Json,Resumo,DetalheObj,ProdDevolvidoOBJ:TJSONObject;
  Detalhes,ProdDevolvido:TJSONArray;
  I:Integer;
  vData:string;
begin
   vBody :=
   '{' +
   '  "nomeServico": "HISTORICOACESSO",' +
   '  "dados": "' + FCNPJ + '"' +
   '}';
    try
       Request                := TRESTRequest.Create(nil);
       RestResponse1          := TRESTResponse.Create(nil);
       RestClient             := TRESTClient.Create(Request);
       Request.Client         := RestClient;
       Request.Method         := TRESTRequestMethod.rmPOST;
       Request.Client.BaseURL := Url_ConsultaDados;
       Request.Timeout        := 180000;
       RestAdapter            := TRESTResponseDataSetAdapter.Create(nil);
       Request.Response       := RestResponse1;
       RestAdapter.Response   := RestResponse1;

       With Request.Params do
       Begin
          Clear;
          AddHeader('login',FLogin);
          AddHeader('senha',FSenha);
          AddBody(vBody, TRESTContentType.ctAPPLICATION_JSON);
       End;
       Try
          Request.Execute;
       Except
          on E: Exception do
          Begin
             Log(e.Message);
             Log('JsonContent: ' + Request.Response.Content);
             raise Exception.Create(e.Message);
             Exit;
          End;
       End;
       Request.Response.ContentType := 'application/json';

       if Assigned(RetornoConsulta) then
       FreeAndNil(RetornoConsulta);

       if Assigned(RetornoProdDevolvido) then
       FreeAndNil(RetornoProdDevolvido);

       RetornoConsulta      := TList<TRetornoConsulta>.Create;
       RetornoProdDevolvido := TList<TRetornoProdDevovido>.Create;

       //RetornoConsulta := TList<TRetornoConsulta>.Create;
       if Request.Response.StatusCode = 200 then
       begin
             ret := TRetornoConsulta.Create;
             Retorno.StatusCode :=  Request.Response.StatusCode;
             Retorno.Mensagem   :=  Request.Response.JSONText;

             Json          := TJSONObject.ParseJSONValue(Request.Response.Content) as TJSONObject;

             Resumo        := Json.GetValue<TJSONObject>('resumo') as TJSONObject;
             Detalhes      := Json.GetValue<TJSONArray>('detalhes') as TJSONArray;
             ProdDevolvido := Json.GetValue<TJSONArray>('prodDevolvidos') as TJSONArray;

             ret.ProdutosPendentes_Interno    := StrToInt( Resumo.Values['produtosPendentes_Interno'].Value );
             ret.ProdutosPendentes_EAN        := StrToInt( Resumo.Values['produtosPendentes_EAN'].Value );
             ret.ProdutosPendentes_Devolvidos := StrToInt( Resumo.Values['produtosPendentes_Devolvidos'].Value );
             vdata                            := Copy( Resumo.Values['dataPrimeiroConsumo'].Value,9,2) + '/' + Copy( Resumo.Values['dataPrimeiroConsumo'].Value,6,2) + '/' + Copy( Resumo.Values['dataPrimeiroConsumo'].Value,1,4);
             ret.ProdutosPendentes_DataInicio := StrTodate(vdata );
             vdata                            := Copy( Resumo.Values['dataUltimoConsumo'].Value,9,2) + '/' + Copy( Resumo.Values['dataUltimoConsumo'].Value,6,2) + '/' + Copy( Resumo.Values['dataUltimoConsumo'].Value,1,4);
             ret.ProdutosPendentes_DataUltConsumo := StrTodate(vdata );

             for I := 0 to Pred(Detalhes.Count) do
             begin
                    DetalheObj := Detalhes.Items[I] as TJsonObject;

                    ret.Requisicoes := StrToInt( DetalheObj.Values['requisicoes'].Value );
                    ret.Enviados    := StrToInt( DetalheObj.Values['enviados'].Value );
                    ret.Retornados  := StrToInt( DetalheObj.Values['retornados'].Value );
             end;

             RetornoConsulta.Add(ret);

             for I := 0 to Pred(ProdDevolvido.Count) do
             begin
                    ProdDevolvidoOBJ := ProdDevolvido.Items[I] as TJsonObject;
                    retProd := TRetornoProdDevovido.Create;

                    retProd.Dev_ID          := ProdDevolvidoOBJ.Values['id'].Value;
                    retProd.Dev_Codigo      := ProdDevolvidoOBJ.Values['codigo'].Value;
                    retProd.Dev_Descricao   := ProdDevolvidoOBJ.Values['descricao'].Value;
                    vdata               := Copy( ProdDevolvidoOBJ.Values['dtinclusao'].Value,9,2) + '/' + Copy( ProdDevolvidoOBJ.Values['dtinclusao'].Value,6,2) + '/' + Copy( ProdDevolvidoOBJ.Values['dtinclusao'].Value,1,4);
                    retProd.Dev_dtinclusao  := StrToDate(vdata);
                    vdata               := Copy( ProdDevolvidoOBJ.Values['dtdevolucao'].Value,9,2) + '/' + Copy( ProdDevolvidoOBJ.Values['dtdevolucao'].Value,6,2) + '/' + Copy( ProdDevolvidoOBJ.Values['dtdevolucao'].Value,1,4);
                    retProd.Dev_dtdevolucao := StrToDate(vdata);
                    retProd.Dev_motivo      := ProdDevolvidoOBJ.Values['motivodevolucao'].Value;

                    RetornoProdDevolvido.Add(retProd);
             end;
       end else
       begin
            Retorno.StatusCode :=  Request.Response.StatusCode;
            Retorno.Mensagem   :=  Request.Response.JSONText;
       end;
    finally
          Freeandnil(RestClient);
          Freeandnil(Request);
    End;
end;

function TDTImendes.ConsultaStatusCliente: Tretorno;
var
  Request: TRESTRequest;
  RestClient: TRESTClient;
  RestAdapter:TRESTResponseDataSetAdapter;
  RestResponse1:TRESTResponse;
begin
    try
       Request                := TRESTRequest.Create(nil);
       RestResponse1          := TRESTResponse.Create(nil);
       RestClient             := TRESTClient.Create(Request);
       Request.Client         := RestClient;
       Request.Method         := TRESTRequestMethod.rmGET;
       Request.Client.BaseURL := Url_Stratus;
       Request.Timeout        := 180000;
       RestAdapter            := TRESTResponseDataSetAdapter.Create(nil);
       Request.Response       := RestResponse1;
       RestAdapter.Response   := RestResponse1;

       With Request.Params do
       Begin
          Clear;
          AddHeader('login',FLogin);
          AddHeader('senha',FSenha);
          AddUrlSegment('cnpj',FCNPJ);
       End;
       Try
          Request.Execute;
       Except
          on E: Exception do
          Begin
             Log(e.Message);
             Log('JsonContent: ' + Request.Response.Content);
             raise Exception.Create(e.Message);
             Exit;
          End;
       End;
       Request.Response.ContentType := 'application/json';

       if Request.Response.StatusCode = 200 then
       begin
          Retorno.StatusCode :=  Request.Response.StatusCode;
          Retorno.Mensagem   :=  Request.Response.JSONText;
       end else
       begin
          Retorno.StatusCode :=  Request.Response.StatusCode;
          Retorno.Mensagem   :=  Request.Response.JSONText;
       end;
    finally
          Freeandnil(RestClient);
          Freeandnil(Request);
    End;
end;

function TDTImendes.ConsultaTributos(Codigo,
  Descricao: string): TRetornoTributos;
var
  Request: TRESTRequest;
  RestClient: TRESTClient;
  RestAdapter:TRESTResponseDataSetAdapter;
  RestResponse1:TRESTResponse;
  vBody:string;
  ret:TRetornoTributos;
  Produto,PisCofins,IPI:TJSONObject;
  Grupo,Item,Regra:TJSONArray;
  ItemObj,RegraObj:TJSONObject;
  I,X:integer;
begin
   if FAmbiente = Homologacao then
   begin
         vBody :=
            ' { ' +
            ' "cabecalho": { ' +
            ' "cnpj": "'+ FCNPJ + '", ' +
            ' "cnae": "'+ FCNAE + '", ' +
            ' "crt": '+ FCRT +', ' +
            // ' "regimeEspecial": "SP62647", ' +
            ' "codFaixa": "'+ FCodFaixa +'", ' +
            ' "regimeTrib": "R", ' +
            ' "contribuinte": 0, ' +
            ' "amb": 1 ' +
            ' }, ' +
            ' "uf": ["'+ FUF +'"], ' +
            ' "produto": [{ ' +
            ' "codigo": "'+ Codigo +'", ' +
            ' "descricao": "'+ Descricao +'" ' +
            ' }' +
            ' ] ' +
            ' } ';
   end else begin
          vBody :=
            ' { ' +
            ' "cabecalho": { ' +
            ' "cnpj": "'+ FCNPJ + '", ' +
            ' "cnae": "'+ FCNAE + '", ' +
            ' "crt": '+ FCRT +', ' +
            // ' "regimeEspecial": "SP62647", ' +
            ' "codFaixa": "'+ FCodFaixa +'", ' +
            ' "regimeTrib": "R", ' +
            ' "contribuinte": 0, ' +
            ' "amb": 2 ' +
            ' }, ' +
            ' "uf": ["'+ FUF +'"], ' +
            ' "produto": [{ ' +
            ' "codigo": "'+ Codigo +'", ' +
            ' "descricao": "'+ Descricao +'" ' +
            ' }' +
            ' ] ' +
            ' } ';         
   end;

    try
       Request                := TRESTRequest.Create(nil);
       RestResponse1          := TRESTResponse.Create(nil);
       RestClient             := TRESTClient.Create(Request);
       Request.Client         := RestClient;
       Request.Method         := TRESTRequestMethod.rmPOST;
       Request.Client.BaseURL := Url_Consulta;
       Request.Timeout        := 180000;
       RestAdapter            := TRESTResponseDataSetAdapter.Create(nil);
       Request.Response       := RestResponse1;
       RestAdapter.Response   := RestResponse1;

       With Request.Params do
       Begin
          Clear;
          AddHeader('login',FLogin);
          AddHeader('senha',FSenha);

          AddBody(vBody, TRESTContentType.ctAPPLICATION_JSON);
       End;
       Try
          Request.Execute;
       Except
          on E: Exception do
          Begin
             Log(e.Message);
             Log('JsonContent: ' + Request.Response.Content);
             raise Exception.Create(e.Message);
             Exit;
          End;
       End;
       Request.Response.ContentType := 'application/json';

       if Assigned(RetornoTributos) then
         FreeAndNil(RetornoTributos);

       RetornoTributos := TList<TRetornoTributos>.Create;

       if Request.Response.StatusCode = 200 then
       begin
             Produto   := TJSONObject.ParseJSONValue(Request.Response.Content) as TJSONObject;
             Grupo     := Produto.GetValue<TJSONArray>('grupo') as TJSONArray;
             for I := 0 to pred(Grupo.Count) do
              begin
                   Produto   := Grupo.Items[I] as TJsonObject;

                   PisCofins := Produto.GetValue<TJSONObject>('piscofins') as TJSONObject;
                   IPI       := Produto.GetValue<TJSONObject>('ipi') as TJSONObject;
                   Regra     := Produto.GetValue<TJSONArray>('regra') as TJSONArray;
                   Item      := Produto.GetValue<TJSONArray>('produto') as TJSONArray;
                   for x := 0 to pred(Item.Count) do
                   begin
                         RegraObj         := Regra.Items[0] as TJSONObject;
                         ret              := TRetornoTributos.Create;

                         ret.StatusCode   := Request.Response.StatusCode;
                         ret.Mensagem     := Request.Response.Content;  
                         ret.Codigo       := Item.get(x).Value;
                         ret.Ncm          := Produto.Values['ncm'].Value.Replace('.','');
                         ret.Cest         := Produto.Values['cest'].Value.Replace('.','');
                         ret.Descricao    := Descricao;

                         if FRegime =  SimplesNacional then
                         begin
                             if PisCofins.Values['cstSai'].Value = '01' then
                             begin
                                 ret.CstPisCofins := '49';
                             end else if PisCofins.Values['cstSai'].Value = '06' then
                             begin
                                 ret.CstPisCofins := '49';
                             end else begin
                                 ret.CstPisCofins := PisCofins.Values['cstSai'].Value;
                             end;
                         end else begin
                             ret.CstPisCofins := PisCofins.Values['cstSai'].Value;
                         end;

                         ret.AliqPis      := StrToFloat(PisCofins.Values['aliqPIS'].Value);
                         ret.AliqCofins   := StrToFloat(PisCofins.Values['aliqCOFINS'].Value);
                         ret.CodEFD       := PisCofins.Values['nri'].Value;
                         ret.CstIPI       := IPI.Values['cstSai'].Value;
                         ret.AliqIPI      := StrToFloat(IPI.Values['aliqIPI'].Value);
                         ret.Cst          := RegraObj.Values['cst'].Value;
                         ret.AliqICMS     := StrToFloat(RegraObj.Values['aliqicms'].Value);
                         ret.Fcp          := StrToFloat(RegraObj.Values['fcp'].Value);
                         ret.CFOPVenda    := RegraObj.Values['cfopVenda'].Value;
                         ret.CFOPCompra   := RegraObj.Values['cfopCompra'].Value;

                         RetornoTributos.Add(ret);
                   end;
              end;
       end else
       begin

       end;
    finally
          Freeandnil(RestClient);
          Freeandnil(Request);
    End;
end;

function TDTImendes.ConsultaTributosEmLote(
  CodigoDescricao: Tstringlist): TRetornoTributos;
var
  Request: TRESTRequest;
  RestClient: TRESTClient;
  RestAdapter:TRESTResponseDataSetAdapter;
  RestResponse1:TRESTResponse;
  vBody:string;
  ret:TRetornoTributos;
  Produto,PisCofins,IPI:TJSONObject;
  Grupo,Item,Regra:TJSONArray;
  ItemObj,RegraObj:TJSONObject;
  I,X:integer;
  vConst1,vConst2,vConst3:string;
  Quebra:TStringList;
begin
  if FAmbiente = Homologacao then
  begin
  vConst1 :=  ' { ' +
              ' "cabecalho": { ' +
              ' "cnpj": "'+ FCNPJ + '", ' +
              ' "cnae": "'+ FCNAE + '", ' +
              ' "crt": ' + FCRT + ', ' +
             // ' "regimeEspecial": "SP62647", ' +
              ' "codFaixa": "'+ FCodFaixa +'", ' +
              ' "regimeTrib": "R", ' +
              ' "contribuinte": 0, ' +
              ' "amb": 1 ' +
              ' }, ' +
              ' "uf": ["'+ FUF +'"], ';   
  end else begin
  vConst1 :=  ' { ' +
              ' "cabecalho": { ' +
              ' "cnpj": "'+ FCNPJ + '", ' +
              ' "cnae": "'+ FCNAE + '", ' +
              ' "crt": ' + FCRT + ', ' +
             // ' "regimeEspecial": "SP62647", ' +
              ' "codFaixa": "'+ FCodFaixa +'", ' +
              ' "regimeTrib": "R", ' +
              ' "contribuinte": 0, ' +
              ' "amb": 2 ' +
              ' }, ' +
              ' "uf": ["'+ FUF +'"], ';                
  end;

  for I := 0 to Pred(CodigoDescricao.Count) do
    begin        
           Quebra := TStringList.Create;
           ExtractStrings(['|'],[ ],Pchar(CodigoDescricao[i]),Quebra);
           if i=0 then
           begin
                 vConst2 := ' "produto": [{ ' +
                            ' "codigo": "' + Quebra[0] + '", ' +
                            ' "descricao": "' + Quebra[1] +'" ' +
                            //' "tipocodigo": "' + '1' +'" ' +
                            ' }';
           end else begin
                 vConst2 := vConst2 + ' ,{ ' +
                            ' "codigo": "' + Quebra[0] + '", ' +
                            ' "descricao": "' + Quebra[1] +'" ' +
                            ' }';
           end; 
           Quebra.Free; 
    end;                                 

   vConst3 :=  '] } ';   
   vBody   :=  vConst1 + vConst2 + vConst3;

    try
       Request                := TRESTRequest.Create(nil);
       RestResponse1          := TRESTResponse.Create(nil);
       RestClient             := TRESTClient.Create(Request);
       Request.Client         := RestClient;
       Request.Method         := TRESTRequestMethod.rmPOST;
       Request.Client.BaseURL := Url_Consulta;
       Request.Timeout        := 180000;
       RestAdapter            := TRESTResponseDataSetAdapter.Create(nil);
       Request.Response       := RestResponse1;
       RestAdapter.Response   := RestResponse1;

       With Request.Params do
       Begin
          Clear;
          AddHeader('login',FLogin);
          AddHeader('senha',FSenha);

          AddBody(vBody, TRESTContentType.ctAPPLICATION_JSON);
       End;
       Try
          Request.Execute;
       Except
          on E: Exception do
          Begin
             Log(e.Message);
             Log('JsonContent: ' + Request.Response.Content);
             raise Exception.Create(e.Message);
             Exit;
          End;
       End;
       Request.Response.ContentType := 'application/json';

       if Assigned(RetornoTributos) then
          FreeAndNil(RetornoTributos);

       RetornoTributos := TList<TRetornoTributos>.Create;

       if Request.Response.StatusCode = 200 then
       begin
             Produto   := TJSONObject.ParseJSONValue(Request.Response.Content) as TJSONObject;
             Grupo     := Produto.GetValue<TJSONArray>('grupo') as TJSONArray;
             for I := 0 to pred(Grupo.Count) do
              begin
                   Produto   := Grupo.Items[I] as TJsonObject;

                   PisCofins := Produto.GetValue<TJSONObject>('piscofins') as TJSONObject;
                   IPI       := Produto.GetValue<TJSONObject>('ipi') as TJSONObject;
                   Regra     := Produto.GetValue<TJSONArray>('regra') as TJSONArray;
                   Item      := Produto.GetValue<TJSONArray>('produto') as TJSONArray;
                   for x := 0 to pred(Item.Count) do
                   begin
                         RegraObj         := Regra.Items[0] as TJSONObject;
                         ret              := TRetornoTributos.Create;

                         ret.StatusCode   := Request.Response.StatusCode;
                         ret.Mensagem     := Request.Response.Content;  
                         ret.Codigo       := Item.get(x).Value;
                         ret.Ncm          := Produto.Values['ncm'].Value.Replace('.','');
                         ret.Cest         := Produto.Values['cest'].Value.Replace('.','');
                         ret.Descricao    := '';
                         ret.CstPisCofins := PisCofins.Values['cstSai'].Value;
                         ret.AliqPis      := StrToFloat(PisCofins.Values['aliqPIS'].Value);
                         ret.AliqCofins   := StrToFloat(PisCofins.Values['aliqCOFINS'].Value);
                         ret.CodEFD       := PisCofins.Values['nri'].Value;
                         ret.CstIPI       := IPI.Values['cstSai'].Value;
                         ret.AliqIPI      := StrToFloat(IPI.Values['aliqIPI'].Value);
                         ret.Cst          := RegraObj.Values['cst'].Value;
                         ret.AliqICMS     := StrToFloat(RegraObj.Values['aliqicms'].Value);
                         ret.Fcp          := StrToFloat(RegraObj.Values['fcp'].Value);
                         ret.CFOPVenda    := RegraObj.Values['cfopVenda'].Value;
                         ret.CFOPCompra   := RegraObj.Values['cfopCompra'].Value;

                         RetornoTributos.Add(ret);
                   end;
              end;
       end else
       begin
            raise Exception.Create(Request.Response.Content);
       end;
    finally
          Freeandnil(RestClient);
          Freeandnil(Request);
    End;
end;

constructor TDTImendes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  RetornoTributos := TList<TRetornoTributos>.Create;
  RetornoConsulta := TList<TRetornoConsulta>.Create;
  RetornoProdDevolvido := TList<TRetornoProdDevovido>.Create;
  RetornaAlterados := TList<TRetornoAlterados>.Create;
  RetornaProdutos := TList<TRetornaProdutos>.Create;
end;

destructor TDTImendes.Destroy;
begin
        RetornoTributos.Clear;
        RetornoConsulta.Clear;
        RetornoProdDevolvido.Clear;
        RetornaAlterados.Clear;
        RetornaProdutos.Clear;

        FreeAndNil(RetornoTributos);
        FreeAndNil(RetornoConsulta);
        FreeAndNil(RetornoProdDevolvido);
        FreeAndNil(RetornaProdutos);
        FreeAndNil(RetornaAlterados);
  inherited Destroy;
end;

function TDTImendes.ListaProdutos(Descricao: string): TRetornaProdutos;
var
  Request: TRESTRequest;
  RestClient: TRESTClient;
  RestAdapter:TRESTResponseDataSetAdapter;
  RestResponse1:TRESTResponse;
  vBody:string;
  ret:TRetornaProdutos;
  retProd:TRetornoProdDevovido;
  Json,Resumo,DetalheObj,ProdDevolvidoOBJ:TJSONObject;
  Detalhes,ProdDevolvido:TJSONArray;
  I:Integer;
  vData:string;
begin
   vBody :=
   '{' +
   '  "nomeServico": "DESCRPRODUTOS",' +
   '  "dados": "' + FCNPJ + '|' + Descricao + '|"' +
   '}';
    try
       Request                := TRESTRequest.Create(nil);
       RestResponse1          := TRESTResponse.Create(nil);
       RestClient             := TRESTClient.Create(Request);
       Request.Client         := RestClient;
       Request.Method         := TRESTRequestMethod.rmPOST;
       Request.Client.BaseURL := Url_ConsultaDados;
       Request.Timeout        := 180000;
       RestAdapter            := TRESTResponseDataSetAdapter.Create(nil);
       Request.Response       := RestResponse1;
       RestAdapter.Response   := RestResponse1;

       With Request.Params do
       Begin
          Clear;
          AddHeader('login',FLogin);
          AddHeader('senha',FSenha);
          AddBody(vBody, TRESTContentType.ctAPPLICATION_JSON);
       End;
       Try
          Request.Execute;
       Except
          on E: Exception do
          Begin
             Log(e.Message);
             Log('JsonContent: ' + Request.Response.Content);
             raise Exception.Create(e.Message);
             Exit;
          End;
       End;
       Request.Response.ContentType := 'application/json';

       if Assigned(RetornaProdutos) then
       FreeAndNil(RetornaProdutos);

       RetornaProdutos      := TList<TRetornaProdutos>.Create;

       if Request.Response.StatusCode = 200 then
       begin
             Retorno.StatusCode :=  Request.Response.StatusCode;
             Retorno.Mensagem   :=  Request.Response.JSONText;

             Json          := TJSONObject.ParseJSONValue(Request.Response.Content) as TJSONObject;

             Resumo        := Json.GetValue<TJSONObject>('cabecalho') as TJSONObject;
             Detalhes      := Json.GetValue<TJSONArray>('produto') as TJSONArray;

             for I := 0 to Pred(Detalhes.Count) do
             begin
                    DetalheObj := Detalhes.Items[I] as TJsonObject;

                    ret := TRetornaProdutos.Create;
                    ret.id                 := DetalheObj.Values['id'].Value;
                    ret.descricao          := DetalheObj.Values['descricao'].Value;
                    ret.Ean                := DetalheObj.Values['ean'].Value;
                    ret.ProdutosRetornados := StrToInt( Resumo.Values['produtosRetornados'].Value );

                    RetornaProdutos.Add(ret);
             end;
       end else
       begin
            Retorno.StatusCode :=  Request.Response.StatusCode;
            Retorno.Mensagem   :=  Request.Response.JSONText;
       end;
    finally
          Freeandnil(RestClient);
          Freeandnil(Request);
    End;

end;

procedure TDTImendes.Log(Mensagem: string);
var
  NomeArquivo: string;
  Arquivo: TextFile;
begin
    try
        try
           if GravaLog then
           begin
                if CaminhoLog<>'' then
                begin
                    if not DirectoryExists(FCaminhoLog) then
                        ForceDirectories(FCaminhoLog);
                    NomeArquivo := ChangeFileExt(FCaminhoLog, '\LogImendes_' + FormatDateTime('DD_MM_YYYY',Date)+'.log');
                    AssignFile(Arquivo, NomeArquivo);
                    if FileExists(NomeArquivo) then
                      Append(arquivo)
                    else
                      ReWrite(arquivo);
                    try
                      WriteLn(arquivo, 'Data: '+ DateTimeToStr(Now));
                      WriteLn(arquivo, 'Erro: ' + Mensagem );
                      WriteLn(arquivo, '------------------------------------------- ');
                    finally
                      CloseFile(arquivo);
                    end;
                end;
           end;
        except
        end;
    finally
    end;
end;

function TDTImendes.RemoveDevolvidos(IdsDosProdutos: TStringList): Tretorno;
var
  Request: TRESTRequest;
  RestClient: TRESTClient;
  RestAdapter:TRESTResponseDataSetAdapter;
  RestResponse1:TRESTResponse;
  vBody:string;
  ret:TRetornoTributos;
  Produto,PisCofins,IPI:TJSONObject;
  Grupo,Item,Regra:TJSONArray;
  ItemObj,RegraObj:TJSONObject;
  I,X:integer;
  vConst1,vConst2,vConst3:string;
begin
  vConst1 :=
   ' { ' +
   ' "nomeServico": "REMOVEDEVOLVIDOS", ' +
   ' "dados": "{ ' +
   ' \"cnpj\": \"'+ FCNPJ +'\", ' +
   ' \"produtos\": [ ';

   for I := 0 to Pred(IdsDosProdutos.Count) do
    begin
           if i=0 then
           begin
                 vConst2 :=  ' { \"id\": '+ IdsDosProdutos[I] +' }';
           end else begin
                 vConst2 := vConst2 + ' ,{ \"id\": '+ IdsDosProdutos[I] +' }';
           end;
    end;

   vConst3 :=
   '] }" ' +
   ' } ';

   vBody   :=  vConst1 + vConst2 + vConst3;

    try
       Request                := TRESTRequest.Create(nil);
       RestResponse1          := TRESTResponse.Create(nil);
       RestClient             := TRESTClient.Create(Request);
       Request.Client         := RestClient;
       Request.Method         := TRESTRequestMethod.rmPOST;
       Request.Client.BaseURL := Url_ConsultaDados;
       Request.Timeout        := 180000;
       RestAdapter            := TRESTResponseDataSetAdapter.Create(nil);
       Request.Response       := RestResponse1;
       RestAdapter.Response   := RestResponse1;

       With Request.Params do
       Begin
          Clear;
          AddHeader('login',FLogin);
          AddHeader('senha',FSenha);

          AddBody(vBody, TRESTContentType.ctAPPLICATION_JSON);
       End;
       Try
          Request.Execute;
       Except
          on E: Exception do
          Begin
             Log(e.Message);
             Log('JsonContent: ' + Request.Response.Content);
             raise Exception.Create(e.Message);
             Exit;
          End;
       End;
       Request.Response.ContentType := 'application/json';

       if Assigned(RetornoTributos) then
          FreeAndNil(RetornoTributos);

       RetornoTributos := TList<TRetornoTributos>.Create;

       if Request.Response.StatusCode = 200 then
       begin
            Retorno.StatusCode := Request.Response.StatusCode;
            Retorno.Mensagem   := Request.Response.Content;
       END ELSE begin
            Retorno.StatusCode := Request.Response.StatusCode;
            Retorno.Mensagem   := Request.Response.Content;
       end;
    finally
          Freeandnil(RestClient);
          Freeandnil(Request);
    End;

end;

procedure TDTImendes.setAmbiente(const Value: TAmbiente);
begin
  FAmbiente := Value;
end;

procedure TDTImendes.setCaminhoLog(const Value: string);
begin
  FCaminhoLog := Value;
end;

procedure TDTImendes.setCNAE(const Value: string);
begin
  FCNAE := Value;
end;

procedure TDTImendes.setCNPJ(const Value: string);
begin
  FCNPJ := Value;
end;

procedure TDTImendes.setCodfaixa(const Value: string);
begin
  FCodFaixa := Value;
end;

procedure TDTImendes.setCRT(const Value: string);
begin
 FCRT := Value;
end;

procedure TDTImendes.setGravaLog(const Value: Boolean);
begin
  FGravaLog := Value;
end;

procedure TDTImendes.setLogin(const Value: string);
begin
  FLogin := Value;
end;

procedure TDTImendes.setRegime(const Value: TRegime);
begin
  FRegime := Value;
end;

procedure TDTImendes.setSenha(const Value: string);
begin
  FSenha := Value;
end;

procedure TDTImendes.setUF(const Value: string);
begin
  FUF := Value;
end;

end.
