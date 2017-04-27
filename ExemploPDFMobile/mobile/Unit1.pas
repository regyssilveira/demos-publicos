unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  ClientModuleUnit1, FMX.Controls.Presentation, FMX.StdCtrls,

  System.IOUtils, FMX.Objects, FMX.ListBox, FMX.Layouts, FMX.TabControl,
  FMX.Edit;

type
  TForm1 = class(TForm)
    Button1: TButton;
    lblMensagem: TLabel;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  xPlat.OpenPDF;

procedure TForm1.Button1Click(Sender: TObject);
var
  RetStream : TStream;
  Buffer    : PByte;
  Mem       : TMemoryStream;
  BytesRead : Integer;
  Size      : Int64;
  Filename  : String;
  BufSize   : Integer;
  Destino   : String;
begin
  CM.DSRestConnection1.Host := Edit1.Text;

  BufSize := 1024;
  try
    Mem := TMemoryStream.Create;
    GetMem(Buffer, BufSize);
    try
      FileName := 'Teste.pdf';
      RetStream := CM.ServerMethods1Client.GerarPDF(Size);
      RetStream.Position := 0;
      if (Size <> 0) then
      begin
        FileName := 'Teste.pdf';
        repeat
          BytesRead := RetStream.Read(Pointer(Buffer)^, BufSize);
          if (BytesRead > 0) then
            Mem.WriteBuffer(Pointer(Buffer)^, BytesRead);
          Application.ProcessMessages;
        until (BytesRead < BufSize);

        Destino := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath, FileName);
        Mem.SaveToFile(Destino);

        OpenPDF('Teste.pdf');
        if (Size <> Mem.Size) then
          raise Exception.Create( 'Erro ao baixar...' );
      end;
    finally
      FreeMem(Buffer, BufSize);
      FreeAndNIl(Mem);
    end;
  except
    on E: Exception do
      lblMensagem.Text := PChar( E.ClassName + ': ' + E.Message );
  end;
end;

end.
