{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2010                                        }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrNFeXmlWriter;

interface

uses
  Classes, SysUtils,
  ACBrLibXml2, ACBrXmlWriter,
  pcnNFe, pcnGerador, pcnConversao, pcnNFeConsts;

type
  TNFeXmlWriterOptions = class(TACBrXmlWriterOptions)
  private
    FAjustarTagNro: boolean;
    FGerarTagIPIparaNaoTributado: boolean;
    FNormatizarMunicipios: boolean;
    FGerarTagAssinatura: TpcnTagAssinatura;
    FPathArquivoMunicipios: string;
    FValidarInscricoes: boolean;
    FValidarListaServicos: boolean;
    FCamposFatObrigatorios: boolean;

  published
    property AjustarTagNro: boolean read FAjustarTagNro write FAjustarTagNro;
    property GerarTagIPIparaNaoTributado: boolean read FGerarTagIPIparaNaoTributado write FGerarTagIPIparaNaoTributado;
    property NormatizarMunicipios: boolean read FNormatizarMunicipios write FNormatizarMunicipios;
    property GerarTagAssinatura: TpcnTagAssinatura read FGerarTagAssinatura write FGerarTagAssinatura;
    property PathArquivoMunicipios: string read FPathArquivoMunicipios write FPathArquivoMunicipios;
    property ValidarInscricoes: boolean read FValidarInscricoes write FValidarInscricoes;
    property ValidarListaServicos: boolean read FValidarListaServicos write FValidarListaServicos;
    property CamposFatObrigatorios: boolean read FCamposFatObrigatorios write FCamposFatObrigatorios;

  end;

  TNFeXmlWriter = class(TACBrXmlWriter)
  private
    FNFe: TNFe;

    Usar_tcDe4: boolean;
    Versao: string;
    ChaveNFe: string;
    FIdCSRT: integer;
    FCSRT: string;

    function GerarInfNFe: TACBrXmlNode;
    function GerarIde: TACBrXmlNode;
    function GerarIdeNFref: TACBrXmlNodeArray;
    function GerarIdeNFrerefNFe(const i: integer): TACBrXmlNode;
    function GerarIdeNFrefRefNF(const i: integer): TACBrXmlNode;
    function GerarRefNFP(const i: integer): TACBrXmlNode;
    function GerarIdeNFrerefCTe(const i: integer): TACBrXmlNode;
    function GerarRefECF(const i: integer): TACBrXmlNode;
    function GerarEmit: TACBrXmlNode;
    function GerarEmitEnderEmit: TACBrXmlNode;
    function GerarAvulsa: TACBrXmlNode;
    function GerarDest: TACBrXmlNode;
    function GerarDestEnderDest(var UF: string): TACBrXmlNode;
    function GerarRetirada: TACBrXmlNode;
    function GerarEntrega: TACBrXmlNode;
    function GerarautXML: TACBrXmlNodeArray;
    function GerarDet: TACBrXmlNodeArray;
    function GerarDetProd(const i: integer): TACBrXmlNode;
    function GerarDetProdDI(const i: integer): TACBrXmlNodeArray;
    function GerarDetProdDIadi(const i, j: integer): TACBrXmlNodeArray;
    function GerarDetProdNVE(const i: integer): TACBrXmlNodeArray;
    function GerarDetProddetExport(const i: integer): TACBrXmlNodeArray;
    function GerarDetProdRastro(const i: integer): TACBrXmlNodeArray;
    function GerarDetProdVeicProd(const i: integer): TACBrXmlNode;
    function GerarDetProdMed(const i: integer): TACBrXmlNodeArray;
    function GerarDetProdArma(const i: integer): TACBrXmlNodeArray;
    function GerarDetProdComb(const i: integer): TACBrXmlNode;
    function GerarDetProdCombCIDE(const i: integer): TACBrXmlNode;
    function GerarDetProdCombencerrante(const i: integer): TACBrXmlNode;
    function GerarDetProdCombICMS(const i: integer): TACBrXmlNode;
    function GerarDetProdCombICMSInter(const i: integer): TACBrXmlNode;
    function GerarDetProdCombICMSCons(const i: integer): TACBrXmlNode;
    function GerarDetImposto(const i: integer): TACBrXmlNode;
    function GerarDetImpostoICMS(const i: integer): TACBrXmlNode;
    function GerarDetImpostoIPI(const i: integer): TACBrXmlNode;
    function GerarDetImpostoII(const i: integer): TACBrXmlNode;
    function GerarDetImpostoPIS(const i: integer): TACBrXmlNode;
    function GerarDetImpostoPISST(const i: integer): TACBrXmlNode;
    function GerarDetImpostoCOFINS(const i: integer): TACBrXmlNode;
    function GerarDetImpostoCOFINSST(const i: integer): TACBrXmlNode;
    function GerarDetImpostoISSQN(const i: integer): TACBrXmlNode;
    function GerarDetDevol(const i: integer): TACBrXmlNode;
    function GerarDetImpostoICMSUFDest(const i: integer): TACBrXmlNode;
    function GerarTotal: TACBrXmlNode;
    function GerarTotalICMSTotal: TACBrXmlNode;
    function GerarTotalISSQNtot: TACBrXmlNode;
    function GerarTotalretTrib: TACBrXmlNode;
    function GerarCobr: TACBrXmlNode;
    function GerarCobrFat: TACBrXmlNode;
    function GerarCobrDup: TACBrXmlNodeArray;
    function Gerarpag: TACBrXmlNodeArray;
    function GerarTransp: TACBrXmlNode;
    function GerarTranspTransporta: TACBrXmlNode;
    function GerarTranspRetTransp: TACBrXmlNode;
    function GerarTranspVeicTransp: TACBrXmlNode;
    function GerarTranspReboque: TACBrXmlNodeArray;
    function GerarTranspVol: TACBrXmlNodeArray;
    function GerarTranspVolLacres(i: integer): TACBrXmlNodeArray;
    function GerarInfAdic: TACBrXmlNode;
    function GerarInfAdicObsCont: TACBrXmlNodeArray;
    function GerarInfAdicObsFisco: TACBrXmlNodeArray;
    function GerarInfAdicProcRef: TACBrXmlNodeArray;
    function GerarExporta: TACBrXmlNode;
    function GerarCompra: TACBrXmlNode;
    function GerarCana: TACBrXmlNode;
    function GerarforDia: TACBrXmlNodeArray;
    function GerarDeduc: TACBrXmlNodeArray;
    function GerarinfRespTec: TACBrXmlNode;
    function GerarProtNFe: TACBrXmlNode;

    function GetOpcoes: TNFeXmlWriterOptions;
    procedure SetOpcoes(AValue: TNFeXmlWriterOptions);

    procedure AjustarMunicipioUF(out xUF: string; out xMun: string;
      out cMun: integer; cPais: integer; const vxUF, vxMun: string; vcMun: integer);

  protected
    function CreateOptions: TNFeXmlWriterOptions; override;

  public
    constructor Create(AOwner: TNFe); reintroduce;
    destructor Destroy; override;

    function GerarXml: boolean; override;
    function ObterNomeArquivo: string; override;

    property Opcoes: TNFeXmlWriterOptions read GetOpcoes write SetOpcoes;
    property NFe: TNFe read FNFe write FNFe;
    property IdCSRT: integer read FIdCSRT write FIdCSRT;
    property CSRT: string read FCSRT write FCSRT;

  end;

implementation

uses
  variants, dateutils,
  pcnConversaoNFe, ACBrValidador, pcnAuxiliar,
  ACBrDFeUtil, pcnConsts, ACBrUtil;

constructor TNFeXmlWriter.Create(AOwner: TNFe);
begin
  inherited Create;

  TNFeXmlWriterOptions(Opcoes).AjustarTagNro := True;
  TNFeXmlWriterOptions(Opcoes).GerarTagIPIparaNaoTributado := True;
  TNFeXmlWriterOptions(Opcoes).NormatizarMunicipios := False;
  TNFeXmlWriterOptions(Opcoes).PathArquivoMunicipios := '';
  TNFeXmlWriterOptions(Opcoes).GerarTagAssinatura := taSomenteSeAssinada;
  TNFeXmlWriterOptions(Opcoes).ValidarInscricoes := False;
  TNFeXmlWriterOptions(Opcoes).ValidarListaServicos := False;
  TNFeXmlWriterOptions(Opcoes).CamposFatObrigatorios := True;
  FNFe    := AOwner;
end;

destructor TNFeXmlWriter.Destroy;
begin
  Opcoes.Free;
  inherited Destroy;
end;

function TNFeXmlWriter.CreateOptions: TNFeXmlWriterOptions;
begin
  Result := TNFeXmlWriterOptions.Create();
end;

function TNFeXmlWriter.GetOpcoes: TNFeXmlWriterOptions;
begin
  Result := TNFeXmlWriterOptions(FOpcoes);
end;

procedure TNFeXmlWriter.SetOpcoes(AValue: TNFeXmlWriterOptions);
begin
  FOpcoes := AValue;
end;

procedure TNFeXmlWriter.AjustarMunicipioUF(out xUF: string; out xMun: string;
  out cMun: integer; cPais: integer; const vxUF, vxMun: string; vcMun: integer);
var
  PaisBrasil: boolean;
begin
  PaisBrasil := cPais = CODIGO_BRASIL;
  cMun := IIf(PaisBrasil, vcMun, CMUN_EXTERIOR);
  xMun := IIf(PaisBrasil, vxMun, XMUN_EXTERIOR);
  xUF := IIf(PaisBrasil, vxUF, UF_EXTERIOR);

  if Opcoes.NormatizarMunicipios then
    if ((EstaZerado(cMun)) and (xMun <> XMUN_EXTERIOR)) then
      cMun := ObterCodigoMunicipio(xMun, xUF, Opcoes.FPathArquivoMunicipios)
    else if ((EstaVazio(xMun)) and (cMun <> CMUN_EXTERIOR)) then
      xMun := ObterNomeMunicipio(xUF, cMun, Opcoes.FPathArquivoMunicipios);

end;

function TNFeXmlWriter.ObterNomeArquivo: string;
begin
  Result := OnlyNumber(FNFe.infNFe.ID) + '-nfe.xml';
end;

function TNFeXmlWriter.GerarXml: boolean;
var
  Gerar: boolean;
  xCNPJCPF: string;
  nfeNode, xmlNode: TACBrXmlNode;
begin
  Result := False;

  ListaDeAlertas.Clear;

  Usar_tcDe4 := (NFe.infNFe.Versao >= 3.10);
  Versao := Copy(NFe.infNFe.VersaoStr, 9, 4);

  xCNPJCPF := nfe.emit.CNPJCPF;

  if not EstaVazio(nfe.Avulsa.CNPJ) then
    xCNPJCPF := nfe.Avulsa.CNPJ;

  ChaveNFe := GerarChaveAcesso(nfe.ide.cUF, nfe.ide.dEmi, xCNPJCPF,
      nfe.ide.serie, nfe.ide.nNF, StrToInt(TpEmisToStr(nfe.ide.tpEmis)),
     { nfe.ide.cNF} 0, nfe.ide.modelo);

  nfe.infNFe.ID := 'NFe' + ChaveNFe;
  nfe.ide.cDV := ExtrairDigitoChaveAcesso(nfe.infNFe.ID);
  nfe.Ide.cNF := ExtrairCodigoChaveAcesso(nfe.infNFe.ID);

  FDocument.Clear();
  nfeNode := FDocument.CreateElement('NFe', 'http://www.portalfiscal.inf.br/nfe');

  if nfe.procNFe.nProt <> '' then
  begin
    xmlNode := FDocument.CreateElement('nfeProc', 'http://www.portalfiscal.inf.br/nfe');
    xmlNode.SetAttribute('versao', FloatToString(nfe.infNFe.Versao, '.', '#0.00'));
    xmlNode.AppendChild(nfeNode);
    FDocument.Root := xmlNode;
  end
  else
  begin
    FDocument.Root := nfeNode;
  end;

  xmlNode := GerarInfNFe();
  nfeNode.AppendChild(xmlNode);

  if nfe.infNFeSupl.qrCode <> '' then
  begin
    xmlNode := nfeNode.AddChild('infNFeSupl');
    xmlNode.AppendChild(AddNode(tcStr, 'ZX02', 'qrCode', 100, 600,
                                1, '<![CDATA[' + nfe.infNFeSupl.qrCode + ']]>', DSC_INFQRCODE, False));

    if nfe.infNFe.Versao >= 4 then
      xmlNode.AppendChild(AddNode(tcStr, 'ZX03', 'urlChave', 21,
                                  85, 1, nfe.infNFeSupl.urlChave, DSC_URLCHAVE, False));
  end;

  if Opcoes.GerarTagAssinatura <> taNunca then
  begin
    Gerar := True;
    if Opcoes.GerarTagAssinatura = taSomenteSeAssinada then
      Gerar := ((NFe.signature.DigestValue <> '') and
                (NFe.signature.SignatureValue <> '') and
                (NFe.signature.X509Certificate <> ''));

    if Opcoes.GerarTagAssinatura = taSomenteParaNaoAssinada then
       Gerar := ((NFe.signature.DigestValue = '') and
                 (NFe.signature.SignatureValue = '') and
                 (NFe.signature.X509Certificate = ''));
    if Gerar then
    begin
      FNFe.signature.URI := '#NFe' + OnlyNumber(NFe.infNFe.ID);
      xmlNode := GerarSignature(FNFe.signature);
      nfeNode.AppendChild(xmlNode);
    end;
  end;

  if nfe.procNFe.nProt <> '' then
  begin
    xmlNode := GerarProtNFe;
    FDocument.Root.AppendChild(xmlNode);
  end;
end;

function TNFeXmlWriter.GerarInfNFe: TACBrXmlNode;
var
  nodeArray: TACBrXmlNodeArray;
  i: integer;
begin
  Result := FDocument.CreateElement('infNFe');
  Result.SetAttribute('Id', nfe.infNFe.ID);
  Result.SetAttribute('versao', FloatToString(nfe.infNFe.Versao, '.', '#0.00'));

  Result.AppendChild(GerarIde);
  Result.AppendChild(GerarEmit);
  Result.AppendChild(GerarAvulsa);

  if (nfe.Dest.CNPJCPF <> '') or (nfe.Dest.idEstrangeiro <> '') or
    (nfe.Dest.EnderDest.UF = 'EX') or (nfe.Ide.modelo <> 65) then
    Result.AppendChild(GerarDest);

  Result.AppendChild(GerarRetirada);
  Result.AppendChild(GerarEntrega);

  nodeArray := GerarautXML;
  for i := 0 to nfe.autXML.Count - 1 do
  begin
    Result.AppendChild(nodeArray[i]);
  end;

  nodeArray := GerarDet;
  for i := 0 to nfe.Det.Count - 1 do
  begin
    Result.AppendChild(nodeArray[i]);
  end;

  Result.AppendChild(GerarTotal);
  Result.AppendChild(GerarTransp);
  Result.AppendChild(GerarCobr);

  if ((nfe.infNFe.Versao >= 3) and (nfe.Ide.modelo <> 55)) or
    (nfe.infNFe.Versao >= 4) then
  begin
    nodeArray := Gerarpag;
    if (nfe.infNFe.Versao >= 4) then
      Result.AppendChild(nodeArray[0])
    else
    begin
      for i := 0 to nfe.pag.Count - 1 do
      begin
        Result.AppendChild(nodeArray[i]);
      end;
    end;
  end;

  Result.AppendChild(GerarInfAdic);
  Result.AppendChild(GerarExporta);
  Result.AppendChild(GerarCompra);
  Result.AppendChild(GerarCana);

  if nfe.infNFe.Versao >= 4 then
    Result.AppendChild(GerarinfRespTec);
end;

function TNFeXmlWriter.GerarIde: TACBrXmlNode;
var
  nodeArray: TACBrXmlNodeArray;
  i: integer;
begin
  Result := FDocument.CreateElement('ide');
  Result.AppendChild(AddNode(tcInt, 'B02', 'cUF    ', 02, 02, 1, nfe.ide.cUF, DSC_CUF));

  if not ValidarCodigoUF(nfe.ide.cUF) then
    wAlerta('B02', 'cUF', DSC_CUF, ERR_MSG_INVALIDO);

  Result.AppendChild(AddNode(tcStr, 'B03', 'cNF    ', 08, 08, 1,
    IntToStrZero(ExtrairCodigoChaveAcesso(nfe.infNFe.ID), 8), DSC_CNF));
  Result.AppendChild(AddNode(tcStr, 'B04', 'natOp  ', 01, 60, 1,
    nfe.ide.natOp, DSC_NATOP));

  if nfe.infNFe.Versao < 4 then
    Result.AppendChild(AddNode(tcStr, 'B05', 'indPag ', 01, 01, 1,
      IndpagToStr(nfe.ide.indPag), DSC_INDPAG));

  Result.AppendChild(AddNode(tcInt, 'B06', 'mod    ', 02, 02, 1,
    nfe.ide.modelo, DSC_MOD));
  Result.AppendChild(AddNode(tcInt, 'B07', 'serie  ', 01, 03, 1,
    nfe.ide.serie, DSC_SERIE));
  Result.AppendChild(AddNode(tcInt, 'B08', 'nNF    ', 01, 09, 1, nfe.ide.nNF, DSC_NNF));

  if nfe.infNFe.Versao >= 3 then
  begin
    Result.AppendChild(AddNode(tcStr, 'B09', 'dhEmi   ', 25, 25, 1,
      DateTimeTodh(nfe.ide.dEmi) + GetUTC(CodigoParaUF(nfe.ide.cUF), nfe.ide.dEmi),
      DSC_DEMI));

    if (nfe.ide.modelo = 55) and (nfe.ide.dSaiEnt <> 0) then
      Result.AppendChild(AddNode(tcStr, 'B10', 'dhSaiEnt', 25, 25,
        0, DateTimeTodh(nfe.ide.dSaiEnt) + GetUTC(CodigoParaUF(nfe.ide.cUF),
        nfe.ide.dSaiEnt), DSC_DSAIENT));
  end
  else
  begin
    Result.AppendChild(AddNode(tcDat, 'B09', 'dEmi   ', 10, 10, 1,
      nfe.ide.dEmi, DSC_DEMI));
    Result.AppendChild(AddNode(tcDat, 'B10', 'dSaiEnt', 10, 10, 0,
      nfe.ide.dSaiEnt, DSC_DSAIENT));
    if nfe.Ide.dSaiEnt > 0 then
      Result.AppendChild(AddNode(tcHor, 'B10a', 'hSaiEnt', 08, 08,
        0, nfe.ide.hSaiEnt, DSC_HSAIENT));
  end;

  Result.AppendChild(AddNode(tcStr, 'B11', 'tpNF   ', 01, 01, 1,
    tpNFToStr(nfe.ide.tpNF), DSC_TPNF));

  if nfe.infNFe.Versao >= 3 then
  begin
    Result.AppendChild(AddNode(tcStr, 'B11a', 'idDest', 01, 01, 1,
      DestinoOperacaoToStr(nfe.Ide.idDest), DSC_IDDEST));
  end;

  Result.AppendChild(AddNode(tcInt, 'B12', 'cMunFG ', 07, 07, 1,
    nfe.ide.cMunFG, DSC_CMUNFG));
  if not ValidarMunicipio(nfe.ide.cMunFG) then
    wAlerta('B12', 'cMunFG', DSC_CMUNFG, ERR_MSG_INVALIDO);

  if nfe.infNFe.Versao < 3 then
  begin
    (**)nodeArray := GerarIdeNFref;
    for i := 0 to nfe.ide.NFref.Count - 1 do
    begin
      Result.AppendChild(nodeArray[i]);
    end;
  end;

  //Gerador.IDNivel := 'B01';
  Result.AppendChild(AddNode(tcStr, 'B21', 'tpImp  ', 01, 01, 1,
    tpImpToStr(nfe.Ide.tpImp), DSC_TPIMP));
  Result.AppendChild(AddNode(tcStr, 'B22', 'tpEmis ', 01, 01, 1,
    tpEmisToStr(nfe.Ide.tpEmis), DSC_TPEMIS));
  Result.AppendChild(AddNode(tcInt, 'B23', 'cDV    ', 01, 01, 1, nfe.Ide.cDV, DSC_CDV));
  Result.AppendChild(AddNode(tcStr, 'B24', 'tpAmb  ', 01, 01, 1,
    tpAmbToStr(nfe.Ide.tpAmb), DSC_TPAMB));
  Result.AppendChild(AddNode(tcStr, 'B25', 'finNFe ', 01, 01, 1,
    finNFeToStr(nfe.Ide.finNFe), DSC_FINNFE));

  if nfe.infNFe.Versao >= 3 then
  begin
    Result.AppendChild(AddNode(tcStr, 'B25a', 'indFinal', 01, 01, 1,
      ConsumidorFinalToStr(nfe.Ide.indFinal), DSC_INDFINAL));
    Result.AppendChild(AddNode(tcStr, 'B25b', 'indPres ', 01, 01, 1,
      PresencaCompradorToStr(nfe.Ide.indPres), DSC_INDPRES));
  end;

  Result.AppendChild(AddNode(tcStr, 'B26', 'procEmi', 01, 01, 1,
    procEmiToStr(nfe.Ide.procEmi), DSC_PROCEMI));
  Result.AppendChild(AddNode(tcStr, 'B27', 'verProc', 01, 20, 1,
    nfe.Ide.verProc, DSC_VERPROC));

  if (nfe.Ide.dhCont > 0) or (nfe.Ide.xJust <> '') then
  begin
    if nfe.infNFe.Versao >= 3 then
      Result.AppendChild(AddNode(tcStr, 'B28', 'dhCont ', 25, 25,
        1, DateTimeTodh(nfe.ide.dhCont) + GetUTC(CodigoParaUF(nfe.ide.cUF),
        nfe.ide.dhCont), DSC_DHCONT))
    else
      Result.AppendChild(AddNode(tcStr, 'B28', 'dhCont ', 19, 19,
        1, DateTimeTodh(nfe.Ide.dhCont), DSC_DHCONT));

    Result.AppendChild(AddNode(tcStr, 'B29', 'xJust  ', 01, 256, 1,
      nfe.ide.xJust, DSC_XJUSTCONT));
  end;

  if nfe.infNFe.Versao >= 3 then
  begin
    (**)nodeArray := GerarIdeNFref;
    for i := 0 to nfe.ide.NFref.Count - 1 do
    begin
      Result.AppendChild(nodeArray[i]);
    end;
  end;
end;

function TNFeXmlWriter.GerarIdeNFref: TACBrXmlNodeArray;
var
  i: integer;
begin
  Result := nil;
  SetLength(Result, nfe.ide.NFref.Count);
  // Gera TAGs se NÃO for uma NFe referência
  for i := 0 to nfe.ide.NFref.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('NFref');
    if nfe.ide.NFref[i].refNFe <> '' then
      Result[i].AppendChild(GerarIdeNFrerefNFe(i));
    if nfe.Ide.NFref[i].RefNF.nNF > 0 then
      Result[i].AppendChild(GerarIdeNFrefRefNF(i));
    if nfe.ide.NFref[i].RefNFP.nNF > 0 then
      Result[i].AppendChild(GerarRefNFP(i));
    if nfe.ide.NFref[i].refCTe <> '' then
      Result[i].AppendChild(GerarIdeNFrerefCTe(i));
    if nfe.ide.NFref[i].RefECF.nCOO <> '' then
      Result[i].AppendChild(GerarRefECF(i));
  end;

  if nfe.ide.NFref.Count > 500 then
    wAlerta('B12a', 'NFref', DSC_QNF, ERR_MSG_MAIOR_MAXIMO + '500');

end;

function TNFeXmlWriter.GerarIdeNFrerefNFe(const i: integer): TACBrXmlNode;
begin
  Result := AddNode(tcEsp, 'B13', 'refNFe', 44, 44, 1,
    OnlyNumber(nfe.ide.NFref[i].refNFe), DSC_REFNFE);
  if not ValidarChave(nfe.ide.NFref[i].refNFe) then
    wAlerta('B13', 'refNFe', DSC_REFNFE, ERR_MSG_INVALIDO);
end;

function TNFeXmlWriter.GerarIdeNFrefRefNF(const i: integer): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('refNF');
  Result.AppendChild(AddNode(tcInt, 'B15', 'cUF   ', 02, 02, 1,
    nfe.Ide.NFref[i].RefNF.cUF, DSC_CUF));

  if not ValidarCodigoUF(nfe.Ide.NFref[i].RefNF.cUF) then
    wAlerta('B15', 'cUF', DSC_CUF, ERR_MSG_INVALIDO);

  Result.AppendChild(AddNode(tcEsp, 'B16', 'AAMM  ', 04, 04, 1,
    nfe.Ide.NFref[i].RefNF.AAMM, DSC_AAMM));

  if not ValidarAAMM(nfe.Ide.NFref[i].RefNF.AAMM) then
    wAlerta('B16', 'AAMM', DSC_AAMM, 'Periodo inválido');

  Result.AppendChild(AddNodeCNPJCPF('B17', 'B17', nfe.Ide.NFref[i].RefNF.CNPJ));
  Result.AppendChild(AddNode(tcInt, 'B18', 'mod   ', 02, 02, 1,
    nfe.Ide.NFref[i].RefNF.Modelo, DSC_MOD));

  if not ValidarMod(nfe.Ide.NFref[i].RefNF.Modelo, nfe.infNFe.Versao) then
    wAlerta('B18', 'mod', DSC_MOD, 'Modelo de documento inválido');

  Result.AppendChild(AddNode(tcInt, 'B19', 'serie ', 01, 03, 1,
    nfe.ide.NFref[i].RefNF.serie, DSC_SERIE));
  Result.AppendChild(AddNode(tcInt, 'B20', 'nNF   ', 01, 09, 1,
    nfe.Ide.NFref[i].RefNF.nNF, DSC_NNF));
end;

function TNFeXmlWriter.GerarRefNFP(const i: integer): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('refNFP');
  Result.AppendChild(AddNode(tcInt, 'B20b', 'cUF   ', 02, 02, 1,
    nfe.Ide.NFref[i].RefNFP.cUF, DSC_CUF));

  if not ValidarCodigoUF(nfe.Ide.NFref[i].RefNFP.cUF) then
    wAlerta('B20b', 'cUF', DSC_CUF, ERR_MSG_INVALIDO);

  Result.AppendChild(AddNode(tcEsp, 'B20c', 'AAMM  ', 04, 04, 1,
    nfe.Ide.NFref[i].RefNFP.AAMM, DSC_AAMM));

  if not ValidarAAMM(nfe.Ide.NFref[i].RefNFP.AAMM) then
    wAlerta('B20c', 'AAMM', DSC_AAMM, 'Periodo inválido');

  Result.AppendChild(AddNodeCNPJCPF('B20d', 'B20e', nfe.Ide.NFref[i].RefNFP.CNPJCPF));
  Result.AppendChild(AddNode(tcStr, 'B20f', 'IE   ', 01, 14, 1,
    nfe.Ide.NFref[i].RefNFP.IE, DSC_IE));
  Result.AppendChild(AddNode(tcInt, 'B20f', 'mod   ', 02, 02, 1,
    nfe.Ide.NFref[i].RefNFP.Modelo, DSC_MOD));
  Result.AppendChild(AddNode(tcInt, 'B20g', 'serie ', 01, 03, 1,
    nfe.ide.NFref[i].RefNFP.serie, DSC_SERIE));
  Result.AppendChild(AddNode(tcInt, 'B20h', 'nNF   ', 01, 09, 1,
    nfe.Ide.NFref[i].RefNFP.nNF, DSC_NNF));
end;

function TNFeXmlWriter.GerarIdeNFrerefCTe(const i: integer): TACBrXmlNode;
begin
  Result := AddNode(tcEsp, 'B20i', 'refCTe', 44, 44, 1,
    OnlyNumber(nfe.ide.NFref[i].refCTe), DSC_REFCTE);
  if not ValidarChave(nfe.ide.NFref[i].refCTe) then
    wAlerta('B20i', 'refCTe', DSC_REFCTE, ERR_MSG_INVALIDO);
end;

function TNFeXmlWriter.GerarRefECF(const i: integer): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('refECF');
  Result.AppendChild(AddNode(tcStr, 'B20k', 'mod   ', 02, 02, 1,
    ECFModRefToStr(nfe.Ide.NFref[i].RefECF.modelo), DSC_MOD));
  Result.AppendChild(AddNode(tcInt, 'B20l', 'nECF  ', 03, 03, 1,
    nfe.Ide.NFref[i].RefECF.nECF, DSC_NECF));
  Result.AppendChild(AddNode(tcInt, 'B20m', 'nCOO  ', 06, 06, 1,
    nfe.Ide.NFref[i].RefECF.nCOO, DSC_NCOO));
end;

function TNFeXmlWriter.GerarEmit: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('emit');
  Result.AppendChild(AddNodeCNPJCPF('C02', 'C02a', nfe.Emit.CNPJCPF));
  Result.AppendChild(AddNode(tcStr, 'C03', 'xNome  ', 02, 60, 1,
    nfe.Emit.xNome, DSC_XNOME));
  Result.AppendChild(AddNode(tcStr, 'C04', 'xFant  ', 01, 60, 0,
    nfe.Emit.xFant, DSC_XFANT));
  Result.AppendChild(GerarEmitEnderEmit);
  //Gerador.IDNivel := 'C01';
  if nfe.Emit.IE = 'ISENTO' then
    Result.AppendChild(AddNode(tcStr, 'C17', 'IE     ', 00, 14, 1, nfe.Emit.IE, DSC_IE))
  else
    Result.AppendChild(AddNode(tcStr, 'C17', 'IE     ', 00, 14, 1,
      OnlyNumber(nfe.Emit.IE), DSC_IE));

  if (Opcoes.ValidarInscricoes) and (nfe.Ide.procEmi <> peAvulsaFisco) then
  begin
    if Length(nfe.Emit.IE) = 0 then
      wAlerta('C17', 'IE', DSC_IE, ERR_MSG_VAZIO)
    else
    begin
      if not pcnAuxiliar.ValidarIE(nfe.Emit.IE, CodigoParaUF(nfe.Ide.cUF)) then
        wAlerta('C17', 'IE', DSC_IE, ERR_MSG_INVALIDO);
    end;
  end;
  Result.AppendChild(AddNode(tcStr, 'C18', 'IEST   ', 02, 14, 0,
    nfe.Emit.IEST, DSC_IEST));
  Result.AppendChild(AddNode(tcStr, 'C19', 'IM     ', 01, 15, 0, nfe.Emit.IM, DSC_IM));
  // NT 2013/005 versão 1.03
  // o CNAE passa ser opcional mesmo quando informado o IM, mas o CNAE só pode
  // ser informado se o IM for informado.
  if Length(nfe.Emit.IM) > 0 then
    Result.AppendChild(AddNode(tcStr, 'C20', 'CNAE ', 07, 07, 0,
      nfe.Emit.CNAE, DSC_CNAE));
  if NFe.infNFe.Versao >= 2 then
    Result.AppendChild(AddNode(tcStr, 'C21', 'CRT ', 01, 01, 1,
      CRTToStr(nfe.Emit.CRT), DSC_CRT));
end;

function TNFeXmlWriter.GerarEmitEnderEmit: TACBrXmlNode;
var
  cMun: integer;
  xMun: string;
  xUF: string;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, CODIGO_BRASIL, nfe.Emit.enderEmit.UF,
    nfe.Emit.enderEmit.xMun, nfe.Emit.EnderEmit.cMun);
  Result := FDocument.CreateElement('enderEmit');
  Result.AppendChild(AddNode(tcStr, 'C06', 'xLgr   ', 02, 60, 1,
    nfe.Emit.enderEmit.xLgr, DSC_XLGR));
  Result.AppendChild(AddNode(tcStr, 'C07', 'nro    ', 01, 60, 1,
    ExecutarAjusteTagNro(Opcoes.FAjustarTagNro, nfe.Emit.enderEmit.nro), DSC_NRO));
  Result.AppendChild(AddNode(tcStr, 'C08', 'xCpl   ', 01, 60, 0,
    nfe.Emit.enderEmit.xCpl, DSC_XCPL));
  Result.AppendChild(AddNode(tcStr, 'C09', 'xBairro', 02, 60, 1,
    nfe.Emit.enderEmit.xBairro, DSC_XBAIRRO));
  Result.AppendChild(AddNode(tcInt, 'C10', 'cMun   ', 01, 07, 1, cMun, DSC_CMUN));
  if not ValidarMunicipio(cMun) then
    wAlerta('C10', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
  Result.AppendChild(AddNode(tcStr, 'C11', 'xMun   ', 02, 60, 1, xMun, DSC_XMUN));
  Result.AppendChild(AddNode(tcStr, 'C12', 'UF     ', 02, 02, 1, xUF, DSC_UF));
  if not pcnAuxiliar.ValidarUF(xUF) then
    wAlerta('C12', 'UF', DSC_UF, ERR_MSG_INVALIDO);
  Result.AppendChild(AddNode(tcInt, 'C13', 'CEP    ', 08, 08, 1,
    nfe.Emit.enderEmit.CEP, DSC_CEP));
  Result.AppendChild(AddNode(tcInt, 'C14', 'cPais  ', 04, 04, 0,
    CODIGO_BRASIL, DSC_CPAIS));
  // Conforme NT-2009/01
  Result.AppendChild(AddNode(tcStr, 'C15', 'xPais  ', 01, 60, 0,
    nfe.Emit.enderEmit.xPais, DSC_XPAIS));
  Result.AppendChild(AddNode(tcStr, 'C16', 'fone   ', 06, 14, 0,
    OnlyNumber(nfe.Emit.enderEmit.fone), DSC_FONE));
end;

function TNFeXmlWriter.GerarAvulsa: TACBrXmlNode;
begin
  Result := nil;
  if Trim(nfe.Avulsa.CNPJ) <> '' then
  begin
    Result := FDocument.CreateElement('avulsa');
    Result.AppendChild(AddNode(tcStr, 'D02', 'CNPJ   ', 14, 14, 1,
      nfe.Avulsa.CNPJ, DSC_CNPJ));
    Result.AppendChild(AddNode(tcStr, 'D03', 'xOrgao ', 01, 60, 1,
      nfe.Avulsa.xOrgao, DSC_XORGAO));
    Result.AppendChild(AddNode(tcStr, 'D04', 'matr   ', 01, 60, 1,
      nfe.Avulsa.matr, DSC_MATR));
    Result.AppendChild(AddNode(tcStr, 'D05', 'xAgente', 01, 60, 1,
      nfe.Avulsa.xAgente, DSC_XAGENTE));
    Result.AppendChild(AddNode(tcStr, 'D06', 'fone   ', 06, 14, 0,
      OnlyNumber(nfe.Avulsa.fone), DSC_FONE));
    Result.AppendChild(AddNode(tcStr, 'D07', 'UF     ', 02, 02, 1,
      nfe.Avulsa.UF, DSC_UF));
    if not pcnAuxiliar.ValidarUF(nfe.Avulsa.UF) then
      wAlerta('D07', 'UF', DSC_UF, ERR_MSG_INVALIDO);
    Result.AppendChild(AddNode(tcStr, 'D08', 'nDAR   ', 01, 60, 0,
      nfe.Avulsa.nDAR, DSC_nDAR));
    Result.AppendChild(AddNode(tcDat, 'D09', 'dEmi   ', 10, 10, 0,
      nfe.Avulsa.dEmi, DSC_DEMI));
    Result.AppendChild(AddNode(tcDe2, 'D10', 'vDAR   ', 01, 15, 0,
      nfe.Avulsa.vDAR, DSC_VDAR));
    Result.AppendChild(AddNode(tcStr, 'D11', 'repEmi ', 01, 60, 1,
      nfe.Avulsa.repEmi, DSC_REPEMI));
    Result.AppendChild(AddNode(tcDat, 'D12', 'dPag   ', 10, 10, 0,
      nfe.Avulsa.dPag, DSC_DPAG));
  end;
end;

function TNFeXmlWriter.GerarDest: TACBrXmlNode;
var
  UF: string;
  IsNFe: boolean;
const
  HOM_NOME_DEST = 'NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL';
begin
  UF := '';
  Result := FDocument.CreateElement('dest');
  IsNFe := (nfe.Ide.modelo = 55);

  if nfe.infNFe.Versao >= 3 then
  begin
    if (nfe.Dest.idEstrangeiro <> '') or ((nfe.Dest.enderDest.cPais <> 0) and
      (nfe.Dest.enderDest.cPais <> 1058)) then
      Result.AppendChild(AddNode(tcStr, 'E03a', 'idEstrangeiro', 00,
        20, 1, nfe.Dest.idEstrangeiro, DSC_IDESTR))
    else
      Result.AppendChild(AddNodeCNPJCPF('E02', 'E03', nfe.Dest.CNPJCPF, IsNFe));
  end
  else
    Result.AppendChild(AddNodeCNPJCPF('E02', 'E03', nfe.Dest.CNPJCPF, IsNFe));

  if nfe.Ide.tpAmb = taProducao then
    Result.AppendChild(AddNode(tcStr, 'E04', 'xNome  ', 02, 60,
      IIf(IsNFe, 1, 0), nfe.Dest.xNome, DSC_XNOME))
  else
    Result.AppendChild(AddNode(tcStr, 'E04', 'xNome  ', 02, 60,
      IIf(IsNFe, 1, 0), HOM_NOME_DEST, DSC_XNOME));

  if IsNFe then
    (**)Result.AppendChild(GerarDestEnderDest(UF))
  else
  begin
    if nfe.Dest.EnderDest.xLgr <> '' then
      (**)Result.AppendChild(GerarDestEnderDest(UF));
  end;

  if nfe.infNFe.Versao >= 3.10 then
    Result.AppendChild(AddNode(tcStr, 'E16a', 'indIEDest', 01, 01,
      1, indIEDestToStr(nfe.Dest.indIEDest), DSC_INDIEDEST))
  else
    nfe.Dest.indIEDest := inContribuinte;

  if nfe.Dest.indIEDest <> inIsento then
  begin
    if (nfe.Dest.IE <> '') or (nfe.infNFe.Versao < 3) then
    begin
      // Inscrição Estadual
      if nfe.Dest.IE = '' then
        Result.AppendChild(AddNode(tcStr, 'E17', 'IE ', 00, 14, 1, '', DSC_IE))
      else
      if nfe.Dest.IE = 'ISENTO' then
        Result.AppendChild(AddNode(tcStr, 'E17', 'IE ', 00, 14, 1,
          nfe.Dest.IE, DSC_IE))
      else if (trim(nfe.Dest.IE) <> '') or (nfe.Ide.modelo <> 65) then
        Result.AppendChild(AddNode(tcStr, 'E17', 'IE     ', 00, 14,
          1, OnlyNumber(nfe.Dest.IE), DSC_IE));

      if (Opcoes.ValidarInscricoes) and (nfe.Dest.IE <> '') and
        (nfe.Dest.IE <> 'ISENTO') then
        if not pcnAuxiliar.ValidarIE(nfe.Dest.IE, UF) then
          wAlerta('E17', 'IE', DSC_IE, ERR_MSG_INVALIDO);
    end;
  end;

  Result.AppendChild(AddNode(tcStr, 'E18', 'ISUF   ', 08, 09, 0,
    nfe.Dest.ISUF, DSC_ISUF));
  if (Opcoes.ValidarInscricoes) and (nfe.Dest.ISUF <> '') then
    if not ValidarISUF(nfe.Dest.ISUF) then
      wAlerta('E18', 'ISUF', DSC_ISUF, ERR_MSG_INVALIDO);
  Result.AppendChild(AddNode(tcStr, 'E18a', 'IM     ', 01, 15, 0, nfe.Dest.IM, DSC_IM));
  Result.AppendChild(AddNode(tcStr, 'E19', 'email   ', 01, 60, 0,
    nfe.Dest.Email, DSC_EMAIL));
end;

function TNFeXmlWriter.GerarDestEnderDest(var UF: string): TACBrXmlNode;
var
  cMun: integer;
  xMun: string;
  xUF: string;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, nfe.Dest.enderDest.cPais,
    nfe.Dest.enderDest.UF, nfe.Dest.enderDest.xMun, nfe.Dest.enderDest.cMun);
  UF := xUF;
  Result := FDocument.CreateElement('enderDest');
  Result.AppendChild(AddNode(tcStr, 'E06', 'xLgr   ', 02, 60, 1,
    nfe.Dest.enderDest.xLgr, DSC_XLGR));
  Result.AppendChild(AddNode(tcStr, 'E07', 'nro    ', 01, 60, 1,
    ExecutarAjusteTagNro(Opcoes.FAjustarTagNro, nfe.Dest.enderDest.nro), DSC_NRO));
  Result.AppendChild(AddNode(tcStr, 'E08', 'xCpl   ', 01, 60, 0,
    nfe.Dest.enderDest.xCpl, DSC_XCPL));
  Result.AppendChild(AddNode(tcStr, 'E09', 'xBairro', 01, 60, 1,
    nfe.Dest.enderDest.xBairro, DSC_XBAIRRO));
  Result.AppendChild(AddNode(tcInt, 'E10', 'cMun   ', 01, 07, 1, cMun, DSC_CMUN));
  if not ValidarMunicipio(cMun) then
    wAlerta('E10', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
  Result.AppendChild(AddNode(tcStr, 'E11', 'xMun   ', 02, 60, 1, xMun, DSC_XMUN));
  Result.AppendChild(AddNode(tcStr, 'E12', 'UF     ', 02, 02, 1, xUF, DSC_UF));
  if not pcnAuxiliar.ValidarUF(xUF) then
    wAlerta('E12', 'UF', DSC_UF, ERR_MSG_INVALIDO);
  Result.AppendChild(AddNode(tcInt, 'E13', 'CEP   ', 08, 08, 0,
    nfe.Dest.enderDest.CEP, DSC_CEP));
  Result.AppendChild(AddNode(tcInt, 'E14', 'cPais ', 02, 04, 0,
    nfe.Dest.enderDest.cPais, DSC_CPAIS));
  if not ValidarCodigoPais(nfe.Dest.enderDest.cPais) = -1 then
    wAlerta('E14', 'cPais', DSC_CPAIS, ERR_MSG_INVALIDO);
  Result.AppendChild(AddNode(tcStr, 'E15', 'xPais  ', 02, 60, 0,
    nfe.Dest.enderDest.xPais, DSC_XPAIS));
  Result.AppendChild(AddNode(tcStr, 'E16', 'fone   ', 06, 14, 0,
    OnlyNumber(nfe.Dest.enderDest.fone), DSC_FONE));
end;

function TNFeXmlWriter.GerarRetirada: TACBrXmlNode;
var
  cMun: integer;
  xMun: string;
  xUF: string;
begin
  Result := nil;
  if trim(nfe.Retirada.xLgr) <> '' then
  begin
    AjustarMunicipioUF(xUF, xMun, cMun, nfe.Emit.EnderEmit.cPais,
      nfe.Retirada.UF, nfe.Retirada.xMun, nfe.Retirada.cMun);
    Result := FDocument.CreateElement('retirada');
    Result.AppendChild(AddNodeCNPJCPF('F02', 'F02a', nfe.Retirada.CNPJCPF, True, False));
    Result.AppendChild(AddNode(tcStr, 'F02b', 'xNome ', 02, 60, 0,
      nfe.Retirada.xNome, DSC_XNOME));
    Result.AppendChild(AddNode(tcStr, 'F03', 'xLgr   ', 02, 60, 1,
      nfe.Retirada.xLgr, DSC_XLGR));
    Result.AppendChild(AddNode(tcStr, 'F04', 'nro    ', 01, 60, 1,
      ExecutarAjusteTagNro(Opcoes.FAjustarTagNro, nfe.Retirada.nro), DSC_NRO));
    Result.AppendChild(AddNode(tcStr, 'F05', 'xCpl   ', 01, 60, 0,
      nfe.Retirada.xCpl, DSC_XCPL));
    Result.AppendChild(AddNode(tcStr, 'F06', 'xBairro', 01, 60, 1,
      nfe.Retirada.xBairro, DSC_XBAIRRO));
    Result.AppendChild(AddNode(tcInt, 'F07', 'cMun   ', 01, 07, 1, cMun, DSC_CMUN));
    if not ValidarMunicipio(cMun) then
      wAlerta('F07', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
    Result.AppendChild(AddNode(tcStr, 'F08', 'xMun   ', 02, 60, 1, xMun, DSC_XMUN));
    Result.AppendChild(AddNode(tcStr, 'F09', 'UF     ', 02, 02, 1, xUF, DSC_UF));
    if not pcnAuxiliar.ValidarUF(xUF) then
      wAlerta('F09', 'UF', DSC_UF, ERR_MSG_INVALIDO);

    Result.AppendChild(AddNode(tcInt, 'F10', 'CEP   ', 08, 08, 0,
      nfe.Retirada.CEP, DSC_CEP));
    Result.AppendChild(AddNode(tcInt, 'F11', 'cPais ', 02, 04, 0,
      nfe.Retirada.cPais, DSC_CPAIS));
    if not ValidarCodigoPais(nfe.Retirada.cPais) = -1 then
      wAlerta('F11', 'cPais', DSC_CPAIS, ERR_MSG_INVALIDO);
    Result.AppendChild(AddNode(tcStr, 'F12', 'xPais  ', 02, 60, 0,
      nfe.Retirada.xPais, DSC_XPAIS));
    Result.AppendChild(AddNode(tcStr, 'F13', 'fone   ', 06, 14, 0,
      OnlyNumber(nfe.Retirada.fone), DSC_FONE));
    Result.AppendChild(AddNode(tcStr, 'F14', 'email  ', 01, 60, 0,
      nfe.Retirada.Email, DSC_EMAIL));
  end;
end;

function TNFeXmlWriter.GerarEntrega: TACBrXmlNode;
var
  cMun: integer;
  xMun: string;
  xUF: string;
begin
  Result := nil;
  if trim(nfe.Entrega.xLgr) <> '' then
  begin
    AjustarMunicipioUF(xUF, xMun, cMun, nfe.Emit.EnderEmit.cPais,
      nfe.Entrega.UF, nfe.Entrega.xMun, nfe.Entrega.cMun);
    Result := FDocument.CreateElement('entrega');
    Result.AppendChild(AddNodeCNPJCPF('G02', 'G02a', nfe.Entrega.CNPJCPF, True, False));
    Result.AppendChild(AddNode(tcStr, 'G02b', 'xNome ', 02, 60, 0,
      nfe.Entrega.xNome, DSC_XNOME));
    Result.AppendChild(AddNode(tcStr, 'G03', 'xLgr   ', 02, 60, 1,
      nfe.Entrega.xLgr, DSC_XLGR));
    Result.AppendChild(AddNode(tcStr, 'G04', 'nro    ', 01, 60, 1,
      ExecutarAjusteTagNro(Opcoes.FAjustarTagNro, nfe.Entrega.nro), DSC_NRO));
    Result.AppendChild(AddNode(tcStr, 'G05', 'xCpl   ', 01, 60, 0,
      nfe.Entrega.xCpl, DSC_XCPL));
    Result.AppendChild(AddNode(tcStr, 'G06', 'xBairro', 01, 60, 1,
      nfe.Entrega.xBairro, DSC_XBAIRRO));
    Result.AppendChild(AddNode(tcInt, 'G07', 'cMun   ', 01, 07, 1, cMun, DSC_CMUN));
    if not ValidarMunicipio(nfe.Entrega.cMun) then
      wAlerta('F07', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
    Result.AppendChild(AddNode(tcStr, 'G08', 'xMun   ', 02, 60, 1, xMun, DSC_XMUN));
    Result.AppendChild(AddNode(tcStr, 'G09', 'UF     ', 02, 02, 1, xUF, DSC_UF));
    if not pcnAuxiliar.ValidarUF(nfe.Entrega.UF) then
      wAlerta('G09', 'UF', DSC_UF, ERR_MSG_INVALIDO);

    Result.AppendChild(AddNode(tcInt, 'G10', 'CEP   ', 08, 08, 0,
      nfe.Entrega.CEP, DSC_CEP));
    Result.AppendChild(AddNode(tcInt, 'G11', 'cPais ', 02, 04, 0,
      nfe.Entrega.cPais, DSC_CPAIS));
    if not ValidarCodigoPais(nfe.Entrega.cPais) = -1 then
      wAlerta('G11', 'cPais', DSC_CPAIS, ERR_MSG_INVALIDO);
    Result.AppendChild(AddNode(tcStr, 'G12', 'xPais  ', 02, 60, 0,
      nfe.Entrega.xPais, DSC_XPAIS));
    Result.AppendChild(AddNode(tcStr, 'G13', 'fone   ', 06, 14, 0,
      OnlyNumber(nfe.Entrega.fone), DSC_FONE));
    Result.AppendChild(AddNode(tcStr, 'G14', 'email  ', 01, 60, 0,
      nfe.Entrega.Email, DSC_EMAIL));
    Result.AppendChild(AddNode(tcStr, 'G15', 'IE     ', 02, 14, 0,
      OnlyNumber(nfe.Entrega.IE), DSC_IE));
  end;
end;

function TNFeXmlWriter.GerarautXML: TACBrXmlNodeArray;
var
  i: integer;
begin
  Result := nil;
  SetLength(Result, nfe.autXML.Count);
  for i := 0 to NFe.autXML.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('autXML');
    Result[i].AppendChild(AddNodeCNPJCPF('G51', 'G52', NFe.autXML[i].CNPJCPF));
  end;

  if NFe.autXML.Count > 10 then
    wAlerta('G50', 'autXML', '', ERR_MSG_MAIOR_MAXIMO + '10');
end;

function TNFeXmlWriter.GerarDet: TACBrXmlNodeArray;
var
  i: integer;
begin
  SetLength(Result, nfe.Det.Count);
  for i := 0 to nfe.Det.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('det');
    Result[i].SetAttribute('nItem', IntToStr(nfe.Det[i].Prod.nItem));
    Result[i].AppendChild(GerarDetProd(i));
    Result[i].AppendChild(GerarDetImposto(i));

    if nfe.Det[i].pDevol > 0 then
      Result[i].AppendChild(GerarDetDevol(i));

    Result[i].AppendChild(AddNode(tcStr, 'V01', 'infAdProd', 01, 500,
      0, nfe.Det[i].infAdProd, DSC_INFADPROD));
  end;
  if nfe.Det.Count > 990 then
    wAlerta('H02', 'nItem', DSC_NITEM, ERR_MSG_MAIOR_MAXIMO + '990');

end;

function TNFeXmlWriter.GerarDetProd(const i: integer): TACBrXmlNode;
const
  HOM_XPROD = 'NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL';
  SEMGTIN = 'SEM GTIN';
var
  ErroValidarGTIN: string;
  nodeArray: TACBrXmlNodeArray;
  j: integer;
begin
  Result := FDocument.CreateElement('prod');
  Result.AppendChild(AddNode(tcStr, 'I02 ', 'cProd   ', 01, 60, 1,
    nfe.Det[i].Prod.cProd, DSC_CPROD));

  // Implementação futura - regra de validação somente em 01/12/2018
  if (NFe.infNFe.Versao >= 4) and (trim(nfe.Det[i].Prod.cEANTrib) = '') and
    (CompareDate(nfe.Ide.dEmi, StringToDateTime('01/12/2018')) > 0) then
    nfe.Det[i].Prod.cEANTrib := SEMGTIN;

  Result.AppendChild(AddNode(tcStr, 'I03 ', 'cEAN', 00, 14, 1,
    nfe.Det[i].Prod.cEAN, DSC_CEAN));

  if (nfe.Det[i].Prod.cEAN <> SEMGTIN) and (nfe.Det[i].Prod.cEAN <> '') then
  begin
    ErroValidarGTIN := ACBrValidador.ValidarGTIN(nfe.Det[i].Prod.cEAN);
    if ErroValidarGTIN <> '' then
      wAlerta('I03', 'cEAN', DSC_CEAN, ErroValidarGTIN);
  end;

  if (NFe.Det[i].Prod.nItem = 1) and (NFe.Ide.tpAmb = taHomologacao) and
    (NFe.ide.modelo = 65) then
    Result.AppendChild(AddNode(tcStr, 'I04 ', 'xProd   ', 1, 120, 1,
      HOM_XPROD, DSC_XPROD))
  else
    Result.AppendChild(AddNode(tcStr, 'I04 ', 'xProd   ', 1, 120, 1,
      nfe.Det[i].Prod.xProd, DSC_XPROD));
  Result.AppendChild(AddNode(tcStr, 'I05 ', 'NCM     ', 02, 08,
    IIf(NFe.infNFe.Versao >= 2, 1, 0), nfe.Det[i].Prod.NCM, DSC_NCM));

  nodeArray := GerarDetProdNVE(i);
  for j := 0 to nfe.Det[i].Prod.NVE.Count - 1 do
  begin
    Result.AppendChild(nodeArray[j]);
  end;

  if NFe.infNFe.Versao >= 4 then
  begin
    if OnlyNumber(nfe.Det[i].Prod.CEST) <> '' then
    begin
      Result.AppendChild(AddNode(tcStr, 'I05c', 'CEST     ', 07, 07,
        1, OnlyNumber(nfe.Det[i].Prod.CEST), DSC_CEST));
      Result.AppendChild(AddNode(tcStr, 'I05d', 'indEscala', 01, 01,
        0, indEscalaToStr(nfe.Det[i].Prod.indEscala), DSC_INDESCALA));
      Result.AppendChild(AddNode(tcStr, 'I05e', 'CNPJFab  ', 14, 14,
        0, nfe.Det[i].Prod.CNPJFab, DSC_CNPJFAB));
    end;
    Result.AppendChild(AddNode(tcStr, 'I05f', 'cBenef', 08, 10, 0,
      nfe.Det[i].Prod.cBenef, DSC_CBENEF));
  end
  else
    Result.AppendChild(AddNode(tcStr, 'I05w', 'CEST', 07, 07, 0,
      OnlyNumber(nfe.Det[i].Prod.CEST), DSC_CEST));

  Result.AppendChild(AddNode(tcStr, 'I06 ', 'EXTIPI  ', 02, 03, 0,
    nfe.Det[i].Prod.EXTIPI, DSC_EXTIPI));
  Result.AppendChild(AddNode(tcEsp, 'I08 ', 'CFOP    ', 04, 04, 1,
    OnlyNumber(nfe.Det[i].Prod.CFOP), DSC_CFOP));
  Result.AppendChild(AddNode(tcStr, 'I09 ', 'uCom    ', 01, 06, 1,
    nfe.Det[i].Prod.uCom, DSC_UCOM));
  Result.AppendChild(AddNode(tcDe4, 'I10 ', 'qCom    ', 00, 15, 1,
    nfe.Det[i].Prod.qCom, DSC_QCOM));
  Result.AppendChild(AddNode(IIf(NFe.infNFe.Versao >= 2, tcDe10, tcDe4),
    'I10a', 'vUnCom  ', 00, 21, 1, nfe.Det[i].Prod.vUnCom, DSC_VUNCOM));
  Result.AppendChild(AddNode(tcDe2, 'I11 ', 'vProd   ', 00, 15, 1,
    nfe.Det[i].Prod.vProd, DSC_VPROD));

  // Implementação futura - regra de validação somente em 01/12/2018
  if (NFe.infNFe.Versao >= 4) and (trim(nfe.Det[i].Prod.cEANTrib) = '') and
    (CompareDate(nfe.Ide.dEmi, StringToDateTime('01/12/2018')) > 0) then
    nfe.Det[i].Prod.cEANTrib := SEMGTIN;

  Result.AppendChild(AddNode(tcStr, 'I12 ', 'cEANTrib', 00, 14, 1,
    nfe.Det[i].Prod.cEANTrib, DSC_CEANTRIB));

  if (nfe.Det[i].Prod.cEANTrib <> SEMGTIN) and (nfe.Det[i].Prod.cEANTrib <> '') then
  begin
    ErroValidarGTIN := ACBrValidador.ValidarGTIN(nfe.Det[i].Prod.cEANTrib);
    if ErroValidarGTIN <> '' then
      wAlerta('I12', 'cEANTrib', DSC_CEANTRIB, ErroValidarGTIN);
  end;

  Result.AppendChild(AddNode(tcStr, 'I13 ', 'uTrib   ', 01, 06, 1,
    nfe.Det[i].Prod.uTrib, DSC_UTRIB));
  Result.AppendChild(AddNode(tcDe4, 'I14 ', 'qTrib   ', 00, 15, 1,
    nfe.Det[i].Prod.qTrib, DSC_QTRIB));
  Result.AppendChild(AddNode(IIf(NFe.infNFe.Versao >= 2, tcDe10, tcDe4),
    'I14a', 'vUnTrib ', 00, 21, 1, nfe.Det[i].Prod.vUnTrib, DSC_VUNTRIB));
  Result.AppendChild(AddNode(tcDe2, 'I15 ', 'vFrete  ', 00, 15, 0,
    nfe.Det[i].Prod.vFrete, DSC_VFRETE));
  Result.AppendChild(AddNode(tcDe2, 'I16 ', 'vSeg    ', 00, 15, 0,
    nfe.Det[i].Prod.vSeg, DSC_VSEG));
  Result.AppendChild(AddNode(tcDe2, 'I17 ', 'vDesc   ', 00, 15, 0,
    nfe.Det[i].Prod.vDesc, DSC_VDESC));
  Result.AppendChild(AddNode(tcDe2, 'I17a', 'vOutro  ', 00, 15, 0,
    nfe.Det[i].Prod.vOutro, DSC_VOUTRO));
  if NFe.infNFe.Versao >= 2 then
    Result.AppendChild(AddNode(tcStr, 'I17b', 'indTot', 01, 01, 1,
      indTotToStr(nfe.Det[i].Prod.IndTot), DSC_INDTOT));

  nodeArray := GerarDetProdDI(i);
  for j := 0 to nfe.Det[i].Prod.DI.Count - 1 do
  begin
    Result.AppendChild(nodeArray[j]);
  end;

  nodeArray := GerarDetProddetExport(i);
  for j := 0 to nfe.Det[i].Prod.detExport.Count - 1 do
  begin
    Result.AppendChild(nodeArray[j]);
  end;

  Result.AppendChild(AddNode(tcStr, 'I30', 'xPed    ', 01, 15, 0,
    nfe.Det[i].Prod.xPed, DSC_XPED));
  Result.AppendChild(AddNode(tcStr, 'I31', 'nItemPed', 06, 06, 0,
    OnlyNumber(nfe.Det[i].Prod.nItemPed), DSC_NITEMPED));
  Result.AppendChild(AddNode(tcStr, 'I70', 'nFCI    ', 36, 36, 0,
    nfe.Det[i].Prod.nFCI, DSC_NFCI));
  if NFe.infNFe.Versao >= 4 then
  begin
    nodeArray := GerarDetProdRastro(i);
    for j := 0 to nfe.Det[i].Prod.rastro.Count - 1 do
    begin
      Result.AppendChild(nodeArray[j]);
    end;
  end;

  Result.AppendChild(GerarDetProdVeicProd(i));

  nodeArray := GerarDetProdMed(i);
  for j := 0 to nfe.Det[i].Prod.med.Count - 1 do
  begin
    Result.AppendChild(nodeArray[j]);
  end;

  nodeArray := GerarDetProdArma(i);
  for j := 0 to nfe.Det[i].Prod.arma.Count - 1 do
  begin
    Result.AppendChild(nodeArray[j]);
  end;

  Result.AppendChild(GerarDetProdComb(i));
  Result.AppendChild(AddNode(tcStr, 'L109', 'nRECOPI', 20, 20, 0,
    nfe.Det[i].Prod.nRECOPI, DSC_NRECOPI));
  if trim(nfe.Det[i].Prod.nRECOPI) <> '' then
    if not ValidaRECOPI(nfe.Det[i].Prod.nRECOPI) then
      wAlerta('L109', 'nRECOPI', DSC_NRECOPI, ERR_MSG_INVALIDO);
end;

function TNFeXmlWriter.GerarDetProdDI(const i: integer): TACBrXmlNodeArray;
var
  j, k: integer;
  nodeArray: TACBrXmlNodeArray;
begin
  Result := nil;
  SetLength(Result, nfe.Det[i].Prod.DI.Count);
  for j := 0 to nfe.Det[i].Prod.DI.Count - 1 do
  begin
    Result[j] := FDocument.CreateElement('DI');
    Result[j].AppendChild(AddNode(tcStr, 'I19', 'nDI', 01, 12, 1,
      nfe.Det[i].Prod.DI[j].nDI, DSC_NDI));

    if not ValidaDIRE(nfe.Det[i].Prod.DI[j].nDI) and not
      ValidaDIDSI(nfe.Det[i].Prod.DI[j].nDI) then
      wAlerta('I19', 'nDI', DSC_NDI, ERR_MSG_INVALIDO);

    Result[j].AppendChild(AddNode(tcDat, 'I20', 'dDI        ', 10,
      10, 1, nfe.Det[i].Prod.DI[j].dDI, DSC_DDi));
    Result[j].AppendChild(AddNode(tcStr, 'I21', 'xLocDesemb ', 01,
      60, 1, nfe.Det[i].Prod.DI[j].xLocDesemb, DSC_XLOCDESEMB));
    Result[j].AppendChild(AddNode(tcStr, 'I22', 'UFDesemb   ', 02,
      02, 1, nfe.Det[i].Prod.DI[j].UFDesemb, DSC_UFDESEMB));
    if not pcnAuxiliar.ValidarUF(nfe.Det[i].Prod.DI[j].UFDesemb) then
      wAlerta('I22', 'UFDesemb', DSC_UFDESEMB, ERR_MSG_INVALIDO);
    Result[j].AppendChild(AddNode(tcDat, 'I23', 'dDesemb    ', 10,
      10, 1, nfe.Det[i].Prod.DI[j].dDesemb, DSC_DDESEMB));

    if nfe.infNFe.Versao >= 3 then
    begin
      Result[j].AppendChild(AddNode(tcStr, 'I23a', 'tpViaTransp ',
        02, 02, 1, TipoViaTranspToStr(nfe.Det[i].Prod.DI[j].tpViaTransp),
        DSC_TPVIATRANSP));

      if nfe.Det[i].Prod.DI[j].tpViaTransp = tvMaritima then
        Result[j].AppendChild(AddNode(tcDe2, 'I23b', 'vAFRMM', 00,
          15, 1, nfe.Det[i].Prod.DI[j].vAFRMM, DSC_VAFRMM))
      else
        Result[j].AppendChild(AddNode(tcDe2, 'I23b', 'vAFRMM', 00,
          15, 0, nfe.Det[i].Prod.DI[j].vAFRMM, DSC_VAFRMM));

      Result[j].AppendChild(AddNode(tcStr, 'I23c', 'tpIntermedio',
        01, 01, 1, TipoIntermedioToStr(nfe.Det[i].Prod.DI[j].tpIntermedio),
        DSC_TPINTERMEDIO));

      Result[j].AppendChild(AddNode(tcStr, 'I23d', 'CNPJ        ',
        14, 14, 0, nfe.Det[i].Prod.DI[j].CNPJ, DSC_CNPJ));

      Result[j].AppendChild(AddNode(tcStr, 'I23e', 'UFTerceiro  ',
        02, 02, 0, nfe.Det[i].Prod.DI[j].UFTerceiro, DSC_UF));
      if nfe.Det[i].Prod.DI[j].UFTerceiro <> '' then
        if not pcnAuxiliar.ValidarUF(nfe.Det[i].Prod.DI[j].UFTerceiro) then
          wAlerta('I23e', 'UFTerceiro', DSC_UF, ERR_MSG_INVALIDO);
    end;

    Result[j].AppendChild(AddNode(tcStr, 'I24', 'cExportador', 01,
      60, 1, nfe.Det[i].Prod.DI[j].cExportador, DSC_CEXPORTADOR));

    nodeArray := GerarDetProdDIadi(i, j);
    for k := 0 to nfe.Det[i].Prod.DI[j].adi.Count - 1 do
    begin
      Result[j].AppendChild(nodeArray[k]);
    end;
  end;
  if nfe.Det[i].Prod.DI.Count > 100 then
    wAlerta('I18', 'DI', DSC_NITEM, ERR_MSG_MAIOR_MAXIMO + '100');
end;

function TNFeXmlWriter.GerarDetProdDIadi(const i, j: integer): TACBrXmlNodeArray;
var
  k: integer;
begin
  Result := nil;
  SetLength(Result, nfe.Det[i].Prod.DI[j].adi.Count);
  for k := 0 to nfe.Det[i].Prod.DI[j].adi.Count - 1 do
  begin
    Result[k] := FDocument.CreateElement('adi');
    Result[k].AppendChild(AddNode(tcInt, 'I26', 'nAdicao    ', 01,
      03, 1, nfe.Det[i].Prod.DI[j].adi[k].nAdicao, DSC_NADICAO));
    Result[k].AppendChild(AddNode(tcInt, 'I27', 'nSeqAdic   ', 01,
      03, 1, nfe.Det[i].Prod.DI[j].adi[k].nSeqAdi, DSC_NSEQADIC));
    Result[k].AppendChild(AddNode(tcStr, 'I28', 'cFabricante', 01,
      60, 1, nfe.Det[i].Prod.DI[j].adi[k].cFabricante, DSC_CFABRICANTE));
    Result[k].AppendChild(AddNode(tcDe2, 'I29', 'vDescDI    ', 00,
      15, 0, nfe.Det[i].Prod.DI[j].adi[k].vDescDI, DSC_VDESCDI));
    // O número do Ato Concessório de Suspensão deve ser preenchido com 11 dígitos
    // (AAAANNNNNND) e o número do Ato Concessório de Drawback Isenção deve ser
    // preenchido com 9 dígitos (AANNNNNND).
    // (Observação incluída na NT 2013/005 v. 1.10)
    Result[k].AppendChild(AddNode(tcStr, 'I29a', 'nDraw     ', 09,
      11, 0, nfe.Det[i].Prod.DI[j].adi[k].nDraw, DSC_NDRAW));
    if trim(nfe.Det[i].Prod.DI[j].adi[k].nDraw) <> '' then
      if not ValidaDrawback(nfe.Det[i].Prod.DI[j].adi[k].nDraw) then
        wAlerta('I29a', 'nDraw', DSC_NDRAW, ERR_MSG_INVALIDO);
  end;
  if nfe.Det[i].Prod.DI[j].adi.Count > 100 then
    wAlerta('I25', 'adi', DSC_NITEM, ERR_MSG_MAIOR_MAXIMO + '100');
end;

function TNFeXmlWriter.GerarDetProdNVE(const i: integer): TACBrXmlNodeArray;
var
  j: integer;
begin
  Result := nil;
  SetLength(Result, nfe.Det[i].Prod.NVE.Count);
  for j := 0 to nfe.Det[i].Prod.NVE.Count - 1 do
  begin
    Result[j] := AddNode(tcStr, 'I05a', 'NVE        ', 06, 06, 0,
      nfe.Det[i].Prod.NVE[j].NVE, DSC_NVE);

    if not ValidaNVE(nfe.Det[i].Prod.NVE[j].NVE) then
      wAlerta('I05a', 'NVE', DSC_NVE, ERR_MSG_INVALIDO);
  end;

  if nfe.Det[i].Prod.NVE.Count > 8 then
    wAlerta('I05a', 'NVE', DSC_NITEM, ERR_MSG_MAIOR_MAXIMO + '8');
end;

function TNFeXmlWriter.GerarDetProddetExport(const i: integer): TACBrXmlNodeArray;
var
  j: integer;
  xmlNode: TACBrXmlNode;
begin
  Result := nil;
  SetLength(Result, nfe.Det[i].Prod.detExport.Count);
  for j := 0 to nfe.Det[i].Prod.detExport.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('detExport');
    // O número do Ato Concessório de Suspensão deve ser preenchido com 11 dígitos
    // (AAAANNNNNND) e o número do Ato Concessório de Drawback Isenção deve ser
    // preenchido com 9 dígitos (AANNNNNND).
    // (Observação incluída na NT 2013/005 v. 1.10)
    Result[j].AppendChild(AddNode(tcStr, 'I51', 'nDraw      ', 09,
      11, 0, nfe.Det[i].Prod.detExport[j].nDraw, DSC_NDRAW));
    if trim(nfe.Det[i].Prod.detExport[j].nDraw) <> '' then
      if not ValidaDrawback(nfe.Det[i].Prod.detExport[j].nDraw) then
        wAlerta('I51', 'nDraw', DSC_NDRAW, ERR_MSG_INVALIDO);

    if (nfe.Det[i].Prod.detExport[j].nRE <> '') or
      (nfe.Det[i].Prod.detExport[j].chNFe <> '') then
    begin
      xmlNode := Result[j].AddChild('exportInd');
      xmlNode.AppendChild(AddNode(tcStr, 'I53', 'nRE    ', 12, 12,
        1, nfe.Det[i].Prod.detExport[j].nRE, DSC_NRE));
      if not ValidaRE(nfe.Det[i].Prod.detExport[j].nRE) then
        wAlerta('I53', 'nRE', DSC_NRE, ERR_MSG_INVALIDO);
      xmlNode.AppendChild(AddNode(tcEsp, 'I54', 'chNFe  ', 44, 44,
        1, OnlyNumber(nfe.Det[i].Prod.detExport[j].chNFe), DSC_REFNFE));
      if not ValidarChave(nfe.Det[i].Prod.detExport[j].chNFe) then
        wAlerta('I54', 'chNFe', DSC_REFNFE, ERR_MSG_INVALIDO);
      xmlNode.AppendChild(AddNode(tcDe4, 'I55', 'qExport', 00, 15,
        1, nfe.Det[i].Prod.detExport[j].qExport, DSC_QEXPORT));
    end;
  end;
  if nfe.Det[i].Prod.detExport.Count > 500 then
    wAlerta('I50', 'detExport', DSC_NITEM, ERR_MSG_MAIOR_MAXIMO + '500');
end;

function TNFeXmlWriter.GerarDetProdRastro(const i: integer): TACBrXmlNodeArray;
var
  j: integer;
begin
  Result := nil;
  SetLength(Result, nfe.Det[i].Prod.rastro.Count);
  for j := 0 to nfe.Det[i].Prod.rastro.Count - 1 do
  begin
    Result[j] := FDocument.CreateElement('rastro');
    Result[j].AppendChild(AddNode(tcStr, 'I81', 'nLote ', 01, 20, 1,
      nfe.Det[i].Prod.rastro[j].nLote, DSC_NLOTE));
    Result[j].AppendChild(AddNode(tcDe3, 'I82', 'qLote ', 00, 11, 1,
      nfe.Det[i].Prod.rastro[j].qLote, DSC_QLOTE));
    Result[j].AppendChild(AddNode(tcDat, 'I83', 'dFab  ', 10, 10, 1,
      nfe.Det[i].Prod.rastro[j].dFab, DSC_DFAB));
    Result[j].AppendChild(AddNode(tcDat, 'I84', 'dVal  ', 10, 10, 1,
      nfe.Det[i].Prod.rastro[j].dVal, DSC_DVAL));
    Result[j].AppendChild(AddNode(tcStr, 'I85', 'cAgreg', 01, 20, 0,
      nfe.Det[i].Prod.rastro[j].cAgreg, DSC_CAGREG));
  end;

  if nfe.Det[i].Prod.rastro.Count > 500 then
    wAlerta('I80', 'rastro', DSC_NITEM, ERR_MSG_MAIOR_MAXIMO + '500');
end;

function TNFeXmlWriter.GerarDetProdVeicProd(const i: integer): TACBrXmlNode;
begin
  Result := nil;
  if trim(nfe.Det[i].Prod.veicProd.chassi) <> '' then
  begin
    Result := FDocument.CreateElement('veicProd');
    Result.AppendChild(AddNode(tcStr, 'J02', 'tpOp    ', 01, 01, 1,
      tpOPToStr(nfe.Det[i].Prod.veicProd.tpOP), DSC_TPOP));
    Result.AppendChild(AddNode(tcStr, 'J03', 'chassi  ', 17, 17, 1,
      nfe.Det[i].Prod.veicProd.chassi, DSC_CHASSI));
    Result.AppendChild(AddNode(tcStr, 'J04', 'cCor    ', 04, 04, 1,
      nfe.Det[i].Prod.veicProd.cCor, DSC_CCOR));
    Result.AppendChild(AddNode(tcStr, 'J05', 'xCor    ', 01, 40, 1,
      nfe.Det[i].Prod.veicProd.xCor, DSC_XCOR));
    Result.AppendChild(AddNode(tcStr, 'J06', 'pot     ', 01, 04, 1,
      nfe.Det[i].Prod.veicProd.pot, DSC_POT));
    if NFe.infNFe.Versao >= 2 then
      Result.AppendChild(AddNode(tcStr, 'J07', 'cilin   ', 04, 04,
        1, nfe.Det[i].Prod.veicProd.cilin, DSC_CILIN))
    else
      Result.AppendChild(AddNode(tcStr, 'J07', 'CM3     ', 04, 04,
        1, nfe.Det[i].Prod.veicProd.cilin, DSC_CILIN));
    Result.AppendChild(AddNode(tcStr, 'J08', 'pesoL   ', 00, 09, 1,
      nfe.Det[i].Prod.veicProd.pesoL, DSC_PESOL));
    Result.AppendChild(AddNode(tcStr, 'J09', 'pesoB   ', 00, 09, 1,
      nfe.Det[i].Prod.veicProd.pesoB, DSC_PESOB));
    Result.AppendChild(AddNode(tcStr, 'J10', 'nSerie  ', 00, 09, 1,
      nfe.Det[i].Prod.veicProd.nSerie, DSC_NSERIE));
    Result.AppendChild(AddNode(tcStr, 'J11', 'tpComb  ', 02, 02, 1,
      nfe.Det[i].Prod.veicProd.tpComb, DSC_TPCOMB));
    Result.AppendChild(AddNode(tcStr, 'J12', 'nMotor  ', 00, 21, 1,
      nfe.Det[i].Prod.veicProd.nMotor, DSC_NMOTOR));
    if NFe.infNFe.Versao >= 2 then
      Result.AppendChild(AddNode(tcStr, 'J13', 'CMT     ', 09, 09,
        1, nfe.Det[i].Prod.veicProd.CMT, DSC_CMT))
    else
      Result.AppendChild(AddNode(tcStr, 'J13', 'CMKG    ', 09, 09,
        1, nfe.Det[i].Prod.veicProd.CMT, DSC_CMT));
    Result.AppendChild(AddNode(tcStr, 'J14', 'dist    ', 00, 04, 1,
      nfe.Det[i].Prod.veicProd.dist, DSC_DIST));
    //    Result.AppendChild(AddNode(tcStr, 'J15', 'RENAVAM ', 00, 09, 0, nfe.Det[i].Prod.veicProd.RENAVAM, DSC_RENAVAM));
    Result.AppendChild(AddNode(tcInt, 'J16', 'anoMod  ', 00, 04, 1,
      nfe.Det[i].Prod.veicProd.anoMod, DSC_ANOMOD));
    Result.AppendChild(AddNode(tcInt, 'J17', 'anoFab  ', 00, 04, 1,
      nfe.Det[i].Prod.veicProd.anoFab, DSC_ANOFAB));
    Result.AppendChild(AddNode(tcStr, 'J18', 'tpPint  ', 00, 01, 1,
      nfe.Det[i].Prod.veicProd.tpPint, DSC_TPPINT));
    Result.AppendChild(AddNode(tcInt, 'J19', 'tpVeic  ', 00, 02, 1,
      nfe.Det[i].Prod.veicProd.tpVeic, DSC_TPVEIC));
    Result.AppendChild(AddNode(tcInt, 'J20', 'espVeic ', 00, 01, 1,
      nfe.Det[i].Prod.veicProd.espVeic, DSC_ESPVEIC));
    Result.AppendChild(AddNode(tcStr, 'J21', 'VIN     ', 00, 01, 1,
      nfe.Det[i].Prod.veicProd.VIN, DSC_VIN));
    Result.AppendChild(AddNode(tcStr, 'J22', 'condVeic', 00, 01, 1,
      condVeicToStr(nfe.Det[i].Prod.veicProd.condVeic), DSC_CONDVEIC));
    Result.AppendChild(AddNode(tcStr, 'J23', 'cMod    ', 00, 06, 1,
      nfe.Det[i].Prod.veicProd.cMod, DSC_CMOD));
    if NFe.infNFe.Versao >= 2 then
    begin
      Result.AppendChild(AddNode(tcStr, 'J24', 'cCorDENATRAN', 00,
        2, 1, nfe.Det[i].Prod.veicProd.cCorDENATRAN, DSC_CCORDEN));
      Result.AppendChild(AddNode(tcInt, 'J25', 'lota    ', 01, 03,
        1, nfe.Det[i].Prod.veicProd.lota, DSC_LOTA));
      Result.AppendChild(AddNode(tcInt, 'J26', 'tpRest  ', 01, 01,
        1, nfe.Det[i].Prod.veicProd.tpRest, DSC_TPREST));
    end;
  end;
end;

function TNFeXmlWriter.GerarDetProdMed(const i: integer): TACBrXmlNodeArray;
var
  j, MaxMed: integer;
begin
  Result := nil;
  SetLength(Result, nfe.Det[i].Prod.med.Count);
  for j := 0 to nfe.Det[i].Prod.med.Count - 1 do
  begin
    Result[j] := FDocument.CreateElement('med');

    if NFe.infNFe.Versao >= 4 then
    begin
      Result[j].AppendChild(AddNode(tcStr, 'K01a', 'cProdANVISA   ',
        13, 013, 1, nfe.Det[i].Prod.med[j].cProdANVISA, DSC_CPRODANVISA));
      Result[j].AppendChild(AddNode(tcStr, 'K01b', 'xMotivoIsencao',
        01, 255, 0, nfe.Det[i].Prod.med[j].xMotivoIsencao, DSC_CPRODANVISA));
    end;

    if NFe.infNFe.Versao < 4 then
    begin
      Result[j].AppendChild(AddNode(tcStr, 'K02', 'nLote', 01, 20,
        1, nfe.Det[i].Prod.med[j].nLote, DSC_NLOTE));
      Result[j].AppendChild(AddNode(tcDe3, 'K03', 'qLote', 00, 11,
        1, nfe.Det[i].Prod.med[j].qLote, DSC_QLOTE));
      Result[j].AppendChild(AddNode(tcDat, 'K04', 'dFab ', 10, 10,
        1, nfe.Det[i].Prod.med[j].dFab, DSC_DFAB));
      Result[j].AppendChild(AddNode(tcDat, 'K05', 'dVal ', 10, 10,
        1, nfe.Det[i].Prod.med[j].dVal, DSC_DVAL));
    end;

    Result[j].AppendChild(AddNode(tcDe2, 'K06', 'vPMC ', 00, 15, 1,
      nfe.Det[i].Prod.med[j].vPMC, DSC_VPMC));
  end;

  if (NFe.infNFe.Versao >= 4) then
    MaxMed := 1
  else
    MaxMed := 500;

  if (nfe.Det[i].Prod.med.Count > MaxMed) then
    wAlerta('K01', 'med', DSC_NITEM, ERR_MSG_MAIOR_MAXIMO + IntToStr(MaxMed));
end;

function TNFeXmlWriter.GerarDetProdArma(const i: integer): TACBrXmlNodeArray;
var
  j: integer;
begin
  Result := nil;
  SetLength(Result, nfe.Det[i].Prod.arma.Count);
  for j := 0 to nfe.Det[i].Prod.arma.Count - 1 do
  begin
    Result[j] := FDocument.CreateElement('arma');
    Result[j].AppendChild(AddNode(tcStr, 'L02', 'tpArma', 01, 001,
      1, tpArmaToStr(nfe.Det[i].Prod.arma[j].tpArma), DSC_TPARMA));
    Result[j].AppendChild(AddNode(tcStr, 'L03', 'nSerie', 01, 015,
      1, nfe.Det[i].Prod.arma[j].nSerie, DSC_NSERIE));
    Result[j].AppendChild(AddNode(tcStr, 'L04', 'nCano ', 01, 015,
      1, nfe.Det[i].Prod.arma[j].nCano, DSC_NCANO));
    Result[j].AppendChild(AddNode(tcStr, 'L05', 'descr ', 01, 256,
      1, nfe.Det[i].Prod.arma[j].descr, DSC_DESCR));
  end;
  if nfe.Det[i].Prod.arma.Count > 500 then
    wAlerta('L01', 'arma', DSC_NITEM, ERR_MSG_MAIOR_MAXIMO + '500');
end;

function TNFeXmlWriter.GerarDetProdComb(const i: integer): TACBrXmlNode;
begin
  Result := nil;
  if (nfe.Det[i].Prod.comb.cProdANP > 0) then
  begin
    Result := FDocument.CreateElement('comb');
    Result.AppendChild(AddNode(tcInt, 'L102', 'cProdANP', 09, 09, 1,
      nfe.Det[i].Prod.comb.cProdANP, DSC_CPRODANP));

    if (nfe.infNFe.Versao < 4) then
      Result.AppendChild(AddNode(tcDe4, 'L102a', 'pMixGN ', 00, 06,
        0, nfe.Det[i].Prod.comb.pMixGN, DSC_PMIXGN))
    else
    begin
      Result.AppendChild(AddNode(tcStr, 'LA03', 'descANP', 02, 95,
        1, nfe.Det[i].Prod.comb.descANP, DSC_DESCANP));

      if nfe.Det[i].Prod.comb.cProdANP = 210203001 then
      begin
        if nfe.Det[i].Prod.comb.pGLP = 100 then
          Result.AppendChild(AddNode(tcDe2, 'LA03a', 'pGLP', 01, 7,
            0, nfe.Det[i].Prod.comb.pGLP, DSC_PGLP))
        else
          Result.AppendChild(AddNode(tcDe4, 'LA03a', 'pGLP', 01, 7,
            1, nfe.Det[i].Prod.comb.pGLP, DSC_PGLP));

        if nfe.Det[i].Prod.comb.pGNn = 100 then
          Result.AppendChild(AddNode(tcDe2, 'LA03b', 'pGNn', 01, 7,
            0, nfe.Det[i].Prod.comb.pGNn, DSC_PGNN))
        else
          Result.AppendChild(AddNode(tcDe4, 'LA03b', 'pGNn', 01, 7,
            1, nfe.Det[i].Prod.comb.pGNn, DSC_PGNN));

        if nfe.Det[i].Prod.comb.pGNi = 100 then
          Result.AppendChild(AddNode(tcDe2, 'LA03c', 'pGNi', 01, 7,
            0, nfe.Det[i].Prod.comb.pGNi, DSC_PGNI))
        else
          Result.AppendChild(AddNode(tcDe4, 'LA03c', 'pGNi', 01, 7,
            1, nfe.Det[i].Prod.comb.pGNi, DSC_PGNI));

        Result.AppendChild(AddNode(tcDe2, 'LA03d', 'vPart ', 01, 15,
          0, nfe.Det[i].Prod.comb.vPart, DSC_VPART));
      end;
    end;

    if (trim(nfe.Det[i].Prod.comb.CODIF)) <> '' then
      Result.AppendChild(AddNode(tcEsp, 'L103', 'CODIF', 00, 21, 1,
        nfe.Det[i].Prod.comb.CODIF, DSC_CODIF));

    if nfe.Det[i].Prod.comb.qTemp <> 0 then
      Result.AppendChild(AddNode(tcDe4, 'L104', 'qTemp', 01, 16, 1,
        nfe.Det[i].Prod.comb.qTemp, DSC_QTEMP));

    if (nfe.infNFe.Versao < 2) and ((nfe.Det[i].Prod.comb.ICMS.vBCICMS > 0) or
      (nfe.Det[i].Prod.comb.ICMS.vICMS > 0) or
      (nfe.Det[i].Prod.comb.ICMS.vBCICMSST > 0) or
      (nfe.Det[i].Prod.comb.ICMS.vICMSST > 0) or
      (nfe.Det[i].Prod.comb.ICMSInter.vBCICMSSTDest > 0) or
      (nfe.Det[i].Prod.comb.ICMSInter.vICMSSTDest > 0) or
      (nfe.Det[i].Prod.comb.ICMSCons.vBCICMSSTCons > 0) or
      (nfe.Det[i].Prod.comb.ICMSCons.vICMSSTCons > 0)) then
    begin
      // Manter Disponivel para versao 3.0
      Result.AppendChild(GerarDetProdCombCIDE(i));
      Result.AppendChild(GerarDetProdCombICMS(i));
      Result.AppendChild(GerarDetProdCombICMSInter(i));
      Result.AppendChild(GerarDetProdCombICMSCons(i));
    end
    else
    begin
      Result.AppendChild(AddNode(tcStr, 'L120', 'UFCons', 02, 02, 1,
        nfe.Det[i].Prod.comb.UFcons, DSC_UFCONS));

      if not pcnAuxiliar.ValidarUF(nfe.Det[i].Prod.comb.UFcons) then
        wAlerta('L120', 'UFcons', DSC_UFCONS, ERR_MSG_INVALIDO);

      Result.AppendChild(GerarDetProdCombCIDE(i));

      if nfe.Det[i].Prod.comb.encerrante.nBico > 0 then
        Result.AppendChild(GerarDetProdCombencerrante(i));
    end;
  end;
end;

function TNFeXmlWriter.GerarDetProdCombCIDE(const i: integer): TACBrXmlNode;
begin
  Result := nil;
  if (nfe.Det[i].Prod.comb.CIDE.qBCProd > 0) or
    (nfe.Det[i].Prod.comb.CIDE.vAliqProd > 0) or
    (nfe.Det[i].Prod.comb.CIDE.vCIDE > 0) then
  begin
    Result := FDocument.CreateElement('CIDE');
    Result.AppendChild(AddNode(tcDe4, 'L106', 'qBCProd  ', 01, 16,
      1, nfe.Det[i].Prod.comb.CIDE.qBCprod, DSC_QBCPROD));
    Result.AppendChild(AddNode(tcDe4, 'L107', 'vAliqProd', 01, 15,
      1, nfe.Det[i].Prod.comb.CIDE.vAliqProd, DSC_VALIQPROD));
    Result.AppendChild(AddNode(tcDe2, 'L108', 'vCIDE    ', 01, 15,
      1, nfe.Det[i].Prod.comb.CIDE.vCIDE, DSC_VCIDE));
  end;
end;

function TNFeXmlWriter.GerarDetProdCombencerrante(const i: integer): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('encerrante');
  Result.AppendChild(AddNode(tcInt, 'LA12', 'nBico  ', 01, 03, 1,
    nfe.Det[i].Prod.comb.encerrante.nBico, DSC_NBICO));
  Result.AppendChild(AddNode(tcInt, 'LA13', 'nBomba ', 01, 03, 0,
    nfe.Det[i].Prod.comb.encerrante.nBomba, DSC_NBOMBA));
  Result.AppendChild(AddNode(tcInt, 'LA14', 'nTanque', 01, 03, 1,
    nfe.Det[i].Prod.comb.encerrante.nTanque, DSC_NTANQUE));
  Result.AppendChild(AddNode(tcDe3, 'LA15', 'vEncIni', 01, 15, 1,
    nfe.Det[i].Prod.comb.encerrante.vEncIni, DSC_VENCINI));
  Result.AppendChild(AddNode(tcDe3, 'LA16', 'vEncFin', 01, 15, 1,
    nfe.Det[i].Prod.comb.encerrante.vEncFin, DSC_VENCFIN));
end;

function TNFeXmlWriter.GerarDetProdCombICMS(const i: integer): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('ICMSComb');
  Result.AppendChild(AddNode(tcDe2, 'L110', 'vBCICMS  ', 01, 15, 1,
    nfe.Det[i].Prod.comb.ICMS.vBCICMS, DSC_VBCICMS));
  Result.AppendChild(AddNode(tcDe2, 'L111', 'vICMS    ', 01, 15, 1,
    nfe.Det[i].Prod.comb.ICMS.vICMS, DSC_VICMS));
  Result.AppendChild(AddNode(tcDe2, 'L112', 'vBCICMSST', 01, 15, 1,
    nfe.Det[i].Prod.comb.ICMS.vBCICMSST, DSC_VBCICMSST));
  Result.AppendChild(AddNode(tcDe2, 'L113', 'vICMSST  ', 01, 15, 1,
    nfe.Det[i].Prod.comb.ICMS.vICMSST, DSC_VICMSST));
end;

function TNFeXmlWriter.GerarDetProdCombICMSInter(const i: integer): TACBrXmlNode;
begin
  Result := nil;
  if (nfe.Det[i].Prod.comb.ICMSInter.vBCICMSSTDest > 0) or
    (nfe.Det[i].Prod.comb.ICMSInter.vICMSSTDest > 0) then
  begin
    Result := FDocument.CreateElement('ICMSInter');
    Result.AppendChild(AddNode(tcDe2, 'L115', 'vBCICMSSTDest', 01,
      15, 1, nfe.Det[i].Prod.comb.ICMSInter.vBCICMSSTDest, DSC_VBCICMSSTDEST));
    Result.AppendChild(AddNode(tcDe2, 'L116', 'vICMSSTDest  ', 01,
      15, 1, nfe.Det[i].Prod.comb.ICMSInter.vICMSSTDest, DSC_VICMSSTDEST));
  end;
end;

function TNFeXmlWriter.GerarDetProdCombICMSCons(const i: integer): TACBrXmlNode;
begin
  Result := nil;
  if (nfe.Det[i].Prod.comb.ICMSCons.vBCICMSSTCons > 0) or
    (nfe.Det[i].Prod.comb.ICMSCons.vICMSSTCons > 0) or
    (trim(nfe.Det[i].Prod.comb.ICMSCons.UFcons) <> '') then
  begin
    Result := FDocument.CreateElement('ICMSCons');
    Result.AppendChild(AddNode(tcDe2, 'L118', 'vBCICMSSTCons', 01,
      15, 1, nfe.Det[i].Prod.comb.ICMSCons.vBCICMSSTCons, DSC_VBCICMSSTCONS));
    Result.AppendChild(AddNode(tcDe2, 'L119', 'vICMSSTCons  ', 01,
      15, 1, nfe.Det[i].Prod.comb.ICMSCons.vICMSSTCons, DSC_VICMSSTCONS));
    Result.AppendChild(AddNode(tcStr, 'L120', 'UFCons       ', 02,
      02, 1, nfe.Det[i].Prod.comb.ICMSCons.UFcons, DSC_UFCONS));
    if not pcnAuxiliar.ValidarUF(nfe.Det[i].Prod.comb.ICMSCons.UFcons) then
      wAlerta('L120', 'UFcons', DSC_UFCONS, ERR_MSG_INVALIDO);
  end;
end;

function TNFeXmlWriter.GerarDetImposto(const i: integer): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('imposto');
  Result.AppendChild(AddNode(tcDe2, 'M02', 'vTotTrib ', 01, 15, 0,
    nfe.Det[i].Imposto.vTotTrib, DSC_VTOTTRIB));

  if ((NFe.Det[i].Imposto.ISSQN.cSitTrib <> ISSQNcSitTribVazio) or
    ((NFe.infNFe.Versao > 3) and (nfe.Det[i].Imposto.ISSQN.cListServ <> ''))) then
  begin
    if NFe.infNFe.Versao >= 3 then
      Result.AppendChild(GerarDetImpostoIPI(i));
    Result.AppendChild(GerarDetImpostoISSQN(i));
  end
  else
  begin
    Result.AppendChild(GerarDetImpostoICMS(i));
    Result.AppendChild(GerarDetImpostoIPI(i));
    Result.AppendChild(GerarDetImpostoII(i));
  end;
  Result.AppendChild(GerarDetImpostoPIS(i));
  Result.AppendChild(GerarDetImpostoPISST(i));
  Result.AppendChild(GerarDetImpostoCOFINS(i));
  Result.AppendChild(GerarDetImpostoCOFINSST(i));

  if nfe.Det[i].Imposto.ICMSUFDest.pICMSInterPart > 0 then
    Result.AppendChild(GerarDetImpostoICMSUFDest(i));
end;

function TNFeXmlWriter.GerarDetImpostoICMS(const i: integer): TACBrXmlNode;
var
  sTagTemp: string;
  xmlNode: TACBrXmlNode;

  function BuscaTag(const t: TpcnCSTIcms): string;
  begin
    case t of
      cst00: Result := '00';
      cst10: Result := '10';
      cst20: Result := '20';
      cst30: Result := '30';
      cst40,
      cst41,
      cst50: Result := '40';
      cst51: Result := '51';
      cst60: Result := '60';
      cst70: Result := '70';
      cst80: Result := '80';
      cst81: Result := '81';
      cst90: Result := '90';
      cstPart10,
      cstPart90: Result := 'Part';
      cstRep41: Result := 'ST';
      cstRep60: Result := IIf(nfe.infNFe.Versao < 4, '60', 'ST');
    end;
  end;

begin
  Result := FDocument.CreateElement('ICMS');
  case nfe.Emit.CRT of
    crtRegimeNormal, crtSimplesExcessoReceita:
    begin
      sTagTemp := BuscaTag(nfe.Det[i].Imposto.ICMS.CST);
      xmlNode := Result.AddChild('ICMS' + sTagTemp);
      xmlNode.AppendChild(AddNode(tcStr, 'N11', 'orig    ', 01,
        01, 1, OrigTOStr(nfe.Det[i].Imposto.ICMS.orig), DSC_ORIG));
      xmlNode.AppendChild(AddNode(tcStr, 'N12', 'CST     ', 02,
        02, 1, CSTICMSTOStr(nfe.Det[i].Imposto.ICMS.CST), DSC_CST));

      case nfe.Det[i].Imposto.ICMS.CST of
        cst00:
        begin
          xmlNode.AppendChild(AddNode(tcStr, 'N13', 'modBC   ', 01,
            01, 1, modBCToStr(nfe.Det[i].Imposto.ICMS.modBC), DSC_MODBC));
          xmlNode.AppendChild(AddNode(tcDe2, 'N15', 'vBC     ', 01,
            15, 1, nfe.Det[i].Imposto.ICMS.vBC, DSC_VBC));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N16', 'pICMS   ', 01, IIf(Usar_tcDe4, 07, 05), 1,
            nfe.Det[i].Imposto.ICMS.pICMS, DSC_PICMS));
          xmlNode.AppendChild(AddNode(tcDe2, 'N17', 'vICMS   ', 01,
            15, 1, nfe.Det[i].Imposto.ICMS.vICMS, DSC_VICMS));
          if (NFe.infNFe.Versao >= 4) then
          begin
            if (nfe.Det[i].Imposto.ICMS.pFCP > 0) or
              (nfe.Det[i].Imposto.ICMS.vFCP > 0) then
            begin
              xmlNode.AppendChild(
                AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2), 'N17b', 'pFCP',
                01, IIf(Usar_tcDe4, 07, 05), 1, nfe.Det[i].Imposto.ICMS.pFCP, DSC_PFCP));
              xmlNode.AppendChild(AddNode(tcDe2, 'N17c', 'vFCP ',
                01, 15, 1, nfe.Det[i].Imposto.ICMS.vFCP, DSC_VFCP));
            end;
          end;
        end;
        cst10,
        cstPart10:
        begin
          xmlNode.AppendChild(AddNode(tcStr, 'N13', 'modBC   ',
            01, 01, 1, modBCToStr(nfe.Det[i].Imposto.ICMS.modBC), DSC_MODBC));
          xmlNode.AppendChild(AddNode(tcDe2, 'N15', 'vBC     ',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vBC, DSC_VBC));
          if (nfe.Det[i].Imposto.ICMS.UFST <> '') or
            (nfe.Det[i].Imposto.ICMS.pBCOp <> 0) or
            (nfe.Det[i].Imposto.ICMS.CST = cstPart10) then
            xmlNode.AppendChild(AddNode(tcDe2, 'N14', 'pRedBC  ',
              01, 05, 0, nfe.Det[i].Imposto.ICMS.pRedBC, DSC_PREDBC));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N16', 'pICMS   ', 01, IIf(Usar_tcDe4, 07, 05), 1,
            nfe.Det[i].Imposto.ICMS.pICMS, DSC_PICMS));
          xmlNode.AppendChild(AddNode(tcDe2, 'N17', 'vICMS   ',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMS, DSC_VICMS));

          if (NFe.infNFe.Versao >= 4) then
          begin
            if (nfe.Det[i].Imposto.ICMS.vBCFCP > 0) or
              (nfe.Det[i].Imposto.ICMS.pFCP > 0) or
              (nfe.Det[i].Imposto.ICMS.vFCP > 0) then
            begin
              xmlNode.AppendChild(AddNode(tcDe2, 'N17a', 'vBCFCP',
                01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCFCP, DSC_VBCFCP));
              xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
                'N17b', 'pFCP', 01, IIf(Usar_tcDe4, 07, 05), 1,
                nfe.Det[i].Imposto.ICMS.pFCP, DSC_PFCP));
              xmlNode.AppendChild(AddNode(tcDe2, 'N17c', 'vFCP  ',
                01, 15, 1, nfe.Det[i].Imposto.ICMS.vFCP, DSC_VFCP));
            end;
          end;

          xmlNode.AppendChild(AddNode(tcStr, 'N18', 'modBCST ',
            01, 01, 1, modBCSTToStr(nfe.Det[i].Imposto.ICMS.modBCST), DSC_MODBCST));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N19', 'pMVAST  ', 01, IIf(Usar_tcDe4, 07, 05), 0,
            nfe.Det[i].Imposto.ICMS.pMVAST, DSC_PMVAST));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N20', 'pRedBCST', 01, IIf(Usar_tcDe4, 07, 05), 0,
            nfe.Det[i].Imposto.ICMS.pRedBCST, DSC_PREDBCST));
          xmlNode.AppendChild(AddNode(tcDe2, 'N21', 'vBCST   ',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCST, DSC_VBCST));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N22', 'pICMSST ', 01, IIf(Usar_tcDe4, 07, 05), 1,
            nfe.Det[i].Imposto.ICMS.pICMSST, DSC_PICMSST));
          xmlNode.AppendChild(AddNode(tcDe2, 'N23', 'vICMSST ',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMSST, DSC_VICMSST));
          if (NFe.infNFe.Versao >= 4) then
          begin
            if (nfe.Det[i].Imposto.ICMS.vBCFCPST > 0) or
              (nfe.Det[i].Imposto.ICMS.pFCPST > 0) or
              (nfe.Det[i].Imposto.ICMS.vFCPST > 0) then
            begin
              xmlNode.AppendChild(AddNode(tcDe2, 'N23a',
                'vBCFCPST ', 01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCFCPST, DSC_VBCFCPST));
              xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
                'N23b', 'pFCPST', 01, IIf(Usar_tcDe4, 07, 05), 1,
                nfe.Det[i].Imposto.ICMS.pFCPST, DSC_PFCPST));
              xmlNode.AppendChild(AddNode(tcDe2, 'N23d', 'vFCPST ',
                01, 15, 1, nfe.Det[i].Imposto.ICMS.vFCPST, DSC_VFCPST));
            end;
          end;
          if (nfe.Det[i].Imposto.ICMS.UFST <> '') or
            (nfe.Det[i].Imposto.ICMS.pBCOp <> 0) or
            (nfe.Det[i].Imposto.ICMS.CST = cstPart10) then
          begin
            xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
              'N25', 'pBCOp   ', 01, IIf(Usar_tcDe4, 07, 05), 1,
              nfe.Det[i].Imposto.ICMS.pBCOp, DSC_PBCOP));
            xmlNode.AppendChild(AddNode(tcStr, 'N24', 'UFST    ',
              02, 02, 1, nfe.Det[i].Imposto.ICMS.UFST, DSC_UFST));
          end;
        end;
        cst20:
        begin
          xmlNode.AppendChild(AddNode(tcStr, 'N13', 'modBC   ',
            01, 01, 1, modBCToStr(nfe.Det[i].Imposto.ICMS.modBC), DSC_MODBC));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N14', 'pRedBC  ', 01, IIf(Usar_tcDe4, 07, 05), 1,
            nfe.Det[i].Imposto.ICMS.pRedBC, DSC_PREDBC));
          xmlNode.AppendChild(AddNode(tcDe2, 'N15', 'vBC     ',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vBC, DSC_VBC));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N16', 'pICMS   ', 01, IIf(Usar_tcDe4, 07, 05), 1,
            nfe.Det[i].Imposto.ICMS.pICMS, DSC_PICMS));
          xmlNode.AppendChild(AddNode(tcDe2, 'N17', 'vICMS   ',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMS, DSC_VICMS));
          if (NFe.infNFe.Versao >= 4) then
          begin
            if (nfe.Det[i].Imposto.ICMS.vBCFCP > 0) or
              (nfe.Det[i].Imposto.ICMS.pFCP > 0) or
              (nfe.Det[i].Imposto.ICMS.vFCP > 0) then
            begin
              xmlNode.AppendChild(AddNode(tcDe2, 'N17a', 'vBCFCP ',
                01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCFCP, DSC_VBCFCP));
              xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
                'N17b', 'pFCP', 01, IIf(Usar_tcDe4, 07, 05), 1,
                nfe.Det[i].Imposto.ICMS.pFCP, DSC_PFCP));
              xmlNode.AppendChild(AddNode(tcDe2, 'N17c', 'vFCP ',
                01, 15, 1, nfe.Det[i].Imposto.ICMS.vFCP, DSC_VFCP));
            end;
          end;
          if (NFe.infNFe.Versao >= 3.10) and
            (nfe.Det[i].Imposto.ICMS.vICMSDeson > 0) then
          begin
            xmlNode.AppendChild(AddNode(tcDe2, 'N27a', 'vICMSDeson',
              01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMSDeson, DSC_VICMSDESON));
            xmlNode.AppendChild(AddNode(tcStr, 'N28', 'motDesICMS',
              01, 02, 1, motDesICMSToStr(nfe.Det[i].Imposto.ICMS.motDesICMS),
              DSC_MOTDESICMS));
          end;
        end;
        cst30:
        begin
          xmlNode.AppendChild(AddNode(tcStr, 'N18', 'modBCST ',
            01, 01, 1, modBCSTToStr(nfe.Det[i].Imposto.ICMS.modBCST), DSC_MODBCST));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N19', 'pMVAST  ', 01, IIf(Usar_tcDe4, 07, 05), 0,
            nfe.Det[i].Imposto.ICMS.pMVAST, DSC_PMVAST));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N20', 'pRedBCST', 01, IIf(Usar_tcDe4, 07, 05), 0,
            nfe.Det[i].Imposto.ICMS.pRedBCST, DSC_PRedBCST));
          xmlNode.AppendChild(AddNode(tcDe2, 'N21', 'vBCST   ',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCST, DSC_VBCST));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N22', 'pICMSST ', 01, IIf(Usar_tcDe4, 07, 05), 1,
            nfe.Det[i].Imposto.ICMS.pICMSST, DSC_PICMSST));
          xmlNode.AppendChild(AddNode(tcDe2, 'N23', 'vICMSST ',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMSST, DSC_VICMSST));
          if (NFe.infNFe.Versao >= 4) then
          begin
            if (nfe.Det[i].Imposto.ICMS.vBCFCPST > 0) or
              (nfe.Det[i].Imposto.ICMS.pFCPST > 0) or
              (nfe.Det[i].Imposto.ICMS.vFCPST > 0) then
            begin
              xmlNode.AppendChild(AddNode(tcDe2, 'N23a',
                'vBCFCPST ', 01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCFCPST, DSC_VBCFCPST));
              xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
                'N23b', 'pFCPST', 01, IIf(Usar_tcDe4, 07, 05), 1,
                nfe.Det[i].Imposto.ICMS.pFCPST, DSC_PFCPST));
              xmlNode.AppendChild(AddNode(tcDe2, 'N23d', 'vFCPST ',
                01, 15, 1, nfe.Det[i].Imposto.ICMS.vFCPST, DSC_VFCPST));
            end;
          end;
          if (NFe.infNFe.Versao >= 3.10) and
            (nfe.Det[i].Imposto.ICMS.vICMSDeson > 0) then
          begin
            xmlNode.AppendChild(AddNode(tcDe2, 'N27a', 'vICMSDeson',
              01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMSDeson, DSC_VICMSDESON));
            xmlNode.AppendChild(AddNode(tcStr, 'N28', 'motDesICMS',
              01, 02, 1, motDesICMSToStr(nfe.Det[i].Imposto.ICMS.motDesICMS),
              DSC_MOTDESICMS));
          end;
        end;
        cst40,
        cst41,
        cst50:
        begin
          //Esse bloco fica a critério de cada UF a obrigação das informações, conforme o manual
          if (NFe.infNFe.Versao >= 3.10) then
          begin
            if (nfe.Det[i].Imposto.ICMS.vICMSDeson > 0) then
            begin
              xmlNode.AppendChild(AddNode(tcDe2, 'N13a',
                'vICMSDeson', 01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMSDeson,
                DSC_VICMSDESON));
              xmlNode.AppendChild(AddNode(tcStr, 'N13b',
                'motDesICMS', 01, 02, 1, motDesICMSToStr(
                nfe.Det[i].Imposto.ICMS.motDesICMS), DSC_MOTDESICMS));
            end;
          end
          else
          begin
            xmlNode.AppendChild(AddNode(tcDe2, 'N17', 'vICMS     ',
              01, 15, 0, nfe.Det[i].Imposto.ICMS.vICMS, DSC_VICMS));
            if (nfe.Det[i].Imposto.ICMS.vICMS > 0) then
              xmlNode.AppendChild(AddNode(tcStr, 'N28', 'motDesICMS',
                01, 01, 0, motDesICMSToStr(nfe.Det[i].Imposto.ICMS.motDesICMS),
                DSC_MOTDESICMS));
          end;
        end;
        cst51:
        begin
          //Esse bloco fica a critério de cada UF a obrigação das informações, conforme o manual
          if nfe.Det[i].Imposto.ICMS.modBC <> dbiNenhum then
            xmlNode.AppendChild(AddNode(tcStr, 'N13', 'modBC',
              01, 01, 0, modBCToStr(nfe.Det[i].Imposto.ICMS.modBC), DSC_MODBC));

          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N14', 'pRedBC   ', 01, IIf(Usar_tcDe4, 07, 05), 0,
            nfe.Det[i].Imposto.ICMS.pRedBC, DSC_PREDBC));
          xmlNode.AppendChild(AddNode(tcDe2, 'N15', 'vBC      ',
            01, 15, 0, nfe.Det[i].Imposto.ICMS.vBC, DSC_VBC));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N16', 'pICMS    ', 01, IIf(Usar_tcDe4, 07, 05), 0,
            nfe.Det[i].Imposto.ICMS.pICMS, DSC_PICMS));
          xmlNode.AppendChild(AddNode(tcDe2, 'N16a', 'vICMSOp ',
            01, 15, 0, nfe.Det[i].Imposto.ICMS.vICMSOp, DSC_VICMS));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N16b', 'pDif    ', 01, IIf(Usar_tcDe4, 07, 05), 0,
            nfe.Det[i].Imposto.ICMS.pDif, DSC_PICMS));
          xmlNode.AppendChild(AddNode(tcDe2, 'N16c', 'vICMSDif',
            01, 15, 0, nfe.Det[i].Imposto.ICMS.vICMSDif, DSC_VICMS));

          if (nfe.Det[i].Imposto.ICMS.pICMS = 0) and
            (nfe.Det[i].Imposto.ICMS.pDif = 0) then
            xmlNode.AppendChild(AddNode(tcDe2, 'N17', 'vICMS',
              01, 15, 0, nfe.Det[i].Imposto.ICMS.vICMS, DSC_VICMS))
          else
            xmlNode.AppendChild(AddNode(tcDe2, 'N17', 'vICMS',
              01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMS, DSC_VICMS));

          if (NFe.infNFe.Versao >= 4) then
          begin
            if (nfe.Det[i].Imposto.ICMS.vBCFCP > 0) or
              (nfe.Det[i].Imposto.ICMS.pFCP > 0) or
              (nfe.Det[i].Imposto.ICMS.vFCP > 0) then
            begin
              xmlNode.AppendChild(AddNode(tcDe2, 'N17a', 'vBCFCP ',
                01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCFCP, DSC_VBCFCP));
              xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
                'N17b', 'pFCP', 01, IIf(Usar_tcDe4, 07, 05), 1,
                nfe.Det[i].Imposto.ICMS.pFCP, DSC_PFCP));
              xmlNode.AppendChild(AddNode(tcDe2, 'N17c', 'vFCP ',
                01, 15, 1, nfe.Det[i].Imposto.ICMS.vFCP, DSC_VFCP));
            end;
          end;
        end;
        cst60:
        begin
          if NFe.infNFe.Versao >= 2 then
          begin
            if (nfe.Det[i].Imposto.ICMS.vBCSTRET > 0) or
              (nfe.Det[i].Imposto.ICMS.vICMSSTRET > 0) then
            begin
              xmlNode.AppendChild(AddNode(tcDe2, 'N26', 'vBCSTRet  ',
                01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCSTRET, DSC_VBCSTRET));

              if (NFe.infNFe.Versao >= 4) then
                xmlNode.AppendChild(
                  AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2), 'N26.1',
                  'pST', 01, IIf(Usar_tcDe4, 07, 05), 1,
                  nfe.Det[i].Imposto.ICMS.pST, DSC_PST));

              xmlNode.AppendChild(AddNode(tcDe2, 'N27', 'vICMSSTRet',
                01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMSSTRET, DSC_VICMSSTRET));
            end;
            if (NFe.infNFe.Versao >= 4) then
            begin
              if (nfe.Det[i].Imposto.ICMS.vBCFCPSTRet > 0) or
                (nfe.Det[i].Imposto.ICMS.pFCPSTRet > 0) or
                (nfe.Det[i].Imposto.ICMS.vFCPSTRet > 0) then
              begin
                xmlNode.AppendChild(AddNode(tcDe2, 'N23a',
                  'vBCFCPSTRet ', 01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCFCPSTRet,
                  DSC_VBCFCPST));
                xmlNode.AppendChild(
                  AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2), 'N27b',
                  'pFCPSTRet', 01, IIf(Usar_tcDe4, 07, 05), 1,
                  nfe.Det[i].Imposto.ICMS.pFCPSTRet, DSC_PFCPSTRET));
                xmlNode.AppendChild(AddNode(tcDe2, 'N27d',
                  'vFCPSTRet ', 01, 15, 1, nfe.Det[i].Imposto.ICMS.vFCPSTRet,
                  DSC_VFCPSTRET));
              end;

              if (nfe.Det[i].Imposto.ICMS.pRedBCEfet > 0) or
                (nfe.Det[i].Imposto.ICMS.vBCEfet > 0) or
                (nfe.Det[i].Imposto.ICMS.pICMSEfet > 0) or
                (nfe.Det[i].Imposto.ICMS.vICMSEfet > 0) then
              begin
                xmlNode.AppendChild(
                  AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2), 'N34',
                  'pRedBCEfet', 01, IIf(Usar_tcDe4, 07, 05), 1,
                  nfe.Det[i].Imposto.ICMS.pRedBCEfet, DSC_PREDBCEFET));
                xmlNode.AppendChild(AddNode(tcDe2, 'N35',
                  'vBCEfet ', 01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCEfet, DSC_VBCEFET));
                xmlNode.AppendChild(
                  AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2), 'N36',
                  'pICMSEfet', 01, IIf(Usar_tcDe4, 07, 05), 1,
                  nfe.Det[i].Imposto.ICMS.pICMSEfet, DSC_PICMSEFET));
                xmlNode.AppendChild(AddNode(tcDe2, 'N37',
                  'vICMSEfet ', 01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMSEfet,
                  DSC_VICMSEFET));
              end;
            end;
          end
          else
          begin
            xmlNode.AppendChild(AddNode(tcDe2, 'N21', 'vBCST   ',
              01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCST, DSC_VBCST));
            xmlNode.AppendChild(AddNode(tcDe2, 'N23', 'vICMSST ',
              01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMSST, DSC_VICMSST));
          end;
        end;
        cst70:
        begin
          xmlNode.AppendChild(AddNode(tcStr, 'N13', 'modBC   ',
            01, 01, 1, modBCToStr(nfe.Det[i].Imposto.ICMS.modBC), DSC_MODBC));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N14', 'pRedBC  ', 01, IIf(Usar_tcDe4, 07, 05), 1,
            nfe.Det[i].Imposto.ICMS.pRedBC, DSC_PREDBC));
          xmlNode.AppendChild(AddNode(tcDe2, 'N15', 'vBC     ',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vBC, DSC_VBC));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N16', 'pICMS   ', 01, IIf(Usar_tcDe4, 07, 05), 1,
            nfe.Det[i].Imposto.ICMS.pICMS, DSC_PICMS));
          xmlNode.AppendChild(AddNode(tcDe2, 'N17', 'vICMS   ',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMS, DSC_VICMS));

          if (NFe.infNFe.Versao >= 4) then
          begin
            if (nfe.Det[i].Imposto.ICMS.vBCFCP > 0) or
              (nfe.Det[i].Imposto.ICMS.pFCP > 0) or
              (nfe.Det[i].Imposto.ICMS.vFCP > 0) then
            begin
              xmlNode.AppendChild(AddNode(tcDe2, 'N23a', 'vBCFCP',
                01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCFCP, DSC_VBCFCP));
              xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
                'N23b', 'pFCP', 01, IIf(Usar_tcDe4, 07, 05), 1,
                nfe.Det[i].Imposto.ICMS.pFCP, DSC_PFCP));
              xmlNode.AppendChild(AddNode(tcDe2, 'N23d', 'vFCP  ',
                01, 15, 1, nfe.Det[i].Imposto.ICMS.vFCP, DSC_VFCP));
            end;
          end;

          xmlNode.AppendChild(AddNode(tcStr, 'N18', 'modBCST ',
            01, 01, 1, modBCSTToStr(nfe.Det[i].Imposto.ICMS.modBCST), DSC_MODBCST));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N19', 'pMVAST  ', 01, IIf(Usar_tcDe4, 07, 05), 0,
            nfe.Det[i].Imposto.ICMS.pMVAST, DSC_PMVAST));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N20', 'pRedBCST', 01, IIf(Usar_tcDe4, 07, 05), 0,
            nfe.Det[i].Imposto.ICMS.pRedBCST, DSC_PREDBCST));
          xmlNode.AppendChild(AddNode(tcDe2, 'N21', 'vBCST   ',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCST, DSC_VBCST));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N22', 'pICMSST ', 01, IIf(Usar_tcDe4, 07, 05), 1,
            nfe.Det[i].Imposto.ICMS.pICMSST, DSC_PICMSST));
          xmlNode.AppendChild(AddNode(tcDe2, 'N23', 'vICMSST ',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMSST, DSC_VICMSST));
          if (NFe.infNFe.Versao >= 4) then
          begin
            if (nfe.Det[i].Imposto.ICMS.vBCFCPST > 0) or
              (nfe.Det[i].Imposto.ICMS.pFCPST > 0) or
              (nfe.Det[i].Imposto.ICMS.vFCPST > 0) then
            begin
              xmlNode.AppendChild(AddNode(tcDe2, 'N23a',
                'vBCFCPST ', 01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCFCPST, DSC_VBCFCPST));
              xmlNode.AppendChild(
                AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2), 'N23b', 'pFCPST',
                01, IIf(Usar_tcDe4, 07, 05), 1, nfe.Det[i].Imposto.ICMS.pFCPST,
                DSC_PFCPST));
              xmlNode.AppendChild(AddNode(tcDe2, 'N23d', 'vFCPST ',
                01, 15, 1, nfe.Det[i].Imposto.ICMS.vFCPST, DSC_VFCPST));
            end;
          end;
          if (NFe.infNFe.Versao >= 3) and
            (nfe.Det[i].Imposto.ICMS.vICMSDeson > 0) then
          begin
            xmlNode.AppendChild(AddNode(tcDe2, 'N27a', 'vICMSDeson',
              01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMSDeson, DSC_VICMSDESON));
            xmlNode.AppendChild(AddNode(tcStr, 'N28', 'motDesICMS',
              01, 02, 1, motDesICMSToStr(nfe.Det[i].Imposto.ICMS.motDesICMS),
              DSC_MOTDESICMS));
          end;
        end;
        cst90,
        cstPart90:
        begin
          if (nfe.Det[i].Imposto.ICMS.vBC > 0) or
            (nfe.Det[i].Imposto.ICMS.vICMS > 0) then
          begin
            xmlNode.AppendChild(AddNode(tcStr, 'N13', 'modBC   ',
              01, 01, 1, modBCToStr(nfe.Det[i].Imposto.ICMS.modBC), DSC_MODBC));
            xmlNode.AppendChild(AddNode(tcDe2, 'N15', 'vBC     ',
              01, 15, 1, nfe.Det[i].Imposto.ICMS.vBC, DSC_VBC));
            xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
              'N14', 'pRedBC  ', 01, IIf(Usar_tcDe4, 07, 05), 0,
              nfe.Det[i].Imposto.ICMS.pRedBC, DSC_PREDBC));
            xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
              'N16', 'pICMS   ', 01, IIf(Usar_tcDe4, 07, 05), 1,
              nfe.Det[i].Imposto.ICMS.pICMS, DSC_PICMS));
            xmlNode.AppendChild(AddNode(tcDe2, 'N17', 'vICMS   ',
              01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMS, DSC_VICMS));
          end;
          if (NFe.infNFe.Versao >= 4) then
          begin
            if (nfe.Det[i].Imposto.ICMS.vBCFCP > 0) or
              (nfe.Det[i].Imposto.ICMS.pFCP > 0) or
              (nfe.Det[i].Imposto.ICMS.vFCP > 0) then
            begin
              xmlNode.AppendChild(AddNode(tcDe2, 'N17a', 'vBCFCP ',
                01, 15, 0, nfe.Det[i].Imposto.ICMS.vBCFCP, DSC_VBCFCP));
              xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
                'N17b', 'pFCP', 01, IIf(Usar_tcDe4, 07, 05), 0,
                nfe.Det[i].Imposto.ICMS.pFCP, DSC_PFCP));
              xmlNode.AppendChild(AddNode(tcDe2, 'N17c', 'vFCP ',
                01, 15, 0, nfe.Det[i].Imposto.ICMS.vFCP, DSC_VFCP));
            end;
          end;
          if (nfe.Det[i].Imposto.ICMS.vBCST > 0) or
            (nfe.Det[i].Imposto.ICMS.vICMSST > 0) then
          begin
            xmlNode.AppendChild(AddNode(tcStr, 'N18', 'modBCST ',
              01, 01, 1, modBCSTToStr(nfe.Det[i].Imposto.ICMS.modBCST), DSC_MODBCST));
            xmlNode.AppendChild(AddNode(tcDe2, 'N19', 'pMVAST  ',
              01, 05, 0, nfe.Det[i].Imposto.ICMS.pMVAST, DSC_PMVAST));
            xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
              'N20', 'pRedBCST', 01, IIf(Usar_tcDe4, 07, 05), 0,
              nfe.Det[i].Imposto.ICMS.pRedBCST, DSC_PREDBCST));
            xmlNode.AppendChild(AddNode(tcDe2, 'N21', 'vBCST   ',
              01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCST, DSC_VBCST));
            xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
              'N22', 'pICMSST ', 01, IIf(Usar_tcDe4, 07, 05), 1,
              nfe.Det[i].Imposto.ICMS.pICMSST, DSC_PICMSST));
            xmlNode.AppendChild(AddNode(tcDe2, 'N23', 'vICMSST ',
              01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMSST, DSC_VICMSST));
          end;
          if (NFe.infNFe.Versao >= 4) then
          begin
            if (nfe.Det[i].Imposto.ICMS.vBCFCPST > 0) or
              (nfe.Det[i].Imposto.ICMS.pFCPST > 0) or
              (nfe.Det[i].Imposto.ICMS.vFCPST > 0) then
            begin
              xmlNode.AppendChild(AddNode(tcDe2, 'N23a',
                'vBCFCPST ', 01, 15, 0, nfe.Det[i].Imposto.ICMS.vBCFCPST, DSC_VBCFCPST));
              xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
                'N23b', 'pFCPST', 01, IIf(Usar_tcDe4, 07, 05), 0,
                nfe.Det[i].Imposto.ICMS.pFCPST, DSC_PFCPST));
              xmlNode.AppendChild(AddNode(tcDe2, 'N23d', 'vFCPST ',
                01, 15, 0, nfe.Det[i].Imposto.ICMS.vFCPST, DSC_VFCPST));
            end;
          end;
          if (nfe.Det[i].Imposto.ICMS.CST = cst90) and
            (NFe.infNFe.Versao >= 3.10) and
            (nfe.Det[i].Imposto.ICMS.vICMSDeson > 0) then
          begin
            xmlNode.AppendChild(AddNode(tcDe2, 'N27a', 'vICMSDeson',
              01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMSDeson, DSC_VICMSDESON));
            xmlNode.AppendChild(AddNode(tcStr, 'N28', 'motDesICMS',
              01, 02, 1, motDesICMSToStr(nfe.Det[i].Imposto.ICMS.motDesICMS),
              DSC_MOTDESICMS));
          end;
          if (nfe.Det[i].Imposto.ICMS.UFST <> '') or
            (nfe.Det[i].Imposto.ICMS.pBCOp <> 0) or
            (nfe.Det[i].Imposto.ICMS.CST = cstPart90) then
          begin
            xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
              'N25', 'pBCOp  ', 01, IIf(Usar_tcDe4, 07, 05), 1,
              nfe.Det[i].Imposto.ICMS.pBCOp, DSC_PBCOP));
            xmlNode.AppendChild(AddNode(tcStr, 'N24', 'UFST   ',
              02, 02, 1, nfe.Det[i].Imposto.ICMS.UFST, DSC_UFST));
          end;
        end;
        cstRep41,
        cstRep60:
        begin
          // ICMSST - Repasse
          xmlNode.AppendChild(AddNode(tcDe2, 'N26', 'vBCSTRet   ',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCSTRet, DSC_VBCICMSST));
          xmlNode.AppendChild(AddNode(tcDe2, 'N27', 'vICMSSTRet ',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMSSTRet, DSC_VICMSSTRET));

          if (nfe.Det[i].Imposto.ICMS.vBCFCPSTRet > 0) or
            (nfe.Det[i].Imposto.ICMS.pFCPSTRet > 0) or
            (nfe.Det[i].Imposto.ICMS.vFCPSTRet > 0) then
          begin
            xmlNode.AppendChild(AddNode(tcDe2, 'N27a', 'vBCFCPSTRet ',
              01, 15, 0, nfe.Det[i].Imposto.ICMS.vBCFCPSTRet, DSC_VBCFCP));
            xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
              'N27b', 'pFCPSTRet', 01, IIf(Usar_tcDe4, 07, 05), 0,
              nfe.Det[i].Imposto.ICMS.pFCPSTRet, DSC_PFCP));
            xmlNode.AppendChild(AddNode(tcDe2, 'N27c', 'vFCPSTRet ',
              01, 15, 0, nfe.Det[i].Imposto.ICMS.vFCPSTRet, DSC_VFCP));
          end;

          xmlNode.AppendChild(AddNode(tcDe2, 'N31', 'vBCSTDest  ',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCSTDest, DSC_VBCICMSSTDEST));
          xmlNode.AppendChild(AddNode(tcDe2, 'N32', 'vICMSSTDest',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMSSTDest, DSC_VBCICMSSTDEST));
        end;
      end;
    end;
    crtSimplesNacional:
    begin
      //Grupo do Simples Nacional
      sTagTemp := CSOSNTOStrTagPos(nfe.Det[i].Imposto.ICMS.CSOSN);
      xmlNode := Result.AddChild('ICMSSN' + sTagTemp);
      xmlNode.AppendChild(AddNode(tcStr, 'N11', 'orig ', 01, 01,
        1, OrigTOStr(nfe.Det[i].Imposto.ICMS.orig), DSC_ORIG));
      xmlNode.AppendChild(AddNode(tcStr, 'N12a', 'CSOSN', 03, 03, 1,
        CSOSNIcmsToStr(nfe.Det[i].Imposto.ICMS.CSOSN), DSC_CSOSN));
      case nfe.Det[i].Imposto.ICMS.CSOSN of
        csosn101:
        begin
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N29', 'pCredSN    ', 01, IIf(Usar_tcDe4, 07, 05), 1,
            nfe.Det[i].Imposto.ICMS.pCredSN, DSC_PCREDSN));
          xmlNode.AppendChild(AddNode(tcDe2, 'N30', 'vCredICMSSN',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vCredICMSSN, DSC_VCREDICMSSN));
        end;
        csosn102,
        csosn103,
        csosn300,
        csosn400:
        begin
          //Tags ORIG e CSON já criadas antes do case
        end;
        csosn201:
        begin  //10e
          xmlNode.AppendChild(AddNode(tcStr, 'N18', 'modBCST ',
            01, 01, 1, modBCSTToStr(nfe.Det[i].Imposto.ICMS.modBCST), DSC_MODBCST));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N19', 'pMVAST  ', 01, IIf(Usar_tcDe4, 07, 05), 0,
            nfe.Det[i].Imposto.ICMS.pMVAST, DSC_PMVAST));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N20', 'pRedBCST', 01, IIf(Usar_tcDe4, 07, 05), 0,
            nfe.Det[i].Imposto.ICMS.pRedBCST, DSC_PREDBCST));
          xmlNode.AppendChild(AddNode(tcDe2, 'N21', 'vBCST   ',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCST, DSC_VBCST));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N22', 'pICMSST ', 01, IIf(Usar_tcDe4, 07, 05), 1,
            nfe.Det[i].Imposto.ICMS.pICMSST, DSC_PICMSST));
          xmlNode.AppendChild(AddNode(tcDe2, 'N23', 'vICMSST ',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMSST, DSC_VICMSST));
          if (NFe.infNFe.Versao >= 4) then
          begin
            if (nfe.Det[i].Imposto.ICMS.vBCFCPST > 0) or
              (nfe.Det[i].Imposto.ICMS.pFCPST > 0) or
              (nfe.Det[i].Imposto.ICMS.vFCPST > 0) then
            begin
              xmlNode.AppendChild(AddNode(tcDe2, 'N23a',
                'vBCFCPST ', 01, 15, 0, nfe.Det[i].Imposto.ICMS.vBCFCPST, DSC_VBCFCPST));
              xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
                'N23b', 'pFCPST', 01, IIf(Usar_tcDe4, 07, 05), 0,
                nfe.Det[i].Imposto.ICMS.pFCPST, DSC_PFCPST));
              xmlNode.AppendChild(AddNode(tcDe2, 'N23d', 'vFCPST ',
                01, 15, 0, nfe.Det[i].Imposto.ICMS.vFCPST, DSC_VFCPST));
            end;
          end;
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N29', 'pCredSN ', 01, IIf(Usar_tcDe4, 07, 05), 1,
            nfe.Det[i].Imposto.ICMS.pCredSN, DSC_PCREDSN));
          xmlNode.AppendChild(AddNode(tcDe2, 'N30', 'vCredICMSSN',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vCredICMSSN, DSC_VCREDICMSSN));
        end;
        csosn202,
        csosn203:
        begin   //10f
          xmlNode.AppendChild(AddNode(tcStr, 'N18', 'modBCST ',
            01, 01, 1, modBCSTToStr(nfe.Det[i].Imposto.ICMS.modBCST), DSC_MODBCST));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N19', 'pMVAST  ', 01, IIf(Usar_tcDe4, 07, 05), 0,
            nfe.Det[i].Imposto.ICMS.pMVAST, DSC_PMVAST));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N20', 'pRedBCST', 01, IIf(Usar_tcDe4, 07, 05), 0,
            nfe.Det[i].Imposto.ICMS.pRedBCST, DSC_PREDBCST));
          xmlNode.AppendChild(AddNode(tcDe2, 'N21', 'vBCST   ',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCST, DSC_VBCST));
          xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
            'N22', 'pICMSST ', 01, IIf(Usar_tcDe4, 07, 05), 1,
            nfe.Det[i].Imposto.ICMS.pICMSST, DSC_PICMSST));
          xmlNode.AppendChild(AddNode(tcDe2, 'N23', 'vICMSST ',
            01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMSST, DSC_VICMSST));
          if (NFe.infNFe.Versao >= 4) then
          begin
            if (nfe.Det[i].Imposto.ICMS.vBCFCPST > 0) or
              (nfe.Det[i].Imposto.ICMS.pFCPST > 0) or
              (nfe.Det[i].Imposto.ICMS.vFCPST > 0) then
            begin
              xmlNode.AppendChild(AddNode(tcDe2, 'N23a',
                'vBCFCPST ', 01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCFCPST, DSC_VBCFCPST));
              xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
                'N23b', 'pFCPST', 01, IIf(Usar_tcDe4, 07, 05), 1,
                nfe.Det[i].Imposto.ICMS.pFCPST, DSC_PFCPST));
              xmlNode.AppendChild(AddNode(tcDe2, 'N23d', 'vFCPST ',
                01, 15, 1, nfe.Det[i].Imposto.ICMS.vFCPST, DSC_VFCPST));
            end;
          end;
        end;
        csosn500:
        begin //10g
          if (nfe.Det[i].Imposto.ICMS.vBCSTRET > 0) or
            (nfe.Det[i].Imposto.ICMS.vICMSSTRET > 0) then
          begin
            xmlNode.AppendChild(AddNode(tcDe2, 'N26', 'vBCSTRet  ',
              01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCSTRET, DSC_VBCSTRET));

            if (NFe.infNFe.Versao >= 4) then
              xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
                'N26.1', 'pST', 01, IIf(Usar_tcDe4, 07, 05), 1,
                nfe.Det[i].Imposto.ICMS.pST, DSC_PST));

            xmlNode.AppendChild(AddNode(tcDe2, 'N27', 'vICMSSTRet',
              01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMSSTRET, DSC_VICMSSTRET));
          end;
          if (NFe.infNFe.Versao >= 4) then
          begin
            if (nfe.Det[i].Imposto.ICMS.vBCFCPSTRet > 0) or
              (nfe.Det[i].Imposto.ICMS.pFCPSTRet > 0) or
              (nfe.Det[i].Imposto.ICMS.vFCPSTRet > 0) then
            begin
              xmlNode.AppendChild(AddNode(tcDe2, 'N27a',
                'vBCFCPSTRet', 01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCFCPSTRet,
                DSC_VBCFCPST));
              xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
                'N27b', 'pFCPSTRet', 01, IIf(Usar_tcDe4, 07, 05), 1,
                nfe.Det[i].Imposto.ICMS.pFCPSTRet, DSC_PFCPSTRET));
              xmlNode.AppendChild(AddNode(tcDe2, 'N27d',
                'vFCPSTRet ', 01, 15, 1, nfe.Det[i].Imposto.ICMS.vFCPSTRet,
                DSC_VFCPSTRET));
            end;

            if (nfe.Det[i].Imposto.ICMS.pRedBCEfet > 0) or
              (nfe.Det[i].Imposto.ICMS.vBCEfet > 0) or
              (nfe.Det[i].Imposto.ICMS.pICMSEfet > 0) or
              (nfe.Det[i].Imposto.ICMS.vICMSEfet > 0) then
            begin
              xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
                'N34', 'pRedBCEfet', 01, IIf(Usar_tcDe4, 07, 05), 1,
                nfe.Det[i].Imposto.ICMS.pRedBCEfet, DSC_PREDBCEFET));
              xmlNode.AppendChild(AddNode(tcDe2, 'N35', 'vBCEfet ',
                01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCEfet, DSC_VBCEFET));
              xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
                'N36', 'pICMSEfet', 01, IIf(Usar_tcDe4, 07, 05), 1,
                nfe.Det[i].Imposto.ICMS.pICMSEfet, DSC_PICMSEFET));
              xmlNode.AppendChild(AddNode(tcDe2, 'N37', 'vICMSEfet ',
                01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMSEfet, DSC_VICMSEFET));
            end;
          end;
        end;
        csosn900:
        begin //10h
          if (nfe.Det[i].Imposto.ICMS.vBC > 0) or
            (nfe.Det[i].Imposto.ICMS.vICMS > 0) then
          begin
            xmlNode.AppendChild(AddNode(tcStr, 'N13', 'modBC   ',
              01, 01, 1, modBCToStr(nfe.Det[i].Imposto.ICMS.modBC), DSC_MODBC));
            xmlNode.AppendChild(AddNode(tcDe2, 'N15', 'vBC     ',
              01, 15, 1, nfe.Det[i].Imposto.ICMS.vBC, DSC_VBC));
            xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
              'N14', 'pRedBC  ', 01, IIf(Usar_tcDe4, 07, 05), 0,
              nfe.Det[i].Imposto.ICMS.pRedBC, DSC_PREDBC));
            xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
              'N16', 'pICMS   ', 01, IIf(Usar_tcDe4, 07, 05), 1,
              nfe.Det[i].Imposto.ICMS.pICMS, DSC_PICMS));
            xmlNode.AppendChild(AddNode(tcDe2, 'N17', 'vICMS   ',
              01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMS, DSC_VICMS));
          end;
          if (nfe.Det[i].Imposto.ICMS.vBCST > 0) or
            (nfe.Det[i].Imposto.ICMS.vICMSST > 0) then
          begin
            xmlNode.AppendChild(AddNode(tcStr, 'N18', 'modBCST ',
              01, 01, 1, modBCSTToStr(nfe.Det[i].Imposto.ICMS.modBCST), DSC_MODBCST));
            xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
              'N19', 'pMVAST  ', 01, IIf(Usar_tcDe4, 07, 05), 0,
              nfe.Det[i].Imposto.ICMS.pMVAST, DSC_PMVAST));
            xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
              'N20', 'pRedBCST', 01, IIf(Usar_tcDe4, 07, 05), 0,
              nfe.Det[i].Imposto.ICMS.pRedBCST, DSC_PREDBCST));
            xmlNode.AppendChild(AddNode(tcDe2, 'N21', 'vBCST   ',
              01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCST, DSC_VBCST));
            xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
              'N22', 'pICMSST ', 01, IIf(Usar_tcDe4, 07, 05), 1,
              nfe.Det[i].Imposto.ICMS.pICMSST, DSC_PICMSST));
            xmlNode.AppendChild(AddNode(tcDe2, 'N23', 'vICMSST ',
              01, 15, 1, nfe.Det[i].Imposto.ICMS.vICMSST, DSC_VICMSST));
          end;
          if (NFe.infNFe.Versao >= 4) then
          begin
            if (nfe.Det[i].Imposto.ICMS.vBCFCPST > 0) or
              (nfe.Det[i].Imposto.ICMS.pFCPST > 0) or
              (nfe.Det[i].Imposto.ICMS.vFCPST > 0) then
            begin
              xmlNode.AppendChild(AddNode(tcDe2, 'N23a',
                'vBCFCPST ', 01, 15, 1, nfe.Det[i].Imposto.ICMS.vBCFCPST, DSC_VBCFCPST));
              xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
                'N23b', 'pFCPST', 01, IIf(Usar_tcDe4, 07, 05), 1,
                nfe.Det[i].Imposto.ICMS.pFCPST, DSC_PFCPST));
              xmlNode.AppendChild(AddNode(tcDe2, 'N23d', 'vFCPST ',
                01, 15, 1, nfe.Det[i].Imposto.ICMS.vFCPST, DSC_VFCPST));
            end;
          end;
          if nfe.Det[i].Imposto.ICMS.pCredSN > 0 then
          begin
            xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
              'N29', 'pCredSN    ', 01, IIf(Usar_tcDe4, 07, 05), 1,
              nfe.Det[i].Imposto.ICMS.pCredSN, DSC_PCREDSN));
            xmlNode.AppendChild(AddNode(tcDe2, 'N30', 'vCredICMSSN',
              01, 15, 1, nfe.Det[i].Imposto.ICMS.vCredICMSSN, DSC_VCREDICMSSN));
          end;
        end;
      end;
    end;
  end;
  //N10a
  //N10b
  //N10c - Simples Nacional
  //N10d - Simples Nacional
  //N10e - Simples Nacional
  //N10f - Simples Nacional
  //N10g - Simples Nacional
  //N10h - Simples Nacional
end;

function TNFeXmlWriter.GerarDetImpostoIPI(const i: integer): TACBrXmlNode;
var
  CST00495099: boolean;
  xmlNode: TACBrXmlNode;
begin
  Result := nil;

  if NFe.Ide.modelo <> 55 then   //não deve gerar grupo IPI para NFCe
    Exit;

  // variavel CST00495099 usada para Ignorar Tag <IPI>
  // se GerarTagIPIparaNaoTributado = False e CST00495099 = False

  CST00495099 := (nfe.Det[i].Imposto.IPI.CST in [ipi00, ipi49, ipi50, ipi99]);

  if (not Opcoes.FGerarTagIPIparaNaoTributado) and (not CST00495099) then
    Exit;

  //se valores padrão de quando não foi preenchido a TAG IPI
  if ((nfe.Det[i].Imposto.IPI.cEnq = '') and (nfe.Det[i].Imposto.IPI.CST = ipi00) and
    (nfe.Det[i].Imposto.IPI.vBC = 0) and (nfe.Det[i].Imposto.IPI.qUnid = 0) and
    (nfe.Det[i].Imposto.IPI.vUnid = 0) and (nfe.Det[i].Imposto.IPI.pIPI = 0) and
    (nfe.Det[i].Imposto.IPI.vIPI = 0)) then
    Exit; //não deve preencher a TAG

  Result := FDocument.CreateElement('IPI');

  if NFe.infNFe.Versao < 4 then
    Result.AppendChild(AddNode(tcStr, 'O02', 'clEnq', 01, 05, 0,
      nfe.Det[i].Imposto.IPI.clEnq, DSC_CLENQ));

  Result.AppendChild(AddNode(tcStr, 'O03', 'CNPJProd', 14, 14, 0,
    nfe.Det[i].Imposto.IPI.CNPJProd, DSC_CNPJPROD));
  Result.AppendChild(AddNode(tcStr, 'O04', 'cSelo   ', 01, 60, 0,
    nfe.Det[i].Imposto.IPI.cSelo, DSC_CSELO));
  Result.AppendChild(AddNode(tcInt, 'O05', 'qSelo   ', 01, 12, 0,
    nfe.Det[i].Imposto.IPI.qSelo, DSC_QSELO));
  if nfe.Det[i].Imposto.IPI.cEnq = '' then
    nfe.Det[i].Imposto.IPI.cEnq := '999';
  Result.AppendChild(AddNode(tcStr, 'O06', 'cEnq    ', 03, 03, 1,
    nfe.Det[i].Imposto.IPI.cEnq, DSC_CENQ));
  if CST00495099 then
  begin

    if (nfe.Det[i].Imposto.IPI.vBC + nfe.Det[i].Imposto.IPI.pIPI > 0) and
      (nfe.Det[i].Imposto.IPI.qUnid + nfe.Det[i].Imposto.IPI.vUnid > 0) then
      wAlerta('O07', 'IPITrib', DSC_IPITrib,
        'As TAG <vBC> e <pIPI> não podem ser informadas em conjunto com as TAG <qUnid> e <vUnid>');

    if (nfe.Det[i].Imposto.IPI.qUnid + nfe.Det[i].Imposto.IPI.vUnid > 0) then
    begin
      xmlNode := Result.AddChild('IPITrib');
      xmlNode.AppendChild(AddNode(tcStr, 'O09', 'CST     ', 02, 02,
        1, CSTIPITOStr(nfe.Det[i].Imposto.IPI.CST), DSC_CST));
      xmlNode.AppendChild(AddNode(tcDe4, 'O11', 'qUnid   ', 01, 16,
        1, nfe.Det[i].Imposto.IPI.qUnid, DSC_QUNID));
      xmlNode.AppendChild(AddNode(tcDe4, 'O12', 'vUnid   ', 01, 15,
        1, nfe.Det[i].Imposto.IPI.vUnid, DSC_VUNID));
      xmlNode.AppendChild(AddNode(tcDe2, 'O14', 'vIPI    ', 01, 15,
        1, nfe.Det[i].Imposto.IPI.vIPI, DSC_VIPI));
    end
    else
    begin
      xmlNode := Result.AddChild('IPITrib');
      xmlNode.AppendChild(AddNode(tcStr, 'O09', 'CST     ', 02, 02,
        1, CSTIPITOStr(nfe.Det[i].Imposto.IPI.CST), DSC_CST));
      xmlNode.AppendChild(AddNode(tcDe2, 'O10', 'vBC     ', 01, 15,
        1, nfe.Det[i].Imposto.IPI.vBC, DSC_VBC));
      xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2),
        'O13', 'pIPI    ', 01, IIf(Usar_tcDe4, 07, 05), 1,
        nfe.Det[i].Imposto.IPI.pIPI, DSC_PIPI));
      xmlNode.AppendChild(AddNode(tcDe2, 'O14', 'vIPI    ', 01, 15,
        1, nfe.Det[i].Imposto.IPI.vIPI, DSC_VIPI));
    end;
  end
  else (* Quando CST/IPI for 01,02,03,04,51,52,53,54 ou 55 *)
  begin
    xmlNode := Result.AddChild('IPINT');
    xmlNode.AppendChild(AddNode(tcStr, 'O09', 'CST     ', 02, 02, 1,
      CSTIPITOStr(nfe.Det[i].Imposto.IPI.CST), DSC_CST));
  end;
end;

function TNFeXmlWriter.GerarDetImpostoII(const i: integer): TACBrXmlNode;
begin
  Result := nil;
  if (nfe.Det[i].Imposto.II.vBc > 0) or (nfe.Det[i].Imposto.II.vDespAdu > 0) or
    (nfe.Det[i].Imposto.II.vII > 0) or (nfe.Det[i].Imposto.II.vIOF > 0) or
    (Copy(nfe.Det[i].Prod.CFOP, 1, 1) = '3') then
  begin
    Result := FDocument.CreateElement('II');
    Result.AppendChild(AddNode(tcDe2, 'P02', 'vBC     ', 01, 15, 1,
      nfe.Det[i].Imposto.II.vBc, DSC_VBC));
    Result.AppendChild(AddNode(tcDe2, 'P03', 'vDespAdu', 01, 15, 1,
      nfe.Det[i].Imposto.II.vDespAdu, DSC_VDESPADU));
    Result.AppendChild(AddNode(tcDe2, 'P04', 'vII     ', 01, 15, 1,
      nfe.Det[i].Imposto.II.vII, DSC_VII));
    Result.AppendChild(AddNode(tcDe2, 'P04', 'vIOF    ', 01, 15, 1,
      nfe.Det[i].Imposto.II.vIOF, DSC_VIOF));
  end;
end;

function TNFeXmlWriter.GerarDetImpostoPIS(const i: integer): TACBrXmlNode;
var
  xmlNode: TACBrXmlNode;
begin
  Result := nil;
  if (nfe.Ide.modelo <> 55) and ((nfe.Det[i].Imposto.PIS.vBC = 0) and
    (nfe.Det[i].Imposto.PIS.pPIS = 0) and (nfe.Det[i].Imposto.PIS.vPIS = 0) and
    (nfe.Det[i].Imposto.PIS.qBCProd = 0) and
    (nfe.Det[i].Imposto.PIS.vAliqProd = 0) and
    (not (nfe.Det[i].Imposto.PIS.CST in [pis04, pis05, pis06, pis07,
    pis08, pis09, pis49, pis99]))) then
    //No caso da NFC-e, o grupo de tributação do PIS e o grupo de tributação da COFINS são opcionais.
    exit;

  Result := FDocument.CreateElement('PIS');
  if nfe.Det[i].Imposto.PIS.CST in [pis01, pis02] then
  begin
    xmlNode := Result.AddChild('PISAliq');
    xmlNode.AppendChild(AddNode(tcStr, 'Q06', 'CST      ', 02, 02,
      1, CSTPISTOStr(nfe.Det[i].Imposto.PIS.CST), DSC_CST));
    xmlNode.AppendChild(AddNode(tcDe2, 'Q07', 'vBC      ', 01, 15,
      1, nfe.Det[i].Imposto.PIS.vBC, DSC_VBC));
    xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2), 'Q08',
      'pPIS     ', 01, IIf(Usar_tcDe4, 07, 05), 1, nfe.Det[i].Imposto.PIS.pPIS, DSC_PPIS));
    xmlNode.AppendChild(AddNode(tcDe2, 'Q09', 'vPIS     ', 01, 15,
      1, nfe.Det[i].Imposto.PIS.vPIS, DSC_VPIS));
  end
  else if nfe.Det[i].Imposto.PIS.CST = pis03 then
  begin
    xmlNode := Result.AddChild('PISQtde');
    xmlNode.AppendChild(AddNode(tcStr, 'Q06', 'CST      ', 02, 02,
      1, CSTPISTOStr(nfe.Det[i].Imposto.PIS.CST), DSC_CST));
    xmlNode.AppendChild(AddNode(tcDe4, 'Q10', 'qBCProd  ', 01, 16,
      1, nfe.Det[i].Imposto.PIS.qBCProd, DSC_QBCPROD));
    xmlNode.AppendChild(AddNode(tcDe4, 'Q11', 'vAliqProd', 01, 15,
      1, nfe.Det[i].Imposto.PIS.vAliqProd, DSC_VALIQPROD));
    xmlNode.AppendChild(AddNode(tcDe2, 'Q09', 'vPIS     ', 01, 15,
      1, nfe.Det[i].Imposto.PIS.vPIS, DSC_VPIS));
  end
  else if nfe.Det[i].Imposto.PIS.CST in [pis04, pis05, pis06, pis07, pis08, pis09] then
  begin
    xmlNode := Result.AddChild('PISNT');
    xmlNode.AppendChild(AddNode(tcStr, 'Q06', 'CST      ', 02, 02,
      1, CSTPISTOStr(nfe.Det[i].Imposto.PIS.CST), DSC_CST));
  end
  else if nfe.Det[i].Imposto.PIS.CST in [pis49, pis50, pis51, pis52,
    pis53, pis54, pis55, pis56, pis60, pis61, pis62, pis63, pis64, pis65,
    pis66, pis67, pis70, pis71, pis72, pis73, pis74, pis75, pis98, pis99] then
  begin

    if (NFe.Det[i].Imposto.PIS.vBC + NFe.Det[i].Imposto.PIS.pPIS > 0) and
      (NFe.Det[i].Imposto.PIS.qBCProd + NFe.Det[i].Imposto.PIS.vAliqProd > 0) then
      wAlerta('Q05', 'PISOutr', DSC_PISOUTR,
        'As TAG <vBC> e <pPIS> não podem ser informadas em conjunto com as TAG <qBCProd> e <vAliqProd>');

    if (NFe.Det[i].Imposto.PIS.qBCProd + NFe.Det[i].Imposto.PIS.vAliqProd > 0) then
    begin
      xmlNode := Result.AddChild('PISOutr');
      xmlNode.AppendChild(AddNode(tcStr, 'Q06', 'CST      ', 02, 02,
        1, CSTPISTOStr(nfe.Det[i].Imposto.PIS.CST), DSC_CST));
      xmlNode.AppendChild(AddNode(tcDe4, 'Q10', 'qBCProd  ', 01, 16,
        1, nfe.Det[i].Imposto.PIS.qBCProd, DSC_QBCPROD));
      xmlNode.AppendChild(AddNode(tcDe4, 'Q11', 'vAliqProd', 01, 15,
        1, nfe.Det[i].Imposto.PIS.vAliqProd, DSC_VALIQPROD));
      xmlNode.AppendChild(AddNode(tcDe2, 'Q09', 'vPIS     ', 01, 15,
        1, nfe.Det[i].Imposto.PIS.vPIS, DSC_VPIS));
    end
    else
    begin
      xmlNode := Result.AddChild('PISOutr');
      xmlNode.AppendChild(AddNode(tcStr, 'Q06', 'CST      ', 02, 02,
        1, CSTPISTOStr(nfe.Det[i].Imposto.PIS.CST), DSC_CST));
      xmlNode.AppendChild(AddNode(tcDe2, 'Q07', 'vBC      ', 01, 15,
        1, nfe.Det[i].Imposto.PIS.vBC, DSC_VBC));
      xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2), 'Q08',
        'pPIS     ', 01, IIf(Usar_tcDe4, 07, 05), 1, nfe.Det[i].Imposto.PIS.pPIS, DSC_PPIS));
      xmlNode.AppendChild(AddNode(tcDe2, 'Q09', 'vPIS     ', 01, 15,
        1, nfe.Det[i].Imposto.PIS.vPIS, DSC_VPIS));
    end;
  end;
end;

function TNFeXmlWriter.GerarDetImpostoPISST(const i: integer): TACBrXmlNode;
begin
  Result := nil;
  if (nfe.Det[i].Imposto.PISST.vBc > 0) or (nfe.Det[i].Imposto.PISST.pPis > 0) or
    (nfe.Det[i].Imposto.PISST.qBCProd > 0) or
    (nfe.Det[i].Imposto.PISST.vAliqProd > 0) or
    (nfe.Det[i].Imposto.PISST.vPIS > 0) then
  begin
    if (nfe.Det[i].Imposto.PISST.vBc + nfe.Det[i].Imposto.PISST.pPis > 0) and
      (nfe.Det[i].Imposto.PISST.qBCProd + nfe.Det[i].Imposto.PISST.vAliqProd > 0) then
      wAlerta('R01', 'PISST', DSC_PISOUTR,
        'As TAG <vBC> e <pPIS> não podem ser informadas em conjunto com as TAG <qBCProd> e <vAliqProd>');

    if (nfe.Det[i].Imposto.PISST.vBc + nfe.Det[i].Imposto.PISST.pPis > 0) then
    begin
      Result := FDocument.CreateElement('PISST');
      Result.AppendChild(AddNode(tcDe2, 'R02', 'vBC      ', 01, 15,
        1, nfe.Det[i].Imposto.PISST.vBc, DSC_VBC));
      Result.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2), 'R03',
        'pPIS     ', 01, IIf(Usar_tcDe4, 07, 05), 1, nfe.Det[i].Imposto.PISST.pPis, DSC_PPIS));
      Result.AppendChild(AddNode(tcDe2, 'R06', 'vPIS     ', 01, 15,
        1, nfe.Det[i].Imposto.PISST.vPIS, DSC_VPIS));
    end;
    if (nfe.Det[i].Imposto.PISST.qBCProd + nfe.Det[i].Imposto.PISST.vAliqProd > 0) then
    begin
      Result := FDocument.CreateElement('PISST');
      Result.AppendChild(AddNode(tcDe4, 'R04', 'qBCProd  ', 01, 16,
        1, nfe.Det[i].Imposto.PISST.qBCProd, DSC_QBCPROD));
      Result.AppendChild(AddNode(tcDe4, 'R05', 'vAliqProd', 01, 15,
        1, nfe.Det[i].Imposto.PISST.vAliqProd, DSC_VALIQPROD));
      Result.AppendChild(AddNode(tcDe2, 'R06', 'vPIS     ', 01, 15,
        1, nfe.Det[i].Imposto.PISST.vPIS, DSC_VPIS));
    end;
  end;
end;

function TNFeXmlWriter.GerarDetImpostoCOFINS(const i: integer): TACBrXmlNode;
var
  xmlNode: TACBrXmlNode;
begin
  Result := nil;
  if (nfe.Ide.modelo <> 55) and ((nfe.Det[i].Imposto.COFINS.vBC = 0) and
    (nfe.Det[i].Imposto.COFINS.pCOFINS = 0) and
    (nfe.Det[i].Imposto.COFINS.vCOFINS = 0) and
    (nfe.Det[i].Imposto.COFINS.qBCProd = 0) and
    (nfe.Det[i].Imposto.COFINS.vAliqProd = 0) and
    (not (nfe.Det[i].Imposto.COFINS.CST in [cof04, cof05, cof06,
    cof07, cof08, cof09, cof49, cof99]))) then
    //No caso da NFC-e, o grupo de tributação do PIS e o grupo de tributação da COFINS são opcionais.
    exit;

  Result := FDocument.CreateElement('COFINS');
  if nfe.Det[i].Imposto.COFINS.CST in [cof01, cof02] then
  begin
    xmlNode := Result.AddChild('COFINSAliq');
    xmlNode.AppendChild(AddNode(tcStr, 'S06', 'CST      ', 02, 02,
      1, CSTCOFINSTOStr(nfe.Det[i].Imposto.COFINS.CST), DSC_CST));
    xmlNode.AppendChild(AddNode(tcDe2, 'S07', 'vBC      ', 01, 15,
      1, nfe.Det[i].Imposto.COFINS.vBC, DSC_VBC));
    xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2), 'S08',
      'pCOFINS  ', 01, IIf(Usar_tcDe4, 07, 05), 1, nfe.Det[i].Imposto.COFINS.pCOFINS,
      DSC_PCOFINS));
    xmlNode.AppendChild(AddNode(tcDe2, 'S11', 'vCOFINS  ', 01, 15,
      1, nfe.Det[i].Imposto.COFINS.vCOFINS, DSC_VCOFINS));
  end
  else if nfe.Det[i].Imposto.COFINS.CST = cof03 then
  begin
    xmlNode := Result.AddChild('COFINSQtde');
    xmlNode.AppendChild(AddNode(tcStr, 'S06', 'CST      ', 02, 02,
      1, CSTCOFINSTOStr(nfe.Det[i].Imposto.COFINS.CST), DSC_CST));
    xmlNode.AppendChild(AddNode(tcDe4, 'S09', 'qBCProd  ', 01, 16,
      1, nfe.Det[i].Imposto.COFINS.qBCProd, DSC_QBCPROD));
    xmlNode.AppendChild(AddNode(tcDe4, 'S10', 'vAliqProd', 01, 15,
      1, nfe.Det[i].Imposto.COFINS.vAliqProd, DSC_VALIQPROD));
    xmlNode.AppendChild(AddNode(tcDe2, 'S11', 'vCOFINS  ', 01, 15,
      1, nfe.Det[i].Imposto.COFINS.vCOFINS, DSC_VCOFINS));
  end
  else if nfe.Det[i].Imposto.COFINS.CST in [cof04, cof05, cof06,
    cof07, cof08, cof09] then
  begin
    xmlNode := Result.AddChild('COFINSNT');
    xmlNode.AppendChild(AddNode(tcStr, 'S06', 'CST      ', 02, 02,
      1, CSTCOFINSTOStr(nfe.Det[i].Imposto.COFINS.CST), DSC_CST));
  end
  else if nfe.Det[i].Imposto.COFINS.CST in [cof49, cof50, cof51,
    cof52, cof53, cof54, cof55, cof56, cof60, cof61, cof62, cof63, cof64,
    cof65, cof66, cof67, cof70, cof71, cof72, cof73, cof74, cof75, cof98, cof99] then
  begin

    if (nfe.Det[i].Imposto.COFINS.vBC + nfe.Det[i].Imposto.COFINS.pCOFINS > 0) and
      (nfe.Det[i].Imposto.COFINS.qBCProd + nfe.Det[i].Imposto.COFINS.vAliqProd > 0) then
      wAlerta('S05', 'COFINSOutr', DSC_PISOUTR,
        'As TAG <vBC> e <pCOFINS> não podem ser informadas em conjunto com as TAG <qBCProd> e <vAliqProd>');

    if (nfe.Det[i].Imposto.COFINS.qBCProd + nfe.Det[i].Imposto.COFINS.vAliqProd > 0) then
    begin
      xmlNode := Result.AddChild('COFINSOutr');
      xmlNode.AppendChild(AddNode(tcStr, 'S06', 'CST      ', 02, 02,
        1, CSTCOFINSTOStr(nfe.Det[i].Imposto.COFINS.CST), DSC_CST));
      xmlNode.AppendChild(AddNode(tcDe4, 'S09', 'qBCProd  ', 01, 16,
        1, nfe.Det[i].Imposto.COFINS.qBCProd, DSC_QBCPROD));
      xmlNode.AppendChild(AddNode(tcDe4, 'S10', 'vAliqProd', 01, 15,
        1, nfe.Det[i].Imposto.COFINS.vAliqProd, DSC_VALIQPROD));
      xmlNode.AppendChild(AddNode(tcDe2, 'S11', 'vCOFINS  ', 01, 15,
        1, nfe.Det[i].Imposto.COFINS.vCOFINS, DSC_VCOFINS));
    end
    else
    begin
      xmlNode := Result.AddChild('COFINSOutr');
      xmlNode.AppendChild(AddNode(tcStr, 'S06', 'CST      ', 02, 02,
        1, CSTCOFINSTOStr(nfe.Det[i].Imposto.COFINS.CST), DSC_CST));
      xmlNode.AppendChild(AddNode(tcDe2, 'S07', 'vBC      ', 01, 15,
        1, nfe.Det[i].Imposto.COFINS.vBC, DSC_VBC));
      xmlNode.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2), 'S08',
        'pCOFINS  ', 01, IIf(Usar_tcDe4, 07, 05), 1, nfe.Det[i].Imposto.COFINS.pCOFINS,
        DSC_PCOFINS));
      xmlNode.AppendChild(AddNode(tcDe2, 'S11', 'vCOFINS  ', 01, 15,
        1, nfe.Det[i].Imposto.COFINS.vCOFINS, DSC_VCOFINS));
    end;
  end;
end;

function TNFeXmlWriter.GerarDetImpostoCOFINSST(const i: integer): TACBrXmlNode;
begin
  Result := nil;
  if (nfe.Det[i].Imposto.COFINSST.vBC > 0) or
    (nfe.Det[i].Imposto.COFINSST.pCOFINS > 0) or
    (nfe.Det[i].Imposto.COFINSST.qBCProd > 0) or
    (nfe.Det[i].Imposto.COFINSST.vAliqProd > 0) or
    (nfe.Det[i].Imposto.COFINSST.vCOFINS > 0) then
  begin

    if (nfe.Det[i].Imposto.COFINSST.vBC + nfe.Det[i].Imposto.COFINSST.pCOFINS > 0) and
      (nfe.Det[i].Imposto.COFINSST.qBCProd + nfe.Det[i].Imposto.COFINSST.vAliqProd > 0) then
      wAlerta('T01', 'COFINSST', DSC_COFINSST,
        'As TAG <vBC> e <pCOFINS> não podem ser informadas em conjunto com as TAG <qBCProd> e <vAliqProd>');

    if (nfe.Det[i].Imposto.COFINSST.vBC + nfe.Det[i].Imposto.COFINSST.pCOFINS > 0) then
    begin
      Result := FDocument.CreateElement('COFINSST');
      Result.AppendChild(AddNode(tcDe2, 'T02', 'vBC        ', 01, 15,
        1, nfe.Det[i].Imposto.COFINSST.vBC, DSC_VBC));
      Result.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2), 'T03',
        'pCOFINS    ', 01, IIf(Usar_tcDe4, 07, 05), 1, nfe.Det[i].Imposto.COFINSST.pCOFINS,
        DSC_PCOFINS));
      Result.AppendChild(AddNode(tcDe2, 'T06', 'vCOFINS    ', 01, 15,
        1, nfe.Det[i].Imposto.COFINSST.vCOFINS, DSC_VCOFINS));
    end;
    if (nfe.Det[i].Imposto.COFINSST.qBCProd +
      nfe.Det[i].Imposto.COFINSST.vAliqProd > 0) then
    begin
      Result := FDocument.CreateElement('COFINSST');
      Result.AppendChild(AddNode(tcDe4, 'T04', 'qBCProd    ', 01, 16,
        1, nfe.Det[i].Imposto.COFINSST.qBCProd, DSC_QBCPROD));
      Result.AppendChild(AddNode(tcDe4, 'T05', 'vAliqProd  ', 01, 15,
        1, nfe.Det[i].Imposto.COFINSST.vAliqProd, DSC_VALIQPROD));
      Result.AppendChild(AddNode(tcDe2, 'T06', 'vCOFINS    ', 01, 15,
        1, nfe.Det[i].Imposto.COFINSST.vCOFINS, DSC_VCOFINS));
    end;
  end;
end;

function TNFeXmlWriter.GerarDetImpostoISSQN(const i: integer): TACBrXmlNode;
var
  Codigo: string;
begin
  Result := nil;
  if (nfe.Det[i].Imposto.ISSQN.vBC > 0) or (nfe.Det[i].Imposto.ISSQN.vAliq > 0) or
    (nfe.Det[i].Imposto.ISSQN.vISSQN > 0) or (nfe.Det[i].Imposto.ISSQN.cMunFG > 0) or
    (nfe.Det[i].Imposto.ISSQN.cListServ <> '') then
  begin
    Result := FDocument.CreateElement('ISSQN');
    Result.AppendChild(AddNode(tcDe2, 'U02', 'vBC        ', 01, 15,
      1, nfe.Det[i].Imposto.ISSQN.vBC, DSC_VBCISS));
    Result.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2), 'U03',
      'vAliq      ', 01, IIf(Usar_tcDe4, 07, 05), 1, nfe.Det[i].Imposto.ISSQN.vAliq,
      DSC_VAliq));
    Result.AppendChild(AddNode(tcDe2, 'U04', 'vISSQN     ', 01, 15,
      1, nfe.Det[i].Imposto.ISSQN.vISSQN, DSC_VISSQN));
    Result.AppendChild(AddNode(tcInt, 'U05', 'cMunFG     ', 07, 07,
      1, nfe.Det[i].Imposto.ISSQN.cMunFG, DSC_CMUNFG));
    if not ValidarMunicipio(nfe.Det[i].Imposto.ISSQN.cMunFG) then
      wAlerta('U05', 'cMunFG', DSC_CMUNFG, ERR_MSG_INVALIDO);

    if NFe.infNFe.Versao >= 3.10 then
    begin
      Result.AppendChild(AddNode(tcStr, 'U06', 'cListServ  ', 05, 05,
        1, nfe.Det[i].Imposto.ISSQN.cListServ, DSC_CLISTSERV));
      Codigo := Copy(nfe.Det[i].Imposto.ISSQN.cListServ, 1, 2) +
        Copy(nfe.Det[i].Imposto.ISSQN.cListServ, 4, 2);
    end
    else
    begin
      Result.AppendChild(AddNode(tcStr, 'U06', 'cListServ  ', 03, 04,
        1, nfe.Det[i].Imposto.ISSQN.cListServ, DSC_CLISTSERV));
      Codigo := nfe.Det[i].Imposto.ISSQN.cListServ;
    end;

    if (Opcoes.ValidarListaServicos) and (nfe.Det[i].Imposto.ISSQN.cListServ <> '') then
      if not ValidarCListServ(StrToIntDef(Codigo, 0)) then
        wAlerta('U06', 'cListServ', DSC_CLISTSERV, ERR_MSG_INVALIDO);

    if (NFe.infNFe.Versao >= 2) and (NFe.infNFe.Versao < 3) then
      Result.AppendChild(AddNode(tcStr, 'U07', 'cSitTrib', 01, 01,
        1, ISSQNcSitTribToStr(nfe.Det[i].Imposto.ISSQN.cSitTrib), DSC_CSITTRIB));

    if NFe.infNFe.Versao >= 3.10 then
    begin
      Result.AppendChild(AddNode(tcDe2, 'U07', 'vDeducao    ', 01,
        15, 0, nfe.Det[i].Imposto.ISSQN.vDeducao, DSC_VDEDUCAO));
      Result.AppendChild(AddNode(tcDe2, 'U08', 'vOutro      ', 01,
        15, 0, nfe.Det[i].Imposto.ISSQN.vOutro, DSC_VOUTRODED));
      Result.AppendChild(AddNode(tcDe2, 'U09', 'vDescIncond ', 01,
        15, 0, nfe.Det[i].Imposto.ISSQN.vDescIncond, DSC_VDESCINCOND));
      Result.AppendChild(AddNode(tcDe2, 'U10', 'vDescCond   ', 01,
        15, 0, nfe.Det[i].Imposto.ISSQN.vDescCond, DSC_VDESCCOND));
      //      Result.AppendChild(AddNode(tcStr, 'U11', 'indISSRet   ', 01, 01, 1, indISSRetToStr( nfe.Det[i].Imposto.ISSQN.indISSRet ) , DSC_INDISSRET));
      Result.AppendChild(AddNode(tcDe2, 'U12', 'vISSRet     ', 01,
        15, 0, nfe.Det[i].Imposto.ISSQN.vISSRet, DSC_VISSRET));
      Result.AppendChild(AddNode(tcStr, 'U13', 'indISS      ', 01,
        01, 1, indISSToStr(nfe.Det[i].Imposto.ISSQN.indISS), DSC_INDISS));
      Result.AppendChild(AddNode(tcStr, 'U14', 'cServico    ', 01,
        20, 0, nfe.Det[i].Imposto.ISSQN.cServico, DSC_CSERVICO));
      Result.AppendChild(AddNode(tcInt, 'U15', 'cMun        ', 01,
        07, 0, nfe.Det[i].Imposto.ISSQN.cMun, DSC_CMUN));
      Result.AppendChild(AddNode(tcInt, 'U16', 'cPais       ', 01,
        04, 0, nfe.Det[i].Imposto.ISSQN.cPais, DSC_CPAIS));
      Result.AppendChild(AddNode(tcStr, 'U17', 'nProcesso   ', 01,
        30, 0, nfe.Det[i].Imposto.ISSQN.nProcesso, DSC_NPROCESSO));
      Result.AppendChild(AddNode(tcStr, 'U18', 'indIncentivo', 01,
        01, 1, indIncentivoToStr(nfe.Det[i].Imposto.ISSQN.indIncentivo), DSC_INDINCENTIVO));
    end;
  end;
end;

function TNFeXmlWriter.GerarDetDevol(const i: integer): TACBrXmlNode;
var
  xmlNode: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('impostoDevol');
  Result.AppendChild(AddNode(tcDe2, 'U51', 'pDevol', 01, 05, 1,
    nfe.Det[i].pDevol, DSC_PDEVOL));
  xmlNode := Result.AddChild('IPI');
  xmlNode.AppendChild(AddNode(tcDe2, 'U61', 'vIPIDevol', 01, 15, 1,
    nfe.Det[i].vIPIDevol, DSC_VIPIDEVOL));
end;

function TNFeXmlWriter.GerarDetImpostoICMSUFDest(const i: integer): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('ICMSUFDest');
  Result.AppendChild(AddNode(tcDe2, 'NA03', 'vBCUFDest', 01, 15, 1,
    nfe.Det[i].Imposto.ICMSUFDest.vBCUFDest, DSC_VBCUFDEST));
  if (NFe.infNFe.Versao >= 4) then
  begin
    // tags marcadas novamente como obrigatórias por algumas SEFAZ ainda não terem implantado os schemas da NT 2016.002 v. 1.50
    // Result.AppendChild(AddNode(tcDe2, 'NA04', 'vBCFCPUFDest', 01, 15, 0, nfe.Det[i].Imposto.ICMSUFDest.vBCFCPUFDest, DSC_VBCUFDEST));
    // Result.AppendChild(AddNode(IIf(Usar_tcDe4,tcDe4,tcDe2), 'NA05', 'pFCPUFDest', 01, IIf(Usar_tcDe4,07,05), 0, nfe.Det[i].Imposto.ICMSUFDest.pFCPUFDest, DSC_PFCPUFDEST));
    Result.AppendChild(AddNode(tcDe2, 'NA04', 'vBCFCPUFDest', 01, 15,
      1, nfe.Det[i].Imposto.ICMSUFDest.vBCFCPUFDest, DSC_VBCUFDEST));
    Result.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2), 'NA05',
      'pFCPUFDest', 01, IIf(Usar_tcDe4, 07, 05), 1, nfe.Det[i].Imposto.ICMSUFDest.pFCPUFDest,
      DSC_PFCPUFDEST));
  end
  else
    Result.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2), 'NA05',
      'pFCPUFDest', 01, IIf(Usar_tcDe4, 07, 05), 1, nfe.Det[i].Imposto.ICMSUFDest.pFCPUFDest,
      DSC_PFCPUFDEST));
  Result.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2), 'NA07',
    'pICMSUFDest', 01, IIf(Usar_tcDe4, 07, 05), 1, nfe.Det[i].Imposto.ICMSUFDest.pICMSUFDest,
    DSC_PICMSUFDEST));
  // Alterado para ficar em conformidade com o novo Schema
  Result.AppendChild(AddNode(tcDe2, 'NA09', 'pICMSInter ', 01, 05,
    1, nfe.Det[i].Imposto.ICMSUFDest.pICMSInter, DSC_PICMSINTER));
  Result.AppendChild(AddNode(IIf(Usar_tcDe4, tcDe4, tcDe2), 'NA11',
    'pICMSInterPart', 01, IIf(Usar_tcDe4, 07, 05), 1,
    nfe.Det[i].Imposto.ICMSUFDest.pICMSInterPart, DSC_PICMSINTERPART));
  if (NFe.infNFe.Versao >= 4) then
    // tag marcada novamente como obrigatória por algumas SEFAZ ainda não terem implantado os schemas da NT 2016.002 v. 1.50
    // Result.AppendChild(AddNode(tcDe2, 'NA13', 'vFCPUFDest ', 01, 15, 0, nfe.Det[i].Imposto.ICMSUFDest.vFCPUFDest, DSC_VFCPUFDEST))
    Result.AppendChild(AddNode(tcDe2, 'NA13', 'vFCPUFDest ', 01, 15,
      1, nfe.Det[i].Imposto.ICMSUFDest.vFCPUFDest, DSC_VFCPUFDEST))
  else
    Result.AppendChild(AddNode(tcDe2, 'NA13', 'vFCPUFDest ', 01, 15,
      1, nfe.Det[i].Imposto.ICMSUFDest.vFCPUFDest, DSC_VFCPUFDEST));
  Result.AppendChild(AddNode(tcDe2, 'NA15', 'vICMSUFDest ', 01, 15,
    1, nfe.Det[i].Imposto.ICMSUFDest.vICMSUFDest, DSC_VICMSUFDEST));
  Result.AppendChild(AddNode(tcDe2, 'NA17', 'vICMSUFRemet', 01, 15,
    1, nfe.Det[i].Imposto.ICMSUFDest.vICMSUFRemet, DSC_VICMSUFREMET));

end;

function TNFeXmlWriter.GerarTotal: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('total');
  Result.AppendChild(GerarTotalICMSTotal);
  Result.AppendChild(GerarTotalISSQNtot);
  Result.AppendChild(GerarTotalretTrib);
end;

function TNFeXmlWriter.GerarTotalICMSTotal: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('ICMSTot');
  Result.AppendChild(AddNode(tcDe2, 'W03', 'vBC  ', 01, 15, 1, nfe.Total.ICMSTot.vBC, DSC_VBC));
  Result.AppendChild(AddNode(tcDe2, 'W04', 'vICMS', 01, 15, 1, nfe.Total.ICMSTot.vICMS, DSC_VICMS));
  if NFe.infNFe.Versao >= 3.10 then
  begin
    Result.AppendChild(AddNode(tcDe2, 'W04a', 'vICMSDeson  ', 01, 15, 1, nfe.Total.ICMSTot.vICMSDeson, DSC_VICMSDESON));
    Result.AppendChild(AddNode(tcDe2, 'W04c', 'vFCPUFDest  ', 01, 15, 0, nfe.Total.ICMSTot.vFCPUFDest, DSC_VICMS));
    Result.AppendChild(AddNode(tcDe2, 'W04e', 'vICMSUFDest ', 01, 15, 0, nfe.Total.ICMSTot.vICMSUFDest, DSC_VICMS));
    Result.AppendChild(AddNode(tcDe2, 'W04g', 'vICMSUFRemet', 01, 15, 0, nfe.Total.ICMSTot.vICMSUFRemet, DSC_VICMS));
  end;
  if (NFe.infNFe.Versao >= 4) then
    Result.AppendChild(AddNode(tcDe2, 'W04h', 'vFCP', 01, 15, 1, nfe.Total.ICMSTot.vFCP, DSC_VFCP));
  Result.AppendChild(AddNode(tcDe2, 'W05', 'vBCST    ', 01, 15, 1, nfe.Total.ICMSTot.vBCST, DSC_VBCST));
  Result.AppendChild(AddNode(tcDe2, 'W06', 'vST      ', 01, 15, 1, nfe.Total.ICMSTot.vST, DSC_VST));
  if (NFe.infNFe.Versao >= 4) then
  begin
    Result.AppendChild(AddNode(tcDe2, 'W06a', 'vFCPST', 01, 15, 1, nfe.Total.ICMSTot.vFCPST, DSC_VFCPST));
    Result.AppendChild(AddNode(tcDe2, 'W06b', 'vFCPSTRet', 01, 15, 1, nfe.Total.ICMSTot.vFCPSTRet, DSC_VFCPSTRET))
  end;
  Result.AppendChild(AddNode(tcDe2, 'W07', 'vProd    ', 01, 15, 1, nfe.Total.ICMSTot.vProd, DSC_VPROD));
  Result.AppendChild(AddNode(tcDe2, 'W08', 'vFrete   ', 01, 15, 1, nfe.Total.ICMSTot.vFrete, DSC_VFRETE));
  Result.AppendChild(AddNode(tcDe2, 'W09', 'vSeg     ', 01, 15, 1, nfe.Total.ICMSTot.vSeg, DSC_VSEG));
  Result.AppendChild(AddNode(tcDe2, 'W10', 'vDesc    ', 01, 15, 1, nfe.Total.ICMSTot.vDesc, DSC_VDESC));
  Result.AppendChild(AddNode(tcDe2, 'W11', 'vII      ', 01, 15, 1, nfe.Total.ICMSTot.vII, DSC_VII));
  Result.AppendChild(AddNode(tcDe2, 'W12', 'vIPI     ', 01, 15, 1, nfe.Total.ICMSTot.vIPI, DSC_VIPI));
  if (NFe.infNFe.Versao >= 4) then
    Result.AppendChild(AddNode(tcDe2, 'W12a', 'vIPIDevol', 01, 15, 1, nfe.Total.ICMSTot.vIPIDevol, DSC_VIPIDEVOL));
  Result.AppendChild(AddNode(tcDe2, 'W13', 'vPIS     ', 01, 15, 1, nfe.Total.ICMSTot.vPIS, DSC_VPIS));
  Result.AppendChild(AddNode(tcDe2, 'W14', 'vCOFINS  ', 01, 15, 1, nfe.Total.ICMSTot.vCOFINS, DSC_VCOFINS));
  Result.AppendChild(AddNode(tcDe2, 'W15', 'vOutro   ', 01, 15, 1, nfe.Total.ICMSTot.vOutro, DSC_VOUTRO));
  Result.AppendChild(AddNode(tcDe2, 'W16', 'vNF      ', 01, 15, 1, nfe.Total.ICMSTot.vNF, DSC_VNF));
  Result.AppendChild(AddNode(tcDe2, 'W16a', 'vTotTrib', 01, 15, 0, nfe.Total.ICMSTot.vTotTrib, DSC_VTOTTRIB));
end;

function TNFeXmlWriter.GerarTotalISSQNtot: TACBrXmlNode;
begin
  Result := nil;
  if (nfe.Total.ISSQNtot.vServ > 0) or
    (nfe.Total.ISSQNtot.vBC > 0) or
    (nfe.Total.ISSQNtot.vISS > 0) or
    (nfe.Total.ISSQNtot.vPIS > 0) or
    (nfe.Total.ISSQNtot.vCOFINS > 0) then
  begin
    Result := FDocument.CreateElement('ISSQNtot');
    Result.AppendChild(AddNode(tcDe2, 'W18', 'vServ     ', 01, 15, 0, nfe.Total.ISSQNtot.vServ, DSC_VSERV));
    Result.AppendChild(AddNode(tcDe2, 'W19', 'vBC       ', 01, 15, 0, nfe.Total.ISSQNtot.vBC, DSC_VBC));
    Result.AppendChild(AddNode(tcDe2, 'W20', 'vISS      ', 01, 15, 0, nfe.Total.ISSQNtot.vISS, DSC_VISS));
    Result.AppendChild(AddNode(tcDe2, 'W21', 'vPIS      ', 01, 15, 0, nfe.Total.ISSQNtot.vPIS, DSC_VPIS));
    Result.AppendChild(AddNode(tcDe2, 'W22', 'vCOFINS   ', 01, 15, 0, nfe.Total.ISSQNtot.vCOFINS, DSC_VCOFINS));

    if nfe.infNFe.Versao >= 3.10 then
    begin
      Result.AppendChild(AddNode(tcDat, 'W22a', 'dCompet     ', 10, 10, 1, nfe.Total.ISSQNtot.dCompet, DSC_DCOMPET));
      Result.AppendChild(AddNode(tcDe2, 'W22b', 'vDeducao    ', 01, 15, 0, nfe.Total.ISSQNtot.vDeducao, DSC_VDEDUCAO));
      Result.AppendChild(AddNode(tcDe2, 'W22c', 'vOutro      ', 01, 15, 0, nfe.Total.ISSQNtot.vOutro, DSC_VOUTRODED));
      Result.AppendChild(AddNode(tcDe2, 'W22d', 'vDescIncond ', 01, 15, 0, nfe.Total.ISSQNtot.vDescIncond, DSC_VDESCINCOND));
      Result.AppendChild(AddNode(tcDe2, 'W22e', 'vDescCond   ', 01, 15, 0, nfe.Total.ISSQNtot.vDescCond, DSC_VDESCCOND));
      Result.AppendChild(AddNode(tcDe2, 'W22f', 'vISSRet     ', 01, 15, 0, nfe.Total.ISSQNtot.vISSRet, DSC_VISSRET));

      if nfe.Total.ISSQNtot.cRegTrib <> RTISSNenhum then
        Result.AppendChild(AddNode(tcStr, 'W22g', 'cRegTrib', 01, 01, 0, RegTribISSQNToStr( nfe.Total.ISSQNtot.cRegTrib ) , DSC_CREGTRIB));
    end;
  end;
end;

function TNFeXmlWriter.GerarTotalretTrib: TACBrXmlNode;
begin
  Result := nil;
  if (nfe.Total.retTrib.vRetPIS > 0) or
    (nfe.Total.retTrib.vRetCOFINS > 0) or
    (nfe.Total.retTrib.vRetCSLL > 0) or
    (nfe.Total.retTrib.vBCIRRF > 0) or
    (nfe.Total.retTrib.vIRRF > 0) or
    (nfe.Total.retTrib.vBCRetPrev > 0) or
    (nfe.Total.retTrib.vRetPrev > 0) then
  begin
    Result := FDocument.CreateElement('retTrib');
    Result.AppendChild(AddNode(tcDe2, 'W24', 'vRetPIS   ', 01, 15, 0, nfe.Total.retTrib.vRetPIS, DSC_VRETPIS));
    Result.AppendChild(AddNode(tcDe2, 'W25', 'vRetCOFINS', 01, 15, 0, nfe.Total.retTrib.vRetCOFINS, DSC_VRETCOFINS));
    Result.AppendChild(AddNode(tcDe2, 'W26', 'vRetCSLL  ', 01, 15, 0, nfe.Total.retTrib.vRetCSLL, DSC_VRETCSLL));
    Result.AppendChild(AddNode(tcDe2, 'W27', 'vBCIRRF   ', 01, 15, 0, nfe.Total.retTrib.vBCIRRF, DSC_VBCIRRF));
    Result.AppendChild(AddNode(tcDe2, 'W28', 'vIRRF     ', 01, 15, 0, nfe.Total.retTrib.vIRRF, DSC_VIRRF));
    Result.AppendChild(AddNode(tcDe2, 'W29', 'vBCRetPrev', 01, 15, 0, nfe.Total.retTrib.vBCRetPrev, DSC_VBCRETPREV));
    Result.AppendChild(AddNode(tcDe2, 'W30', 'vRetPrev  ', 01, 15, 0, nfe.Total.retTrib.vRetPrev, DSC_VRETPREV));
  end;
end;

function TNFeXmlWriter.GerarCobr: TACBrXmlNode;
Var
  i: Integer;
  nodeArray: TACBrXmlNodeArray;
begin
  Result := nil;
  if (trim(nfe.Cobr.Fat.nFat) <> '') or
    (nfe.Cobr.Fat.vOrig > 0) or
    (nfe.Cobr.Fat.vDesc > 0) or
    (nfe.Cobr.Fat.vLiq > 0) or
    (nfe.Cobr.Dup.Count > 0) then
  begin
    Result := FDocument.CreateElement('cobr');
    Result.AppendChild(GerarCobrFat);
    nodeArray := GerarCobrDup;
    for i := 0 to nfe.Cobr.Dup.Count - 1 do
    begin
      Result.AppendChild(nodeArray[i]);
    end;
  end;
end;

function TNFeXmlWriter.GerarCobrFat: TACBrXmlNode;
begin
  Result := nil;
  if (trim(nfe.Cobr.Fat.nFat) <> '') or
    (nfe.Cobr.Fat.vOrig > 0) or
    (nfe.Cobr.Fat.vDesc > 0) or
    (nfe.Cobr.Fat.vLiq > 0) then
  begin
    Result := FDocument.CreateElement('fat');
    Result.AppendChild(AddNode(tcStr, 'Y03', 'nFat   ', 01, 60, IIf(Opcoes.CamposFatObrigatorios and (NFe.infNFe.Versao >= 4),1,0), nfe.Cobr.Fat.nFat, DSC_NFAT));
    Result.AppendChild(AddNode(tcDe2, 'Y04', 'vOrig  ', 01, 15, IIf(Opcoes.CamposFatObrigatorios and (NFe.infNFe.Versao >= 4),1,0), nfe.Cobr.Fat.vOrig, DSC_VORIG));
    Result.AppendChild(AddNode(tcDe2, 'Y05', 'vDesc  ', 01, 15, IIf(Opcoes.CamposFatObrigatorios and (NFe.infNFe.Versao >= 4),1,0), nfe.Cobr.Fat.vDesc, DSC_VDESC));
    Result.AppendChild(AddNode(tcDe2, 'Y06', 'vLiq   ', 01, 15, IIf(Opcoes.CamposFatObrigatorios and (NFe.infNFe.Versao >= 4),1,0), nfe.Cobr.Fat.vLiq, DSC_VLIQ));
  end;
end;

function TNFeXmlWriter.GerarCobrDup: TACBrXmlNodeArray;
var
  i: Integer;
begin
  Result := nil;
  SetLength(Result, nfe.Cobr.Dup.Count);
  for i := 0 to nfe.Cobr.Dup.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('dup');
    if (NFe.infNFe.Versao >= 4) then
    begin
      Result[i].AppendChild(AddNode(tcStr, 'Y08', 'nDup ', 01, 60, 1, nfe.Cobr.Dup[i].nDup, DSC_NDUP));
      Result[i].AppendChild(AddNode(tcDat, 'Y09', 'dVenc', 10, 10, 1, nfe.Cobr.Dup[i].dVenc, DSC_DVENC));
    end
    else
    begin
      Result[i].AppendChild(AddNode(tcStr, 'Y08', 'nDup ', 01, 60, 0, nfe.Cobr.Dup[i].nDup, DSC_NDUP));
      Result[i].AppendChild(AddNode(tcDat, 'Y09', 'dVenc', 10, 10, 0, nfe.Cobr.Dup[i].dVenc, DSC_DVENC));
    end;
    Result[i].AppendChild(AddNode(tcDe2, 'Y10', 'vDup ', 01, 15, 1, nfe.Cobr.Dup[i].vDup, DSC_VDUP));
  end;
  if nfe.Cobr.Dup.Count > 120 then
    wAlerta('Y07', 'dup', DSC_NITEM, ERR_MSG_MAIOR_MAXIMO + '120');
end;

function TNFeXmlWriter.Gerarpag: TACBrXmlNodeArray;
var
  i: Integer;
  xmlNode, xmlCardNode: TACBrXmlNode;
begin
  Result := nil;
  if (NFe.infNFe.Versao >= 4) then
  begin
    SetLength(Result, 1);
    Result[0] := FDocument.CreateElement('pag');
  end
  else if(nfe.pag.Count > 0) then
    SetLength(Result, nfe.pag.Count);

  for i := 0 to nfe.pag.Count - 1 do
  begin
    if (NFe.infNFe.Versao >= 4) then
    begin
      xmlNode := FDocument.CreateElement('detPag');
      xmlNode.AppendChild(AddNode(tcStr, 'YA01b', 'indPag ', 01, 01, 0, IndpagToStr(nfe.pag[i].indPag), DSC_INDPAG));
    end
    else
      xmlNode := FDocument.CreateElement('pag');

    xmlNode.AppendChild(AddNode(tcStr, 'YA02', 'tPag', 02, 02, 1, FormaPagamentoToStr(nfe.pag[i].tPag), DSC_TPAG));
    xmlNode.AppendChild(AddNode(tcDe2, 'YA03', 'vPag', 01, 15, 1, nfe.pag[i].vPag, DSC_VPAG));
    if(NFe.pag[i].tPag in [fpCartaoDebito,fpCartaoCredito]) and
      ((nfe.pag[i].CNPJ <> '') or (nfe.pag[i].tpIntegra <> tiNaoInformado))then
      begin
        xmlCardNode := xmlNode.AddChild('card');
        xmlCardNode.AppendChild(AddNode(tcStr, 'YA04a', 'tpIntegra', 01, 01, 1, tpIntegraToStr(nfe.pag[i].tpIntegra), DSC_TPINTEGRA));
        if nfe.pag[i].CNPJ <> '' then
         begin
           xmlCardNode.AppendChild(AddNode(tcStr, 'YA05', 'CNPJ ', 14, 14, 0, nfe.pag[i].CNPJ, DSC_CNPJ));
           xmlCardNode.AppendChild(AddNode(tcStr, 'YA06', 'tBand', 02, 02, 0, BandeiraCartaoToStr(nfe.pag[i].tBand), DSC_TBAND));
           xmlCardNode.AppendChild(AddNode(tcStr, 'YA07', 'cAut ', 01, 20, 0, nfe.pag[i].cAut, DSC_CAUT));
         end;
      end;
    if (NFe.infNFe.Versao >= 4) then
      Result[0].AppendChild(xmlNode)
    else
      Result[i] := xmlNode;
  end;

  if (NFe.infNFe.Versao >= 4) then
  begin
    Result[0].AppendChild(AddNode(tcDe2, 'YA09', 'vTroco', 01, 15, 0, nfe.pag.vTroco, DSC_VPAG));
  end;

  if nfe.pag.Count > 100 then
    wAlerta('YA01', 'pag', '', ERR_MSG_MAIOR_MAXIMO + '100');
end;

function TNFeXmlWriter.GerarTransp: TACBrXmlNode;
Var
  i: Integer;
  nodeArray: TACBrXmlNodeArray;
begin
  Result := FDocument.CreateElement('transp');
  Result.AppendChild(AddNode(tcStr, 'X02', 'modFrete', 01, 01, 1, modFreteToStr(nfe.Transp.modFrete), DSC_MODFRETE));
  Result.AppendChild(GerarTranspTransporta);
  Result.AppendChild(GerarTranspRetTransp);
  Result.AppendChild(GerarTranspVeicTransp);
  nodeArray := GerarTranspReboque;
  for i := 0 to nfe.Transp.Reboque.Count - 1 do
  begin
    Result.AppendChild(nodeArray[i]);
  end;
  Result.AppendChild(AddNode(tcStr, 'X25a','vagao ', 01, 20, 0, nfe.Transp.vagao, DSC_VAGAO));
  Result.AppendChild(AddNode(tcStr, 'X25b','balsa ', 01, 20, 0, nfe.Transp.balsa, DSC_BALSA));

  nodeArray := GerarTranspVol;
  for i := 0 to nfe.Transp.Vol.Count - 1 do
  begin
    Result.AppendChild(nodeArray[i]);
  end;
end;

function TNFeXmlWriter.GerarTranspTransporta: TACBrXmlNode;
begin
  Result := nil;
  if (trim(nfe.Transp.Transporta.CNPJCPF) <> '') or
    (trim(nfe.Transp.Transporta.xNome) <> '') or
    (trim(nfe.Transp.Transporta.IE) <> '') or
    (trim(nfe.Transp.Transporta.xEnder) <> '') or
    (trim(nfe.Transp.Transporta.xMun) <> '') or
    (trim(nfe.Transp.Transporta.UF) <> '') then
  begin
    Result := FDocument.CreateElement('transporta');
    if trim(nfe.Transp.Transporta.CNPJCPF) <> '' then
       Result.AppendChild(AddNodeCNPJCPF('X04', 'X05', nfe.Transp.Transporta.CNPJCPF));
    Result.AppendChild(AddNode(tcStr, 'X06', 'xNome   ', 01, 60, 0, nfe.Transp.Transporta.xNome, DSC_XNOME));
    if trim(nfe.Transp.Transporta.IE) = 'ISENTO' then
       Result.AppendChild(AddNode(tcStr, 'X07', 'IE      ', 02, 14, 0, nfe.Transp.Transporta.IE, DSC_IE))
    else
     begin
       Result.AppendChild(AddNode(tcStr, 'X07', 'IE      ', 02, 14, 0, OnlyNumber(nfe.Transp.Transporta.IE), DSC_IE));
       if (Opcoes.ValidarInscricoes) and (nfe.Transp.Transporta.IE <> '') then
         if not pcnAuxiliar.ValidarIE(nfe.Transp.Transporta.IE, nfe.Transp.Transporta.UF) then
           wAlerta('X07', 'IE', DSC_IE, ERR_MSG_INVALIDO);
     end;
    Result.AppendChild(AddNode(tcStr, 'X08', 'xEnder  ', 01, 60, 0, nfe.Transp.Transporta.xEnder, DSC_XENDER));
    Result.AppendChild(AddNode(tcStr, 'X09', 'xMun    ', 01, 60, 0, nfe.Transp.Transporta.xMun, DSC_XMUN));
    if trim(nfe.Transp.Transporta.UF) <> '' then
     begin
       Result.AppendChild(AddNode(tcStr, 'X10', 'UF      ', 01, 02, 0, nfe.Transp.Transporta.UF, DSC_UF));
       if not pcnAuxiliar.ValidarUF(nfe.Transp.Transporta.UF) then
         wAlerta('X10', 'UF', DSC_UF, ERR_MSG_INVALIDO);
     end;
  end;
end;

function TNFeXmlWriter.GerarTranspRetTransp: TACBrXmlNode;
begin
  Result := nil;
  if (nfe.Transp.retTransp.vServ > 0) or
    (nfe.Transp.retTransp.vBCRet > 0) or
    (nfe.Transp.retTransp.pICMSRet > 0) or
    (nfe.Transp.retTransp.vICMSRet > 0) or
    (trim(nfe.Transp.retTransp.CFOP) <> '') or
    (nfe.Transp.retTransp.cMunFG > 0) then
  begin
    Result := FDocument.CreateElement('retTransp');
    Result.AppendChild(AddNode(tcDe2, 'X12', 'vServ   ', 01, 15, 1, nfe.Transp.retTransp.vServ, DSC_VSERV));
    Result.AppendChild(AddNode(tcDe2, 'X13', 'vBCRet  ', 01, 15, 1, nfe.Transp.retTransp.vBCRet, DSC_VBCRET));
    Result.AppendChild(AddNode(tcDe2, 'X14', 'pICMSRet', 01, 05, 1, nfe.Transp.retTransp.pICMSRet, DSC_PICMSRET));
    Result.AppendChild(AddNode(tcDe2, 'X15', 'vICMSRet', 01, 15, 1, nfe.Transp.retTransp.vICMSRet, DSC_VICMSRET));
    Result.AppendChild(AddNode(tcEsp, 'X16', 'CFOP    ', 04, 04, 1, OnlyNumber(nfe.Transp.retTransp.CFOP), DSC_CFOP));
    Result.AppendChild(AddNode(tcStr, 'X17', 'cMunFG  ', 07, 07, 1, nfe.Transp.retTransp.cMunFG, DSC_CMUNFG));
    if not ValidarMunicipio(nfe.Transp.retTransp.cMunFG) then
      wAlerta('X17', 'cMunFG', DSC_CMUNFG, ERR_MSG_INVALIDO);
  end;
end;

function TNFeXmlWriter.GerarTranspVeicTransp: TACBrXmlNode;
begin
  Result := nil;
  if (trim(nfe.Transp.veicTransp.placa) <> '') or
    (trim(nfe.Transp.veicTransp.UF) <> '') or
    (trim(nfe.Transp.veicTransp.RNTC) <> '') then
  begin
    Result := FDocument.CreateElement('veicTransp');
    Result.AppendChild(AddNode(tcStr, 'X19', 'placa   ', 06, 07, 1, nfe.Transp.veicTransp.placa, DSC_PLACA));
    Result.AppendChild(AddNode(tcStr, 'X20', 'UF      ', 02, 02, 1, nfe.Transp.veicTransp.UF, DSC_UF));
    if not pcnAuxiliar.ValidarUF(nfe.Transp.veicTransp.UF) then
      wAlerta('X20', 'UF', DSC_UF, ERR_MSG_INVALIDO);
    Result.AppendChild(AddNode(tcStr, 'X21', 'RNTC    ', 01, 20, 0, nfe.Transp.veicTransp.RNTC, DSC_RNTC));
  end;
end;

function TNFeXmlWriter.GerarTranspReboque: TACBrXmlNodeArray;
var
  i: Integer;
begin
  SetLength(Result, nfe.Transp.Reboque.Count);
  if nfe.Transp.Reboque.Count > 5 then
    wAlerta('X22', 'reboque', DSC_REBOQUE, ERR_MSG_MAIOR_MAXIMO + '5');
  for i := 0 to nfe.Transp.Reboque.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('reboque');
    Result[i].AppendChild(AddNode(tcStr, 'X23', 'placa ', 06, 07, 1, nfe.Transp.Reboque[i].placa, DSC_PLACA));
    Result[i].AppendChild(AddNode(tcStr, 'X24', 'UF    ', 02, 02, 1, nfe.Transp.Reboque[i].UF, DSC_UF));
    if not pcnAuxiliar.ValidarUF(nfe.Transp.Reboque[i].UF) then
      wAlerta('X24', 'UF', DSC_UF, ERR_MSG_INVALIDO);
    Result[i].AppendChild(AddNode(tcStr, 'X25', 'RNTC  ', 01, 20, 0, nfe.Transp.Reboque[i].RNTC, DSC_RNTC));
  end;
end;

function TNFeXmlWriter.GerarTranspVol: TACBrXmlNodeArray;
Var
  i, j: Integer;
  nodeArray: TACBrXmlNodeArray;
begin
  Result := nil;
  SetLength(Result, nfe.Transp.Vol.Count);
  for i := 0 to nfe.Transp.Vol.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('vol');
    Result[i].AppendChild(AddNode(tcInt, 'X27', 'qVol  ', 01, 15, 1, nfe.Transp.Vol[i].qVol, DSC_QVOL));
    Result[i].AppendChild(AddNode(tcStr, 'X28', 'esp   ', 01, 60, 0, nfe.Transp.vol[i].esp, DSC_ESP));
    Result[i].AppendChild(AddNode(tcStr, 'X29', 'marca ', 01, 60, 0, nfe.Transp.Vol[i].marca, DSC_MARCA));
    Result[i].AppendChild(AddNode(tcStr, 'X30', 'nVol  ', 01, 60, 0, nfe.Transp.Vol[i].nVol, DSC_NVOL));
    Result[i].AppendChild(AddNode(tcDe3, 'X31', 'pesoL ', 01, 15, 0, nfe.Transp.Vol[i].pesoL, DSC_PESOL));
    Result[i].AppendChild(AddNode(tcDe3, 'X32', 'pesoB ', 01, 15, 0, nfe.Transp.Vol[i].pesoB, DSC_PESOB));

    nodeArray := GerarTranspVolLacres(i);
    for j := 0 to nfe.Transp.Vol[i].lacres.Count - 1 do
    begin
      Result[i].AppendChild(nodeArray[j]);
    end;
  end;
end;

function TNFeXmlWriter.GerarTranspVolLacres(i: integer): TACBrXmlNodeArray;
var
  j: Integer;
begin
  Result := nil;
  SetLength(Result, nfe.Transp.Vol[i].lacres.Count);
  for j := 0 to nfe.transp.Vol[i].lacres.Count - 1 do
  begin
    Result[j] := FDocument.CreateElement('lacres');
    Result[j].AppendChild(AddNode(tcStr, 'X34', 'nLacre', 01, 60, 1, nfe.transp.Vol[i].lacres[j].nLacre, DSC_NLACRE));
  end;
end;

function TNFeXmlWriter.GerarInfAdic: TACBrXmlNode;
Var
  i: Integer;
  nodeArray: TACBrXmlNodeArray;
begin
  Result := nil;
  if (trim(nfe.InfAdic.infAdFisco) <> EmptyStr) or
    (trim(nfe.InfAdic.infCpl) <> EmptyStr) or
    (nfe.InfAdic.obsCont.Count > 0) or
    (nfe.InfAdic.obsFisco.Count > 0) or
    (nfe.InfAdic.procRef.Count > 0) then
  begin
    Result := FDocument.CreateElement('infAdic');
    Result.AppendChild(AddNode(tcStr, 'Z02', 'infAdFisco', 01, 2000, 0, nfe.InfAdic.infAdFisco, DSC_INFADFISCO));
    Result.AppendChild(AddNode(tcStr, 'Z03', 'infCpl    ', 01, 5000, 0, nfe.InfAdic.infCpl, DSC_INFCPL));

    nodeArray := GerarInfAdicObsCont;
    for i := 0 to nfe.InfAdic.obsCont.Count - 1 do
    begin
      Result.AppendChild(nodeArray[i]);
    end;
    nodeArray := GerarInfAdicObsFisco;
    for i := 0 to nfe.InfAdic.obsFisco.Count - 1 do
    begin
      Result.AppendChild(nodeArray[i]);
    end;

    nodeArray := GerarInfAdicProcRef;
    for i := 0 to nfe.InfAdic.procRef.Count - 1 do
    begin
      Result.AppendChild(nodeArray[i]);
    end;
  end;
end;

function TNFeXmlWriter.GerarInfAdicObsCont: TACBrXmlNodeArray;
var
  i: Integer;
begin
  Result := nil;
  SetLength(Result, nfe.InfAdic.obsCont.Count);
  if nfe.InfAdic.obsCont.Count > 10 then
    wAlerta('Z04', 'obsCont', DSC_OBSCONT, ERR_MSG_MAIOR_MAXIMO + '10');

  for i := 0 to nfe.InfAdic.obsCont.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('obsCont');
    Result[i].SetAttribute('xCampo', nfe.InfAdic.obsCont[i].xCampo);

    if length(trim(nfe.InfAdic.obsCont[i].xCampo)) > 20 then
      wAlerta('ZO5', 'xCampo', DSC_XCAMPO, ERR_MSG_MAIOR);
    if length(trim(nfe.InfAdic.obsCont[i].xCampo)) = 0 then
      wAlerta('ZO5', 'xCampo', DSC_XCAMPO, ERR_MSG_VAZIO);
    Result[i].AppendChild(AddNode(tcStr, 'Z06', 'xTexto', 01, 60, 1, nfe.InfAdic.obsCont[i].xTexto, DSC_XTEXTO));
  end;
end;

function TNFeXmlWriter.GerarInfAdicObsFisco: TACBrXmlNodeArray;
var
  i: Integer;
begin
  Result := nil;
  SetLength(Result, nfe.InfAdic.obsCont.Count);
  if nfe.InfAdic.obsFisco.Count > 10 then
    wAlerta('Z07', 'obsFisco', DSC_OBSFISCO, ERR_MSG_MAIOR_MAXIMO + '10');
  for i := 0 to nfe.InfAdic.obsFisco.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('obsFisco');
    Result[i].SetAttribute('xCampo', nfe.InfAdic.obsFisco[i].xCampo);

    if length(trim(nfe.InfAdic.obsFisco[i].xCampo)) > 20 then
      wAlerta('ZO8', 'xCampo', DSC_XCAMPO, ERR_MSG_MAIOR);
    if length(trim(nfe.InfAdic.obsFisco[i].xCampo)) = 0 then
      wAlerta('ZO8', 'xCampo', DSC_XCAMPO, ERR_MSG_VAZIO);
    Result[i].AppendChild(AddNode(tcStr, 'Z09', 'xTexto', 01, 60, 1, nfe.InfAdic.obsFisco[i].xTexto, DSC_XTEXTO));
  end;
end;

function TNFeXmlWriter.GerarInfAdicProcRef: TACBrXmlNodeArray;
var
  i: Integer;
begin
  Result := nil;
  SetLength(Result, nfe.InfAdic.procRef.Count);

  if nfe.InfAdic.procRef.Count > 0 then
  begin
    for i := 0 to nfe.InfAdic.procRef.Count - 1 do
    begin
      Result[i] := FDocument.CreateElement('procRef');
      Result[i].AppendChild(AddNode(tcStr, 'Z11', 'nProc  ', 01, 60, 1, nfe.InfAdic.procRef[i].nProc, DSC_NPROC));
      Result[i].AppendChild(AddNode(tcStr, 'Z12', 'indProc', 01, 01, 1, indProcToStr(nfe.InfAdic.procRef[i].indProc), DSC_INDPROC));
    end;
  end;
end;

function TNFeXmlWriter.GerarExporta: TACBrXmlNode;
begin
  Result := nil;
  if nfe.infNFe.Versao >= 3.10 then
  begin
    if trim(nfe.exporta.UFSaidaPais) + trim(nfe.exporta.xLocExporta) <> '' then
    begin
      Result := FDocument.CreateElement('exporta');
      Result.AppendChild(AddNode(tcStr, 'ZA02', 'UFSaidaPais', 02, 02, 1, nfe.exporta.UFSaidaPais, DSC_UFEMBARQ));
      if not pcnAuxiliar.ValidarUF(nfe.exporta.UFSaidaPais) then
        wAlerta('ZA02', 'UFSaidaPais', DSC_UFEMBARQ, ERR_MSG_INVALIDO);
      Result.AppendChild(AddNode(tcStr, 'ZA03', 'xLocExporta ', 01, 60, 1, nfe.exporta.xLocExporta, DSC_XLOCEMBARQ));
      Result.AppendChild(AddNode(tcStr, 'ZA04', 'xLocDespacho', 01, 60, 0, nfe.exporta.xLocDespacho, DSC_XLOCDESP));
    end;
  end
  else
  begin
    if trim(nfe.exporta.UFembarq) + trim(nfe.exporta.xLocEmbarq) <> '' then
    begin
      Result := FDocument.CreateElement('exporta');
      Result.AppendChild(AddNode(tcStr, 'ZA02', 'UFEmbarq', 02, 02, 1, nfe.exporta.UFembarq, DSC_UFEMBARQ));
      if not pcnAuxiliar.ValidarUF(nfe.exporta.UFembarq) then
        wAlerta('ZA02', 'UFEmbarq', DSC_UFEMBARQ, ERR_MSG_INVALIDO);
      Result.AppendChild(AddNode(tcStr, 'ZA03', 'xLocEmbarq', 01, 60, 1, nfe.exporta.xLocEmbarq, DSC_XLOCEMBARQ));
    end;
  end;
end;

function TNFeXmlWriter.GerarCompra: TACBrXmlNode;
begin
  Result := nil;
  if trim(nfe.compra.xNEmp) + trim(nfe.compra.xPed) + trim(nfe.compra.xCont) <> '' then
  begin
    Result := FDocument.CreateElement('compra');
    Result.AppendChild(AddNode(tcStr, 'ZB02', 'xNEmp', 01, 22, 0, nfe.compra.xNEmp, DSC_XNEMP));
    Result.AppendChild(AddNode(tcStr, 'ZB03', 'xPed ', 01, 60, 0, nfe.compra.xPed, DSC_XPED));
    Result.AppendChild(AddNode(tcStr, 'ZB04', 'xCont', 01, 60, 0, nfe.compra.xCont, DSC_XCONT));
  end;
end;

function TNFeXmlWriter.GerarCana: TACBrXmlNode;
Var
  i: Integer;
  nodeArray: TACBrXmlNodeArray;
begin
  Result := nil;
  if not(Trim(nfe.cana.safra) = '') or not(Trim(nfe.cana.ref) = '') or
     (nfe.cana.fordia.Count > 0) or (nfe.cana.deduc.Count > 0) then
  begin
     Result := FDocument.CreateElement('cana');
     Result.AppendChild(AddNode(tcStr, 'ZC02', 'safra', 04, 09, 0, nfe.cana.safra, DSC_SAFRA));
     Result.AppendChild(AddNode(tcStr, 'ZC03', 'ref  ', 04, 09, 0, nfe.cana.ref, DSC_REF));

     nodeArray := GerarforDia;
     for i := 0 to nfe.cana.fordia.Count - 1 do
     begin
       Result.AppendChild(nodeArray[i]);
     end;

     Result.AppendChild(AddNode(tcDe10,'ZC07','qTotMes', 01, 21, 1, nfe.cana.qTotMes, DSC_QTOTMES));
     Result.AppendChild(AddNode(tcDe10,'ZC08','qTotAnt', 01, 21, 1, nfe.cana.qTotAnt, DSC_QTOTANT));
     Result.AppendChild(AddNode(tcDe10,'ZC09','qTotGer', 01, 21, 1, nfe.cana.qTotGer, DSC_TOTGER));

     nodeArray := GerarDeduc;
     for i := 0 to nfe.cana.deduc.Count - 1 do
     begin
       Result.AppendChild(nodeArray[i]);
     end;

     Result.AppendChild(AddNode(tcDe2,'ZC13','vFor   ', 01, 15, 1, nfe.cana.vFor, DSC_VFOR));
     Result.AppendChild(AddNode(tcDe2,'ZC14','vTotDed', 01, 15, 1, nfe.cana.vTotDed, DSC_VTOTDED));
     Result.AppendChild(AddNode(tcDe2,'ZC15','vLiqFor', 01, 15, 1, nfe.cana.vLiqFor, DSC_VLIQFOR));
  end;
end;

function TNFeXmlWriter.GerarforDia: TACBrXmlNodeArray;
var
  i: Integer;
begin
  Result := nil;
  SetLength(Result, nfe.cana.fordia.Count);
  if nfe.cana.fordia.Count > 31 then
    wAlerta('ZC04', 'forDia', DSC_FORDIA, ERR_MSG_MAIOR_MAXIMO + '31');

  for i := 0 to nfe.cana.fordia.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('forDia');
    Result[i].SetAttribute('dia', IntToStr(nfe.cana.fordia[i].dia));
    Result[i].AppendChild(AddNode(tcDe10,'ZC06','qtde   ', 11, 21, 1, nfe.cana.fordia[i].qtde, DSC_QTDE));
  end;
end;

function TNFeXmlWriter.GerarDeduc: TACBrXmlNodeArray;
var
  i: Integer;
begin
  Result := nil;
  SetLength(Result, nfe.cana.deduc.Count);
  if nfe.cana.deduc.Count > 10 then
    wAlerta('ZC10', 'deduc', DSC_DEDUC, ERR_MSG_MAIOR_MAXIMO + '10');
  for i := 0 to nfe.cana.deduc.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('deduc');
    Result[i].AppendChild(AddNode(tcStr,'ZC11','xDed   ', 01, 60, 1, nfe.cana.deduc[i].xDed, DSC_XDED));
    Result[i].AppendChild(AddNode(tcDe2,'ZC12','vDed   ', 01, 15, 1, nfe.cana.deduc[i].vDed, DSC_VDED));
  end;
end;

function TNFeXmlWriter.GerarinfRespTec: TACBrXmlNode;
begin
  Result := nil;
  if (nfe.infRespTec.CNPJ <> '') then
  begin
    Result := FDocument.CreateElement('infRespTec');
    Result.AppendChild(AddNodeCNPJ('#82', nfe.infRespTec.CNPJ, CODIGO_BRASIL, True));
    Result.AppendChild(AddNode(tcStr, '#083', 'xContato', 02, 60, 1, nfe.infRespTec.xContato, DSC_XCONTATO));
    Result.AppendChild(AddNode(tcStr, '#084', 'email   ', 06, 60, 1, nfe.infRespTec.email, DSC_EMAIL));
    Result.AppendChild(AddNode(tcStr, '#085', 'fone    ', 07, 12, 1, nfe.infRespTec.fone, DSC_FONE));

    if (idCSRT <> 0) and (CSRT <> '') then
    begin
      Result.AppendChild(AddNode(tcInt, '#086', 'idCSRT  ', 02, 02, 1, idCSRT, DSC_IDCSRT));
      Result.AppendChild(AddNode(tcStr, '#087', 'hashCSRT', 28, 28, 1, CalcularHashCSRT(CSRT, ChaveNFe), DSC_HASHCSRT));
    end;
  end;
end;

function TNFeXmlWriter.GerarProtNFe: TACBrXmlNode;
var
  xmlNode: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('protNFe');
  Result.SetAttribute('versao', FloatToString(nfe.infNFe.Versao, '.', '#0.00'));

  xmlNode := Result.AddChild('infProt');
  xmlNode.AddChild('tpAmb').Content := TpAmbToStr(nfe.procNFe.tpAmb);
  xmlNode.AddChild('verAplic').Content := nfe.procNFe.verAplic;
  xmlNode.AddChild('chNFe').Content := nfe.procNFe.chNFe;
  xmlNode.AddChild('dhRecbto').Content :=
    FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', nfe.procNFe.dhRecbto) +
    IIf(FNFe.infNFe.Versao >= 3.10, GetUTC(CodigoParaUF(FNFe.Ide.cUF),
    nfe.procNFe.dhRecbto), '');
  xmlNode.AddChild('nProt').Content := nfe.procNFe.nProt;
  xmlNode.AddChild('digVal').Content := nfe.procNFe.digVal;
  xmlNode.AddChild('cStat').Content := IntToStr(nfe.procNFe.cStat);
  xmlNode.AddChild('xMotivo').Content := nfe.procNFe.xMotivo;
end;

end.