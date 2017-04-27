//
// Created by the DataSnap proxy generator.
// 27/04/2017 16:08:09
//

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethods1Client = class(TDSAdminRestClient)
  private
    FDSServerModuleCreateCommand: TDSRestCommand;
    FGerarPDFCommand: TDSRestCommand;
    FGerarPDFCommand_Cache: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DSServerModuleCreate(Sender: TObject);
    function GerarPDF(out Size: Int64; const ARequestFilter: string = ''): TStream;
    function GerarPDF_Cache(out Size: Int64; const ARequestFilter: string = ''): IDSRestCachedStream;
  end;

const
  TServerMethods1_DSServerModuleCreate: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TServerMethods1_GerarPDF: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Size'; Direction: 2; DBXType: 18; TypeName: 'Int64'),
    (Name: ''; Direction: 4; DBXType: 33; TypeName: 'TStream')
  );

  TServerMethods1_GerarPDF_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Size'; Direction: 2; DBXType: 18; TypeName: 'Int64'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

implementation

procedure TServerMethods1Client.DSServerModuleCreate(Sender: TObject);
begin
  if FDSServerModuleCreateCommand = nil then
  begin
    FDSServerModuleCreateCommand := FConnection.CreateCommand;
    FDSServerModuleCreateCommand.RequestType := 'POST';
    FDSServerModuleCreateCommand.Text := 'TServerMethods1."DSServerModuleCreate"';
    FDSServerModuleCreateCommand.Prepare(TServerMethods1_DSServerModuleCreate);
  end;
  if not Assigned(Sender) then
    FDSServerModuleCreateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDSServerModuleCreateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDSServerModuleCreateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDSServerModuleCreateCommand.Execute;
end;

function TServerMethods1Client.GerarPDF(out Size: Int64; const ARequestFilter: string): TStream;
begin
  if FGerarPDFCommand = nil then
  begin
    FGerarPDFCommand := FConnection.CreateCommand;
    FGerarPDFCommand.RequestType := 'GET';
    FGerarPDFCommand.Text := 'TServerMethods1.GerarPDF';
    FGerarPDFCommand.Prepare(TServerMethods1_GerarPDF);
  end;
  FGerarPDFCommand.Execute(ARequestFilter);
  Size := FGerarPDFCommand.Parameters[0].Value.GetInt64;
  Result := FGerarPDFCommand.Parameters[1].Value.GetStream(FInstanceOwner);
end;

function TServerMethods1Client.GerarPDF_Cache(out Size: Int64; const ARequestFilter: string): IDSRestCachedStream;
begin
  if FGerarPDFCommand_Cache = nil then
  begin
    FGerarPDFCommand_Cache := FConnection.CreateCommand;
    FGerarPDFCommand_Cache.RequestType := 'GET';
    FGerarPDFCommand_Cache.Text := 'TServerMethods1.GerarPDF';
    FGerarPDFCommand_Cache.Prepare(TServerMethods1_GerarPDF_Cache);
  end;
  FGerarPDFCommand_Cache.ExecuteCache(ARequestFilter);
  Size := FGerarPDFCommand_Cache.Parameters[0].Value.GetInt64;
  Result := TDSRestCachedStream.Create(FGerarPDFCommand_Cache.Parameters[1].Value.GetString);
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FDSServerModuleCreateCommand.DisposeOf;
  FGerarPDFCommand.DisposeOf;
  FGerarPDFCommand_Cache.DisposeOf;
  inherited;
end;

end.

