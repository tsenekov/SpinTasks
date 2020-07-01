unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Threading, Vcl.StdCtrls, Vcl.Samples.Gauges, Vcl.ExtCtrls;

type
  TfrmMain = class(TForm)
    GaugeAni: TGauge;
    btnLongQuery: TButton;
    Timer1: TTimer;
    procedure btnLongQueryClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    task: ITask;
    procedure ShowProgress(text: string);
    procedure AniEnabler(setstate: Boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnLongQueryClick(Sender: TObject);
begin
  if Assigned(task) and (task.Status = TTaskStatus.Running) then
    exit;

  // run sql query in thread
  task := TTask.Create(
    procedure()
    var
      id: integer;
    begin
      // start animation
      AniEnabler(true);

      // start long query here ...
      id := round(random(1000));
      ShowProgress('thread id #' + id.ToString + ': start sql query 1');
      Sleep(2000);
      ShowProgress('thread id #' + id.ToString + ': start sql query 2');
      Sleep(5000);
      ShowProgress('thread id #' + id.ToString + ': start sql query 3');
      Sleep(10000);
      ShowProgress('thread id #' + id.ToString + ': end sql query');

      // stop animation
      AniEnabler(false);
    end);

  task.Start;

end;

procedure TfrmMain.ShowProgress(text: string);
begin
  TThread.Synchronize(nil,
    procedure()
    begin
      caption := text;
    end);
end;

procedure TfrmMain.AniEnabler(setstate: Boolean);
begin
  TThread.Synchronize(nil,
    procedure()
    begin
      Timer1.Enabled := setstate;
      if not setstate then
        GaugeAni.Progress := 0;
    end);
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(task) and (task.Status = TTaskStatus.Running) then
  begin
    CanClose := false;
    ShowMessage('Task in progress. Please wait');
  end
  else
    CanClose := true;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  GaugeAni.Progress := GaugeAni.Progress + 1;
  if GaugeAni.Progress >= GaugeAni.MaxValue then
    GaugeAni.Progress := GaugeAni.MinValue;
end;

end.
