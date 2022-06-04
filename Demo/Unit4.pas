unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DTImendes;

type
  TForm4 = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtCNPJ: TEdit;
    edtCnae: TEdit;
    Button1: TButton;
    edtUF: TEdit;
    edtCodigo: TEdit;
    edtDescricao: TEdit;
    Button2: TButton;
    DTImendes1: TDTImendes;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
var
i:integer;
begin
      DTImendes1.CNPJ := edtCNPJ.Text;
      DTImendes1.CNAE := edtCnae.Text;
      DTImendes1.UF   := edtUF.Text;
      DTImendes1.RegimeTributario := SimplesNacional;
      DTImendes1.Ambiente := Homologacao;
      DTImendes1.Login := '';
      DTImendes1.Senha := '';
      DTImendes1.CRT   := '1';
      DTImendes1.CodFaixa := '102';

      DTImendes1.ConsultaTributos(edtCodigo.Text,edtDescricao.Text);
      Memo1.Lines.Clear;

      for I := 0 to Pred(DTImendes1.RetornoTributos.Count) do
        begin
              Memo1.Lines.Add('Status: ' + DTImendes1.RetornoTributos[i].StatusCode.ToString);
              Memo1.Lines.Add('Codigo: ' + DTImendes1.RetornoTributos[i].Codigo);
              Memo1.Lines.Add('Descricao: ' + DTImendes1.RetornoTributos[i].Descricao);
              Memo1.Lines.Add('Ncm: ' + DTImendes1.RetornoTributos[i].Ncm);
              Memo1.Lines.Add('Cest: ' + DTImendes1.RetornoTributos[i].Cest);
              Memo1.Lines.Add('CodAnp: ' + DTImendes1.RetornoTributos[i].CodAnp);
              Memo1.Lines.Add('CstPisCofins: ' + DTImendes1.RetornoTributos[i].CstPisCofins);
              Memo1.Lines.Add('AliqPis: ' + DTImendes1.RetornoTributos[i].AliqPis.ToString);
              Memo1.Lines.Add('AliqCofins: ' + DTImendes1.RetornoTributos[i].AliqCofins.ToString);
              Memo1.Lines.Add('CodEFD: ' + DTImendes1.RetornoTributos[i].CodEFD);
              Memo1.Lines.Add('CstIPI: ' + DTImendes1.RetornoTributos[i].CstIPI);
              Memo1.Lines.Add('AliqIPI: ' + DTImendes1.RetornoTributos[i].AliqIPI.ToString);
              Memo1.Lines.Add('Cst: ' + DTImendes1.RetornoTributos[i].Cst);
              Memo1.Lines.Add('AliqICMS: ' + DTImendes1.RetornoTributos[i].AliqICMS.ToString);
              Memo1.Lines.Add('Fcp: ' + DTImendes1.RetornoTributos[i].Fcp.ToString);
              Memo1.Lines.Add('CFOPVenda: ' + DTImendes1.RetornoTributos[i].CFOPVenda);
              Memo1.Lines.Add('CFOPCompra: ' + DTImendes1.RetornoTributos[i].CFOPCompra);
        end;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
      DTImendes1.CNPJ             := edtCNPJ.Text;
      DTImendes1.CNAE             := edtCnae.Text;
      DTImendes1.UF               := edtUF.Text;
      DTImendes1.RegimeTributario := SimplesNacional;
      DTImendes1.Ambiente         := Homologacao;
      DTImendes1.Login            := '';
      DTImendes1.Senha            := '';

      DTImendes1.ConsultaStatusCliente;
      Memo1.Lines.Clear;

      Memo1.Lines.Add('Status: ' + DTImendes1.retorno.StatusCode.ToString);
      Memo1.Lines.Add('Mensagem: ' + DTImendes1.retorno. Mensagem);
end;

procedure TForm4.Button3Click(Sender: TObject);
var
i:integer;
Produtos:TStringList;
begin
      Produtos := TStringList.Create;

      Produtos.Add('7894900019155' + '|' + 'coca cola');
      Produtos.Add('7894900911510' + '|' + 'kuat');

      DTImendes1.CNPJ := edtCNPJ.Text;
      DTImendes1.CNAE := edtCnae.Text;
      DTImendes1.UF   := edtUF.Text;
      DTImendes1.RegimeTributario := SimplesNacional;
      DTImendes1.Ambiente := Homologacao;
      DTImendes1.Login := '';
      DTImendes1.Senha := '';
      DTImendes1.CRT   := '1';
      DTImendes1.CodFaixa := '102';

      DTImendes1.ConsultaTributosemlote(Produtos);

      Produtos.Free;
      Memo1.Lines.Clear;

      for I := 0 to Pred(DTImendes1.RetornoTributos.Count) do
        begin
              Memo1.Lines.Add('Status: ' + DTImendes1.RetornoTributos[i].StatusCode.ToString);
              Memo1.Lines.Add('Codigo: ' + DTImendes1.RetornoTributos[i].Codigo);
              Memo1.Lines.Add('Descricao: ' + DTImendes1.RetornoTributos[i].Descricao);
              Memo1.Lines.Add('Ncm: ' + DTImendes1.RetornoTributos[i].Ncm);
              Memo1.Lines.Add('Cest: ' + DTImendes1.RetornoTributos[i].Cest);
              Memo1.Lines.Add('CodAnp: ' + DTImendes1.RetornoTributos[i].CodAnp);
              Memo1.Lines.Add('CstPisCofins: ' + DTImendes1.RetornoTributos[i].CstPisCofins);
              Memo1.Lines.Add('AliqPis: ' + DTImendes1.RetornoTributos[i].AliqPis.ToString);
              Memo1.Lines.Add('AliqCofins: ' + DTImendes1.RetornoTributos[i].AliqCofins.ToString);
              Memo1.Lines.Add('CodEFD: ' + DTImendes1.RetornoTributos[i].CodEFD);
              Memo1.Lines.Add('CstIPI: ' + DTImendes1.RetornoTributos[i].CstIPI);
              Memo1.Lines.Add('AliqIPI: ' + DTImendes1.RetornoTributos[i].AliqIPI.ToString);
              Memo1.Lines.Add('Cst: ' + DTImendes1.RetornoTributos[i].Cst);
              Memo1.Lines.Add('AliqICMS: ' + DTImendes1.RetornoTributos[i].AliqICMS.ToString);
              Memo1.Lines.Add('Fcp: ' + DTImendes1.RetornoTributos[i].Fcp.ToString);
              Memo1.Lines.Add('CFOPVenda: ' + DTImendes1.RetornoTributos[i].CFOPVenda);
              Memo1.Lines.Add('CFOPCompra: ' + DTImendes1.RetornoTributos[i].CFOPCompra);
              Memo1.Lines.Add('++++++++++++++++++++++xxxx++++++++++++++++++++++++++');
        end;
end;

procedure TForm4.Button4Click(Sender: TObject);
var
i:integer;
begin
      DTImendes1.CNPJ := edtCNPJ.Text;
      DTImendes1.CNAE := edtCnae.Text;
      DTImendes1.UF   := edtUF.Text;
      DTImendes1.RegimeTributario := SimplesNacional;
      DTImendes1.Ambiente := Homologacao;
      DTImendes1.Login := '';
      DTImendes1.Senha := '';
      DTImendes1.CRT   := '1';
      DTImendes1.CodFaixa := '102';

      DTImendes1.ConsultaHistoricodeAcessos;
      Memo1.Lines.Clear;

      for I := 0 to Pred(DTImendes1.RetornoConsulta.Count) do
        begin
             Memo1.Lines.Add('ProdutosPendentes_Interno: ' + DTImendes1.RetornoConsulta[i].ProdutosPendentes_Interno.ToString);
             Memo1.Lines.Add('ProdutosPendentes_EAN: ' + DTImendes1.RetornoConsulta[i].ProdutosPendentes_EAN.ToString);
             Memo1.Lines.Add('ProdutosPendentes_Devolvidos: ' + DTImendes1.RetornoConsulta[i].ProdutosPendentes_Devolvidos.ToString);
             Memo1.Lines.Add('Data Primeiro Consumo: ' + datetostr(DTImendes1.RetornoConsulta[i].ProdutosPendentes_DataInicio));
             Memo1.Lines.Add('Data Ultimo Consumo: ' + datetostr(DTImendes1.RetornoConsulta[i].ProdutosPendentes_DataUltConsumo));


             Memo1.Lines.Add('Requisicoes: ' + DTImendes1.RetornoConsulta[i].Requisicoes.ToString);
             Memo1.Lines.Add('Enviados: ' + DTImendes1.RetornoConsulta[i].Enviados.ToString);
             Memo1.Lines.Add('Retornados: ' + DTImendes1.RetornoConsulta[i].Retornados.ToString);
         end;

       for I := 0 to Pred(DTImendes1.retornoproddevolvido.Count) do
         begin
             Memo1.Lines.Add('+++++++++++++++++++++++ produtos +++++++++++++++++++++++++++++++');
             Memo1.Lines.Add('id: ' + DTImendes1.retornoproddevolvido[i].Dev_ID);
             Memo1.Lines.Add('codigo: ' + DTImendes1.retornoproddevolvido[i].Dev_Codigo);
             Memo1.Lines.Add('descricao: ' + DTImendes1.retornoproddevolvido[i].Dev_Descricao);
             Memo1.Lines.Add('motivo: ' + DTImendes1.retornoproddevolvido[i].Dev_motivo);
             Memo1.Lines.Add('data Inclusao: ' + DateToStr(DTImendes1.retornoproddevolvido[i].Dev_dtinclusao));
             Memo1.Lines.Add('data Exclusao: ' + DateToStr(DTImendes1.retornoproddevolvido[i].Dev_dtdevolucao));
         end;
end;

procedure TForm4.Button5Click(Sender: TObject);
var
xLista:TStringList;
begin
      DTImendes1.CNPJ := edtCNPJ.Text;
      DTImendes1.CNAE := edtCnae.Text;
      DTImendes1.UF   := edtUF.Text;
      DTImendes1.RegimeTributario := SimplesNacional;
      DTImendes1.Ambiente := Homologacao;
      DTImendes1.Login := '';
      DTImendes1.Senha := '';
      DTImendes1.CRT   := '1';
      DTImendes1.CodFaixa := '102';

      xLista := TStringList.Create;

      xLista.Add('310394695');
      //xLista.Add('278671421');

      DTImendes1.RemoveDevolvidos(xLista);

      xLista.Free;

      Memo1.Lines.Clear;
      Memo1.Lines.Add('Status: ' + DTImendes1.Retorno.StatusCode.ToString);
      Memo1.Lines.Add('Mensagem: ' + DTImendes1.Retorno.Mensagem);
end;

procedure TForm4.Button6Click(Sender: TObject);
var
i:integer;
begin
      DTImendes1.CNPJ := edtCNPJ.Text;
      DTImendes1.CNAE := edtCnae.Text;
      DTImendes1.UF   := edtUF.Text;
      DTImendes1.RegimeTributario := SimplesNacional;
      DTImendes1.Ambiente := Homologacao;
      DTImendes1.Login := '';
      DTImendes1.Senha := '';
      DTImendes1.CRT   := '1';
      DTImendes1.CodFaixa := '102';

      DTImendes1.AlteraDados;

      Memo1.Lines.Clear;

      for I := 0 to Pred(DTImendes1.RetornaAlterados.Count) do
       begin
            Memo1.Lines.Add('Retornados: ' + DTImendes1.RetornaAlterados[i].Retornados.ToString);
            Memo1.Lines.Add('codigo: ' + DTImendes1.RetornaAlterados[i].Codigo);
            Memo1.Lines.Add('data Ult. consulta: ' + DateToStr( DTImendes1.RetornaAlterados[i].dtultcons ));
            Memo1.Lines.Add('data Ult alteracao: ' + DateToStr( DTImendes1.RetornaAlterados[i].dtrev ));
            Memo1.Lines.Add('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
       end;
end;

procedure TForm4.Button7Click(Sender: TObject);
var
i:integer;
begin
      DTImendes1.CNPJ := edtCNPJ.Text;
      DTImendes1.CNAE := edtCnae.Text;
      DTImendes1.UF   := edtUF.Text;
      DTImendes1.RegimeTributario := SimplesNacional;
      DTImendes1.Ambiente := Homologacao;
      DTImendes1.Login := '';
      DTImendes1.Senha := '';
      DTImendes1.CRT   := '1';
      DTImendes1.CodFaixa := '102';

      DTImendes1.listaprodutos(edtDescricao.Text);

      Memo1.Lines.Clear;

      for I := 0 to Pred(DTImendes1.Retornaprodutos.Count) do
       begin
            Memo1.Lines.Add('Retornados: ' + DTImendes1.Retornaprodutos[i].ProdutosRetornados.ToString);
            Memo1.Lines.Add('id: ' + DTImendes1.Retornaprodutos[i].id);
            Memo1.Lines.Add('descricao: ' + ( DTImendes1.Retornaprodutos[i].descricao ));
            Memo1.Lines.Add('ean: ' + ( DTImendes1.Retornaprodutos[i].ean ));
            Memo1.Lines.Add('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
       end;

end;

end.
