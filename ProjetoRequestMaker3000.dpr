program ProjetoRequestMaker3000;

uses
  Vcl.Forms,
  RequestMaker3000 in 'RequestMaker3000.pas' {Form1},
  uJSON in '..\json-v-1-0-6\json\uJSON.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
