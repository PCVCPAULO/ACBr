{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emiss�o de Nota Fiscal}
{ eletr�nica - NFe - http://www.nfe.fazenda.gov.br                             }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       Andr� Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{$I ACBr.inc}
unit ACBrNFeDANFeRLPaisagem;

interface

uses
  SysUtils, Variants, Classes, Graphics,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QExtCtrls, Qt, QStdCtrls,
  {$ELSE}
    Controls, Forms, Dialogs, ExtCtrls,
  {$ENDIF}
  RLReport, RLFilters, RLPDFFilter, RLPrinters,
    {$IFDEF BORLAND}
  XMLIntf, XMLDoc,
    {$IF CompilerVersion > 22}
      Vcl.Imaging.jpeg,
    {$ELSE}
      jpeg,
    {$IFEND}
  {$ENDIF}
  ACBrNFeDANFeRL, pcnConversao, RLBarcode, DB;

type
  TfrlDANFeRLPaisagem = class(TfrlDANFeRL)
    rlbEmitente: TRLBand;
    rliEmitente: TRLDraw;
    rliNatOpe: TRLDraw;
    rliChave: TRLDraw;
    rliNatOpe1: TRLDraw;
    RLDraw9: TRLDraw;
    RLDraw10: TRLDraw;
    rllDANFE: TRLLabel;
    rllDocumento1: TRLLabel;
    rllDocumento2: TRLLabel;
    rllTipoEntrada: TRLLabel;
    rllTipoSaida: TRLLabel;
    rliTipoEntrada: TRLDraw;
    rllEntradaSaida: TRLLabel;
    rllNumNF1: TRLLabel;
    rllSERIE1: TRLLabel;
    rliChave2: TRLDraw;
    rliChave3: TRLDraw;
    rlbCodigoBarras: TRLBarcode;
    rlbCabecalhoItens: TRLBand;
    rlbDadosAdicionais: TRLBand;
    RLDraw50: TRLDraw;
    RLDraw51: TRLDraw;
    rllChaveAcesso: TRLLabel;
    rllDadosVariaveis1a: TRLLabel;
    rllDadosVariaveis1b: TRLLabel;
    rllDadosVariaveis3_Descricao: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel31: TRLLabel;
    RLLabel77: TRLLabel;
    RLLabel78: TRLLabel;
    rlmEmitente: TRLMemo;
    rlmEndereco: TRLMemo;
    rliLogo: TRLImage;
    rllNatOperacao: TRLLabel;
    rllDadosVariaveis3: TRLLabel;
    rllInscricaoEstadual: TRLLabel;
    rllInscrEstSubst: TRLLabel;
    rllCNPJ: TRLLabel;
    rlmDadosAdicionais: TRLMemo;
    rllChave: TRLLabel;
    rllEmitente: TRLLabel;
    rlbCodigoBarrasFS: TRLBarcode;
    rllXmotivo: TRLLabel;
    rlbDestinatario: TRLBand;
    RLLabel32: TRLLabel;
    rllDestNome: TRLLabel;
    RLLabel35: TRLLabel;
    rllDestEndereco: TRLLabel;
    RLLabel39: TRLLabel;
    rllDestCidade: TRLLabel;
    RLLabel40: TRLLabel;
    rllDestFone: TRLLabel;
    RLLabel36: TRLLabel;
    rllDestBairro: TRLLabel;
    RLLabel41: TRLLabel;
    rllDestUF: TRLLabel;
    RLLabel33: TRLLabel;
    rllDestCNPJ: TRLLabel;
    RLLabel37: TRLLabel;
    rllDestCEP: TRLLabel;
    RLLabel42: TRLLabel;
    rllDestIE: TRLLabel;
    RLLabel34: TRLLabel;
    rllEmissao: TRLLabel;
    RLLabel38: TRLLabel;
    rllSaida: TRLLabel;
    RLLabel43: TRLLabel;
    rllHoraSaida: TRLLabel;
    RLDraw16: TRLDraw;
    RLDraw17: TRLDraw;
    RLDraw22: TRLDraw;
    RLDraw23: TRLDraw;
    RLDraw20: TRLDraw;
    RLDraw19: TRLDraw;
    RLDraw24: TRLDraw;
    RLDraw21: TRLDraw;
    RLDraw18: TRLDraw;
    RLDraw15: TRLDraw;
    rlbFatura: TRLBand;
    rllFatNum1: TRLLabel;
    rllFatNum6: TRLLabel;
    rllFatNum11: TRLLabel;
    rllFatData1: TRLLabel;
    rllFatData6: TRLLabel;
    rllFatData11: TRLLabel;
    rllFatValor1: TRLLabel;
    rllFatValor6: TRLLabel;
    rllFatValor11: TRLLabel;
    rllFatNum2: TRLLabel;
    rllFatNum7: TRLLabel;
    rllFatNum12: TRLLabel;
    rllFatData2: TRLLabel;
    rllFatData7: TRLLabel;
    rllFatData12: TRLLabel;
    rllFatValor2: TRLLabel;
    rllFatValor7: TRLLabel;
    rllFatValor12: TRLLabel;
    rllFatNum3: TRLLabel;
    rllFatNum8: TRLLabel;
    rllFatNum13: TRLLabel;
    rllFatData3: TRLLabel;
    rllFatData8: TRLLabel;
    rllFatData13: TRLLabel;
    rllFatValor3: TRLLabel;
    rllFatValor8: TRLLabel;
    rllFatValor13: TRLLabel;
    rllFatNum4: TRLLabel;
    rllFatNum9: TRLLabel;
    rllFatNum14: TRLLabel;
    rllFatData4: TRLLabel;
    rllFatData9: TRLLabel;
    rllFatData14: TRLLabel;
    rllFatValor4: TRLLabel;
    rllFatValor9: TRLLabel;
    rllFatValor14: TRLLabel;
    rliFatura2: TRLDraw;
    rliFatura3: TRLDraw;
    rliFatura4: TRLDraw;
    rliFatura: TRLDraw;
    rlbImposto: TRLBand;
    rllTituloBaseICMS: TRLLabel;
    rllBaseICMS: TRLLabel;
    RLLabel49: TRLLabel;
    rllValorFrete: TRLLabel;
    rllTituloValorICMS: TRLLabel;
    rllValorICMS: TRLLabel;
    RLLabel50: TRLLabel;
    rllValorSeguro: TRLLabel;
    RLLabel51: TRLLabel;
    rllDescontos: TRLLabel;
    rllTituloBaseICMSST: TRLLabel;
    rllBaseICMSST: TRLLabel;
    RLLabel52: TRLLabel;
    rllAcessorias: TRLLabel;
    rllTituloValorICMSST: TRLLabel;
    rllValorICMSST: TRLLabel;
    RLLabel53: TRLLabel;
    rllValorIPI: TRLLabel;
    RLLabel48: TRLLabel;
    rllTotalProdutos: TRLLabel;
    RLLabel54: TRLLabel;
    rllTotalNF: TRLLabel;
    RLDraw30: TRLDraw;
    rliDivImposto1: TRLDraw;
    RLDraw33: TRLDraw;
    RLDraw34: TRLDraw;
    RLDraw35: TRLDraw;
    rliDivImposto2: TRLDraw;
    RLDraw29: TRLDraw;
    rlbTransp: TRLBand;
    RLLabel55: TRLLabel;
    rllTransNome: TRLLabel;
    RLLabel63: TRLLabel;
    rllTransEndereco: TRLLabel;
    RLLabel67: TRLLabel;
    rllTransQTDE: TRLLabel;
    RLLabel68: TRLLabel;
    rllTransEspecie: TRLLabel;
    RLLabel69: TRLLabel;
    rllTransMarca: TRLLabel;
    RLLabel56: TRLLabel;
    RLLabel64: TRLLabel;
    rllTransCidade: TRLLabel;
    RLLabel70: TRLLabel;
    rllTransNumeracao: TRLLabel;
    rllTransModFrete: TRLLabel;
    RLLabel59: TRLLabel;
    rllTransCodigoANTT: TRLLabel;
    RLLabel60: TRLLabel;
    rllTransPlaca: TRLLabel;
    RLLabel71: TRLLabel;
    rllTransPesoBruto: TRLLabel;
    RLLabel61: TRLLabel;
    rllTransUFPlaca: TRLLabel;
    RLLabel65: TRLLabel;
    rllTransUF: TRLLabel;
    RLLabel62: TRLLabel;
    rllTransCNPJ: TRLLabel;
    RLLabel66: TRLLabel;
    rllTransIE: TRLLabel;
    RLLabel72: TRLLabel;
    rllTransPesoLiq: TRLLabel;
    RLDraw38: TRLDraw;
    RLDraw39: TRLDraw;
    rliTransp1: TRLDraw;
    rliTransp2: TRLDraw;
    RLDraw41: TRLDraw;
    rliTransp4: TRLDraw;
    RLDraw47: TRLDraw;
    RLDraw48: TRLDraw;
    RLDraw49: TRLDraw;
    rliTransp5: TRLDraw;
    rliTransp: TRLDraw;
    RLLabel25: TRLLabel;
    rlbItens: TRLBand;
    rlbISSQN: TRLBand;
    RLLabel73: TRLLabel;
    RLLabel74: TRLLabel;
    RLLabel75: TRLLabel;
    RLLabel76: TRLLabel;
    RLDraw56: TRLDraw;
    RLDraw57: TRLDraw;
    RLDraw58: TRLDraw;
    RLDraw52: TRLDraw;
    rliMarcaDagua1: TRLImage;
    rllPageNumber: TRLSystemInfo;
    rllLastPage: TRLSystemInfo;
    rlbAvisoContingencia: TRLBand;
    rllAvisoContingencia: TRLLabel;
    rlbContinuacaoInformacoesComplementares: TRLBand;
    RLLabel16: TRLLabel;
    rlmContinuacaoDadosAdicionais: TRLMemo;
    rllHomologacao: TRLLabel;
    LinhaDCSuperior: TRLDraw;
    LinhaDCInferior: TRLDraw;
    LinhaDCEsquerda: TRLDraw;
    LinhaDCDireita: TRLDraw;
    rllCabFatura1: TRLLabel;
    rllCabFatura2: TRLLabel;
    rllCabFatura3: TRLLabel;
    RLDraw69: TRLDraw;
    rllISSQNValorServicos: TRLLabel;
    rllISSQNBaseCalculo: TRLLabel;
    rllISSQNValorISSQN: TRLLabel;
    rllISSQNInscricao: TRLLabel;
    LinhaFimItens: TRLDraw;
    RLDraw70: TRLDraw;
    rliTransp3: TRLDraw;
    rllUsuario: TRLLabel;
    rllSistema: TRLLabel;
    rllCabFatura4: TRLLabel;
    rllCabFatura5: TRLLabel;
    rllCabFatura6: TRLLabel;
    rllCabFatura7: TRLLabel;
    rllCabFatura8: TRLLabel;
    rllCabFatura9: TRLLabel;
    rllCabFatura10: TRLLabel;
    rllCabFatura11: TRLLabel;
    rllCabFatura12: TRLLabel;
    rllContingencia: TRLLabel;
    RLAngleLabel1: TRLAngleLabel;
    RLAngleLabel2: TRLAngleLabel;
    RLDraw13: TRLDraw;
    rliFatura1: TRLDraw;
    rllFatura: TRLAngleLabel;
    rliFatura5: TRLDraw;
    rllFatNum5: TRLLabel;
    rllFatNum10: TRLLabel;
    rllFatNum15: TRLLabel;
    rllFatData15: TRLLabel;
    rllFatData10: TRLLabel;
    rllFatData5: TRLLabel;
    rllFatValor5: TRLLabel;
    rllFatValor10: TRLLabel;
    rllFatValor15: TRLLabel;
    rllCabFatura13: TRLLabel;
    rllCabFatura14: TRLLabel;
    rllCabFatura15: TRLLabel;
    rliDivImposto0: TRLDraw;
    RLAngleLabel4: TRLAngleLabel;
    RLAngleLabel5: TRLAngleLabel;
    rliTransp6: TRLDraw;
    RLAngleLabel6: TRLAngleLabel;
    RLAngleLabel7: TRLAngleLabel;
    RLDraw3: TRLDraw;
    RLAngleLabel8: TRLAngleLabel;
    RLDraw5: TRLDraw;
    RLAngleLabel9: TRLAngleLabel;
    rlmDadosAdicionaisAuxiliar: TRLMemo;
    pnlCanhoto: TRLPanel;
    rliCanhoto: TRLDraw;
    rliCanhoto3: TRLDraw;
    rliCanhoto1: TRLDraw;
    rliCanhoto2: TRLDraw;
    rllNFe: TRLAngleLabel;
    rllNumNF0: TRLAngleLabel;
    rllSERIE0: TRLAngleLabel;
    rllIdentificacao: TRLAngleLabel;
    rllDataRecebimento: TRLAngleLabel;
    rllRecebemosDe: TRLAngleLabel;
    rllResumo: TRLAngleLabel;
    pnlDivisao: TRLPanel;
    rliDivisao: TRLDraw;
    pnlCabecalho1: TRLPanel;
    lblDadosDoProduto: TRLLabel;
    rlmCodProd: TRLMemo;
    rlsDivProd1: TRLDraw;
    rlmDescricaoProduto: TRLMemo;
    rllCinza1: TRLLabel;
    rlsRectProdutos1: TRLDraw;
    RLDraw4: TRLDraw;
    pnlDescricao1: TRLPanel;
    txtCodigo: TRLDBText;
    LinhaProd2: TRLDraw;
    LinhaProd1: TRLDraw;
    pnlCabecalho2: TRLPanel;
    rlsRectProdutos2: TRLDraw;
    rllCinza2: TRLLabel;
    rlsDivProd3: TRLDraw;
    rlsDivProd4: TRLDraw;
    rlsDivProd5: TRLDraw;
    rlsDivProd6: TRLDraw;
    rlsDivProd7: TRLDraw;
    rlsDivProd8: TRLDraw;
    RLDraw1: TRLDraw;
    rlsDivProd9: TRLDraw;
    rlsDivProd10: TRLDraw;
    rlsDivProd11: TRLDraw;
    rlsDivProd12: TRLDraw;
    RLLabel82: TRLLabel;
    lblCST: TRLLabel;
    RLLabel84: TRLLabel;
    RLLabel85: TRLLabel;
    RLLabel91: TRLLabel;
    RLLabel87: TRLLabel;
    RLLabel88: TRLLabel;
    lblValorTotal: TRLLabel;
    lblPercValorDesc: TRLLabel;
    lblPercValorDesc1: TRLLabel;
    RLLabel89: TRLLabel;
    RLLabel90: TRLLabel;
    RLLabel92: TRLLabel;
    RLLabel93: TRLLabel;
    RLLabel94: TRLLabel;
    RLLabel95: TRLLabel;
    RLLabel96: TRLLabel;
    RLLabel97: TRLLabel;
    RLLabel98: TRLLabel;
    RLDraw54: TRLDraw;
    rlsDivProd13: TRLDraw;
    pnlDescricao2: TRLPanel;
    txtNCM: TRLDBText;
    txtCST: TRLDBText;
    txtCFOP: TRLDBText;
    txtUnidade: TRLDBText;
    txtQuantidade: TRLDBText;
    txtValorUnitario: TRLDBText;
    txtValorTotal: TRLDBText;
    txtValorDesconto: TRLDBText;
    txtBaseICMS: TRLDBText;
    txtValorICMS: TRLDBText;
    txtValorIPI: TRLDBText;
    txtAliqICMS: TRLDBText;
    txtAliqIPI: TRLDBText;
    LinhaProd4: TRLDraw;
    LinhaProd5: TRLDraw;
    LinhaProd6: TRLDraw;
    LinhaProd7: TRLDraw;
    LinhaProd8: TRLDraw;
    LinhaProd9: TRLDraw;
    LinhaProd10: TRLDraw;
    LinhaProd11: TRLDraw;
    LinhaProd12: TRLDraw;
    LinhaProd13: TRLDraw;
    LinhaProd14: TRLDraw;
    LinhaProd15: TRLDraw;
    LinhaProd16: TRLDraw;
    LinhaProd3: TRLDraw;
    rlmDescricao: TRLDBMemo;
    rlbObsItem: TRLBand;
    LinhaFimObsItem: TRLDraw;
    LinhaInicioItem: TRLDraw;
    LinhaObsItemEsquerda: TRLDraw;
    LinhaObsItemDireita: TRLDraw;
    rlmObsItem: TRLMemo;
    RLDraw2: TRLDraw;
    rllEAN: TRLLabel;
    txtEAN: TRLDBText;
    LinhaProdEAN: TRLDraw;
    rlsDivProdEAN: TRLDraw;
    RLLabel12: TRLLabel;
    rlsDivProd14: TRLDraw;
    LinhaProd17: TRLDraw;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    txtBaseICMSST: TRLDBText;
    rlsDivProd15: TRLDraw;
    LinhaProd18: TRLDraw;
    txtValorICMSST: TRLDBText;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLDraw6: TRLDraw;
    rliDivImposto3: TRLDraw;
    rliDivImposto4: TRLDraw;
    rliDivImposto5: TRLDraw;
    RLDraw12: TRLDraw;
    rllTituloTotalTributos: TRLLabel;
    rllTotalTributos: TRLLabel;
    RLBFaturaReal: TRLBand;
    RLDraw8: TRLDraw;
    RLDraw27: TRLDraw;
    RLAngleLabel3: TRLAngleLabel;
    RLLabel5: TRLLabel;
    RLLabelLIQ: TRLLabel;
    RLLabelDupl: TRLLabel;
    RLLabelValor: TRLLabel;
    RLLabelNUmero: TRLLabel;
    RLLabelPag: TRLLabel;
    RlbDadoPagamento: TRLLabel;
    RlbDadoNumero: TRLLabel;
    RlbDadoValorOriginal: TRLLabel;
    RlbDadoValorDesconto: TRLLabel;
    RlbDadoValorLiquido: TRLLabel;
    RLDrawFaturareal: TRLDraw;
    rlbCancelada: TRLBand;
    RLLCancelada: TRLLabel;
    RLLabel6: TRLLabel;
    procedure RLNFeBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rlbEmitenteBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbItensAfterPrint(Sender: TObject);
    procedure rlbDadosAdicionaisBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbItensBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rlbDadosAdicionaisAfterPrint(Sender: TObject);
    procedure rlbObsItemBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure pnlDescricao1AfterPrint(Sender: TObject);
    procedure rlbCabecalhoItensBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    FRecebemoDe   : string;
    sQuebraLinha  : String;
    procedure InitDados;
    procedure Header;
    procedure Emitente;
    procedure Destinatario;
    Function EnderecoRetirada : String;
    Function EnderecoEntrega : String;
    procedure Imposto;
    procedure Transporte;
    procedure DadosAdicionais;
    procedure Observacoes;
    procedure Itens;
    procedure ISSQN;
    procedure AddFatura;
    procedure ConfigureDataSource;
    function ManterArma(inItem: integer): String;
    function ManterCombustivel(inItem: integer): String;
    function ManterMedicamentos(inItem: integer) : String;
    function ManterVeiculos(inItem: integer): String;
    function ManterXpod(sXProd: String; inItem: Integer): String;
    procedure AddFaturaReal;
    function ManterDuplicatas: Integer;
    procedure AplicaParametros;
  public

  end;

implementation

uses DateUtils, StrUtils,
  pcnNFe, pcnConversaoNFe,
  ACBrNFeDANFeRLClass, ACBrDFeUtil, ACBrValidador, ACBrUtil, ACBrNFe;

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

procedure TfrlDANFeRLPaisagem.RLNFeBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  q := 0;
  with RLNFe.Margins do
  begin
    TopMargin     := FMargemSuperior * 10;
    BottomMargin  := FMargemInferior * 10;
    LeftMargin    := FMargemEsquerda * 10;
    RightMargin   := FMargemDireita * 10;
  end;

  ConfigureDataSource;
  InitDados;

  RLNFe.Title       := Copy (FNFe.InfNFe.Id, 4, 44);

  if FNumCopias > 0 then
    RLPrinters.RLPrinter.Copies := FNumCopias
  else
    RLPrinters.RLPrinter.Copies := 1;
end;

procedure TfrlDANFeRLPaisagem.rlbEmitenteBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  iItemAtual := 0;

  rlbCodigoBarras.BringToFront;
  if RLNFe.PageNumber > 1 then
    begin
      rlbISSQN.Visible := False;
      rlbDadosAdicionais.Visible := False;

      if iQuantItens > q then
        begin
          rlbCabecalhoItens.Visible := True;
          lblDadosDoProduto.Caption := ACBrStr('CONTINUA��O DOS DADOS DO PRODUTO / SERVI�OS');
          rliMarcaDagua1.Top := 300;
        end
      else
        rlbCabecalhoItens.Visible := False;

    end;
end;

procedure TfrlDANFeRLPaisagem.InitDados;
var i, j, b, h, iAlturaCanhoto,vWidthAux, vLeftAux: Integer;
  LogoStream: TStringStream;
  vAutoSizeAux : Boolean;
begin
  // Carrega logomarca
  if (FLogo <> '') then
  begin
    if FileExists (FLogo) then
     rliLogo.Picture.LoadFromFile(FLogo)
    else
    begin
      LogoStream := TStringStream.Create(FLogo);
      try
         rliLogo.Picture.Bitmap.LoadFromStream(LogoStream);
      finally
         LogoStream.Free;
      end;
    end;
  end;


  if (FMarcaDagua <> '') and FileExists(FMarcaDagua) then
  begin
    rliMarcaDagua1.Picture.LoadFromFile(FMarcaDagua);
  end;

  // Exibe o resumo da NF-e no canhoto
  if FResumoCanhoto = True then
    begin
      if FResumoCanhoto_Texto <> '' then
        rllResumo.Caption := FResumoCanhoto_Texto
      else
        begin
          rllResumo.Caption := ACBrStr('EMISS�O: ') +
                           FormatDateTime('DD/MM/YYYY', FNFe.Ide.dEmi) +
                           '  -  ' +
                           'DEST. / REM.: ' + FNFe.Dest.xNome + '  -  ' +
                           'VALOR TOTAL: R$ ' +
                           FormatFloatBr(FNFe.Total.ICMSTot.vNF,
                           '###,###,###,##0.00');
        end; // if FResumoCanhoto_Texto <> ''
      rllResumo.Visible := True;
      iAlturaCanhoto := 25;
    end
  else
    begin
      rllResumo.Visible := False;
      iAlturaCanhoto := 15;
    end;

  rliCanhoto1.Left := iAlturaCanhoto;
  rliCanhoto2.Left := rliCanhoto1.Left;
  rliCanhoto2.Width := (rliCanhoto.Left + rliCanhoto.Width) - rliCanhoto2.Left;
  rllDataRecebimento.Left := rliCanhoto1.Left + 3;
  rllIdentificacao.Left := rliCanhoto1.Left + 3;

  // Exibe o desenvolvedor do sistema
  if FSsitema <> '' then
    begin
      rllSistema.Caption := FSsitema;
      rllSistema.Visible := True;
    end
  else
    rllSistema.Visible := False;

  // Exibe o nome do usu�rio
  if FUsuario <> '' then
    begin
      rllUsuario.Caption := ACBrStr('DATA / HORA DA IMPRESS�O: ') + DateTimeToStr(Now) + ' - ' + FUsuario;
      rllUsuario.Visible := True;
    end
  else
    rllUsuario.Visible := False;

  // Exibe a informa��o de Ambiente de Homologa��o
  if FNFe.Ide.tpAmb = taHomologacao then
    begin
      rllHomologacao.Caption := ACBrStr('AMBIENTE DE HOMOLOGA��O - NF-E SEM VALOR FISCAL');
      rllHomologacao.Visible := True;
    end
  else
    begin
      rllHomologacao.Caption := '';
      rllHomologacao.Visible := False;
    end;
  // Exibe a informa��o correta no label da chave de acesso
  if FNFeCancelada then
  begin
    rllXmotivo.Caption := 'NF-e CANCELADA';
    rllDadosVariaveis3_Descricao.Caption  := ACBrStr('PROTOCOLO DE HOMOLOGA��O DE CANCELAMENTO');
    rlbCodigoBarras.Visible               := False;
    rllXmotivo.Visible                    := True;
    rllDadosVariaveis3_Descricao.Visible  := True;
    rlbCancelada.Visible                  := True;
    RLLCancelada.Caption                  := 'NF-e CANCELADA';
  end
  else
  begin
    if FNFe.procNFe.cStat > 0 then
    begin
      rlbCodigoBarras.Visible := False;
      rllXmotivo.Visible := True;
      rllDadosVariaveis3_Descricao.Visible := True;
      case FNFe.procNFe.cStat of
        100 : begin
                rlbCodigoBarras.Visible := True;
                rllXMotivo.Visible := False;
                rllDadosVariaveis3_Descricao.Caption := ACBrStr('PROTOCOLO DE AUTORIZA��O DE USO');
              end;
        101,
        135,
        151,
        155:  begin
                rllXmotivo.Caption := 'NF-e CANCELADA';
                rllDadosVariaveis3_Descricao.Caption := ACBrStr('PROTOCOLO DE HOMOLOGA��O DE CANCELAMENTO');
              end;
        110,
        205,
        301,
        302: begin
              rllXmotivo.Caption := 'NF-e DENEGADA';
              rllDadosVariaveis3_Descricao.Caption := ACBrStr('PROTOCOLO DE DENEGA��O DE USO');
            end;
        else
            begin
              rllXmotivo.Caption := FNFe.procNFe.xMotivo;
              rllDadosVariaveis3_Descricao.Visible := False;
              rllDadosVariaveis3.Visible := False;
            end;
      end;
    end
    else
    begin
      if (FNFe.Ide.tpEmis in [teNormal, teSCAN]) then
      begin
        rlbCodigoBarras.Visible := False;
        rllXmotivo.Caption := ACBrStr('NF-E N�O ENVIADA PARA SEFAZ');
        rllXMotivo.Visible := True;
        rllDadosVariaveis3_Descricao.Visible := False;
        rllDadosVariaveis3.Visible := False;
      end;
    end;
  end;

  // Ajusta a largura da coluna "C�digo do Produto"
  txtCodigo.Width := FLarguraCodProd;
  rlmCodProd.Width := FLarguraCodProd;
  rlsDivProd1.Left := FLarguraCodProd + 2;
  LinhaProd2.Left :=  FLarguraCodProd + 2;

  if FExibirEAN = False then
    begin
      rllEAN.Visible := False;
      txtEAN.Visible := False;
      rlsDivProdEAN.Visible := False;
      LinhaProdEAN.Visible := False;
      rlmDescricaoProduto.Left := rlsDivProd1.Left + 2;
      rlmDescricaoProduto.Width := ((rlsRectProdutos1.Left + rlsRectProdutos1.Width) - rlsDivProd1.Left) - 3;
      rlmDescricao.Left := LinhaProd2.Left + 2;
      rlmDescricao.Width := (pnlDescricao1.Width - LinhaProd2.Left) - 24;
    end
  else
    begin
      rllEAN.Visible := True;
      txtEAN.Visible := True;
      rlsDivProdEAN.Visible := True;
      LinhaProdEAN.Visible := True;
      rllEAN.Left := rlsDivProd1.Left + 2;
      txtEAN.Left := LinhaProd2.Left + 2;
      rlsDivProdEAN.Left := (rllEAN.Left + rllEAN.Width) + 2;
      LinhaProdEAN.Left := (txtEAN.Left + txtEAN.Width) + 2;
      rlmDescricaoProduto.Left := (rlsDivProdEAN.Left) + 2;
      rlmDescricaoProduto.Width := ((rlsRectProdutos1.Left + rlsRectProdutos1.Width) - (rlsDivProdEAN.Left)) - 3;
      rlmDescricao.Left := LinhaProdEAN.Left + 2;
      rlmDescricao.Width := (pnlDescricao1.Width - LinhaProdEAN.Left) - 24;
    end;

  rlmDescricaoProduto.Lines.BeginUpdate;
  rlmDescricaoProduto.Lines.Clear;
  rlmCodProd.Lines.BeginUpdate;
  rlmCodProd.Lines.Clear;

  // ajusta a posi��o do 'c�digo do produto'
  if rlmCodProd.Width > 90 then
    begin
      rlmCodProd.Top := 13;
      rlmCodProd.Height := 7;
    end
  else
    begin
      rlmCodProd.Top := 9;
      rlmCodProd.Height := 14;
    end;

  // Se a largura da coluna 'C�digo do produto' for suficiente,
  // exibe o t�tulo da coluna sem abrevia��es
  if rlmCodProd.Width > 113 then
    rlmCodProd.Lines.Add(ACBrStr('C�DIGO DO PRODUTO / SERVI�O') )
  else
    rlmCodProd.Lines.Add(ACBrStr('C�DIGO DO PROD. / SERV.'));

  // Ajusta a posi��o da coluna 'Descri��o do produto'
  if rlmDescricaoProduto.Width > 128 then
    begin
      rlmDescricaoProduto.Top := 13;
      rlmDescricaoProduto.Height := 7;
    end
  else
    begin
      rlmDescricaoProduto.Top := 9;
      rlmDescricaoProduto.Height := 14;
    end;

  // Se a largura da coluna 'Descri��o do produto' for suficiente,
  // exibe o t�tulo da coluna sem abrevia��es
  if rlmDescricaoProduto.Width > 72 then
    rlmDescricaoProduto.Lines.Add(ACBrStr('DESCRI��O DO PRODUTO / SERVI�O'))
  else
    rlmDescricaoProduto.Lines.Add('DESCR. PROD. / SERV.');

  rlmCodProd.Lines.EndUpdate;
  rlmDescricaoProduto.Lines.EndUpdate;

  case FNomeFonte of
    nfTimesNewRoman,
    nfArial: rlbItens.Height:= 11;
    nfCourierNew: rlbItens.Height:= 10;
  end;
  txtCodigo.Top        := 0;
  txtEAN.Top           := txtCodigo.Top;
  rlmDescricao.Top     := txtCodigo.Top;
  txtNCM.Top           := txtCodigo.Top;
  txtCST.Top           := txtCodigo.Top;
  txtCFOP.Top          := txtCodigo.Top;
  txtUnidade.Top       := txtCodigo.Top;
  txtQuantidade.Top    := txtCodigo.Top;
  txtValorUnitario.Top := txtCodigo.Top;
  txtValorTotal.Top    := txtCodigo.Top;
  txtValorDesconto.Top := txtCodigo.Top;
  txtBaseICMS.Top      := txtCodigo.Top;
  txtValorICMS.Top     := txtCodigo.Top;
  txtBaseICMSST.Top    := txtCodigo.Top;
  txtValorICMSST.Top   := txtCodigo.Top;
  txtValorIPI.Top      := txtCodigo.Top;
  txtAliqICMS.Top      := txtCodigo.Top;
  txtAliqIPI.Top       := txtCodigo.Top;

  // Posiciona o canhoto do DANFE no cabe�alho ou rodap�
  case FPosCanhoto of
    pcCabecalho:
      begin
        pnlCanhoto.Align := faLeftMost;
        pnlDivisao.Align := faLeftMost;
        pnlCanhoto.Left := 26;
        pnlDivisao.Left := pnlCanhoto.Left + pnlCanhoto.Width;
      end;
    pcRodape:
      begin
        pnlCanhoto.Align := faRightMost;
        pnlDivisao.Align := faRightMost;
        pnlDivisao.Left := 1024;
        pnlCanhoto.Left := pnlDivisao.Left + pnlDivisao.Width;
      end;
  end;

  // Posiciona a Marca D'�gua
  rliMarcaDagua1.Left := rlbItens.Left + (rlbItens.Width div 2) -
                                                  (rliMarcaDagua1.Width div 2);


  // Oculta alguns itens do DANFE
  if FFormularioContinuo = True then
    begin
      rllRecebemosDe.Visible := False;
      rllResumo.Visible := False;
      rllDataRecebimento.Visible := False;
      rllIdentificacao.Visible := False;
      rllNFe.Visible := False;
      rliCanhoto.Visible := False;
      rliCanhoto1.Visible := False;
      rliCanhoto2.Visible := False;
      rliCanhoto3.Visible := False;
      rliDivisao.Visible := False;
      rliTipoEntrada.Visible := False;
      rllDANFE.Visible := False;
      rllDocumento1.Visible := False;
      rllDocumento2.Visible := False;
      rllTipoEntrada.Visible := False;
      rllTipoSaida.Visible := False;
      rllEmitente.Visible := False;
      rliLogo.Visible := False;
      rlmEmitente.Visible := False;
      rlmEndereco.Visible := False;
      rliEmitente.Visible := False;
      rllChaveAcesso.Visible := False;
      rliChave.Visible := False;
      rliChave2.Visible := False;
      rliChave3.Visible := False;
    end;

  // Expande a logomarca
  if FExpandirLogoMarca = True then
    begin
      rlmEmitente.Visible := False;
      rlmEndereco.Visible := False;
      with rliLogo do
        begin
          Width := 450;
          Scaled := False;
          Stretch := True;
        end;
    end;

  // Altera a fonte da Raz�o Social do Emitente
  rlmEmitente.Font.Size := FTamanhoFonte_RazaoSocial;

  for b := 0 to (RLNFe.ControlCount - 1) do
    for i := 0 to ((TRLBand(RLNFe.Controls[b]).ControlCount) - 1) do
    begin
      //Altera o tamanho da fonte dos demais campos
      if TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Tag in [3,70] then
      begin
        TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Style := [];
        if FNegrito then// Dados em negrito
          TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Style := [fsBold];
        if Owner <> nil then
          TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Size :=
            TACBrNFeDANFeRL(Owner).TamanhoFonte_DemaisCampos + 1;
      end;

      // Altera a fonde do DANFE
      case FNomeFonte of
        nfArial:
          begin
            for j := 0 to ((TRLPanel(TRLBand(RLNFe.Controls[b]).Controls[i]).ControlCount) - 1) do
              TRLLabel(TRLPanel(TRLBand(RLNFe.Controls[b]).Controls[i]).Controls[j]).Font.Name :=
                                                                      'Arial';
            if TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Tag <> 20 then
              TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Name :=
                                                                      'Arial';
            if TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Tag = 3 then
              TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Size :=
                (TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Size) - 1;
          end;
        nfCourierNew:
          begin
            for j := 0 to ((TRLPanel(TRLBand(RLNFe.Controls[b]).Controls[i]).ControlCount) - 1) do
            begin
              TRLLabel(TRLPanel(TRLBand(RLNFe.Controls[b]).Controls[i]).Controls[j]).Font.Name :=
                                                                                 'Courier New';
              if TRLLabel(TRLPanel(TRLBand(RLNFe.Controls[b]).Controls[i]).Controls[j]).Tag = 0 then
                TRLLabel(TRLPanel(TRLBand(RLNFe.Controls[b]).Controls[i]).Controls[j]).Font.Size :=
                  (TRLLabel(TRLPanel(TRLBand(RLNFe.Controls[b]).Controls[i]).Controls[j]).Font.Size - 1);

            end;
            TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Name :=
                                                              'Courier New';
            if (TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Tag = 0) or
               (TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Tag = 3) then
              TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Size :=
                (TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Size) - 1;
            if TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Tag = 40 then
              TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Top :=
                (TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Top) - 1;
          end;
        nfTimesNewRoman:
          begin
            for j := 0 to ((TRLPanel(TRLBand(RLNFe.Controls[b]).Controls[i]).ControlCount) - 1) do
              TRLLabel(TRLPanel(TRLBand(RLNFe.Controls[b]).Controls[i]).Controls[j]).Font.Name :=
                                                                'Times New Roman';
              if TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Tag <> 20 then
                TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Name :=
                                                                'Times New Roman';
              if TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Tag = 3 then
                TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Size :=
                  (TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Font.Size) - 1;
          end;
      end;
      //copia o left e width do componente, alterar o size do fonte, com o autosize ajusta o height, depois retorna como estava
      if TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Tag in [3,70] then
      begin
        vWidthAux := TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Width;
        vLeftAux  := TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Left;
        vAutoSizeAux := TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).AutoSize;
        TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).AutoSize := True;
        TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).AutoSize := vAutoSizeAux;
        TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Left  := vLeftAux;
        if TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Alignment = taLeftJustify then
           vWidthAux := vWidthAux - vAuxDiferencaPDF;//na hora de gerar o PDF vai ficar correto.
        TRLLabel((TRLBand(RLNFe.Controls[b])).Controls[i]).Width := vWidthAux;
      end;
    end;
  if FNomeFonte = nfCourierNew then
  begin
    rllNumNF1.Font.Size := rllNumNF1.Font.Size -2;
    rllNumNF1.Top := rllNumNF1.Top + 1;
  end;

  if TACBrNFeDANFeRL(Owner).TamanhoFonteEndereco > 0 then
    RLMEndereco.Font.Size:= TACBrNFeDANFeRL(Owner).TamanhoFonteEndereco;

  AplicaParametros; // Aplica os par�metros escolhidos

  DadosAdicionais;
  Header;
  Emitente;
  Destinatario;
  Imposto;
  Itens;
  ISSQN;
  Transporte;
  AddFaturaReal;
  AddFatura;
  Observacoes;

  // Verifica se ser� exibida a 'continua��o das informa��es complementares'
  if rlmDadosAdicionaisAuxiliar.Lines.Count > iLimiteLinhas then
    begin
      rlbContinuacaoInformacoesComplementares.Visible := True;
      h := (rlmContinuacaoDadosAdicionais.Top +
            rlmContinuacaoDadosAdicionais.Height) + 2;
      LinhaDCInferior.Top := h;
      h := (h - LinhaDCSuperior.Top) + 1;
      LinhaDCEsquerda.Height := h;
      LinhaDCDireita.Height := h;
    end
  else
    rlbContinuacaoInformacoesComplementares.Visible := False;

  iQuantItens := FNFe.Det.Count;
end;

procedure TfrlDANFeRLPaisagem.Header;
var sChaveContingencia: String;
begin
  with FNFe.InfNFe, FNFe.Ide do
  begin
    rllChave.Caption        := FormatarChaveAcesso(OnlyNumber(FNFe.InfNFe.Id));
    rllChave.AutoSize       := True;

    while rliChave.Width <  (rllChave.Width + 10 + (rllChave.Left - rliChave.Left)) do
      rllChave.Font.Size    := rllChave.Font.Size -1;//para nao truncar a chave vai diminuir o fonte

    rlbCodigoBarras.Caption := OnlyNumber(FNFe.InfNFe.Id);
    rllNumNF0.Caption       := ACBrStr('N� ') + FormatFloat('000,000,000', nNF);
    rllNumNF1.Caption       := rllNumNF0.Caption;
    rllSERIE0.Caption       := ACBrStr('S�RIE ') + IntToStr(Serie);
    rllSERIE1.Caption       := rllSERIE0.Caption;
    rllNatOperacao.Caption  := NatOp;
    rllEntradaSaida.Caption := tpNFToStr( tpNF );
    rllEmissao.Caption      := FormatDateBr(dEmi);
    rllSaida.Caption        := IfThen(DSaiEnt <> 0, FormatDateBr(dSaiEnt));

    if versao = 2.00 then
      rllHoraSaida.Caption  := ifthen(hSaiEnt = 0, '', TimeToStr(hSaiEnt))
    else
      rllHoraSaida.Caption  := ifthen(TimeOf(dSaiEnt)=0, '', TimeToStr(dSaiEnt));

    // Configura��o inicial
    rllDadosVariaveis3_Descricao.Caption:= ACBrStr( 'PROTOCOLO DE AUTORIZA��O DE USO');
    rlbCodigoBarras.Visible       := True;
    rlbCodigoBarrasFS.Visible     := False;
    rllAvisoContingencia.Visible  := True;
    rlbAvisoContingencia.Visible  := True;
    rllAvisoContingencia.Caption  := ACBrStr( 'DANFE em Conting�ncia - Impresso em decorr�ncia de problemas t�cnicos');

    rllDadosVariaveis1a.Visible   := False;
    rllDadosVariaveis1b.Visible   := False;

    case FNFe.Ide.tpEmis of
      teNormal,
      teSCAN,
      teSVCAN,
      teSVCRS,
      teSVCSP         : begin
                          rllAvisoContingencia.Visible        := False;
                          rlbAvisoContingencia.Visible        := False;

                          rllDadosVariaveis1a.Visible         := ( FNFe.procNFe.cStat > 0 );
                          rllDadosVariaveis1b.Visible         := rllDadosVariaveis1a.Visible;

                          if FProtocoloNFe <> '' then
                            rllDadosVariaveis3.Caption        := FProtocoloNFe
                          else
                            rllDadosVariaveis3.Caption        := FNFe.procNFe.nProt + ' ' +
                                                                  DateTimeToStr(FNFe.procNFe.dhRecbto);
                        end;
      teContingencia,
      teFSDA          : begin
                          sChaveContingencia                  := TACBrNFe(TACBrNFeDANFeRL(Owner).ACBrNFe).GerarChaveContingencia(FNFe);
                          rlbCodigoBarrasFS.Caption           := sChaveContingencia;
                          rlbCodigoBarrasFS.Visible           := True;

                          rllDadosVariaveis3_Descricao.Caption:= 'DADOS DA NF-E';
                          rllDadosVariaveis3.Caption          := FormatarChaveAcesso(sChaveContingencia);

                          if (dhCont > 0) and (xJust > '') then
                            rllContingencia.Caption           := ACBrStr( 'Data / Hora da entrada em conting�ncia: ') +
                                                                          FormatDateTime('dd/mm/yyyy hh:nn:ss', dhCont) +
                                                                          ' Motivo conting�ncia: ' + xJust;
                        end;

      teDPEC          : begin
                          rllDadosVariaveis1a.Visible         := True;
                          rllDadosVariaveis1b.Visible         := True;

                          if NaoEstaVazio(FNFe.procNFe.nProt) then // DPEC TRANSMITIDO
                            rllDadosVariaveis3.Caption        := FNFe.procNFe.nProt + ' ' +
                                                                  IfThen(FNFe.procNFe.dhRecbto <> 0,
                                                                  DateTimeToStr(FNFe.procNFe.dhRecbto), '')
                          else
                          begin
                            rllDadosVariaveis3_Descricao.Caption:= ACBrStr( 'N�MERO DE REGISTRO DO EPEC');
                            if NaoEstaVazio( FProtocoloNFe) then
                              rllDadosVariaveis3.Caption        := FProtocoloNFe
                          end;

                          if (dhCont > 0) and (xJust > '') then
                            rllContingencia.Caption             := ACBrStr( 'Data / Hora da entrada em conting�ncia: ') +
                                                                            FormatDateTime('dd/mm/yyyy hh:nn:ss', dhCont) +
                                                                            ' Motivo conting�ncia: ' + xJust;
                        end;

    end;
  end;
  if rlbCodigoBarras.Visible then
    rllChave.Holder := rlbCodigoBarras;

end;

procedure TfrlDANFeRLPaisagem.Emitente;
var
  vWidthAux, vLeftAux : integer;
  sTemp : String;
begin
  //emit
  with FNFe.Emit do
  begin
    if FRecebemoDe = '' then
      FRecebemoDe := rllRecebemosDe.Caption;

    rllRecebemosDe.Caption        := Format (FRecebemoDe, [ XNome ]);
    rllInscricaoEstadual.Caption  := IE;
    rllInscrEstSubst.caption      := IEST;
    rllCNPJ.Caption               := FormatarCNPJouCPF(CNPJCPF );
    rlmEmitente.Lines.Text        := TACBrNFeDANFeRL(Owner).ManterNomeImpresso( XNome , XFant );
    vWidthAux                     := rlmEmitente.Width;
    vLeftAux                      := rlmEmitente.Left;
    rlmEmitente.AutoSize          := True;
    rlmEmitente.AutoSize          := False;
    rlmEmitente.Left              := vLeftAux;
    rlmEmitente.Width             := vWidthAux;
    rlmEndereco.Top               := rlmEmitente.Top + rlmEmitente.Height;
    rlmEndereco.Lines.Clear;
    with EnderEmit do
    begin
      sTemp :=  Trim( XLgr ) +
                IfThen(Nro = '0', '', ', ' + Nro) + ' ' +
                IfThen( xCpl > '' , Trim( XCpl ) , '') +
                ' - ' + Trim( XBairro );

      sTemp := sTemp + ' CEP:' + FormatarCEP(Poem_Zeros(CEP, 8)) + ' - ' + XMun + ' - ' + UF;
      rlmEndereco.Lines.add(sTemp );
      sTemp := 'TEL: ' + FormatarFone(Fone) + IfThen( FFax <> ''  ,  ' - FAX: ' + FormatarFone(FFax),'' );
      rlmEndereco.Lines.add(sTemp );
    end;
  end;
  if FSite <> '' then
      rlmEndereco.Lines.Add(FSite);
  if FEmail <> '' then
      rlmEndereco.Lines.Add(FEmail);
  rlmEndereco.Height:= rliEmitente.Height - rlmEndereco.Top - 15;
end;

procedure TfrlDANFeRLPaisagem.Destinatario;
begin
  // destinatario
  with FNFe.Dest do
  begin
    if NaoEstaVazio(idEstrangeiro) then
      rllDestCNPJ.Caption   := idEstrangeiro
    else
      rllDestCNPJ.Caption   := FormatarCNPJouCPF(CNPJCPF);

    rllDestIE.Caption       := IE;
    rllDestNome.Caption     := XNome;
    with EnderDest do
    begin
      rllDestEndereco.Caption := XLgr +
                                  IfThen(Nro = '0', '', ', ' + Nro) +
                                  IfThen(xCpl > '', ' ' + xCpl, '' );
      rllDestBairro.Caption := XBairro;
      rllDestCidade.Caption := XMun;
      rllDestUF.Caption     := UF;
      rllDestCEP.Caption    := FormatarCEP(Poem_Zeros(CEP, 8));
      rllDestFONE.Caption   := FormatarFone(Fone);
    end;
  end;
end;

Function TfrlDANFeRLPaisagem.EnderecoEntrega : String;
begin
  Result := '';
  if FNFe.Entrega.xLgr > '' then
  begin
    with FNFe.Entrega do
    begin
      Result := XLgr +
                    IfThen(Nro = '0', '', ', ' + Nro) +
                    IfThen(xCpl > '','', ' - ' + xCpl );


      Result := 'LOCAL DE ENTREGA: ' + Result + ' - ' +
                    xBairro + ' - ' + xMun + '-' + UF +
                    TrataDocumento( CNPJCPF );

    end;
  end;
end;

Function TfrlDANFeRLPaisagem.EnderecoRetirada : String;
begin
  Result := '';
  if FNFe.Retirada.xLgr > '' then
  begin
    with FNFe.Retirada do
    begin

      Result := XLgr +
                    IfThen(Nro = '0', '', ', ' + Nro) +
                    IfThen(xCpl > '','', ' - ' + xCpl );

      Result := 'LOCAL DE RETIRADA: ' + Result + ' - ' +
                    xBairro + ' - ' + xMun + '-' + UF +
                    TrataDocumento( CNPJCPF );
    end;
  end;
end;

procedure TfrlDANFeRLPaisagem.Imposto;
var LarguraCampo: Integer;
begin
  with FNFe.Total.ICMSTot do
  begin
    rllBaseICMS.Caption       := FormatFloatBr(VBC, '###,###,###,##0.00');
    rllValorICMS.Caption      := FormatFloatBr(VICMS, '###,###,###,##0.00');
    rllBaseICMSST.Caption     := FormatFloatBr(VBCST, '###,###,###,##0.00');
    rllValorICMSST.Caption    := FormatFloatBr(VST, '###,###,###,##0.00');
    rllTotalProdutos.Caption  := FormatFloatBr(VProd, '###,###,###,##0.00');
    rllValorFrete.Caption     := FormatFloatBr(VFrete, '###,###,###,##0.00');
    rllValorSeguro.Caption    := FormatFloatBr(VSeg, '###,###,###,##0.00');
    rllDescontos.Caption      := FormatFloatBr(VDesc, '###,###,###,##0.00');
    rllAcessorias.Caption     := FormatFloatBr(VOutro, '###,###,###,##0.00');
    rllValorIPI.Caption       := FormatFloatBr(VIPI, '###,###,###,##0.00');
    rllTotalNF.Caption        := FormatFloatBr(VNF, '###,###,###,##0.00');

    // Exibe o Valor total dos tributos se vTotTrib for informado
    // e ajusta a posi��o dos outros campos para "abrir espa�o" para ele.
    if vTotTrib > 0 then
      begin
        rllTotalTributos.Caption := FormatFloatBr(vTotTrib, '###,###,###,##0.00');
        rliDivImposto4.Visible := True;
        rllTituloTotalTributos.Visible := True;
        rllTotalTributos.Visible := True;

        rliDivImposto4.Left := 638;
        rllTituloTotalTributos.Left := rliDivImposto4.Left + 3;
        rllTotalTributos.Left := rliDivImposto4.Left + 7;
        rllTotalTributos.Width := (rliDivImposto5.Left - 7) - (rliDivImposto4.Left + 3);

        LarguraCampo := 151;

        rliDivImposto3.Left := rliDivImposto4.Left - LarguraCampo - 1;
        rllTituloValorICMSST.Left := rliDivImposto3.Left + 3;
        rllValorICMSST.Left := rliDivImposto3.Left + 7;
        rllValorICMSST.Width := (rliDivImposto4.Left - 7) - (rliDivImposto3.Left + 3);
      end
    else
      begin
        rliDivImposto4.Visible := False;
        rllTituloTotalTributos.Visible := False;
        rllTotalTributos.Visible := False;

        LarguraCampo := 189;

        rliDivImposto3.Left := rliDivImposto5.Left - LarguraCampo - 1;
        rllTituloValorICMSST.Left := rliDivImposto3.Left + 3;
        rllValorICMSST.Left := rliDivImposto3.Left + 7;
        rllValorICMSST.Width := (rliDivImposto5.Left - 7) - (rliDivImposto3.Left + 3);
      end;

    rliDivImposto2.Left := rliDivImposto3.Left - LarguraCampo - 1;
    rllTituloBaseICMSST.Left := rliDivImposto2.Left + 3;
    rllBaseICMSST.Left := rliDivImposto2.Left + 7;
    rllBaseICMSST.Width := (rliDivImposto3.Left - 7) - (rliDivImposto2.Left + 3);

    rliDivImposto1.Left := rliDivImposto2.Left - LarguraCampo - 1;
    rllTituloValorICMS.Left := rliDivImposto1.Left + 3;
    rllValorICMS.Left := rliDivImposto1.Left + 7;
    rllValorICMS.Width := (rliDivImposto2.Left - 7) - (rliDivImposto1.Left + 3);

    rllTituloBaseICMS.Left := rliDivImposto0.Left + 3;
    rllBaseICMS.Left := rllTituloBaseICMS.Left + 4;
    rllBaseICMS.Width := (rliDivImposto1.Left - 7) - (rliDivImposto0.Left + 3);
  end;
end;

procedure TfrlDANFeRLPaisagem.Transporte;
var
  i, j: Integer;
  RLLabel, RLLabelModelo: TRLLabel;
begin
  with FNFe.Transp do
  begin
    rllTransModFrete.Caption := modFreteToDesStr( modFrete );
    with Transporta do
    begin
      if Trim(CNPJCPF) <> '' then
        rllTransCNPJ.Caption := FormatarCNPJouCPF(CNPJCPF)
      else
        rllTransCNPJ.Caption := '';

      rllTransNome.Caption := XNome;
      rllTransIE.Caption := IE;
      rllTransEndereco.Caption := XEnder;
      rllTransCidade.Caption := XMun;
      rllTransUF.Caption := UF;
    end;
  end;

  with FNFe.Transp.VeicTransp do
  begin
    rllTransCodigoANTT.Caption := RNTC;
    rllTransPlaca.Caption   :=  Placa;
    rllTransUFPlaca.Caption :=  UF;
  end;

  if FNFe.Transp.Vol.Count > 0 then
   begin
    // Aproveita os labels criados em tempo de projeto (1� linha)
     with FNFe.Transp.Vol[0] do
      begin
        if qVol > 0 then
          rllTransQTDE.Caption       :=  IntToStr(QVol);
        rllTransEspecie.Caption    :=  Esp  ;
        rllTransMarca.Caption      :=  Marca;
        rllTransNumeracao.Caption  :=  NVol ;
        if pesoL > 0 then
          rllTransPesoLiq.Caption    :=  FormatFloatBr(PesoL,
                                                        '###,###,###,##0.000');
        if pesoB > 0 then
          rllTransPesoBruto.Caption  :=  FormatFloatBr(PesoB,
                                                        '###,###,###,##0.000');
      end;
      // Preenche os dados
      for i := 1 to FNFe.Transp.Vol.Count - 1 do
      begin
        with FNFe.Transp.Vol[i] do
        begin
          // Cria os demais labels dinamicamente
          for j := 1 to 6 do
          begin
            RLLabel := TRLLabel.Create(Self);
            case j of
              1:  begin // Qtde
                    RLLabelModelo := rllTransQTDE;
                    if qVol > 0 then
                      RLLabel.Caption := IntToStr(QVol);
                  end;
              2:  begin // Especie
                    RLLabelModelo   := rllTransEspecie;
                    RLLabel.Caption := Esp;
                  end;
              3:  begin // Marca
                    RLLabelModelo   := rllTransMarca;
                    RLLabel.Caption := Marca;
                  end;
              4:  begin // Numeracao
                    RLLabelModelo   := rllTransNumeracao;
                    RLLabel.Caption := NVol;
                  end;
              5:  begin // Peso liq
                    RLLabelModelo := rllTransPesoLiq;
                    if pesoL > 0 then
                      RLLabel.Caption := FormatFloatBr(PesoL, '###,###,###,##0.000');
                  end;
              6:  begin // Peso bruto
                    RLLabelModelo := rllTransPesoBruto;
                    if pesoB > 0 then
                      RLLabel.Caption  := FormatFloatBr(PesoB, '###,###,###,##0.000');
                  end;
            end;
            RLLabel.Alignment  := RLLabelModelo.Alignment;
            RLLabel.AutoSize   := RLLabelModelo.AutoSize;
            RLLabel.Font       := RLLabelModelo.Font;
            RLLabel.Name       := RLLabelModelo.Name + IntToStr(i);
            RLLabel.Parent     := RLLabelModelo.Parent;
            RLLabel.ParentFont := RLLabelModelo.ParentFont;
            RLLabel.Tag        := RLLabelModelo.Tag;
            RLLabel.Height     := RLLabelModelo.Height;
            RLLabel.Width      := RLLabelModelo.Width;
            RLLabel.Left       := RLLabelModelo.Left;
            RLLabel.Top        := RLLabelModelo.Top + (i * (RLLabelModelo.Height)) ;//iAltLinha;
          end;
        end;
      end;
   end
  else
  begin
    rllTransQTDE.Caption       :=  '';
    rllTransEspecie.Caption    :=  '';
    rllTransMarca.Caption      :=  '';
    rllTransNumeracao.Caption  :=  '';
    rllTransPesoLiq.Caption    :=  '';
    rllTransPesoBruto.Caption  :=  '';
  end;
end;

procedure TfrlDANFeRLPaisagem.DadosAdicionais;
var sInfCompl, sInfAdFisco, sInfContr, sObsFisco, sObsProcRef, sInfInteira,
    sProtocolo, sSuframa : WideString;
    sIndProc: String;
    i: Integer;
begin
  rlmDadosAdicionaisAuxiliar.Lines.BeginUpdate;
  rlmDadosAdicionaisAuxiliar.Lines.Clear;

  // Protocolo de autoriza��o, nos casos de emiss�o em conting�ncia
  if (FNFe.Ide.tpEmis in [teContingencia, teFSDA]) and
                                              (FNFe.procNFe.cStat = 100) then
  begin
    sProtocolo := ACBrStr('PROTOCOLO DE AUTORIZA��O DE USO: ') +
                     FNFe.procNFe.nProt + ' ' + DateTimeToStr(FNFe.procNFe.dhRecbto);
    InsereLinhas(sProtocolo, iLimiteCaracteresLinha, rlmDadosAdicionaisAuxiliar);
  end;

  // Inscri��o Suframa
  if FNFe.Dest.ISUF > '' then
  begin
    sSuframa := ACBrStr('INSCRI��O SUFRAMA: ' ) + FNFe.Dest.ISUF;
    InsereLinhas(sSuframa, iLimiteCaracteresLinha, rlmDadosAdicionaisAuxiliar);
  end;

  InsereLinhas(EnderecoRetirada, iLimiteCaracteresLinha, rlmDadosAdicionaisAuxiliar);

  InsereLinhas(EnderecoEntrega, iLimiteCaracteresLinha, rlmDadosAdicionaisAuxiliar);


  // Informa��es de interesse do fisco
  if FNFe.InfAdic.infAdFisco > '' then
  begin
    if FNFe.InfAdic.infCpl > '' then
      sInfAdFisco := FNFe.InfAdic.infAdFisco + '; '
    else
      sInfAdFisco := FNFe.InfAdic.infAdFisco;
    end
  else
    sInfAdFisco := '';

  // Informa��es de interesse do contribuinte
  if FNFe.InfAdic.infCpl > '' then
    sInfCompl := FNFe.InfAdic.infCpl
  else
    sInfCompl := '';

  // Informa��es de uso livre do contribuinte com "xCampo" e "xTexto"
  if FNFe.InfAdic.obsCont.Count > 0 then
  begin
    sInfContr := '';
    for i := 0 to (FNFe.InfAdic.obsCont.Count - 1) do
    begin
      if FNFe.InfAdic.obsCont.Items[i].Index =
                                          (FNFe.InfAdic.obsCont.Count - 1) then
            sInfContr := sInfContr + FNFe.InfAdic.obsCont.Items[i].xCampo +
                              ': ' + FNFe.InfAdic.obsCont.Items[i].xTexto
      else
        sInfContr := sInfContr + FNFe.InfAdic.obsCont.Items[i].xCampo +
                            ': ' + FNFe.InfAdic.obsCont.Items[i].xTexto + '; ';
      end; // for i := 0 to (FNFe.InfAdic.obsCont.Count - 1)
      if (sInfCompl > '') or (sInfAdFisco > '') then
        sInfContr := sInfContr + '; '
    end // if FNFe.InfAdic.obsCont.Count > 0
  else
    sInfContr := '';

  // Informa��es de uso livre do fisco com "xCampo" e "xTexto"
  if FNFe.InfAdic.obsFisco.Count > 0 then
  begin
    sObsFisco := '';
    for i := 0 to (FNFe.InfAdic.obsFisco.Count - 1) do
    begin
      if FNFe.InfAdic.obsFisco.Items[i].Index =
                                          (FNFe.InfAdic.obsFisco.Count - 1) then
        sObsFisco := sObsFisco + FNFe.InfAdic.obsFisco.Items[i].xCampo +
                              ': ' + FNFe.InfAdic.obsFisco.Items[i].xTexto
      else
        sObsFisco := sObsFisco + FNFe.InfAdic.obsFisco.Items[i].xCampo +
                            ': ' + FNFe.InfAdic.obsFisco.Items[i].xTexto + '; ';
      end; // for i := 0 to (FNFe.InfAdic.obsFisco.Count - 1)
      if (sInfCompl > '') or (sInfAdFisco > '') then
        sObsFisco := sObsFisco + '; '
    end // if FNFe.InfAdic.obsFisco.Count > 0
  else
  sObsFisco := '';

  // Informa��es do processo referenciado
  if FNFe.InfAdic.procRef.Count > 0 then
  begin
    sObsProcRef := '';

    for i := 0 to (FNFe.InfAdic.procRef.Count - 1) do
    begin
      sIndProc := ACBrStr( indProcToDescrStr(FNFe.InfAdic.procRef.Items[i].indProc ) );

      if FNFe.InfAdic.procRef.Items[i].Index =
                                          (FNFe.InfAdic.procRef.Count - 1) then
            sObsProcRef := sObsProcRef +  ACBrStr('PROCESSO OU ATO CONCESS�RIO N�: ') +
                           FNFe.InfAdic.procRef.Items[i].nProc + ' - ORIGEM: ' +
                           sIndProc
          else
            sObsProcRef := sObsProcRef +  ACBrStr('PROCESSO OU ATO CONCESS�RIO N�: ') +
                           FNFe.InfAdic.procRef.Items[i].nProc + ' - ORIGEM: ' +
                           sIndProc + '; ';
    end; // for i := 0 to (FNFe.InfAdic.procRef.Count - 1)
    if (sInfCompl > '') or (sInfAdFisco > '') then
        sObsProcRef := sObsProcRef + '; '
    end // if FNFe.InfAdic.procRef.Count > 0
  else
    sObsProcRef := '';

  sInfInteira := sInfAdFisco + sObsFisco + sObsProcRef + sInfContr + sInfCompl;
  InsereLinhas(sInfInteira, iLimiteCaracteresLinha, rlmDadosAdicionaisAuxiliar);
  rlmDadosAdicionaisAuxiliar.Lines.EndUpdate;
end;

procedure TfrlDANFeRLPaisagem.Observacoes;
var i, iMaximoLinhas, iRestanteLinhas: Integer;
sTexto: WideString;
begin
  rlmDadosAdicionais.Lines.BeginUpdate;
  rlmDadosAdicionais.Lines.Clear;

  if rlmDadosAdicionaisAuxiliar.Lines.Count > iLimiteLinhas then
    begin
      iMaximoLinhas := iLimiteLinhas;
      iRestanteLinhas := rlmDadosAdicionaisAuxiliar.Lines.Count - iLimiteLinhas;
      rlmContinuacaoDadosAdicionais.Lines.BeginUpdate;
      sTexto := '';
      for i := 0 to (iRestanteLinhas - 1) do
        begin
          sTexto := sTexto +
                  rlmDadosAdicionaisAuxiliar.Lines.Strings[(iMaximoLinhas + i)];
        end;

      InsereLinhas(sTexto, iLimiteCaracteresContinuacao, rlmContinuacaoDadosAdicionais);
      rlmContinuacaoDadosAdicionais.Lines.Text :=
                        StringReplace(rlmContinuacaoDadosAdicionais.Lines.Text,
                        ';', '', [rfReplaceAll, rfIgnoreCase]);
      rlmContinuacaoDadosAdicionais.Lines.EndUpdate;
    end
  else
    iMaximoLinhas := rlmDadosAdicionaisAuxiliar.Lines.Count;

  for i := 0 to (iMaximoLinhas - 1) do
    begin
      rlmDadosAdicionais.Lines.Add(rlmDadosAdicionaisAuxiliar.Lines.Strings[i]);
    end;

  rlmDadosAdicionais.Lines.Text := StringReplace(rlmDadosAdicionais.Lines.Text,
                                   ';', '', [rfReplaceAll, rfIgnoreCase]);

  rlmDadosAdicionais.Lines.EndUpdate;
end;

procedure TfrlDANFeRLPaisagem.Itens;
var
  nItem : integer;
begin
  for nItem := 0 to (FNFe.Det.Count - 1) do
  begin
    with FNFe.Det.Items[nItem] do
    begin
      cdsItens.Append;
      cdsItens.FieldByName('CODIGO').AsString       := Prod.CProd;
      cdsItens.FieldByName('EAN').AsString          := Prod.cEAN;
      cdsItens.FieldByName('DESCRICAO').AsString    := ManterXpod( Prod.XProd , nItem );
      cdsItens.FieldByName('NCM').AsString          := Prod.NCM;
      cdsItens.FieldByName('CST').AsString          := OrigToStr(Imposto.ICMS.orig) + CSTICMSToStr(Imposto.ICMS.CST);
      cdsItens.FieldByName('CSOSN').AsString        := OrigToStr(Imposto.ICMS.orig) + CSOSNIcmsToStr(Imposto.ICMS.CSOSN);
      cdsItens.FieldByName('CFOP').AsString         := Prod.CFOP;
      cdsItens.FieldByName('UNIDADE').AsString      := Prod.UCom;
      cdsItens.FieldByName('QTDE').AsString         := TACBrNFeDANFeRL(Owner).FormatQuantidade( Prod.qCom);
      cdsItens.FieldByName('VALOR').AsString        := TACBrNFeDANFeRL(Owner).FormatValorUnitario(  Prod.vUnCom);
      cdsItens.FieldByName('TOTAL').AsString        := FormatFloat('###,###,###,##0.00', Prod.vProd);
      cdsItens.FieldByName('VALORDESC').AsString    := FormatFloat('###,###,###,##0.00', ManterDesPro( Prod.vDesc ,Prod.vProd));
      cdsItens.FieldByName('Valorliquido').AsString := FormatFloatBr( Prod.vProd - ManterDesPro( Prod.vDesc ,Prod.vProd),'###,###,##0.00');
      cdsItens.FieldByName('BICMS').AsString        := FormatFloat('###,###,###,##0.00', Imposto.ICMS.VBC);
      cdsItens.FieldByName('ALIQICMS').AsString     := FormatFloat('###,###,###,##0.00', Imposto.ICMS.PICMS);
      cdsItens.FieldByName('VALORICMS').AsString    := FormatFloat('###,###,###,##0.00', Imposto.ICMS.VICMS);
      cdsItens.FieldByName('BICMSST').AsString      := FormatFloat('###,###,###,##0.00', Imposto.ICMS.vBCST);
      cdsItens.FieldByName('VALORICMSST').AsString  := FormatFloat('###,###,###,##0.00', Imposto.ICMS.vICMSST);
      cdsItens.FieldByName('ALIQIPI').AsString      := FormatFloat('##0.00', Imposto.IPI.PIPI);
      cdsItens.FieldByName('VALORIPI').AsString     := FormatFloat('##0.00', Imposto.IPI.VIPI);
      cdsItens.Post;
    end;
  end;
  cdsItens.First;
end;

procedure TfrlDANFeRLPaisagem.ISSQN;
begin
  with FNFe.Total.ISSQNtot do
  begin
    rlbISSQN.Visible  := ( FNFe.Total.ISSQNtot.vISS > 0 ) and ( fMostraDadosISSQN = True );
    if rlbISSQN.Visible then
    begin
      rllISSQNInscricao.Caption     := FNFe.Emit.IM;
      rllISSQNValorServicos.Caption := FormatFloatBr(FNFe.Total.ISSQNtot.vServ,'###,###,##0.00');
      rllISSQNBaseCalculo.Caption   := FormatFloatBr(FNFe.Total.ISSQNtot.vBC,'###,###,##0.00');
      rllISSQNValorISSQN.Caption    := FormatFloatBr(FNFe.Total.ISSQNtot.vISS,'###,###,##0.00');
    end;
  end;
end;

procedure TfrlDANFeRLPaisagem.AddFatura;
var x, iQuantDup, iLinhas, iColunas, iPosQuadro, iAltLinha,
    iAltQuadro1Linha, iAltQuadro, iAltBand, iFolga: Integer;
begin

  rlbFatura.Visible := ( FNFe.Cobr.Dup.Count > 0 );

  if FNFe.Cobr.Dup.Count > 0 then
  begin
    if FNFe.Cobr.Dup.Count < 6 then
      TRLLabel (FindComponent('rllFatura')).Caption := 'DUPL';

    for x := 1 to 15 do
    begin
      TRLLabel (FindComponent ('rllFatNum'   + intToStr (x))).Caption := '';
      TRLLabel (FindComponent ('rllFatData'  + intToStr (x))).Caption := '';
      TRLLabel (FindComponent ('rllFatValor' + intToStr (x))).Caption := '';
    end;

    TRLLabel(FindComponent('rllFatNum1')).AutoSize := True;


    iQuantDup := ManterDuplicatas;

    {=============== Ajusta o tamanho do quadro das faturas ===============}

    iColunas          := 5;   // Quantidade de colunas
    iAltLinha         := 12;  // Altura de cada linha
    iPosQuadro        := 0;   // Posi��o (Top) do Quadro
    iAltQuadro1Linha  := 27;  // Altura do quadro com 1 linha
    iFolga            := 1;   // Dist�ncia entre o final da Band e o final do quadro

    if (iQuantDup mod iColunas) = 0 then // Quantidade de linhas
      iLinhas := iQuantDup div iColunas
    else
      iLinhas := (iQuantDup div iColunas) + 1;

    if iLinhas = 1 then
      iAltQuadro := iAltQuadro1Linha
    else
      iAltQuadro := iAltQuadro1Linha + ((iLinhas - 1) * iAltLinha);

    iAltBand := iPosQuadro + iAltQuadro + iFolga;

    rlbFatura.Height  := iAltBand;
    rliFatura.Height  := iAltQuadro;
    rliFatura1.Height := iAltQuadro;
    rliFatura2.Height := iAltQuadro;
    rliFatura3.Height := iAltQuadro;
    rliFatura4.Height := iAltQuadro;
    rliFatura5.Height := iAltQuadro;

    {=============== Centraliza o label "DUPLICATA" ===============}
    rllFatura.Top := (rlbFatura.Height - rllFatura.Height) div 2;
  end;
end;

procedure TfrlDANFeRLPaisagem.rlbItensAfterPrint(Sender: TObject);
var h: Integer;
str: WideString;
begin
  q := q + 1;
  if FNFe.Det.Items[q - 1].infAdProd > '' then
    begin
      rlmObsItem.Lines.BeginUpdate;
      rlmObsItem.Lines.Clear;
      str := StringReplace((FNFe.Det.Items[q - 1].infAdProd), ';',
                                          #13#10, [rfReplaceAll, rfIgnoreCase]);
      rlmObsItem.Lines.Add(str);
      rlmObsItem.Lines.EndUpdate;
      rlbObsItem.Visible := True;

      h := (rlmObsItem.Top + rlmObsItem.Height) + 2;
      LinhaFimObsItem.Top := h;
      h := h + 1;
      LinhaObsItemEsquerda.Height := h;
      LinhaObsItemDireita.Height := h;
      if iQuantItens > q then
        LinhaInicioItem.Visible := True
      else
        LinhaInicioItem.Visible := False;
    end
  else
    rlbObsItem.Visible := False;
end;

procedure TfrlDANFeRLPaisagem.rlbDadosAdicionaisBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
var iAumento: Integer;
begin
  iAumento := pnlCanhoto.Width + pnlDivisao.Width;
  pnlCanhoto.Visible := False;
  pnlDivisao.Visible := False;
  rliChave.Width := rliChave.Width + iAumento;
  rliChave2.Width := rliChave2.Width + iAumento;
  rliChave3.Width := rliChave3.Width + iAumento;
  rliNatOpe.Width := rliNatOpe.Width + iAumento;
  rliNatOpe1.Width := rliNatOpe1.Width + iAumento;
  rllDadosVariaveis1a.Left := rllDadosVariaveis1a.Left + (iAumento div 2);
  rllDadosVariaveis1b.Left := rllDadosVariaveis1b.Left + (iAumento div 2);
  rlbCodigoBarras.Left := rlbCodigoBarras.Left + (iAumento div 2);
  rllXmotivo.Left := rllXmotivo.Left + (iAumento div 2);
  rlmContinuacaoDadosAdicionais.Width := rlmContinuacaoDadosAdicionais.Width +
                                                                       iAumento;
  LinhaDCDireita.Left := LinhaDCDireita.Left + iAumento;
  LinhaDCSuperior.Width := LinhaDCSuperior.Width + iAumento;
  LinhaDCInferior.Width := LinhaDCInferior.Width + iAumento;
  pnlCabecalho1.Width := pnlCabecalho1.Width + iAumento;
  rllCinza1.Width := rllCinza1.Width + iAumento;
  rlmDescricaoProduto.Width := rlmDescricaoProduto.Width + iAumento;
  pnlCabecalho2.Left := pnlCabecalho2.Left + iAumento;
end;

procedure TfrlDANFeRLPaisagem.rlbItensBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  // Controla os itens por p�gina
  iItemAtual := iItemAtual + 1;

  if FProdutosPorPagina = 0 then
    begin
      rlbItens.PageBreaking := pbNone;
    end
  else
    begin
      if iItemAtual = FProdutosPorPagina then
        begin
          rlbItens.PageBreaking := pbBeforePrint;
          // Necess�rio informar medidas absolutas porque a primeira linha
          // da p�gina 2 recebia medidas da p�gina 1
          if RLNFe.PageNumber = 1 then
            begin
              pnlDescricao1.Width := 472;
              rlmDescricao.Width := 386;
              LinhaFimItens.Width := 1070;
              pnlDescricao2.Left := 472;
            end;
        end
      else
        begin
          rlbItens.PageBreaking := pbNone;
        end;
    end;

  {=====================================================================
   - Faz o deslocamento dos itens para suprir a aus�ncia do canhoto nas
     pr�ximas p�ginas. � necess�rio informar medidas absolutas.
   - Nas vers�es 3.69 em diante do Fortes Report, a instru��o abaixo �
     aplicada somente a partir da segunda linha da segunda p�gina.
   - Para contornar esta dificuldade, a mesma instru��o foi repetida no
     evento "AfterPrint" de "rlbCabecalhoItens".
   =====================================================================}
  if RLNFe.PageNumber > 1 then
    begin
      pnlDescricao1.Width := 472;
      rlmDescricao.Width := 386;
      LinhaFimItens.Width := 1070;
      pnlDescricao2.Left := 472;
    end;
end;

procedure TfrlDANFeRLPaisagem.rlbDadosAdicionaisAfterPrint(
  Sender: TObject);
var iAumento: Integer;
begin
  iAumento := pnlCanhoto.Width + pnlDivisao.Width;
  case FPosCanhoto of
    pcCabecalho: rlbObsItem.Left := rlbObsItem.Left - iAumento;
    pcRodape: rlbObsItem.Left := rlbObsItem.Left;
  end;
end;

procedure TfrlDANFeRLPaisagem.rlbObsItemBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
var iAumento: Integer;
begin
  if RLNFe.PageNumber > 1 then
    begin
      pnlDescricao1.Width := 472;
      rlmDescricao.Width  := 386;
      LinhaFimItens.Width := 1070;
      pnlDescricao2.Left  := 472;

      iAumento := pnlCanhoto.Width + pnlDivisao.Width;
      rlbObsItem.Width := rlbObsItem.Width + iAumento;
      LinhaObsItemDireita.Left := LinhaObsItemDireita.Left + iAumento;
      LinhaFimObsItem.Width := LinhaFimObsItem.Width + iAumento;
      LinhaInicioItem.Width := LinhaInicioItem.Width + iAumento;
      rlmObsItem.Width := rlmObsItem.Width + iAumento;
    end;
end;

procedure TfrlDANFeRLPaisagem.ConfigureDataSource;
begin
  rlmDescricao.DataSource := DataSource1;
  RLNFe.DataSource := DataSource1;
  txtEAN.DataSource := DataSource1;
  txtCodigo.DataSource := DataSource1;
  txtNCM.DataSource := DataSource1;
  txtCST.DataSource := DataSource1;
  txtCFOP.DataSource := DataSource1;
  txtUnidade.DataSource := DataSource1;
  txtQuantidade.DataSource := DataSource1;
  txtValorUnitario.DataSource := DataSource1;
  txtValorTotal.DataSource := DataSource1;
  txtBaseICMS.DataSource := DataSource1;
  txtBaseICMSST.DataSource := DataSource1;
  txtValorICMS.DataSource := DataSource1;
  txtValorICMSST.DataSource := DataSource1;
  txtValorIPI.DataSource := DataSource1;
  txtAliqICMS.DataSource := DataSource1;
  txtAliqIPI.DataSource := DataSource1;
  txtValorDesconto.DataSource := DataSource1;
end;

procedure TfrlDANFeRLPaisagem.pnlDescricao1AfterPrint(Sender: TObject);
begin
  pnlDescricao2.Height := pnlDescricao1.Height;
end;

procedure TfrlDANFeRLPaisagem.rlbCabecalhoItensBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  case FNFe.Emit.CRT of
    crtRegimeNormal,
    crtSimplesExcessoReceita :
      begin
        lblCST.Caption    := 'CST';
        lblCST.Font.Size  := 5;
        lblCST.Top        := 15;
        txtCST.DataField  := 'CST';
      end;

    crtSimplesNacional :
      begin
        lblCST.Caption    := 'CSOSN';
        lblCST.Font.Size  := 4;
        lblCST.Top        := 14;
        txtCST.DataField  := 'CSOSN';
      end;
  end;

  if ( fImprimirDescPorc ) then
  begin
    lblPercValorDesc.Caption := 'PERC.(%)';
    fImprimirTotalLiquido    := false;
  end
  else
    lblPercValorDesc.Caption := 'VALOR';

  if ( fImprimirTotalLiquido ) then
  begin
    lblValorTotal.Caption       := 'DESCONTO';
    txtValorTotal.DataField     := 'VALORDESC';
    lblPercValorDesc1.Caption   := 'L�QUIDO';
    txtValorDesconto.DataField  := 'valorliquido';
  end;

  if RLNFe.PageNumber > 1 then
  begin
    pnlDescricao1.Width :=  472;
    rlmDescricao.Width  :=  386;
    LinhaFimItens.Width := 1070;
    pnlDescricao2.Left  :=  472;
  end;
end;

procedure TfrlDANFeRLPaisagem.FormCreate(Sender: TObject);
begin
  inherited;
	FineTuneAngleLabels := true;
  iItemAtual := 0;
  iLimiteLinhas := 12;
  iLinhasUtilizadas := 0;
  iLimiteCaracteresLinha := 142;
  iLimiteCaracteresContinuacao := 204;
end;

Function TfrlDANFeRLPaisagem.ManterVeiculos( inItem:  integer  ) : String;
begin
  Result := '';
{ detalhamento especifico de ve�culos }
  with FNFe.Det.Items[inItem].Prod do
  begin
    if veicProd.chassi > '' then
    begin
      Result := sQuebraLinha;
      if dv_tpOp in FDetVeiculos          then Result := Result + ACBrStr('TIPO DA OPERA��O: ' + VeiculosTipoOperStr( veicProd.tpOP ) ) + sQuebraLinha;
      if dv_Chassi in FDetVeiculos        then Result := Result + ACBrStr('CHASSI: ' )+ veicProd.chassi + sQuebraLinha;
      if dv_cCor in FDetVeiculos          then Result := Result + ACBrStr('C�DIGO DA COR: ' )+ veicProd.cCor + sQuebraLinha;
      if dv_xCor in FDetVeiculos          then Result := Result + ACBrStr('NOME DA COR: ') + veicProd.xCor + sQuebraLinha;
      if dv_pot in FDetVeiculos           then Result := Result + ACBrStr('POT�NCIA DO MOTOR: ') + veicProd.pot + sQuebraLinha;
      if dv_cilin in FDetVeiculos         then Result := Result + ACBrStr('CILINDRADAS: ') + veicProd.Cilin + sQuebraLinha;
      if dv_pesoL in FDetVeiculos         then Result := Result + ACBrStr('PESO L�QUIDO: ') + veicProd.pesoL + sQuebraLinha;
      if dv_pesoB in FDetVeiculos         then Result := Result + ACBrStr('PESO BRUTO: ' )+ veicProd.pesoB + sQuebraLinha;
      if dv_nSerie in FDetVeiculos        then Result := Result + ACBrStr('N�MERO DE S�RIE: ') + veicProd.nSerie + sQuebraLinha;
      if dv_tpComb in FDetVeiculos        then Result := Result + ACBrStr('COMBUST�VEL: ' + VeiculosCombustivelStr( veicProd.tpComb ) ) + sQuebraLinha;
      if dv_nMotor in FDetVeiculos        then Result := Result + ACBrStr('N�MERO DO MOTOR: ') + veicProd.nMotor + sQuebraLinha;
      if dv_CMT in FDetVeiculos           then Result := Result + ACBrStr('CAP. M�X. TRA��O: ') + veicProd.CMT + sQuebraLinha;
      if dv_dist in FDetVeiculos          then Result := Result + ACBrStr('DIST�NCIA ENTRE EIXOS: ') + veicProd.dist + sQuebraLinha;
      if dv_anoMod in FDetVeiculos        then Result := Result + ACBrStr('ANO DO MODELO: ' )+ IntToStr(veicProd.anoMod) + sQuebraLinha;
      if dv_anoFab in FDetVeiculos        then Result := Result + ACBrStr('ANO DE FABRICA��O: ') + IntToStr(veicProd.anoFab) + sQuebraLinha;
      if dv_tpPint in FDetVeiculos        then Result := Result + ACBrStr('TIPO DE PINTURA: ') + veicProd.tpPint + sQuebraLinha;
      if dv_tpVeic in FDetVeiculos        then Result := Result + ACBrStr('TIPO DE VE�CULO: ' +VeiculosTipoStr( veicProd.tpVeic ) )+ sQuebraLinha;
      if dv_espVeic in FDetVeiculos       then Result := Result + ACBrStr('ESP�CIE DO VE�CULO: ' +VeiculosEspecieStr( veicProd.espVeic )) + sQuebraLinha;
      if dv_VIN in FDetVeiculos           then Result := Result + ACBrStr('VIN (CHASSI): ' + VeiculosVinStr( veicProd.VIN ) )+ sQuebraLinha;
      if dv_condVeic in FDetVeiculos      then Result := Result + ACBrStr('CONDI��O DO VE�CULO: ' +VeiculosCondicaoStr( veicProd.condVeic)) + sQuebraLinha;
      if dv_cMod in FDetVeiculos          then Result := Result + ACBrStr('C�DIGO MARCA MODELO: ') + veicProd.cMod + sQuebraLinha;
      if dv_cCorDENATRAN in FDetVeiculos  then Result := Result + ACBrStr('C�DIGO COR DENATRAN: ' +VeiculosCorDENATRANSTr( veicProd.cCorDENATRAN )) + sQuebraLinha;
      if dv_lota in FDetVeiculos          then Result := Result + ACBrStr('CAPACIDADE M�XIMA DE LOTA��O: ') +IntToStr(veicProd.lota) + sQuebraLinha;
      if dv_tpRest in FDetVeiculos        then Result := Result + ACBrStr('RESTRI��O: ' +VeiculosRestricaoStr( veicProd.tpRest ) )+ #13#10;
    end;
  end;
end;


Function TfrlDANFeRLPaisagem.ManterMedicamentos( inItem:  integer ) : String;
Var
  i : Integer;
begin
  Result := '';
  with FNFe.Det.Items[inItem].Prod do
  begin
    if med.Count > 0 then
    begin
      Result := sQuebraLinha;
      for i := 0 to med.Count - 1 do
      begin
        if dm_nLote in FDetMedicamentos then Result := Result + ACBrStr('LOTE: ') + med.Items[i].nLote + sQuebraLinha;
        if dm_qLote in FDetMedicamentos then Result := Result + ACBrStr('QTD: ' ) + FormatFloat('###,##0.000', med.Items[i].qLote) + sQuebraLinha;
        if dm_dFab  in FDetMedicamentos then Result := Result + ACBrStr('FAB: ' ) + DateToStr(med.Items[i].dFab) + sQuebraLinha;
        if dm_dVal  in FDetMedicamentos then Result := Result + ACBrStr('VAL: ' ) + DateToStr(med.Items[i].dVal) + sQuebraLinha;
        if dm_vPMC  in FDetMedicamentos then Result := Result + IfThen( med.Items[i].vPMC > 0,
                                                                  ACBrStr('PMC: R$') + FormatFloat('###,##0.00', med.Items[i].vPMC),'' )
                                                                  + #13#10;

      end;
    end;
  end;
end;

Function TfrlDANFeRLPaisagem.ManterArma( inItem:  integer  ) : String;
Var
  i : Integer;
begin
  Result := '';
  with FNFe.Det.Items[inItem].Prod do
  begin
    if arma.Count > 0 then
    begin
      Result := sQuebraLinha;
      for i := 0 to arma.Count - 1 do
      begin
        if da_tpArma in FDetArmamentos then Result := Result + ACBrStr('TIPO DE ARMA: ')   + ArmaTipoStr( arma.Items[i].tpArma ) + sQuebraLinha;
        if da_nSerie in FDetArmamentos then Result := Result + ACBrStr('No. S�RIE ARMA: ') + arma.Items[i].nSerie + sQuebraLinha;
        if da_nCano  in FDetArmamentos then Result := Result + ACBrStr('No. S�RIE CANO: ') + arma.Items[i].nCano + sQuebraLinha;
        if da_descr  in FDetArmamentos then Result := Result + ACBrStr('DESCRI��O ARMA: ') + arma.Items[i].descr + #13#10;
       end;
    end;
  end;
end;


Function TfrlDANFeRLPaisagem.ManterCombustivel( inItem:  integer  ) : String;
begin
  Result := '';
  with FNFe.Det.Items[inItem].Prod do
  begin
    if comb.cProdANP > 0 then
    begin
      Result := sQuebraLinha;
      if dc_cProdANP    in FDetCombustiveis then Result := Result + ACBrStr('C�D. PRODUTO ANP: ') + IntToStr(comb.cProdANP) + sQuebraLinha;
      if dc_CODIF       in FDetCombustiveis then
                        if comb.CODIF > ''  then Result := Result + ACBrStr('AUTORIZA��O/CODIF: ') + comb.CODIF + sQuebraLinha;
      if dc_qTemp       in FDetCombustiveis then
                          if comb.qTemp > 0 then Result := Result + ACBrStr('QTD. FATURADA TEMP. AMBIENTE: ') +  FormatFloat('###,##0.0000', comb.qTemp) + sQuebraLinha;
      if dc_UFCons      in FDetCombustiveis then Result := Result + ACBrStr('UF DE CONSUMO: ') + comb.UFcons + sQuebraLinha;
      if comb.CIDE.qBCProd > 0 then
      begin
        if dc_qBCProd   in FDetCombustiveis then Result := Result + ACBrStr('BASE DE C�LCULO CIDE: ') + FormatFloat('###,##0.0000', comb.CIDE.qBCProd) + sQuebraLinha;
        if dc_vAliqProd in FDetCombustiveis then Result := Result + ACBrStr('AL�QUOTA CIDE: ') + FormatFloat('###,##0.0000', comb.CIDE.vAliqProd) + sQuebraLinha;
        if dc_vCIDE     in FDetCombustiveis then Result := Result + ACBrStr('VALOR CIDE: ') + FormatFloat('###,##0.00', comb.CIDE.vCIDE) + sQuebraLinha;
      end;
      if comb.encerrante.nBico > 0  then
      begin
        Result := Result + 'ENCERRANTE' + sQuebraLinha;
        Result := Result + 'BICO: ' +  IntToStr( comb.encerrante.nBico ) + sQuebraLinha;
        if comb.encerrante.nBomba > 0 then
          Result := Result + 'BOMBA: ' + IntToStr(comb.encerrante.nBomba) + sQuebraLinha;
        Result := Result + 'TANQUE: ' + IntToStr(comb.encerrante.nTanque) + sQuebraLinha;
        Result := Result + ACBrStr('NO IN�CIO: ' ) + FormatFloat('###,##0.000', comb.encerrante.vEncIni) + sQuebraLinha;
        Result := Result + 'NO FINAL: ' + FormatFloat('###,##0.000', comb.encerrante.vEncFin)+ #13#10;
      end
      else
        Result := Result + #13#10;
    end;
  end;
end;

Function TfrlDANFeRLPaisagem.ManterXpod( sXProd : String;  inItem : Integer ) : String;
begin
  Result := sXProd;
  if FImprimirDetalhamentoEspecifico = true then
  begin
    sQuebraLinha := QuebraLinha;
    Result := Result + ManterVeiculos( inItem );
    Result := Result + ManterMedicamentos( inItem );
    Result := Result + ManterArma( inItem );
    Result := Result + ManterCombustivel( inItem );
  end;
end;

Procedure TfrlDANFeRLPaisagem.AddFaturaReal;
begin

  case FNFe.Ide.indPag of
    ipVista : RlbDadoPagamento.caption := ACBrStr('PAGAMENTO � VISTA');
    ipPrazo : RlbDadoPagamento.caption := ACBrStr('PAGAMENTO � PRAZO');
    ipOutras: RlbDadoPagamento.caption := 'OUTROS';
  end;

  RLLabelNUmero.Caption         := '';
  RLLabelValor.Caption          := '';
  RLLabelDupl.Caption           := '';
  RLLabelLIQ.Caption            := '';
  RlbDadoNumero.caption         := '';
  RlbDadoValorOriginal.caption  := '';
  RlbDadoValorDesconto.caption  := '';
  RlbDadoValorLiquido.caption   := '';

  if fExibeCampoFatura then
  begin

    RLLabelNUmero.Caption := ACBrStr( 'N�MERO' );
    RLLabelValor.Caption  := ACBrStr( 'VALOR ORIGINAL' );
    RLLabelDupl.Caption   := ACBrStr( 'VALOR DESCONTO' );
    RLLabelLIQ.Caption    := ACBrStr( 'VALOR L�QUIDO' );

    if NaoEstaVazio(FNFe.Cobr.Fat.nFat) then
    begin
      with FNFe.Cobr.Fat do
      begin
        RlbDadoNumero.caption         := nFat;
        RlbDadoValorOriginal.caption  := FormatFloatBr(vOrig,'###,###,###,##0.00');
        RlbDadoValorDesconto.caption  := FormatFloatBr(vDesc,'###,###,###,##0.00');
        RlbDadoValorLiquido.caption   := FormatFloatBr(vLiq ,'###,###,###,##0.00');
      end;
    end;
  end;
end;


Function TfrlDANFeRLPaisagem.ManterDuplicatas : Integer;
Var
  x : Integer;
begin
  with FNFe.Cobr do
  begin
    if Dup.Count > 15 then
      Result := 15
    else
      Result := Dup.Count;

    for x := 0 to (Result - 1) do
    begin
      with Dup[x] do
      begin
        TRLLabel(FindComponent('rllFatNum'    + IntToStr(x + 1))).Caption := NDup;
        TRLLabel(FindComponent('rllFatData'   + IntToStr(x + 1))).Caption := FormatDateBr(DVenc);
        TRLLabel(FindComponent('rllFatValor'  + IntToStr(x + 1))).Caption := FormatFloatBr( VDup,'###,###,###,##0.00');
      end;
    end;
  end;
end;

// Aplica parametros para formatar o Danfe
procedure TfrlDANFeRLPaisagem.AplicaParametros;
var
  base: Integer;
  AltLinhaComun: Integer;
begin

  AltLinhaComun     := fAltLinhaComun;

  // ******** Cabe�alho ********
  base              := rliNatOpe.Top;//RLDraw6.Top;
  rliNatOpe.Height  := 2*AltLinhaComun + 1;
  rliNatOpe1.Top    := base + AltLinhaComun;
  RLDraw9.Height    := AltLinhaComun + 1;

  RLDraw10.Top      := base + AltLinhaComun;
  RLDraw10.Height   := AltLinhaComun + 1;
  RLDraw2.Top       := base + AltLinhaComun;
  RLDraw2.Height    := AltLinhaComun + 1;
  RLLabel28.Holder  := nil;//para o compando abaixo ter efeito.
  RLLabel28.Top     := base + 1;
  rllDadosVariaveis3_Descricao.Top:= base + 1;

  RLLabel29.Top := base + AltLinhaComun + 1;
  RLLabel30.Top := base + AltLinhaComun + 1;
  RLLabel31.Top := base + AltLinhaComun + 1;

  rllNatOperacao.Top        := base + AltLinhaComun - rllNatOperacao.Height;
  rllDadosVariaveis3.Top    := base + AltLinhaComun - rllDadosVariaveis3.Height;

  rllInscricaoEstadual.Top  := base + 2*AltLinhaComun - rllInscricaoEstadual.Height;
  rllInscrEstSubst.Top      := base + 2*AltLinhaComun - rllInscrEstSubst.Height;
  rllCNPJ.Top               := base + 2*AltLinhaComun - rllCNPJ.Height;

  // Bands remetente
  rlbEmitente.Height        := rliNatOpe.Height + rliEmitente.Height + 2; //168 + (2*AltLinhaComun - 60);

  // ******** Destinatario ********
  base := RLDraw15.Top;
  RLDraw15.Height := 3*AltLinhaComun + 1;
  RLDraw13.Height := 3*AltLinhaComun + 1;

  RLDraw16.Top    := base + AltLinhaComun;
  RLDraw17.Top    := base + 2*AltLinhaComun;
  RLDraw16.Left   := RLDraw13.Left;
  RLDraw17.Left   := RLDraw13.Left;

  RLDraw18.Height := 3*AltLinhaComun + 1;
  RLDraw19.Height := AltLinhaComun;

  RLDraw20.Top    := base + AltLinhaComun;
  RLDraw20.Height := AltLinhaComun;
  RLDraw21.Top    := base + AltLinhaComun;
  RLDraw21.Height := AltLinhaComun;

  RLDraw22.Top    := base + 2*AltLinhaComun;
  RLDraw22.Height := AltLinhaComun;
  RLDraw23.Top    := base + 2*AltLinhaComun;
  RLDraw23.Height := AltLinhaComun;
  RLDraw24.Top    := base + 2*AltLinhaComun;
  RLDraw24.Height := AltLinhaComun;

  // Linha 1
  RLLabel32.Top   := base + 1;
  RLLabel33.Top   := base + 1;
  RLLabel34.Top   := base + 1;

  rllDestNome.Top := base + AltLinhaComun - rllDestNome.Height;
  rllDestCNPJ.Top := base + AltLinhaComun - rllDestCNPJ.Height;
  rllEmissao.Top  := base + AltLinhaComun - rllEmissao.Height;

  // Linha 2
  RLLabel35.Top   := base + AltLinhaComun + 1;
  RLLabel36.Top   := base + AltLinhaComun + 1;
  RLLabel37.Top   := base + AltLinhaComun + 1;
  RLLabel38.Top   := base + AltLinhaComun + 1;

  rllDestEndereco.Top := base + 2*AltLinhaComun - rllDestEndereco.Height;
  rllDestBairro.Top   := base + 2*AltLinhaComun - rllDestBairro.Height;
  rllDestCEP.Top := base + 2*AltLinhaComun - rllDestCEP.Height;
  rllSaida.Top   := base + 2*AltLinhaComun - rllSaida.Height;

  // Linha 3
  RLLabel39.Top := base + 2*AltLinhaComun + 1;
  RLLabel40.Top := base + 2*AltLinhaComun + 1;
  RLLabel41.Top := base + 2*AltLinhaComun + 1;
  RLLabel42.Top := base + 2*AltLinhaComun + 1;
  RLLabel43.Top := base + 2*AltLinhaComun + 1;

  rllDestCidade.Top := base + 3*AltLinhaComun - rllDestCidade.Height; //13;
  rllDestFone.Top   := base + 3*AltLinhaComun - rllDestFone.Height;
  rllDestUF.Top     := base + 3*AltLinhaComun - rllDestUF.Height;
  rllDestIE.Top     := base + 3*AltLinhaComun - rllDestIE.Height;
  rllHoraSaida.Top  := base + 3*AltLinhaComun - rllHoraSaida.Height;

  RLAngleLabel1.Top   := RLDraw15.Top + 1;
  RLAngleLabel1.Height:= RLDraw15.Height - 3;
  RLAngleLabel2.Top   := RLDraw15.Top + 1;
  RLAngleLabel2.Height:= RLDraw15.Height - 3;
  RLAngleLabel1.AutoSize:= False;//vai ajustar o tamanho da fonte se necess�rio.
  RLAngleLabel2.AutoSize:= False;
  // Band destinatario
  rlbDestinatario.Height := RLDraw15.Height + 2;// 92 + (3*AltLinhaComun - 90);

  // ******** Fatura ********
  base := RLDrawFaturareal.Top;
  RLDrawFaturareal.Height:= AltLinhaComun + 1;
  RLDraw8.Height:=RLDrawFaturareal.Height;

  RLLabelPag.Top    := base + 1;
  RLLabelNUmero.Top := RLLabelPag.Top;
  RLLabelValor.Top  := RLLabelPag.Top;
  RLLabelDupl.Top   := RLLabelPag.Top;
  RLLabelLIQ.Top    := RLLabelPag.Top;

  RLDraw27.Top := RLLabelPag.Top + RLLabelPag.Height ;
  RLLabel5.Height:= RLDraw27.Top - base - 2;

  RlbDadoPagamento.Top     := base + AltLinhaComun - RlbDadoPagamento.Height;
  if RlbDadoPagamento.Top < RLDraw27.Top then
    RlbDadoPagamento.Top := RLDraw27.Top + 1;
  RlbDadoNumero.Top        := RlbDadoPagamento.Top;
  RlbDadoValorOriginal.Top := RlbDadoPagamento.Top;
  RlbDadoValorDesconto.Top := RlbDadoPagamento.Top;
  RlbDadoValorLiquido.Top  := RlbDadoPagamento.Top;


  RLAngleLabel3.Top   := RLDrawFaturareal.Top + 1;
  RLAngleLabel3.Height:= RLDrawFaturareal.Height - 3;
  RLAngleLabel3.AutoSize := False;
  // Band fatura
  RLBFaturaReal.Height:=RLDrawFaturareal.Top + RLDrawFaturareal.Height + 2;

  // ******** C�lculo do imposto ********
  base := RLDraw29.Top;
  RLDraw29.Height := 2*AltLinhaComun + 1;
  rliDivImposto0.Height := 2*AltLinhaComun + 1;

  RLDraw30.Top := base + AltLinhaComun;

  rliDivImposto1.Height := AltLinhaComun;
  rliDivImposto2.Height := AltLinhaComun;
  rliDivImposto3.Height := AltLinhaComun;
  rliDivImposto4.Height := AltLinhaComun;
  rliDivImposto5.Height := AltLinhaComun;
  rliDivImposto1.Top := base;
  rliDivImposto2.Top := base;
  rliDivImposto3.Top := base;
  rliDivImposto4.Top := base;
  rliDivImposto5.Top := base;

  RLDraw33.Height := AltLinhaComun;
  RLDraw34.Height := AltLinhaComun;
  RLDraw35.Height := AltLinhaComun;
  RLDraw6.Height  := AltLinhaComun;
  RLDraw12.Height := AltLinhaComun;
  RLDraw33.Top   := base + AltLinhaComun;
  RLDraw34.Top   := base + AltLinhaComun;
  RLDraw35.Top   := base + AltLinhaComun;
  RLDraw6.Top    := base + AltLinhaComun;
  RLDraw12.Top   := base + AltLinhaComun;

  // Linha 1
  rllTituloBaseICMS.Top   := base + 1;
  rllTituloValorICMS.Top  := base + 1;
  rllTituloBaseICMSST.Top := base + 1;
  rllTituloValorICMSST.Top   := base + 1;
  rllTituloTotalTributos.Top := base + 1;
  rlLabel48.Top := base + 1;

  rllBaseICMS.Top   := base + AltLinhaComun - rllBaseICMS.Height;
  rllValorICMS.Top  := base + AltLinhaComun - rllValorICMS.Height;
  rllBaseICMSST.Top := base + AltLinhaComun - rllBaseICMSST.Height;
  rllValorICMSST.Top   := base + AltLinhaComun - rllValorICMSST.Height;
  rllTotalTributos.Top := base + AltLinhaComun - rllTotalTributos.Height;
  rllTotalProdutos.Top := base + AltLinhaComun - rllTotalProdutos.Height;

  // Linha 2
  RLLabel49.Top := base + AltLinhaComun + 1;
  RLLabel50.Top := base + AltLinhaComun + 1;
  RLLabel51.Top := base + AltLinhaComun + 1;
  RLLabel52.Top := base + AltLinhaComun + 1;
  RLLabel53.Top := base + AltLinhaComun + 1;
  RLLabel54.Top := base + AltLinhaComun + 1;

  rllValorFrete.Top  := base + 2*AltLinhaComun - rllValorFrete.Height;
  rllValorSeguro.Top := base + 2*AltLinhaComun - rllValorSeguro.Height;
  rllDescontos.Top   := base + 2*AltLinhaComun - rllDescontos.Height;
  rllAcessorias.Top  := base + 2*AltLinhaComun - rllAcessorias.Height;
  rllValorIPI.Top    := base + 2*AltLinhaComun - rllValorIPI.Height;
  rllTotalNF.Top     := base + 2*AltLinhaComun - rllTotalNF.Height;

  RLLabel25.Top       := base + AltLinhaComun;
  RLLabel25.Height    := AltLinhaComun-1;

  RLAngleLabel4.Top   := RLDraw29.Top + 1;
  RLAngleLabel4.Height:= RLDraw29.Height - 3;
  RLAngleLabel5.Top   := RLDraw29.Top + 1;
  RLAngleLabel5.Height:= RLDraw29.Height - 3;
  RLAngleLabel4.AutoSize:= False;
  RLAngleLabel5.AutoSize:= False;
  // Band Calculo do imposto
  rlbImposto.Height      := 62  + (2*AltLinhaComun - 60);

  // ******** Transportadora ********
  base := rliTransp.Top;
  rliTransp.Height := 3*AltLinhaComun + 2;
  if FNFe.Transp.Vol.Count > 1 then//contem mais volumes na DANFE
    rliTransp.Height := rliTransp.Height + ((rllTransQTDE.Height) * (FNFe.Transp.Vol.Count - 1));//a quantidade de volumes pode variar, entao � feito um recalculo

  RLDraw38.Top := base + AltLinhaComun;
  RLDraw39.Top := base + 2*AltLinhaComun;

  RLDraw41.Top := base;
  RLDraw47.Top := base;
  RLDraw48.Top := base;
  RLDraw49.Top := base;
  rliTransp5.Top := base;

  RLDraw41.Height := AltLinhaComun;
  RLDraw47.Height := AltLinhaComun;
  RLDraw48.Height := AltLinhaComun;
  RLDraw49.Height := 2*AltLinhaComun;
  rliTransp5.Height := rliTransp.Height;
  rliTransp6.Height := rliTransp.Height;

  RLDraw70.Top    := base + AltLinhaComun;
  RLDraw70.Height := AltLinhaComun;

  rliTransp1.Top := base + 2*AltLinhaComun;
  rliTransp2.Top := base + 2*AltLinhaComun;
  rliTransp3.Top := base + 2*AltLinhaComun;
  rliTransp4.Top := base + 2*AltLinhaComun;
  rliTransp1.Height := rliTransp.Height - rliTransp1.Top;//AltLinhaComun;
  rliTransp2.Height := rliTransp1.Height;
  rliTransp3.Height := rliTransp1.Height;
  rliTransp4.Height := rliTransp1.Height;

  //Linha 1
  RLLabel55.Top := base + 1;
  RLLabel56.Top := base + 1;
  RLLabel59.Top := base + 1;
  RLLabel60.Top := base + 1;
  RLLabel61.Top := base + 1;
  RLLabel62.Top := base + 1;

  rllTransNome.Top       := base + AltLinhaComun - rllTransNome.Height;
  rllTransModFrete.Top   := base + AltLinhaComun - rllTransModFrete.Height;
  rllTransCodigoANTT.Top := base + AltLinhaComun - rllTransCodigoANTT.Height;
  rllTransPlaca.Top      := base + AltLinhaComun - rllTransPlaca.Height;
  rllTransUFPlaca.Top    := base + AltLinhaComun - rllTransUFPlaca.Height;
  rllTransCNPJ.Top       := base + AltLinhaComun - rllTransCNPJ.Height;

  //Linha 2
  RLLabel63.Top := base + AltLinhaComun + 1;
  RLLabel64.Top := base + AltLinhaComun + 1;
  RLLabel65.Top := base + AltLinhaComun + 1;
  RLLabel66.Top := base + AltLinhaComun + 1;

  rllTransEndereco.Top := base + 2*AltLinhaComun - rllTransEndereco.Height;
  rllTransCidade.Top   := base + 2*AltLinhaComun - rllTransCidade.Height;
  rllTransUF.Top := base + 2*AltLinhaComun - rllTransUF.Height;
  rllTransIE.Top := base + 2*AltLinhaComun - rllTransIE.Height;

  //Linha 3
  RLLabel67.Top := base + 2*AltLinhaComun + 1;
  RLLabel68.Top := base + 2*AltLinhaComun + 1;
  RLLabel69.Top := base + 2*AltLinhaComun + 1;
  RLLabel70.Top := base + 2*AltLinhaComun + 1;
  RLLabel71.Top := base + 2*AltLinhaComun + 1;
  RLLabel72.Top := base + 2*AltLinhaComun + 1;

  rllTransQTDE.Top      := base + 3*AltLinhaComun - rllTransQTDE.Height;
  rllTransEspecie.Top   := base + 3*AltLinhaComun - rllTransEspecie.Height;
  rllTransMarca.Top     := base + 3*AltLinhaComun - rllTransMarca.Height;
  rllTransNumeracao.Top := base + 3*AltLinhaComun - rllTransNumeracao.Height;
  rllTransPesoBruto.Top := base + 3*AltLinhaComun - rllTransPesoBruto.Height;
  rllTransPesoLiq.Top   := base + 3*AltLinhaComun - rllTransPesoLiq.Height;

  RLAngleLabel6.Top   := rliTransp.Top + 1;
  RLAngleLabel6.Height:= rliTransp.Height - 3;
  RLAngleLabel7.Top   := rliTransp.Top + 1;
  RLAngleLabel7.Height:= rliTransp.Height - 3;
  RLAngleLabel6.AutoSize:= False;
  RLAngleLabel7.AutoSize:= False;
  // Band Transportadora
  rlbTransp.Height       := rliTransp.Height + 2;// 110 + (3*AltLinhaComun - 90);

  // ******** Produtos ********
  rlbObsItem.Height      := 12 + fEspacoEntreProdutos; // Remove espa�o entre produtos com EspacoEntreProdutos = 0
end;

end.
