# 📦 DTImendes - Component API Imendes

[![Delphi](https://img.shields.io/badge/Delphi-10.3+-blue.svg)](https://www.embarcadero.com/products/delphi)
[![API Version](https://img.shields.io/badge/API-v2.23.1.0-green.svg)](https://imendes.com.br)
[![License](https://img.shields.io/badge/license-MIT-orange.svg)](LICENSE)
[![Maintained](https://img.shields.io/badge/Maintained-Yes-brightgreen.svg)](https://github.com/tiagopassarelladt/DTImendes)

> **Componente Delphi para integração com a API Imendes - Consulta de Tributos**

Componente completo para consulta de tributos fiscais brasileiros através da API Imendes. Totalmente atualizado com suporte à **Reforma Tributária** (CBS e IBS), **ISS** para serviços, e todas as regras fiscais estaduais.

---

## 📋 Índice

- [Características](#-características)
- [Instalação](#-instalação)
- [Configuração Rápida](#-configuração-rápida)
- [Exemplos de Uso](#-exemplos-de-uso)
- [Funcionalidades](#-funcionalidades)
- [Estrutura de Dados](#-estrutura-de-dados)
- [Demo Application](#-demo-application)
- [API Reference](#-api-reference)
- [FAQ](#-faq)
- [Suporte](#-suporte)

---

## ✨ Características

- ✅ **API v2.23.1.0** - Versão mais recente da API Imendes
- ✅ **Reforma Tributária** - Suporte completo a CBS e IBS
- ✅ **ISS** - Consulta de tributos para serviços
- ✅ **75+ Campos** - Informações completas de tributação
- ✅ **Consulta Individual ou em Lote** - Flexibilidade total
- ✅ **Metadados da API** - Acesso a cabeçalho e informações de consumo
- ✅ **Compatibilidade Retroativa** - Não quebra aplicações existentes
- ✅ **Demo Completo** - Aplicação de exemplo com todas as funcionalidades
- ✅ **REST API** - Comunicação moderna e eficiente
- ✅ **Thread-safe** - Pronto para uso em aplicações multithread

---

## 🔧 Instalação

### Método 1: Manual

1. Clone ou baixe este repositório
2. Abra o projeto `Imendes.dpk` no Delphi
3. Clique com botão direito no projeto → **Install**
4. O componente `TDTImendes` aparecerá na paleta de componentes

### Método 2: Via Boss (Package Manager)

```bash
boss install github.com/tiagopassarelladt/DTImendes
```

### Requisitos

- Delphi 10.3 Rio ou superior
- REST Client components (incluídos no Delphi)
- Conta ativa na API Imendes ([https://imendes.com.br](https://imendes.com.br))

---

## 🚀 Configuração Rápida

### 1. Adicione o componente ao seu formulário

```delphi
uses DTImendes;

// O componente TDTImendes estará disponível na paleta
```

### 2. Configure as credenciais

```delphi
procedure TForm1.FormCreate(Sender: TObject);
begin
  DTImendes1.CNPJ := '11914502000144';
  DTImendes1.Login := '11914502000144';
  DTImendes1.Senha := 'sua_senha_aqui';
  DTImendes1.UF := 'MG';
  DTImendes1.CRT := '1'; // 1=Simples, 2=Presumido, 3=Real
  DTImendes1.CodFaixa := '102';
  DTImendes1.RegimeTributario := SimplesNacional;
  DTImendes1.Ambiente := Producao;
end;
```

### 3. Faça sua primeira consulta

```delphi
procedure TForm1.Button1Click(Sender: TObject);
var
  i: Integer;
begin
  // Consulta um produto
  DTImendes1.ConsultaTributos('7894900019155', 'COCA COLA');
  
  // Acessa os resultados
  for i := 0 to DTImendes1.RetornoTributos.Count - 1 do
  begin
    ShowMessage('NCM: ' + DTImendes1.RetornoTributos[i].Ncm);
    ShowMessage('CEST: ' + DTImendes1.RetornoTributos[i].Cest);
    ShowMessage('ICMS: ' + FloatToStr(DTImendes1.RetornoTributos[i].AliqICMS) + '%');
  end;
end;
```

---

## 💡 Exemplos de Uso

### 📌 Consulta Individual

```delphi
procedure ConsultarProduto;
var
  Tributo: TRetornoTributos;
begin
  DTImendes1.ConsultaTributos('7894900019155', 'COCA COLA');
  
  if DTImendes1.RetornoTributos.Count > 0 then
  begin
    Tributo := DTImendes1.RetornoTributos[0];
    
    // Informações básicas
    Memo1.Lines.Add('Código: ' + Tributo.Codigo);
    Memo1.Lines.Add('Descrição: ' + Tributo.Descricao);
    Memo1.Lines.Add('NCM: ' + Tributo.Ncm);
    Memo1.Lines.Add('CEST: ' + Tributo.Cest);
    
    // ICMS
    Memo1.Lines.Add('CST: ' + Tributo.Cst);
    Memo1.Lines.Add('Alíquota ICMS: ' + FloatToStr(Tributo.AliqICMS) + '%');
    Memo1.Lines.Add('CFOP Venda: ' + Tributo.CFOPVenda);
    
    // PIS/COFINS
    Memo1.Lines.Add('Alíquota PIS: ' + FloatToStr(Tributo.AliqPis) + '%');
    Memo1.Lines.Add('Alíquota COFINS: ' + FloatToStr(Tributo.AliqCofins) + '%');
    
    // IPI
    Memo1.Lines.Add('CST IPI: ' + Tributo.CstIPI);
    Memo1.Lines.Add('Alíquota IPI: ' + FloatToStr(Tributo.AliqIPI) + '%');
  end;
end;
```

### 📦 Consulta em Lote

```delphi
procedure ConsultarLote;
var
  Produtos: TStringList;
  i: Integer;
begin
  Produtos := TStringList.Create;
  try
    // Adiciona produtos no formato: Codigo|Descrição
    Produtos.Add('7894900019155|COCA COLA');
    Produtos.Add('7894900911510|KUAT');
    Produtos.Add('7891000100103|NESCAU');
    
    // Consulta o lote
    DTImendes1.ConsultaTributosEmLote(Produtos);
    
    // Processa resultados
    for i := 0 to DTImendes1.RetornoTributos.Count - 1 do
    begin
      Memo1.Lines.Add('----------------------------');
      Memo1.Lines.Add('Produto: ' + DTImendes1.RetornoTributos[i].Descricao);
      Memo1.Lines.Add('NCM: ' + DTImendes1.RetornoTributos[i].Ncm);
      Memo1.Lines.Add('Alíquota ICMS: ' + FloatToStr(DTImendes1.RetornoTributos[i].AliqICMS) + '%');
    end;
  finally
    Produtos.Free;
  end;
end;
```

### 🆕 Reforma Tributária (CBS e IBS)

```delphi
procedure ExibirReformaTributaria;
var
  Tributo: TRetornoTributos;
begin
  DTImendes1.ConsultaTributos('7894900019155', 'COCA COLA');
  
  if DTImendes1.RetornoTributos.Count > 0 then
  begin
    Tributo := DTImendes1.RetornoTributos[0];
    
    // CBS - Contribuição sobre Bens e Serviços
    if Tributo.CBS_cst <> '' then
    begin
      Memo1.Lines.Add('=== CBS (Reforma Tributária) ===');
      Memo1.Lines.Add('Classificação: ' + Tributo.CBS_cClassTrib);
      Memo1.Lines.Add('Descrição: ' + Tributo.CBS_descrcClassTrib);
      Memo1.Lines.Add('CST: ' + Tributo.CBS_cst);
      Memo1.Lines.Add('Alíquota: ' + FloatToStr(Tributo.CBS_aliquota) + '%');
      Memo1.Lines.Add('Redução: ' + FloatToStr(Tributo.CBS_reducao) + '%');
      Memo1.Lines.Add('Vigência: ' + Tributo.CBS_dtVigIni + ' até ' + Tributo.CBS_dtVigFim);
    end;
    
    // IBS - Imposto sobre Bens e Serviços
    if Tributo.IBS_cst <> '' then
    begin
      Memo1.Lines.Add('=== IBS (Reforma Tributária) ===');
      Memo1.Lines.Add('Classificação: ' + Tributo.IBS_cClassTrib);
      Memo1.Lines.Add('CST: ' + Tributo.IBS_cst);
      Memo1.Lines.Add('IBS UF: ' + FloatToStr(Tributo.IBS_ibsUF) + '%');
      Memo1.Lines.Add('IBS Municipal: ' + FloatToStr(Tributo.IBS_ibsMun) + '%');
      Memo1.Lines.Add('Vigência: ' + Tributo.IBS_dtVigIni + ' até ' + Tributo.IBS_dtVigFim);
    end;
  end;
end;
```

### 🏢 ISS (Imposto sobre Serviços)

```delphi
procedure ExibirISS;
var
  Tributo: TRetornoTributos;
begin
  DTImendes1.ConsultaTributos('12345', 'SERVICO DE CONSULTORIA');
  
  if DTImendes1.RetornoTributos.Count > 0 then
  begin
    Tributo := DTImendes1.RetornoTributos[0];
    
    // ISS para serviços
    if Tributo.ISS_cst <> '' then
    begin
      Memo1.Lines.Add('=== ISS ===');
      Memo1.Lines.Add('CST: ' + Tributo.ISS_cst);
      Memo1.Lines.Add('Descrição CST: ' + Tributo.ISS_descrCST);
      Memo1.Lines.Add('Alíquota: ' + FloatToStr(Tributo.ISS_aliquota) + '%');
    end;
  end;
end;
```

### 📊 Metadados da API (Cabeçalho)

```delphi
procedure ExibirMetadadosAPI;
begin
  DTImendes1.ConsultaTributos('7894900019155', 'COCA COLA');
  
  // Acessa informações do cabeçalho da resposta
  Memo1.Lines.Add('=== Metadados da API ===');
  Memo1.Lines.Add('Transação: ' + DTImendes1.RetornoCabecalho.Transacao);
  Memo1.Lines.Add('Versão API: ' + DTImendes1.RetornoCabecalho.Versao);
  Memo1.Lines.Add('Data/Hora: ' + DTImendes1.RetornoCabecalho.DataHora);
  Memo1.Lines.Add('Duração: ' + DTImendes1.RetornoCabecalho.Duracao + ' ms');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('=== Informações de Consumo ===');
  Memo1.Lines.Add('Acessos Contratados: ' + DTImendes1.RetornoCabecalho.AcesContratado);
  Memo1.Lines.Add('Acessos Disponíveis: ' + DTImendes1.RetornoCabecalho.AcesDisponivel);
  Memo1.Lines.Add('Acessos Consumidos: ' + DTImendes1.RetornoCabecalho.AcesConsumido);
  Memo1.Lines.Add('Requisições Disponíveis: ' + DTImendes1.RetornoCabecalho.ReqDisponivel);
end;
```

### 📈 Status do Cliente

```delphi
procedure VerificarStatus;
begin
  DTImendes1.ConsultaStatusCliente;
  
  ShowMessage('Status Code: ' + DTImendes1.Retorno.StatusCode.ToString);
  ShowMessage('Mensagem: ' + DTImendes1.Retorno.Mensagem);
end;
```

### 📜 Histórico de Acessos

```delphi
procedure ConsultarHistorico;
var
  i: Integer;
begin
  DTImendes1.ConsultaHistoricodeAcessos;
  
  for i := 0 to DTImendes1.RetornoConsulta.Count - 1 do
  begin
    Memo1.Lines.Add('Produtos Pendentes: ' + 
      DTImendes1.RetornoConsulta[i].ProdutosPendentes_Interno.ToString);
    Memo1.Lines.Add('Requisições: ' + 
      DTImendes1.RetornoConsulta[i].Requisicoes.ToString);
  end;
end;
```

---

## 🎯 Funcionalidades

### Métodos Principais

| Método | Descrição |
|--------|-----------|
| `ConsultaTributos` | Consulta tributos de um produto específico |
| `ConsultaTributosEmLote` | Consulta múltiplos produtos de uma vez |
| `ConsultaStatusCliente` | Verifica status da conta na API |
| `ConsultaHistoricodeAcessos` | Obtém histórico de consultas |
| `AlteraDados` | Lista produtos com dados alterados |
| `ListaProdutos` | Busca produtos por termo |
| `RemoveDevolvidos` | Remove produtos devolvidos da lista |

### Propriedades de Configuração

```delphi
property CNPJ: string;              // CNPJ da empresa
property CNAE: string;              // CNAE principal (opcional)
property UF: string;                // Estado (ex: 'MG', 'SP')
property Login: string;             // Login de acesso (geralmente CNPJ)
property Senha: string;             // Senha de acesso
property CRT: string;               // Código Regime Tributário
property CodFaixa: string;          // Código da faixa (Simples Nacional)
property RegimeTributario: TRegime; // SimplesNacional, LucroPresumido, LucroReal
property Ambiente: TAmbiente;       // Homologacao ou Producao
```

### Propriedades de Retorno

```delphi
property RetornoTributos: TList<TRetornoTributos>;      // Lista de produtos consultados
property RetornoCabecalho: TRetornoCabecalho;           // Metadados da resposta API
property Retorno: TRetorno;                             // Status da operação
property RetornoConsulta: TList<TRetornoConsulta>;      // Histórico de consultas
property RetornaAlterados: TList<TRetornaAlterados>;    // Produtos alterados
property RetornaProdutos: TList<TRetornaProdutos>;      // Busca de produtos
```

---

## 📊 Estrutura de Dados

### TRetornoTributos (75+ Campos)

#### 📦 Informações Básicas
- `Codigo` - Código do produto
- `Descricao` - Descrição do produto
- `Ncm` - Nomenclatura Comum do Mercosul
- `Cest` - Código Especificador da Substituição Tributária
- `CodAnp` - Código ANP (combustíveis)
- `Lista` - Lista do produto
- `Tipo` - Tipo do produto

#### 💰 ICMS
- `Cst` - Código Situação Tributária
- `CSOSN` - Código Situação Operação Simples Nacional
- `AliqICMS` - Alíquota ICMS
- `ReducaoAliqICMS` - Redução Base de Cálculo ICMS
- `Fcp` - Fundo Combate Pobreza
- `CFOPVenda` - CFOP para vendas
- `CFOPCompra` - CFOP para compras
- `CodBeneficio` - Código do benefício fiscal
- `AmpLegal` - Amparo legal

#### 🏪 ICMS ST
- `AliqICMSST` - Alíquota ICMS ST
- `ReducaoBCICMSST` - Redução BC ICMS ST
- `IVA` - Índice de Valor Agregado
- `Antecipado` - Indicador de antecipação
- `Desonerado` - Indicador de desoneração
- `ICMSDeson` - Motivo desoneração ICMS
- `PICMSEfet` - ICMS efetivo
- `PRedBCEfet` - Redução BC efetiva

#### 💵 PIS/COFINS
- `CstPisCofins` - CST de saída
- `CstPisCofinsEnt` - CST de entrada
- `AliqPis` - Alíquota PIS
- `AliqCofins` - Alíquota COFINS
- `NriPisCofins` - NRI (Número de Referência)
- `AmpLegalPisCofins` - Amparo legal
- `DtVigIniPisCofins` - Data início vigência
- `DtVigFimPisCofins` - Data fim vigência

#### 🏭 IPI
- `CstIPI` - CST de saída
- `CstIPIEnt` - CST de entrada
- `AliqIPI` - Alíquota IPI
- `CodEnqIPI` - Código de enquadramento
- `ExIPI` - EX IPI

#### 🆕 CBS (Reforma Tributária)
- `CBS_cClassTrib` - Código classificação tributária
- `CBS_descrcClassTrib` - Descrição classificação
- `CBS_cst` - CST CBS
- `CBS_descrCST` - Descrição CST
- `CBS_aliquota` - Alíquota CBS
- `CBS_reducao` - Redução CBS
- `CBS_reducaoBcCBS` - Redução BC CBS
- `CBS_ampLegal` - Amparo legal
- `CBS_dtVigIni` - Data início vigência
- `CBS_dtVigFim` - Data fim vigência

#### 🆕 IBS (Reforma Tributária)
- `IBS_cClassTrib` - Código classificação tributária
- `IBS_descrcClassTrib` - Descrição classificação
- `IBS_cst` - CST IBS
- `IBS_descrCST` - Descrição CST
- `IBS_ibsUF` - IBS Estadual
- `IBS_ibsMun` - IBS Municipal
- `IBS_reducaoaliqIBS` - Redução alíquota
- `IBS_reducaoBcIBS` - Redução BC
- `IBS_ampLegal` - Amparo legal
- `IBS_dtVigIni` - Data início vigência
- `IBS_dtVigFim` - Data fim vigência

#### 🏢 ISS (Serviços)
- `ISS_cClassTrib` - Código classificação
- `ISS_descrcClassTrib` - Descrição classificação
- `ISS_cst` - CST ISS
- `ISS_descrCST` - Descrição CST
- `ISS_aliquota` - Alíquota ISS
- `ISS_tpTrib` - Tipo tributação
- `ISS_natOper` - Natureza operação
- `ISS_indInc` - Indicador incidência
- `ISS_dtVigIni` - Data início vigência

#### 📋 REGRA (Informações Estaduais)
- `RegraUF` - UF da regra
- `RegraExcecao` - Indicador exceção
- `PICMSPDVRegra` - Percentual ICMS PDV
- `SimbPDVRegra` - Símbolo PDV
- `PDifer` - Percentual diferimento
- `PercIsencao` - Percentual isenção
- `ESTDFinalidade` - Finalidade estadual
- `DtVigIniRegra` - Data início vigência
- `DtVigFimRegra` - Data fim vigência
- `IndicDeduzDesonerado` - Indicador deduz desonerado

### TRetornoCabecalho (22 Campos)

#### 🔍 Informações da Transação
- `Transacao` - ID da transação
- `Versao` - Versão da API
- `DataHora` - Data e hora da resposta
- `Mensagem` - Mensagem retornada
- `Duracao` - Tempo de processamento

#### 📊 Controle de Acessos
- `AcesPrimeiro` - Data primeiro acesso
- `AcesExpirar` - Data expiração
- `AcesTotal` - Total de acessos
- `AcesContratado` - Acessos contratados
- `AcesDisponivel` - Acessos disponíveis
- `AcesReservado` - Acessos reservados
- `AcesConsumido` - Acessos consumidos

#### 📦 Controle de Produtos
- `ProdInterno` - Código interno
- `ProdEAN` - Código EAN
- `ProdPendente` - Produtos pendentes
- `ProdDevolvido` - Produtos devolvidos

#### 🚀 Controle de Requisições
- `ReqDisponivel` - Requisições disponíveis
- `ReqConsumido` - Requisições consumidas
- `ReqReservado` - Requisições reservadas

#### ℹ️ Outras Informações
- `AcesDados` - Dados de acesso
- `Aviso` - Avisos
- `Detalhes` - Detalhes adicionais

---

## 🎨 Demo Application

O projeto inclui uma aplicação de demonstração completa (`Demo/DemoImendes.dpr`) com:

### 📑 7 Abas Funcionais

1. **⚙️ Configuração**
   - Credenciais de acesso (CNPJ, Login, Senha)
   - Parâmetros tributários (UF, CRT, CNAE)
   - Regime tributário (Simples Nacional, Presumido, Real)
   - Ambiente (Homologação/Produção)

2. **🔍 Consulta Tributos**
   - Consulta individual com display completo
   - Exibe todos os 75+ campos disponíveis
   - Seções organizadas (ICMS, PIS/COFINS, IPI, CBS, IBS, ISS)
   - Formatação visual clara com separadores

3. **✅ Status Cliente**
   - Verifica status da conta na API
   - Exibe mensagens do sistema
   - Status code da operação

4. **📦 Consulta Lote**
   - Consulta múltiplos produtos simultaneamente
   - Até 100 produtos por requisição
   - Resultados organizados por produto

5. **📜 Histórico**
   - Histórico de acessos à API
   - Produtos pendentes e devolvidos
   - Estatísticas de uso

6. **🗑️ Remove Devolvidos**
   - Gerenciamento de produtos devolvidos
   - Remove produtos da lista de pendentes

7. **🔄 Altera Dados / Lista**
   - Produtos com dados alterados
   - Busca de produtos por termo
   - Lista completa de produtos

### 🎨 Interface Moderna

- **Tema Escuro** - Background cinza escuro (#414141) com texto branco
- **Fonte Monoespaçada** - Consolas para melhor legibilidade
- **Layout Organizado** - PageControl com abas intuitivas
- **Valores Pré-configurados** - Pronto para testes imediatos

### ▶️ Como Executar o Demo

1. Abra `Demo/DemoImendes.dproj` no Delphi
2. Compile e execute (F9)
3. Configure suas credenciais na aba "Configuração"
4. Teste as funcionalidades nas demais abas

---

## 📖 API Reference

### Consulta Individual

```delphi
function ConsultaTributos(Codigo: string; Descricao: string): Boolean;
```

**Parâmetros:**
- `Codigo` - Código do produto (código interno, EAN, etc)
- `Descricao` - Descrição do produto

**Retorno:**
- `True` - Consulta realizada com sucesso
- `False` - Erro na consulta

**Dados retornados em:**
- `DTImendes1.RetornoTributos[i]` - Lista de produtos encontrados
- `DTImendes1.RetornoCabecalho` - Metadados da resposta

### Consulta em Lote

```delphi
function ConsultaTributosEmLote(CodigoDescricao: TStringList): Boolean;
```

**Parâmetros:**
- `CodigoDescricao` - Lista com produtos no formato "Codigo|Descrição"

**Exemplo:**
```delphi
Lista.Add('7894900019155|COCA COLA');
Lista.Add('7894900911510|KUAT');
```

**Limitações:**
- Máximo de 100 produtos por requisição
- Tempo limite de 60 segundos

### Status do Cliente

```delphi
function ConsultaStatusCliente: Boolean;
```

**Retorno em:**
- `DTImendes1.Retorno.StatusCode` - Código HTTP
- `DTImendes1.Retorno.Mensagem` - Mensagem de status

### Histórico de Acessos

```delphi
function ConsultaHistoricodeAcessos: Boolean;
```

**Retorno em:**
- `DTImendes1.RetornoConsulta[i]` - Lista de histórico

### Produtos Alterados

```delphi
function AlteraDados: Boolean;
```

**Retorno em:**
- `DTImendes1.RetornaAlterados[i]` - Lista de produtos alterados

### Busca de Produtos

```delphi
function ListaProdutos(Termo: string): Boolean;
```

**Parâmetros:**
- `Termo` - Termo de busca (descrição, código, etc)

**Retorno em:**
- `DTImendes1.RetornaProdutos[i]` - Lista de produtos encontrados

### Remove Devolvidos

```delphi
function RemoveDevolvidos(IDs: TStringList): Boolean;
```

**Parâmetros:**
- `IDs` - Lista com IDs dos produtos a remover

---

## ❓ FAQ

### ❓ Como obter credenciais de acesso?

Acesse [https://imendes.com.br](https://imendes.com.br) e solicite uma conta. Você receberá:
- Login (geralmente seu CNPJ)
- Senha de acesso
- Informações sobre o plano contratado

### ❓ Qual a diferença entre Homologação e Produção?

- **Homologação**: Ambiente de testes, não consome requisições do plano
- **Produção**: Ambiente real, consome requisições contratadas

### ❓ Quantas consultas posso fazer por requisição em lote?

Até 100 produtos por requisição. Para mais produtos, divida em múltiplas requisições.

### ❓ Os campos CBS e IBS já funcionam?

Sim! O componente já está preparado para a Reforma Tributária. Os campos serão populados quando a API retornar essas informações.

### ❓ Como tratar produtos que não retornam CBS/IBS?

```delphi
if Tributo.CBS_cst <> '' then
begin
  // Produto tem informações CBS
end;

if Tributo.IBS_cst <> '' then
begin
  // Produto tem informações IBS
end;
```

### ❓ Posso usar em aplicações multithreaded?

Sim, mas crie uma instância do componente para cada thread ou use sincronização apropriada.

### ❓ Como monitorar meu consumo de requisições?

```delphi
DTImendes1.ConsultaTributos('853', 'AGUA');

ShowMessage('Disponíveis: ' + DTImendes1.RetornoCabecalho.AcesDisponivel);
ShowMessage('Consumidos: ' + DTImendes1.RetornoCabecalho.AcesConsumido);
```

### ❓ Minha aplicação antiga vai quebrar com a atualização?

Não! A atualização mantém 100% de compatibilidade retroativa. Todos os campos e comportamentos anteriores permanecem inalterados.

### ❓ Como funciona o campo `Lista`?

O campo `Lista` indica se o produto pertence a listas especiais:
- Lista Negativa (combustíveis)
- Lista Neutra
- Lista Positiva

### ❓ O que é o campo `Tipo`?

Indica o tipo do produto:
- Produto
- Serviço
- Outros tipos específicos

---

## 🆘 Suporte

### 📧 Contato

- **Issues GitHub**: [https://github.com/tiagopassarelladt/DTImendes/issues](https://github.com/tiagopassarelladt/DTImendes/issues)
- **API Imendes**: [https://imendes.com.br](https://imendes.com.br)
- **Documentação API**: [Manual API Imendes](https://imendes.com.br/documentacao)

### 🐛 Reportar Bugs

Ao reportar bugs, inclua:
1. Versão do Delphi
2. Versão do componente
3. Código que reproduz o problema
4. Mensagem de erro completa
5. Ambiente (Homologação/Produção)

### 💡 Sugestões

Sugestões de melhorias são bem-vindas! Abra uma issue com a tag `enhancement`.

---

## 📝 Changelog

### v2.23.1.0 (14/11/2025)

#### ✨ Novidades
- ✅ Suporte completo à API v2.23.1.0
- ✅ 50+ novos campos adicionados
- ✅ CBS - Contribuição sobre Bens e Serviços
- ✅ IBS - Imposto sobre Bens e Serviços
- ✅ ISS - Imposto sobre Serviços
- ✅ TRetornoCabecalho - Classe para metadados da API
- ✅ Demo modernizado com PageControl
- ✅ Tema escuro no demo

#### 🔧 Melhorias
- ✅ Campos PIS/COFINS expandidos (5 novos)
- ✅ Campos IPI expandidos (3 novos)
- ✅ Campos REGRA expandidos (15+ novos)
- ✅ Tratamento de campos opcionais aprimorado
- ✅ Documentação completa criada

#### 🐛 Correções
- ✅ Correção de syntax TryGetValue
- ✅ Remoção de métodos deprecated (.get())
- ✅ 0 warnings de compilação

Veja [CHANGELOG_ATUALIZACAO.md](CHANGELOG_ATUALIZACAO.md) para detalhes completos.

---

## 📄 Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

---

## 🙏 Agradecimentos

- **Imendes** - Pela excelente API de consulta tributária
- **Comunidade Delphi** - Pelo suporte e feedback
- **Contribuidores** - A todos que ajudaram a melhorar este componente

---

## 🚀 Roadmap

### Próximas Versões

- [ ] Suporte a cache de consultas
- [ ] Modo offline com banco local
- [ ] Exportação para Excel/CSV
- [ ] Integração com sistemas ERP
- [ ] Validação automática de NCM/CEST
- [ ] Calculadora de impostos
- [ ] Relatórios de consumo
- [ ] API REST wrapper

---

## ⭐ Star este projeto!

Se este componente foi útil para você, considere dar uma ⭐ no GitHub!

---

<div align="center">

**Desenvolvido com ❤️ por [Tiago Passarella DT](https://github.com/tiagopassarelladt)**

[![GitHub](https://img.shields.io/github/stars/tiagopassarelladt/DTImendes?style=social)](https://github.com/tiagopassarelladt/DTImendes)

</div>
