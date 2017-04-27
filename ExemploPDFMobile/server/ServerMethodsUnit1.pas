unit ServerMethodsUnit1;

interface

uses
  System.SysUtils, System.Classes, System.Json, Datasnap.DSServer,
  Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter, frxClass, frxExportPDF,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxDBSet;

type
  TServerMethods1 = class(TDSServerModule)
    frxReport1: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    FDMemTable1: TFDMemTable;
    FDMemTable1id: TIntegerField;
    FDMemTable1nome: TStringField;
    FDMemTable1valor: TFloatField;
    frxDBDataset1: TfrxDBDataset;
    procedure DSServerModuleCreate(Sender: TObject);
  private

  public
    function GerarPDF(out Size: Int64): TStream;
  end;

implementation


{$R *.dfm}


uses
  System.StrUtils;

procedure TServerMethods1.DSServerModuleCreate(Sender: TObject);
var
  I: Integer;
begin
  FDMemTable1.Close;
  FDMemTable1.CreateDataset;

  Randomize;
  for I := 1 to 50 do
    FDMemTable1.AppendRecord([I, Format('nome %d', [I]), Random(100)]);
end;

function TServerMethods1.GerarPDF(out Size: Int64): TStream;
var
  CaminhoPDF: String;
begin
  CaminhoPDF := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)) + 'PDF');
  ForceDirectories(CaminhoPDF);

  frxPDFExport1.FileName        := CaminhoPDF + 'Teste.pdf';
  frxPDFExport1.DefaultPath     := CaminhoPDF;
  frxPDFExport1.ShowDialog      := False;
  frxPDFExport1.ShowProgress    := False;
  frxPDFExport1.OverwritePrompt := False;

  frxReport1.PrepareReport();
  frxReport1.Export(frxPDFExport1);

  Result := TFileStream.Create(CaminhoPDF + 'Teste.pdf', fmOpenRead or fmShareDenyNone);
  Size   := Result.Size;

  Result.Position := 0;
end;

end.

