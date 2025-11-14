unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DTImendes,
  Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm4 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    Panel15: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    edtLogin: TEdit;
    edtSenha: TEdit;
    edtCNPJ: TEdit;
    edtCnae: TEdit;
    edtUF: TEdit;
    Button8: TButton;
    edtCRT: TEdit;
    edtCodFaixa: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Panel1: TPanel;
    Memo1: TMemo;
    Panel3: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    edtCodigo: TEdit;
    edtDescricao: TEdit;
    Button1: TButton;
    Panel2: TPanel;
    Memo2: TMemo;
    Panel4: TPanel;
    Button3: TButton;
    Panel5: TPanel;
    Memo3: TMemo;
    Panel6: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtCodigoLote1: TEdit;
    edtDescricaoLote1: TEdit;
    edtCodigoLote2: TEdit;
    edtDescricaoLote2: TEdit;
    Button2: TButton;
    Panel7: TPanel;
    Memo4: TMemo;
    Panel8: TPanel;
    Button4: TButton;
    Panel9: TPanel;
    Memo5: TMemo;
    Panel10: TPanel;
    Label12: TLabel;
    edtIDRemover: TEdit;
    Button5: TButton;
    Panel11: TPanel;
    Memo6: TMemo;
    Panel12: TPanel;
    Button6: TButton;
    Label13: TLabel;
    edtBuscaProduto: TEdit;
    Button7: TButton;
    Panel13: TPanel;
    Memo7: TMemo;
    Panel14: TPanel;
    Memo8: TMemo;
    DTImendes1: TDTImendes;
    procedure Button1Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ConfigComponente;
    procedure AdicionaLinha(Memo: TMemo; const Texto: string);
    procedure AdicionaSeparador(Memo: TMemo);
    procedure AdicionaTitulo(Memo: TMemo; const Titulo: string);
  public
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.FormCreate(Sender: TObject);
begin
  edtCNPJ.Text := '';
  edtCnae.Text := '';
  edtUF.Text := 'MG';
  edtLogin.Text := '';
  edtSenha.Text := '';
  edtCRT.Text := '1';
  edtCodFaixa.Text := '102';
  ComboBox1.ItemIndex := 0;
  ComboBox2.ItemIndex := 1;
  edtCodigo.Text := '7894900019155';
  edtDescricao.Text := 'COCA COLA';
  edtCodigoLote1.Text := '7894900019155';
  edtDescricaoLote1.Text := 'COCA COLA';
  edtCodigoLote2.Text := '7894900911510';
  edtDescricaoLote2.Text := 'KUAT';
  
  Memo1.Color := $00414141;
  Memo1.Font.Color := clWhite;
  Memo2.Color := $00414141;
  Memo2.Font.Color := clWhite;
  Memo3.Color := $00414141;
  Memo3.Font.Color := clWhite;
  Memo4.Color := $00414141;
  Memo4.Font.Color := clWhite;
  Memo5.Color := $00414141;
  Memo5.Font.Color := clWhite;
  Memo6.Color := $00414141;
  Memo6.Font.Color := clWhite;
  Memo7.Color := $00414141;
  Memo7.Font.Color := clWhite;
  Memo8.Color := $00414141;
  Memo8.Font.Color := clWhite;
end;

procedure TForm4.ConfigComponente;
begin
  DTImendes1.CNPJ := edtCNPJ.Text;
  DTImendes1.CNAE := edtCnae.Text;
  DTImendes1.UF := edtUF.Text;
  DTImendes1.Login := edtLogin.Text;
  DTImendes1.Senha := edtSenha.Text;
  DTImendes1.CRT := edtCRT.Text;
  DTImendes1.CodFaixa := edtCodFaixa.Text;
  case ComboBox1.ItemIndex of
    0: DTImendes1.RegimeTributario := SimplesNacional;
    1: DTImendes1.RegimeTributario := LucroPresumido;
    2: DTImendes1.RegimeTributario := LucroReal;
  end;
  case ComboBox2.ItemIndex of
    0: DTImendes1.Ambiente := Homologacao;
    1: DTImendes1.Ambiente := Producao;
  end;
end;

procedure TForm4.AdicionaLinha(Memo: TMemo; const Texto: string);
begin
  Memo.Lines.Add(Texto);
end;

procedure TForm4.AdicionaSeparador(Memo: TMemo);
begin
  Memo.Lines.Add('');
end;

procedure TForm4.AdicionaTitulo(Memo: TMemo; const Titulo: string);
begin
  Memo.Lines.Add('');
  Memo.Lines.Add('');
  Memo.Lines.Add('  ' + Titulo);
  Memo.Lines.Add('');
end;

procedure TForm4.Button1Click(Sender: TObject);
var
  i: integer;
begin
  ConfigComponente;
  Memo2.Lines.Clear;
  AdicionaTitulo(Memo2, 'CONSULTA TRIBUTOS');
  AdicionaLinha(Memo2, 'Consultando...');
  Application.ProcessMessages;
  try
    DTImendes1.ConsultaTributos(edtCodigo.Text, edtDescricao.Text);
    Memo2.Lines.Clear;
    AdicionaTitulo(Memo2, 'RESULTADO DA CONSULTA');
    AdicionaSeparador(Memo2);
    AdicionaTitulo(Memo2, 'CABECALHO DA RESPOSTA');
    AdicionaLinha(Memo2, 'Transacao........: ' + DTImendes1.RetornoCabecalho.Transacao);
    AdicionaLinha(Memo2, 'Versao API.......: ' + DTImendes1.RetornoCabecalho.Versao);
    AdicionaLinha(Memo2, 'Data/Hora........: ' + DTImendes1.RetornoCabecalho.DataHora);
    AdicionaLinha(Memo2, 'Duracao..........: ' + DTImendes1.RetornoCabecalho.Duracao);
    AdicionaSeparador(Memo2);
    
    for i := 0 to Pred(DTImendes1.RetornoTributos.Count) do
    begin
      AdicionaTitulo(Memo2, 'PRODUTO ' + IntToStr(i + 1));
      AdicionaSeparador(Memo2);
      
      AdicionaLinha(Memo2, '=== DADOS BASICOS ===');
      AdicionaLinha(Memo2, 'Codigo...........: ' + DTImendes1.RetornoTributos[i].Codigo);
      AdicionaLinha(Memo2, 'Descricao........: ' + DTImendes1.RetornoTributos[i].Descricao);
      AdicionaLinha(Memo2, 'NCM..............: ' + DTImendes1.RetornoTributos[i].Ncm);
      AdicionaLinha(Memo2, 'CEST.............: ' + DTImendes1.RetornoTributos[i].Cest);
      AdicionaLinha(Memo2, 'Codigo ANP.......: ' + DTImendes1.RetornoTributos[i].CodAnp);
      AdicionaLinha(Memo2, 'Lista............: ' + DTImendes1.RetornoTributos[i].Lista);
      AdicionaLinha(Memo2, 'Tipo.............: ' + DTImendes1.RetornoTributos[i].Tipo);
      AdicionaLinha(Memo2, '');
      
      AdicionaLinha(Memo2, '=== ICMS ===');
      AdicionaLinha(Memo2, 'CST..............: ' + DTImendes1.RetornoTributos[i].Cst);
      AdicionaLinha(Memo2, 'CSOSN............: ' + DTImendes1.RetornoTributos[i].CSOSN);
      AdicionaLinha(Memo2, 'Aliquota.........: ' + FormatFloat('0.00', DTImendes1.RetornoTributos[i].AliqICMS) + '%');
      AdicionaLinha(Memo2, 'Reducao BC.......: ' + FormatFloat('0.00', DTImendes1.RetornoTributos[i].ReducaoAliqICMS) + '%');
      AdicionaLinha(Memo2, 'FCP..............: ' + FormatFloat('0.00', DTImendes1.RetornoTributos[i].Fcp) + '%');
      AdicionaLinha(Memo2, 'CFOP Venda.......: ' + DTImendes1.RetornoTributos[i].CFOPVenda);
      AdicionaLinha(Memo2, 'CFOP Compra......: ' + DTImendes1.RetornoTributos[i].CFOPCompra);
      AdicionaLinha(Memo2, 'Cod Beneficio....: ' + DTImendes1.RetornoTributos[i].CodBeneficio);
      AdicionaLinha(Memo2, '');
      
      AdicionaLinha(Memo2, '=== ICMS ST ===');
      AdicionaLinha(Memo2, 'Aliquota ST......: ' + FormatFloat('0.00', DTImendes1.RetornoTributos[i].AliqICMSST) + '%');
      AdicionaLinha(Memo2, 'Reducao BC ST....: ' + FormatFloat('0.00', DTImendes1.RetornoTributos[i].ReducaoBCICMSST) + '%');
      AdicionaLinha(Memo2, 'IVA..............: ' + FormatFloat('0.00', DTImendes1.RetornoTributos[i].IVA) + '%');
      AdicionaLinha(Memo2, 'Antecipado.......: ' + DTImendes1.RetornoTributos[i].Antecipado);
      AdicionaLinha(Memo2, '');
      
      AdicionaLinha(Memo2, '=== PIS/COFINS ===');
      AdicionaLinha(Memo2, 'CST Entrada......: ' + DTImendes1.RetornoTributos[i].CstPisCofinsEnt);
      AdicionaLinha(Memo2, 'CST Saida........: ' + DTImendes1.RetornoTributos[i].CstPisCofins);
      AdicionaLinha(Memo2, 'Aliq PIS.........: ' + FormatFloat('0.00', DTImendes1.RetornoTributos[i].AliqPis) + '%');
      AdicionaLinha(Memo2, 'Aliq COFINS......: ' + FormatFloat('0.00', DTImendes1.RetornoTributos[i].AliqCofins) + '%');
      AdicionaLinha(Memo2, 'NRI..............: ' + DTImendes1.RetornoTributos[i].NriPisCofins);
      AdicionaLinha(Memo2, '');
      
      AdicionaLinha(Memo2, '=== IPI ===');
      AdicionaLinha(Memo2, 'CST Entrada......: ' + DTImendes1.RetornoTributos[i].CstIPIEnt);
      AdicionaLinha(Memo2, 'CST Saida........: ' + DTImendes1.RetornoTributos[i].CstIPI);
      AdicionaLinha(Memo2, 'Aliquota.........: ' + FormatFloat('0.00', DTImendes1.RetornoTributos[i].AliqIPI) + '%');
      AdicionaLinha(Memo2, 'Cod Enquadramento: ' + DTImendes1.RetornoTributos[i].CodEnqIPI);
      AdicionaLinha(Memo2, 'EX...............: ' + DTImendes1.RetornoTributos[i].ExIPI);
      AdicionaLinha(Memo2, '');
      
      if DTImendes1.RetornoTributos[i].CBS_cst <> '' then
      begin
        AdicionaLinha(Memo2, '=== CBS (REFORMA TRIBUTARIA) ===');
        AdicionaLinha(Memo2, 'Classificacao....: ' + DTImendes1.RetornoTributos[i].CBS_cClassTrib);
        AdicionaLinha(Memo2, 'Descricao........: ' + DTImendes1.RetornoTributos[i].CBS_descrcClassTrib);
        AdicionaLinha(Memo2, 'CST..............: ' + DTImendes1.RetornoTributos[i].CBS_cst);
        AdicionaLinha(Memo2, 'Descr CST........: ' + DTImendes1.RetornoTributos[i].CBS_descrCST);
        AdicionaLinha(Memo2, 'Aliquota.........: ' + FormatFloat('0.00', DTImendes1.RetornoTributos[i].CBS_aliquota) + '%');
        AdicionaLinha(Memo2, 'Reducao..........: ' + FormatFloat('0.00', DTImendes1.RetornoTributos[i].CBS_reducao) + '%');
        AdicionaLinha(Memo2, 'Vigencia.........: ' + DTImendes1.RetornoTributos[i].CBS_dtVigIni + ' ate ' + DTImendes1.RetornoTributos[i].CBS_dtVigFim);
        AdicionaLinha(Memo2, '');
      end;
      
      if DTImendes1.RetornoTributos[i].IBS_cst <> '' then
      begin
        AdicionaLinha(Memo2, '=== IBS (REFORMA TRIBUTARIA) ===');
        AdicionaLinha(Memo2, 'Classificacao....: ' + DTImendes1.RetornoTributos[i].IBS_cClassTrib);
        AdicionaLinha(Memo2, 'Descricao........: ' + DTImendes1.RetornoTributos[i].IBS_descrcClassTrib);
        AdicionaLinha(Memo2, 'CST..............: ' + DTImendes1.RetornoTributos[i].IBS_cst);
        AdicionaLinha(Memo2, 'Descr CST........: ' + DTImendes1.RetornoTributos[i].IBS_descrCST);
        AdicionaLinha(Memo2, 'IBS UF...........: ' + FormatFloat('0.00', DTImendes1.RetornoTributos[i].IBS_ibsUF) + '%');
        AdicionaLinha(Memo2, 'IBS Municipal....: ' + FormatFloat('0.00', DTImendes1.RetornoTributos[i].IBS_ibsMun) + '%');
        AdicionaLinha(Memo2, 'Vigencia.........: ' + DTImendes1.RetornoTributos[i].IBS_dtVigIni + ' ate ' + DTImendes1.RetornoTributos[i].IBS_dtVigFim);
        AdicionaLinha(Memo2, '');
      end;
      
      if DTImendes1.RetornoTributos[i].ISS_cst <> '' then
      begin
        AdicionaLinha(Memo2, '=== ISS (SERVICOS) ===');
        AdicionaLinha(Memo2, 'CST..............: ' + DTImendes1.RetornoTributos[i].ISS_cst);
        AdicionaLinha(Memo2, 'Descr CST........: ' + DTImendes1.RetornoTributos[i].ISS_descrCST);
        AdicionaLinha(Memo2, 'Aliquota.........: ' + FormatFloat('0.00', DTImendes1.RetornoTributos[i].ISS_aliquota) + '%');
//        AdicionaLinha(Memo2, 'Tipo Tributacao..: ' + DTImendes1.RetornoTributos[i].ISS_tpTrib);
//        AdicionaLinha(Memo2, 'Natureza Opera...: ' + DTImendes1.RetornoTributos[i].ISS_natOper);
        AdicionaLinha(Memo2, '');
      end;
      
      AdicionaSeparador(Memo2);
      AdicionaSeparador(Memo2);
    end;
  except
    on E: Exception do
    begin
      Memo2.Lines.Clear;
      AdicionaLinha(Memo2, 'ERRO: ' + E.Message);
    end;
  end;
end;

procedure TForm4.Button2Click(Sender: TObject);
var
  i: integer;
  Produtos: TStringList;
begin
  ConfigComponente;
  Memo4.Lines.Clear;
  Produtos := TStringList.Create;
  try
    if edtCodigoLote1.Text <> '' then
      Produtos.Add(edtCodigoLote1.Text + '|' + edtDescricaoLote1.Text);
    if edtCodigoLote2.Text <> '' then
      Produtos.Add(edtCodigoLote2.Text + '|' + edtDescricaoLote2.Text);
    if Produtos.Count = 0 then Exit;
    DTImendes1.ConsultaTributosEmLote(Produtos);
    AdicionaTitulo(Memo4, 'LOTE - Total: ' + IntToStr(DTImendes1.RetornoTributos.Count));
    for i := 0 to Pred(DTImendes1.RetornoTributos.Count) do
    begin
      AdicionaLinha(Memo4, 'Codigo: ' + DTImendes1.RetornoTributos[i].Codigo);
      AdicionaLinha(Memo4, 'NCM: ' + DTImendes1.RetornoTributos[i].Ncm);
      AdicionaSeparador(Memo4);
    end;
  except
    on E: Exception do
      AdicionaLinha(Memo4, 'ERRO: ' + E.Message);
  end;
  Produtos.Free;
end;

procedure TForm4.Button3Click(Sender: TObject);
begin
  ConfigComponente;
  Memo3.Lines.Clear;
  try
    DTImendes1.ConsultaStatusCliente;
    AdicionaTitulo(Memo3, 'STATUS');
    AdicionaLinha(Memo3, 'Status: ' + DTImendes1.Retorno.StatusCode.ToString);
    AdicionaLinha(Memo3, 'Mensagem: ' + DTImendes1.Retorno.Mensagem);
  except
    on E: Exception do
      AdicionaLinha(Memo3, 'ERRO: ' + E.Message);
  end;
end;

procedure TForm4.Button4Click(Sender: TObject);
var
  i: integer;
begin
  ConfigComponente;
  Memo5.Lines.Clear;
  try
    DTImendes1.ConsultaHistoricodeAcessos;
    AdicionaTitulo(Memo5, 'HISTORICO');
    for i := 0 to Pred(DTImendes1.RetornoConsulta.Count) do
    begin
      AdicionaLinha(Memo5, 'Interno: ' + DTImendes1.RetornoConsulta[i].ProdutosPendentes_Interno.ToString);
      AdicionaLinha(Memo5, 'Requisicoes: ' + DTImendes1.RetornoConsulta[i].Requisicoes.ToString);
    end;
  except
    on E: Exception do
      AdicionaLinha(Memo5, 'ERRO: ' + E.Message);
  end;
end;

procedure TForm4.Button5Click(Sender: TObject);
var
  xLista: TStringList;
begin
  ConfigComponente;
  Memo6.Lines.Clear;
  if edtIDRemover.Text = '' then Exit;
  xLista := TStringList.Create;
  try
    xLista.Add(edtIDRemover.Text);
    DTImendes1.RemoveDevolvidos(xLista);
    AdicionaLinha(Memo6, 'Status: ' + DTImendes1.Retorno.StatusCode.ToString);
  except
    on E: Exception do
      AdicionaLinha(Memo6, 'ERRO: ' + E.Message);
  end;
  xLista.Free;
end;

procedure TForm4.Button6Click(Sender: TObject);
var
  i: integer;
begin
  ConfigComponente;
  Memo7.Lines.Clear;
  try
    DTImendes1.AlteraDados;
    AdicionaTitulo(Memo7, 'ALTERADOS');
    for i := 0 to Pred(DTImendes1.RetornaAlterados.Count) do
    begin
      AdicionaLinha(Memo7, 'Codigo: ' + DTImendes1.RetornaAlterados[i].Codigo);
      AdicionaSeparador(Memo7);
    end;
  except
    on E: Exception do
      AdicionaLinha(Memo7, 'ERRO: ' + E.Message);
  end;
end;

procedure TForm4.Button7Click(Sender: TObject);
var
  i: integer;
begin
  ConfigComponente;
  Memo8.Lines.Clear;
  if edtBuscaProduto.Text = '' then Exit;
  try
    DTImendes1.ListaProdutos(edtBuscaProduto.Text);
    AdicionaTitulo(Memo8, 'PRODUTOS');
    for i := 0 to Pred(DTImendes1.RetornaProdutos.Count) do
    begin
      AdicionaLinha(Memo8, 'ID: ' + DTImendes1.RetornaProdutos[i].id);
      AdicionaLinha(Memo8, 'Descricao: ' + DTImendes1.RetornaProdutos[i].descricao);
      AdicionaSeparador(Memo8);
    end;
  except
    on E: Exception do
      AdicionaLinha(Memo8, 'ERRO: ' + E.Message);
  end;
end;

procedure TForm4.Button8Click(Sender: TObject);
begin
  ConfigComponente;
  Memo1.Lines.Clear;
  AdicionaTitulo(Memo1, 'CONFIGURACOES');
  AdicionaLinha(Memo1, 'CNPJ: ' + edtCNPJ.Text);
  AdicionaLinha(Memo1, 'UF: ' + edtUF.Text);
  AdicionaLinha(Memo1, 'Regime: ' + ComboBox1.Text);
  AdicionaLinha(Memo1, 'Ambiente: ' + ComboBox2.Text);
end;

end.
