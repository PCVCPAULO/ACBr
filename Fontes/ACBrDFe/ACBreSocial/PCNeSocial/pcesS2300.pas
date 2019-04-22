{******************************************************************************}
{ Projeto: Componente ACBreSocial                                              }
{  Biblioteca multiplataforma de componentes Delphi para envio dos eventos do  }
{ eSocial - http://www.esocial.gov.br/                                         }
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

{******************************************************************************
|* Historico
|*
|* 27/10/2015: Jean Carlo Cantu, Tiago Ravache
|*  - Doa��o do componente para o Projeto ACBr
|* 01/03/2016: Guilherme Costa
|*  - Altera��es para valida��o com o XSD
|* 23/02/2018:Edmar Fraz�o
|   - Altera��o natAtividade campo opcional para categorias  linha 437
******************************************************************************}
{$I ACBr.inc}

unit pcesS2300;

interface

uses
  SysUtils, Classes, Contnrs,
  pcnConversao, ACBrUtil,
  pcesCommon, pcesConversaoeSocial, pcesGerador;

type
  TS2300CollectionItem = class;
  TEvtTSVInicio = class;
  TinfoTSVInicio = class;
  TinfoComplementares = class;
  TinfoDirSind = class;
  TinfoTrabCedido = class;
  TTermino = class;

  TS2300Collection = class(TeSocialCollection)
  private
    function GetItem(Index: Integer): TS2300CollectionItem;
    procedure SetItem(Index: Integer; Value: TS2300CollectionItem);
  public
    function Add: TS2300CollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a fun��o New'{$EndIf};
    function New: TS2300CollectionItem;
    property Items[Index: Integer]: TS2300CollectionItem read GetItem write SetItem; default;
  end;

  TS2300CollectionItem = class(TObject)
  private
    FTipoEvento: TTipoEvento;
    FEvtTSVInicio: TEvtTSVInicio;
  public
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    property TipoEvento: TTipoEvento read FTipoEvento;
    property EvtTSVInicio: TEvtTSVInicio read FEvtTSVInicio write FEvtTSVInicio;
  end;

  TEvtTSVInicio = class(TeSocialEvento)
  private
    FIdeEvento: TIdeEvento2;
    FIdeEmpregador: TIdeEmpregador;
    FTrabalhador: TTrabalhador;
    FinfoTSVInicio : TinfoTSVInicio;

    procedure GerarInfoTSVInicio(obj : TinfoTSVInicio);
    procedure GerarInfoComplementares(obj: TinfoComplementares);
    procedure GerarCargoFuncao(obj: TcargoFuncao);
    procedure GerarRemuneracao(obj: TRemuneracao);
    procedure GerarFGTS(obj: TFGTS);
    procedure GerarinfoDirSind(obj: TinfoDirSind);
    procedure GerarinfoTrabCedido(obj: TinfoTrabCedido);
    procedure GerarinfoEstagiario(obj: TinfoEstagiario);
    procedure GerarInstEnsino(obj: TinstEnsino);
    procedure GerarageIntegracao(obj: TageIntegracao);
    procedure GerarsupervisorEstagio(obj: TsupervisorEstagio);
    procedure GerarTermino(obj: TTermino);
  public
    constructor Create(AACBreSocial: TObject); override;
    destructor  Destroy; override;

    function GerarXML: boolean; override;
    function LerArqIni(const AIniString: String): Boolean;

    property IdeEvento: TIdeEvento2 read FIdeEvento write FIdeEvento;
    property IdeEmpregador: TIdeEmpregador read FIdeEmpregador write FIdeEmpregador;
    property Trabalhador: TTrabalhador read FTrabalhador write FTrabalhador;
    property infoTSVInicio : TinfoTSVInicio read FinfoTSVInicio write FInfoTSVInicio;
  end;

  TinfoTSVInicio = class(TObject)
  private
    FcadIni: tpSimNao;
    FcodCateg : Integer;
    FdtInicio : TDateTime;
    FnatAtividade : tpNatAtividade;
    FinfoComplementares : TinfoComplementares;
    Fafastamento: TAfastamento;
    Ftermino: TTermino;
    FMudancaCPF: TMudancaCPF2;
  public
    constructor Create;
    destructor  Destroy; override;

    property cadIni: tpSimNao read FcadIni write FcadIni;
    property codCateg : Integer read FcodCateg write FcodCateg;
    property dtInicio : TDateTime read FdtInicio write FdtInicio;
    property natAtividade : tpNatAtividade read FnatAtividade write FnatAtividade;
    property infoComplementares : TinfoComplementares read FinfoComplementares write FinfoComplementares;
    property mudancaCPF: TMudancaCPF2 read FMudancaCPF write FMudancaCPF;
    property afastamento: TAfastamento read Fafastamento write Fafastamento;
    property termino: TTermino read Ftermino write Ftermino;
  end;

  TinfoComplementares = class(TObject)
  private
    FcargoFuncao : TcargoFuncao;
    FRemuneracao : TRemuneracao;
    FFgts        : TFGTS;
    FinfoDirSind : TinfoDirSind;
    FinfoTrabCedido : TinfoTrabCedido;
    FinfoEstagiario : TinfoEstagiario;
  public
    constructor Create;
    destructor  Destroy; override;

    property cargoFuncao: TcargoFuncao read FcargoFuncao write FcargoFuncao;
    property Remuneracao: TRemuneracao read FRemuneracao write FRemuneracao;
    property Fgts : TFGTS read FFgts write FFgts;
    property infoDirSind: TinfoDirSind read FinfoDirSind write FinfoDirSind;
    property infoTrabCedido: TinfoTrabCedido read FinfoTrabCedido write FinfoTrabCedido;
    property infoEstagiario: TinfoEstagiario read FinfoEstagiario write FinfoEstagiario;
  end;

  TinfoDirSind = class(TObject)
  private
    FcategOrig : Integer;
    FcnpjOrigem : String;
    FdtAdmOrig : TDateTime;
    FmatricOrig : String;
  public
    property categOrig: Integer read FcategOrig write FcategOrig;
    property cnpjOrigem: String read FcnpjOrigem write FcnpjOrigem;
    property dtAdmOrig: TDateTime read FdtAdmOrig write FdtAdmOrig;
    property matricOrig: String read FmatricOrig write FmatricOrig;
  end;

  TinfoTrabCedido = class(TObject)
  private
    FcategOrig : Integer;
    FcnpjCednt : String;
    FmatricCed : String;
    FdtAdmCed : TDateTime;
    FTpRegTrab: tpTpRegTrab;
    FTpRegPrev: tpTpRegPrev;
    FinfOnus : tpInfOnus;
  public
    property categOrig: Integer read FcategOrig write FcategOrig;
    property cnpjCednt: String read FcnpjCednt write FcnpjCednt;
    property matricCed: String read FmatricCed write FmatricCed;
    property dtAdmCed: TDateTime read FdtAdmCed write FdtAdmCed;
    property tpRegTrab: tpTpRegTrab read FTpRegTrab write FTpRegTrab;
    property tpRegPrev: tpTpRegPrev read FTpRegPrev write FTpRegPrev;
    property infOnus: tpInfOnus read FinfOnus write FinfOnus;
  end;

  TTermino = class(TObject)
  private
    FdtTerm: TDateTime;
  public
    property dtTerm: TDateTime read FdtTerm write FdtTerm;
  end;

implementation

uses
  IniFiles,
  ACBreSocial;

{ TS2300Collection }

function TS2300Collection.Add: TS2300CollectionItem;
begin
  Result := Self.New;
end;

function TS2300Collection.GetItem(Index: Integer): TS2300CollectionItem;
begin
  Result := TS2300CollectionItem(inherited GetItem(Index));
end;

procedure TS2300Collection.SetItem(Index: Integer; Value: TS2300CollectionItem);
begin
  inherited SetItem(Index, Value);
end;

function TS2300Collection.New: TS2300CollectionItem;
begin
  Result := TS2300CollectionItem.Create(FACBreSocial);
  Self.Add(Result);
end;

{ TS2300CollectionItem }

constructor TS2300CollectionItem.Create(AOwner: TComponent);
begin
  inherited Create;
  FTipoEvento   := teS2300;
  FEvtTSVInicio := TEvtTSVInicio.Create(AOwner);
end;

destructor TS2300CollectionItem.Destroy;
begin
  FEvtTSVInicio.Free;

  inherited;
end;

{ TinfoTSVInicio }

constructor TinfoTSVInicio.Create;
begin
  inherited;

  FinfoComplementares := TinfoComplementares.Create;
  Fafastamento        := TAfastamento.Create;
  FMudancaCPF         := TMudancaCPF2.Create;
  Ftermino            := TTermino.Create;
end;

destructor TinfoTSVInicio.Destroy;
begin
  FinfoComplementares.Free;
  Fafastamento.Free;
  FMudancaCPF.Free;
  Ftermino.Free;

  inherited;
end;

{ TinfoComplementares }

constructor TinfoComplementares.Create;
begin
  inherited;

  FcargoFuncao    := TcargoFuncao.Create;
  FRemuneracao    := TRemuneracao.Create;
  FFgts           := TFGTS.Create;
  FinfoDirSind    := TinfoDirSind.Create;
  FinfoTrabCedido := TinfoTrabCedido.Create;
  FinfoEstagiario := TinfoEstagiario.Create;
end;

destructor TinfoComplementares.Destroy;
begin
  FcargoFuncao.Free;
  FRemuneracao.Free;
  FFgts.Free;
  FinfoDirSind.Free;
  FinfoTrabCedido.Free;
  FinfoEstagiario.Free;

  inherited;
end;

{ TEvtTSVInicio }

constructor TEvtTSVInicio.Create(AACBreSocial: TObject);
begin
  inherited Create(AACBreSocial);

  FIdeEvento     := TIdeEvento2.Create;
  FIdeEmpregador := TIdeEmpregador.Create;
  FTrabalhador   := TTrabalhador.Create;
  FinfoTSVInicio := TinfoTSVInicio.Create;
end;

destructor TEvtTSVInicio.Destroy;
begin
  FIdeEvento.Free;
  FIdeEmpregador.Free;
  FTrabalhador.Free;
  FinfoTSVInicio.Free;

  inherited;
end;

procedure TEvtTSVInicio.GerarageIntegracao(obj: TageIntegracao);
begin
  if obj.cnpjAgntInteg <> EmptyStr then
  begin
	Gerador.wGrupo('ageIntegracao');

    Gerador.wCampo(tcStr, '', 'cnpjAgntInteg', 14,  14, 1, obj.cnpjAgntInteg);
	Gerador.wCampo(tcStr, '', 'nmRazao',        1, 100, 1, obj.nmRazao);
	Gerador.wCampo(tcStr, '', 'dscLograd',      1,  80, 1, obj.dscLograd);
	Gerador.wCampo(tcStr, '', 'nrLograd',       1,  10, 1, obj.nrLograd);
	Gerador.wCampo(tcStr, '', 'bairro',         1,  60, 0, obj.bairro);
	Gerador.wCampo(tcStr, '', 'cep',            1,   8, 1, obj.cep);
	Gerador.wCampo(tcStr, '', 'codMunic',       7,   7, 0, obj.codMunic);
	Gerador.wCampo(tcStr, '', 'uf',             2,   2, 1, eSufToStr(obj.uf));

	Gerador.wGrupo('/ageIntegracao');
  end;
end;

procedure TEvtTSVInicio.GerarCargoFuncao(obj: TcargoFuncao);
begin
  if obj.codCargo <> EmptyStr then
  begin
    Gerador.wGrupo('cargoFuncao');

    Gerador.wCampo(tcStr, '', 'codCargo',  1, 30, 1, obj.codCargo);
    Gerador.wCampo(tcStr, '', 'codFuncao', 1, 30, 0, obj.codFuncao);

    Gerador.wGrupo('/cargoFuncao');
  end;
end;

procedure TEvtTSVInicio.GerarFGTS(obj: TFGTS);
begin
  if obj.dtOpcFGTS > 0 then
  begin
    Gerador.wGrupo('fgts');

    Gerador.wCampo(tcStr, '', 'opcFGTS',    1,  1, 1, eSOpcFGTSToStr(obj.OpcFGTS));
    Gerador.wCampo(tcDat, '', 'dtOpcFGTS', 10, 10, 0, obj.dtOpcFGTS);

    Gerador.wGrupo('/fgts');
  end;
end;

procedure TEvtTSVInicio.GerarInfoComplementares(obj: TinfoComplementares);
begin
  if (obj.cargoFuncao.codCargo <> EmptyStr) or (obj.Remuneracao.VrSalFx > 0) or
     (obj.Remuneracao.UndSalFixo = sfNaoaplicavel ) or
     (obj.FGTS.DtOpcFGTS> 0) or (obj.infoDirSind.categOrig > 0) or
     (obj.infoTrabCedido.dtAdmCed>0) or (obj.infoEstagiario.dtPrevTerm > 0) then
  begin
    Gerador.wGrupo('infoComplementares');

    GerarCargoFuncao(obj.cargoFuncao);
    GerarRemuneracao(obj.Remuneracao);
    GerarFGTS(obj.FGTS);
    GerarinfoDirSind(obj.infoDirSind);
    GerarinfoTrabCedido(obj.infoTrabCedido);
    GerarinfoEstagiario(obj.infoEstagiario);

    Gerador.wGrupo('/infoComplementares');
  end;
end;

procedure TEvtTSVInicio.GerarinfoDirSind(obj: TinfoDirSind);
begin
  if obj.categOrig > 0 then
  begin
    Gerador.wGrupo('infoDirigenteSindical');

    Gerador.wCampo(tcStr, '', 'categOrig',   1,  3, 1, obj.categOrig);
    Gerador.wCampo(tcStr, '', 'cnpjOrigem', 14, 14, 0, obj.cnpjOrigem);
    Gerador.wCampo(tcDat, '', 'dtAdmOrig',  10, 10, 0, obj.dtAdmOrig);
    Gerador.wCampo(tcStr, '', 'matricOrig',  1, 30, 0, obj.matricOrig);

    Gerador.wGrupo('/infoDirigenteSindical');
  end;
end;

procedure TEvtTSVInicio.GerarinfoEstagiario(obj: TinfoEstagiario);
begin
  if obj.dtPrevTerm > 0 then
  begin
    Gerador.wGrupo('infoEstagiario');

    Gerador.wCampo(tcStr, '', 'natEstagio',   1,  1, 1, eSTpNatEstagioToStr(obj.natEstagio));
    Gerador.wCampo(tcStr, '', 'nivEstagio',   1,  1, 1, eStpNivelEstagioToStr(obj.nivEstagio));
    Gerador.wCampo(tcStr, '', 'areaAtuacao',  1, 50, 0, obj.areaAtuacao);
    Gerador.wCampo(tcStr, '', 'nrApol',       1, 30, 0, obj.nrApol);
    Gerador.wCampo(tcDe2, '', 'vlrBolsa',     1, 14, 0, obj.vlrBolsa);
    Gerador.wCampo(tcDat, '', 'dtPrevTerm',  10, 10, 1, obj.dtPrevTerm);

    GerarInstEnsino(obj.instEnsino);
    GerarageIntegracao(obj.ageIntegracao);
    GerarsupervisorEstagio(obj.supervisorEstagio);

    Gerador.wGrupo('/infoEstagiario');
  end;
end;

procedure TEvtTSVInicio.GerarinfoTrabCedido(obj: TinfoTrabCedido);
begin
  if obj.dtAdmCed > 0 then
  begin
    Gerador.wGrupo('infoTrabCedido');

    Gerador.wCampo(tcStr, '', 'categOrig',  1,  3, 1, obj.categOrig);
    Gerador.wCampo(tcStr, '', 'cnpjCednt', 14, 14, 1, obj.cnpjCednt);
    Gerador.wCampo(tcStr, '', 'matricCed',  1, 30, 1, obj.matricCed);
    Gerador.wCampo(tcDat, '', 'dtAdmCed',  10, 10, 1, obj.dtAdmCed);
    Gerador.wCampo(tcInt, '', 'tpRegTrab',  1,  1, 1, eSTpRegTrabToStr(obj.tpRegTrab));
    Gerador.wCampo(tcInt, '', 'tpRegPrev',  1,  1, 1, eSTpRegPrevToStr(obj.tpRegPrev));
    Gerador.wCampo(tcStr, '', 'infOnus',    1,  1, 1, tpInfOnusToStr(obj.infOnus));

    Gerador.wGrupo('/infoTrabCedido');
  end;
end;

procedure TEvtTSVInicio.GerarInfoTSVInicio(obj: TinfoTSVInicio);
begin
  Gerador.wGrupo('infoTSVInicio');

  Gerador.wCampo(tcStr, '', 'cadIni',        1,  1, 1, eSSimNaoToStr(obj.cadIni));
  Gerador.wCampo(tcStr, '', 'codCateg',      0,  3, 1, obj.codCateg);
  Gerador.wCampo(tcDat, '', 'dtInicio',     10, 10, 1, obj.dtInicio);

  //    Valida��o: **Preenchimento obrigat�rio** para as categorias de avulso, cooperado e dirigente sindical.
  //               N�o deve ser preenchido para as categorias Diretor n�o empregado, servidor p�blico indicado a conselho, membro de conselho tutelar e estagi�rio.

  if
    (obj.codCateg <> 721) and // Diretor n�o empregado com FGTS
    (obj.codCateg <> 722) and // Diretor n�o empregado sem FGTS
    (obj.codCateg <> 305) and // Servidor Publico Indicado a Conselho
    (obj.codCateg <> 771) and // Membro conselho tutelar
    (obj.codCateg <> 901) and // Estagiario
    (obj.natAtividade <> navNaoInformar)
  then
    Gerador.wCampo(tcStr, '', 'natAtividade',  1,  1, 0, eSNatAtividadeToStr(obj.natAtividade));

  GerarInfoComplementares(obj.InfoComplementares);

  if (obj.cadIni <> tpSim) then
    GerarMudancaCPF2(obj.mudancaCPF);

  GerarAfastamento(obj.afastamento);
  GerarTermino(obj.termino);

  Gerador.wGrupo('/infoTSVInicio');
end;

procedure TEvtTSVInicio.GerarInstEnsino(obj: TinstEnsino);
begin
  Gerador.wGrupo('instEnsino');

  Gerador.wCampo(tcStr, '', 'cnpjInstEnsino', 14,  14, 0, obj.cnpjInstEnsino);
  Gerador.wCampo(tcStr, '', 'nmRazao',         1, 100, 1, obj.nmRazao);
  Gerador.wCampo(tcStr, '', 'dscLograd',       1,  80, 0, obj.dscLograd);
  Gerador.wCampo(tcStr, '', 'nrLograd',        1,  10, 0, obj.nrLograd);
  Gerador.wCampo(tcStr, '', 'bairro',          1,  60, 0, obj.bairro);
  Gerador.wCampo(tcStr, '', 'cep',             1,   8, 0, obj.cep);
  Gerador.wCampo(tcInt, '', 'codMunic',        7,   7, 0, obj.codMunic);
  Gerador.wCampo(tcStr, '', 'uf',              2,   2, 0, obj.uf);

  Gerador.wGrupo('/instEnsino');
end;

procedure TEvtTSVInicio.GerarRemuneracao(obj: TRemuneracao);
begin
  if (obj.vrSalFx > 0) or (obj.UndSalFixo = sfNaoaplicavel ) then
  begin
    Gerador.wGrupo('remuneracao');

    Gerador.wCampo(tcDe2, '', 'vrSalFx',    1,  14, 1, obj.vrSalFx);
    Gerador.wCampo(tcStr, '', 'undSalFixo', 1,   1, 1, eSUndSalFixoToStr(obj.undSalFixo));
    Gerador.wCampo(tcStr, '', 'dscSalVar',  1, 255, 0, obj.dscSalVar);

    Gerador.wGrupo('/remuneracao');
  end;
end;

procedure TEvtTSVInicio.GerarsupervisorEstagio(obj: TsupervisorEstagio);
begin
  if obj.cpfSupervisor <> EmptyStr then
  begin
    Gerador.wGrupo('supervisorEstagio');

    Gerador.wCampo(tcStr, '', 'cpfSupervisor', 11, 11, 1, obj.cpfSupervisor);
    Gerador.wCampo(tcStr, '', 'nmSuperv',       1, 70, 1, obj.nmSuperv);

    Gerador.wGrupo('/supervisorEstagio');
  end;
end;

procedure TEvtTSVInicio.GerarTermino(obj: TTermino);
begin
  if obj.dtTerm > 0 then
  begin
    Gerador.wGrupo('termino');

    Gerador.wCampo(tcDat, '', 'dtTerm', 10, 10, 1, obj.dtTerm);

    Gerador.wGrupo('/termino');
  end;
end;

function TEvtTSVInicio.GerarXML: boolean;
begin
  try
    Self.VersaoDF := TACBreSocial(FACBreSocial).Configuracoes.Geral.VersaoDF;
     
    Self.Id := GerarChaveEsocial(now, self.ideEmpregador.NrInsc, self.Sequencial);

    GerarCabecalho('evtTSVInicio');
    Gerador.wGrupo('evtTSVInicio Id="' + Self.Id + '"');

    GerarIdeEvento2(self.IdeEvento);
    GerarIdeEmpregador(self.IdeEmpregador);

    GerarTrabalhador(self.Trabalhador, 'trabalhador', 3, Self.FinfoTSVInicio.codCateg);
    GerarInfoTSVInicio(self.infoTSVInicio);

    Gerador.wGrupo('/evtTSVInicio');

    GerarRodape;

    XML := Assinar(Gerador.ArquivoFormatoXML, 'evtTSVInicio');

    Validar(schevtTSVInicio);
  except on e:exception do
    raise Exception.Create('ID: ' + Self.Id + sLineBreak + ' ' + e.Message);
  end;

  Result := (Gerador.ArquivoFormatoXML <> '');
end;

function TEvtTSVInicio.LerArqIni(const AIniString: String): Boolean;
var
  INIRec: TMemIniFile;
  Ok: Boolean;
  sSecao, sFim: String;
  I: Integer;
begin
  Result := True;

  INIRec := TMemIniFile.Create('');
  try
    LerIniArquivoOuString(AIniString, INIRec);

    with Self do
    begin
      sSecao := 'evtTSVInicio';
      Id         := INIRec.ReadString(sSecao, 'Id', '');
      Sequencial := INIRec.ReadInteger(sSecao, 'Sequencial', 0);

      sSecao := 'ideEvento';
      ideEvento.indRetif    := eSStrToIndRetificacao(Ok, INIRec.ReadString(sSecao, 'indRetif', '1'));
      ideEvento.NrRecibo    := INIRec.ReadString(sSecao, 'nrRecibo', EmptyStr);
      ideEvento.ProcEmi     := eSStrToProcEmi(Ok, INIRec.ReadString(sSecao, 'procEmi', '1'));
      ideEvento.VerProc     := INIRec.ReadString(sSecao, 'verProc', EmptyStr);

      sSecao := 'ideEmpregador';
      ideEmpregador.OrgaoPublico := (TACBreSocial(FACBreSocial).Configuracoes.Geral.TipoEmpregador = teOrgaoPublico);
      ideEmpregador.TpInsc       := eSStrToTpInscricao(Ok, INIRec.ReadString(sSecao, 'tpInsc', '1'));
      ideEmpregador.NrInsc       := INIRec.ReadString(sSecao, 'nrInsc', EmptyStr);

      sSecao := 'trabalhador';
      trabalhador.CpfTrab    := INIRec.ReadString(sSecao, 'cpfTrab', EmptyStr);
      trabalhador.NisTrab    := INIRec.ReadString(sSecao, 'nisTrab', EmptyStr);
      trabalhador.NmTrab     := INIRec.ReadString(sSecao, 'nmTrab', EmptyStr);
      trabalhador.Sexo       := INIRec.ReadString(sSecao, 'sexo', EmptyStr);
      trabalhador.RacaCor    := INIRec.ReadInteger(sSecao, 'racaCor', 1);
      trabalhador.EstCiv     := INIRec.ReadInteger(sSecao, 'estCiv', 1);
      trabalhador.GrauInstr  := INIRec.ReadString(sSecao, 'grauInstr', '01');
      trabalhador.nmSoc      := INIRec.ReadString(sSecao, 'nmSoc', EmptyStr);

      sSecao := 'nascimento';
      trabalhador.Nascimento.dtNascto   := StringToDateTime(INIRec.ReadString(sSecao, 'dtNascto', '0'));
      trabalhador.Nascimento.codMunic   := INIRec.ReadInteger(sSecao, 'codMunic', 0);
      trabalhador.Nascimento.UF         := INIRec.ReadString(sSecao, 'uf', 'SP');
      trabalhador.Nascimento.PaisNascto := INIRec.ReadString(sSecao, 'paisNascto', '');
      trabalhador.Nascimento.PaisNac    := INIRec.ReadString(sSecao, 'paisNac', '');
      trabalhador.Nascimento.NmMae      := INIRec.ReadString(sSecao, 'nmMae', '');
      trabalhador.Nascimento.NmPai      := INIRec.ReadString(sSecao, 'nmPai', '');

      sSecao := 'CTPS';
      if INIRec.ReadString(sSecao, 'nrCtps', '') <> '' then
      begin
        trabalhador.documentos.CTPS.NrCtps    := INIRec.ReadString(sSecao, 'nrCtps', '');
        trabalhador.documentos.CTPS.SerieCtps := INIRec.ReadString(sSecao, 'serieCtps', '');
        trabalhador.documentos.CTPS.UfCtps    := INIRec.ReadString(sSecao, 'ufCtps', 'SP');
      end;

      sSecao := 'RIC';
      if INIRec.ReadString(sSecao, 'nrRic', '') <> '' then
      begin
        trabalhador.documentos.RIC.NrRic        := INIRec.ReadString(sSecao, 'nrRic', '');
        trabalhador.documentos.RIC.OrgaoEmissor := INIRec.ReadString(sSecao, 'orgaoEmissor', '');
        trabalhador.documentos.RIC.DtExped      := StringToDateTime(INIRec.ReadString(sSecao, 'dtExped', '0'));
      end;

      sSecao := 'RG';
      if INIRec.ReadString(sSecao, 'nrRg', '') <> '' then
      begin
        trabalhador.documentos.rg.NrRg         := INIRec.ReadString(sSecao, 'nrRg', '');
        trabalhador.documentos.rg.OrgaoEmissor := INIRec.ReadString(sSecao, 'orgaoEmissor', '');
        trabalhador.documentos.rg.DtExped      := StringToDateTime(INIRec.ReadString(sSecao, 'dtExped', '0'));
      end;

      sSecao := 'RNE';
      if INIRec.ReadString(sSecao, 'nrRne', '') <> '' then
      begin
        trabalhador.documentos.RNE.NrRne        := INIRec.ReadString(sSecao, 'nrRne', '');
        trabalhador.documentos.RNE.OrgaoEmissor := INIRec.ReadString(sSecao, 'orgaoEmissor', '');
        trabalhador.documentos.RNE.DtExped      := StringToDateTime(INIRec.ReadString(sSecao, 'dtExped', '0'));
      end;

      sSecao := 'OC';
      if INIRec.ReadString(sSecao, 'nrOc', '') <> '' then
      begin
        trabalhador.documentos.OC.NrOc         := INIRec.ReadString(sSecao, 'nrOc', '');
        trabalhador.documentos.OC.OrgaoEmissor := INIRec.ReadString(sSecao, 'orgaoEmissor', '');
        trabalhador.documentos.OC.DtExped      := StringToDateTime(INIRec.ReadString(sSecao, 'dtExped', '0'));
        trabalhador.documentos.OC.DtValid      := StringToDateTime(INIRec.ReadString(sSecao, 'dtValid', '0'));
      end;

      sSecao := 'CNH';
      if INIRec.ReadString(sSecao, 'nrRegCnh', '') <> '' then
      begin
        trabalhador.documentos.CNH.nrRegCnh     := INIRec.ReadString(sSecao, 'nrRegCnh', '');
        trabalhador.documentos.CNH.DtExped      := StringToDateTime(INIRec.ReadString(sSecao, 'dtExped', '0'));
        trabalhador.documentos.CNH.ufCnh        := eSStrTouf(Ok, INIRec.ReadString(sSecao, 'ufCnh', 'SP'));
        trabalhador.documentos.CNH.DtValid      := StringToDateTime(INIRec.ReadString(sSecao, 'dtValid', '0'));
        trabalhador.documentos.CNH.dtPriHab     := StringToDateTime(INIRec.ReadString(sSecao, 'dtPriHab', '0'));
        trabalhador.documentos.CNH.categoriaCnh := eSStrToCnh(Ok, INIRec.ReadString(sSecao, 'categoriaCnh', 'A'));
      end;

      sSecao := 'enderecoBrasil';
      if INIRec.ReadString(sSecao, 'tpLograd', '') <> '' then
      begin
        trabalhador.Endereco.Brasil.TpLograd    := INIRec.ReadString(sSecao, 'tpLograd', '');
        trabalhador.Endereco.Brasil.DscLograd   := INIRec.ReadString(sSecao, 'dscLograd', '');
        trabalhador.Endereco.Brasil.NrLograd    := INIRec.ReadString(sSecao, 'nrLograd', '');
        trabalhador.Endereco.Brasil.Complemento := INIRec.ReadString(sSecao, 'complemento', '');
        trabalhador.Endereco.Brasil.Bairro      := INIRec.ReadString(sSecao, 'bairro', '');
        trabalhador.Endereco.Brasil.Cep         := INIRec.ReadString(sSecao, 'cep', '');
        trabalhador.Endereco.Brasil.CodMunic    := INIRec.ReadInteger(sSecao, 'codMunic', 0);
        trabalhador.Endereco.Brasil.UF          := eSStrTouf(Ok, INIRec.ReadString(sSecao, 'uf', 'SP'));
      end;

      sSecao := 'enderecoExterior';
      if INIRec.ReadString(sSecao, 'paisResid', '') <> '' then
      begin
        trabalhador.Endereco.Exterior.PaisResid   := INIRec.ReadString(sSecao, 'paisResid', '');
        trabalhador.Endereco.Exterior.DscLograd   := INIRec.ReadString(sSecao, 'dscLograd', '');
        trabalhador.Endereco.Exterior.NrLograd    := INIRec.ReadString(sSecao, 'nrLograd', '');
        trabalhador.Endereco.Exterior.Complemento := INIRec.ReadString(sSecao, 'complemento', '');
        trabalhador.Endereco.Exterior.Bairro      := INIRec.ReadString(sSecao, 'bairro', '');
        trabalhador.Endereco.Exterior.NmCid       := INIRec.ReadString(sSecao, 'nmCid', '');
        trabalhador.Endereco.Exterior.CodPostal   := INIRec.ReadString(sSecao, 'codPostal', '');
      end;

      sSecao := 'trabEstrangeiro';
      if INIRec.ReadString(sSecao, 'dtChegada', '') <> '' then
      begin
        trabalhador.TrabEstrangeiro.DtChegada        := StringToDateTime(INIRec.ReadString(sSecao, 'dtChegada', '0'));
        trabalhador.TrabEstrangeiro.ClassTrabEstrang := eSStrToClassTrabEstrang(Ok, INIRec.ReadString(sSecao, 'classTrabEstrang', '1'));
        trabalhador.TrabEstrangeiro.CasadoBr         := INIRec.ReadString(sSecao, 'casadoBr', 'S');
        trabalhador.TrabEstrangeiro.FilhosBr         := INIRec.ReadString(sSecao, 'filhosBr', 'S');
      end;

      sSecao := 'infoDeficiencia';
      if INIRec.ReadString(sSecao, 'defFisica', '') <> '' then
      begin
        trabalhador.infoDeficiencia.DefFisica      := eSStrToSimNao(Ok, INIRec.ReadString(sSecao, 'defFisica', 'S'));
        trabalhador.infoDeficiencia.DefVisual      := eSStrToSimNao(Ok, INIRec.ReadString(sSecao, 'defVisual', 'S'));
        trabalhador.infoDeficiencia.DefAuditiva    := eSStrToSimNao(Ok, INIRec.ReadString(sSecao, 'defAuditiva', 'S'));
        trabalhador.infoDeficiencia.DefMental      := eSStrToSimNao(Ok, INIRec.ReadString(sSecao, 'defMental', 'S'));
        trabalhador.infoDeficiencia.DefIntelectual := eSStrToSimNao(Ok, INIRec.ReadString(sSecao, 'defIntelectual', 'S'));
        trabalhador.infoDeficiencia.ReabReadap     := eSStrToSimNao(Ok, INIRec.ReadString(sSecao, 'reabReadap', 'S'));
        trabalhador.infoDeficiencia.Observacao     := INIRec.ReadString(sSecao, 'observacao', '');
      end;

      I := 1;
      while true do
      begin
        // de 00 at� 99
        sSecao := 'dependente' + IntToStrZero(I, 2);
        sFim   := INIRec.ReadString(sSecao, 'tpDep', 'FIM');

        if (sFim = 'FIM') or (Length(sFim) <= 0) then
          break;

        with trabalhador.Dependente.New do
        begin
          tpDep    := eSStrToTpDep(Ok, sFim);
          nmDep    := INIRec.ReadString(sSecao, 'nmDep', '');
          dtNascto := StringToDateTime(INIRec.ReadString(sSecao, 'dtNascto', '0'));
          cpfDep   := INIRec.ReadString(sSecao, 'cpfDep', '');
          depIRRF  := eSStrToSimNao(Ok, INIRec.ReadString(sSecao, 'depIRRF', 'S'));
          depSF    := eSStrToSimNao(Ok, INIRec.ReadString(sSecao, 'depSF', 'S'));
          incTrab  := eSStrToSimNao(Ok, INIRec.ReadString(sSecao, 'incTrab', 'S'));
        end;

        Inc(I);
      end;

      sSecao := 'contato';
      if INIRec.ReadString(sSecao, 'fonePrinc', '') <> '' then
      begin
        trabalhador.contato.FonePrinc     := INIRec.ReadString(sSecao, 'fonePrinc', '');
        trabalhador.contato.FoneAlternat  := INIRec.ReadString(sSecao, 'foneAlternat', 'S');
        trabalhador.contato.EmailPrinc    := INIRec.ReadString(sSecao, 'emailPrinc', 'S');
        trabalhador.contato.EmailAlternat := INIRec.ReadString(sSecao, 'emailAlternat', 'S');
      end;

      sSecao := 'infoTSVInicio';
      infoTSVInicio.cadIni         := eSStrToSimNao(Ok, INIRec.ReadString(sSecao, 'cadIni', 'S'));
      infoTSVInicio.codCateg       := INIRec.ReadInteger(sSecao, 'codCateg', 0);
      infoTSVInicio.dtInicio       := StringToDateTime(INIRec.ReadString(sSecao, 'dtInicio', '0'));
      infoTSVInicio.natAtividade   := eSStrToNatAtividade(Ok, INIRec.ReadString(sSecao, 'natAtividade', '1'));

      sSecao := 'cargoFuncao';
      if INIRec.ReadString(sSecao, 'codCargo', '') <> '' then
      begin
        infoTSVInicio.infoComplementares.cargoFuncao.CodCargo    := INIRec.ReadString(sSecao, 'codCargo', '');
        infoTSVInicio.infoComplementares.cargoFuncao.CodFuncao   := INIRec.ReadString(sSecao, 'codFuncao', '');
      end;

      sSecao := 'remuneracao';
      if INIRec.ReadString(sSecao, 'vrSalFx', '') <> '' then
      begin
        infoTSVInicio.infoComplementares.remuneracao.VrSalFx    := StringToFloatDef(INIRec.ReadString(sSecao, 'vrSalFx', ''), 0);
        infoTSVInicio.infoComplementares.remuneracao.UndSalFixo := eSStrToUndSalFixo(Ok, INIRec.ReadString(sSecao, 'undSalFixo', ''));
        infoTSVInicio.infoComplementares.remuneracao.DscSalVar  := INIRec.ReadString(sSecao, 'dscSalVar', '');
      end;

      sSecao := 'FGTS';
      if INIRec.ReadString(sSecao, 'opcFGTS', '') <> '' then
      begin
        infoTSVInicio.infoComplementares.FGTS.OpcFGTS   := eSStrToOpcFGTS(Ok, INIRec.ReadString(sSecao, 'opcFGTS', '1'));
        infoTSVInicio.infoComplementares.FGTS.DtOpcFGTS := StringToDateTime(INIRec.ReadString(sSecao, 'dtOpcFGTS', '0'));
      end;

      sSecao := 'infoDirigenteSindical';
      if INIRec.ReadString(sSecao, 'categOrig', '') <> '' then
      begin
        infoTSVInicio.infoComplementares.infoDirSind.categOrig  := INIRec.ReadInteger(sSecao, 'categOrig', 1);
        infoTSVInicio.infoComplementares.infoDirSind.cnpjOrigem := INIRec.ReadString(sSecao, 'cnpjOrigem', '');
        infoTSVInicio.infoComplementares.infoDirSind.dtAdmOrig  := StringToDateTime(INIRec.ReadString(sSecao, 'dtAdmOrig', '0'));
        infoTSVInicio.infoComplementares.infoDirSind.matricOrig := INIRec.ReadString(sSecao, 'matricOrig', '');
      end;

      sSecao := 'infoTrabCedido';
      if INIRec.ReadString(sSecao, 'categOrig', '') <> '' then
      begin
        infoTSVInicio.infoComplementares.infoTrabCedido.categOrig := INIRec.ReadInteger(sSecao, 'categOrig', 1);
        infoTSVInicio.infoComplementares.infoTrabCedido.cnpjCednt := INIRec.ReadString(sSecao, 'cnpjCednt', '');
        infoTSVInicio.infoComplementares.infoTrabCedido.matricCed := INIRec.ReadString(sSecao, 'matricCed', '');
        infoTSVInicio.infoComplementares.infoTrabCedido.dtAdmCed  := StringToDateTime(INIRec.ReadString(sSecao, 'dtAdmCed', '0'));
        infoTSVInicio.infoComplementares.infoTrabCedido.tpRegTrab := eSStrToTpRegTrab(Ok, INIRec.ReadString(sSecao, 'tpRegTrab', '1'));
        infoTSVInicio.infoComplementares.infoTrabCedido.tpRegPrev := eSStrTotpRegPrev(Ok, INIRec.ReadString(sSecao, 'tpRegPrev', '1'));
        infoTSVInicio.infoComplementares.infoTrabCedido.infOnus   := StrTotpInfOnus(Ok, INIRec.ReadString(sSecao, 'infOnus', '1'));
      end;

      sSecao := 'infoEstagiario';
      if INIRec.ReadString(sSecao, 'natEstagio', '') <> '' then
      begin
        infoTSVInicio.infoComplementares.infoEstagiario.natEstagio  := eSStrToTpNatEstagio(Ok, INIRec.ReadString(sSecao, 'natEstagio', 'O'));
        infoTSVInicio.infoComplementares.infoEstagiario.nivEstagio  := eSStrTotpNivelEstagio(Ok, INIRec.ReadString(sSecao, 'nivEstagio', '1'));
        infoTSVInicio.infoComplementares.infoEstagiario.areaAtuacao := INIRec.ReadString(sSecao, 'areaAtuacao', '');
        infoTSVInicio.infoComplementares.infoEstagiario.nrApol      := INIRec.ReadString(sSecao, 'nrApol', '');
        infoTSVInicio.infoComplementares.infoEstagiario.vlrBolsa    := StringToFloatDef(INIRec.ReadString(sSecao, 'vlrBolsa', ''), 0);
        infoTSVInicio.infoComplementares.infoEstagiario.dtPrevTerm  := StringToDateTime(INIRec.ReadString(sSecao, 'dtPrevTerm', '0'));

        sSecao := 'instEnsino';
        infoTSVInicio.infoComplementares.infoEstagiario.instEnsino.cnpjInstEnsino := INIRec.ReadString(sSecao, 'cnpjInstEnsino', '');
        infoTSVInicio.infoComplementares.infoEstagiario.instEnsino.nmRazao        := INIRec.ReadString(sSecao, 'nmRazao', '');
        infoTSVInicio.infoComplementares.infoEstagiario.instEnsino.dscLograd      := INIRec.ReadString(sSecao, 'dscLograd', '');
        infoTSVInicio.infoComplementares.infoEstagiario.instEnsino.nrLograd       := INIRec.ReadString(sSecao, 'nrLograd', '');
        infoTSVInicio.infoComplementares.infoEstagiario.instEnsino.bairro         := INIRec.ReadString(sSecao, 'bairro', '');
        infoTSVInicio.infoComplementares.infoEstagiario.instEnsino.Cep            := INIRec.ReadString(sSecao, 'cep', '');
        infoTSVInicio.infoComplementares.infoEstagiario.instEnsino.codMunic       := INIRec.ReadInteger(sSecao, 'codMunic', 0);
        infoTSVInicio.infoComplementares.infoEstagiario.instEnsino.uf             := INIRec.ReadString(sSecao, 'uf', '');

        sSecao := 'ageIntegracao';
        if INIRec.ReadString(sSecao, 'cnpjAgntInteg', '') <> '' then
        begin
          infoTSVInicio.infoComplementares.infoEstagiario.ageIntegracao.cnpjAgntInteg := INIRec.ReadString(sSecao, 'cnpjAgntInteg', '');
          infoTSVInicio.infoComplementares.infoEstagiario.ageIntegracao.nmRazao       := INIRec.ReadString(sSecao, 'nmRazao', '');
          infoTSVInicio.infoComplementares.infoEstagiario.ageIntegracao.dscLograd     := INIRec.ReadString(sSecao, 'dscLograd', '');
          infoTSVInicio.infoComplementares.infoEstagiario.ageIntegracao.nrLograd      := INIRec.ReadString(sSecao, 'nrLograd', '');
          infoTSVInicio.infoComplementares.infoEstagiario.ageIntegracao.bairro        := INIRec.ReadString(sSecao, 'bairro', '');
          infoTSVInicio.infoComplementares.infoEstagiario.ageIntegracao.Cep           := INIRec.ReadString(sSecao, 'cep', '');
          infoTSVInicio.infoComplementares.infoEstagiario.ageIntegracao.codMunic      := INIRec.ReadInteger(sSecao, 'codMunic', 0);
          infoTSVInicio.infoComplementares.infoEstagiario.ageIntegracao.uf            := eSStrTouf(Ok, INIRec.ReadString(sSecao, 'uf', 'SP'));
        end;

        sSecao := 'supervisorEstagio';
        if INIRec.ReadString(sSecao, 'cpfSupervisor', '') <> '' then
        begin
          infoTSVInicio.infoComplementares.infoEstagiario.supervisorEstagio.cpfSupervisor := INIRec.ReadString(sSecao, 'cpfSupervisor', '');
          infoTSVInicio.infoComplementares.infoEstagiario.supervisorEstagio.nmSuperv      := INIRec.ReadString(sSecao, 'nmSuperv', '');
        end;
      end;

      sSecao := 'afastamento';
      if INIRec.ReadString(sSecao, 'dtIniAfast', '') <> '' then
      begin
        infoTSVInicio.afastamento.DtIniAfast  := StringToDateTime(INIRec.ReadString(sSecao, 'dtIniAfast', '0'));
        infoTSVInicio.afastamento.codMotAfast := eSStrTotpMotivosAfastamento(Ok, INIRec.ReadString(sSecao, 'codMotAfast', '00'));
      end;

      sSecao := 'termino';
      if INIRec.ReadString(sSecao, 'dtTerm', '') <> '' then
        infoTSVInicio.termino.dtTerm  := StringToDateTime(INIRec.ReadString(sSecao, 'dtTerm', '0'));
    end;

    GerarXML;
  finally
     INIRec.Free;
  end;
end;

end.
