unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  changepassword, FileUtil, process, Math;

type

  { TSettingForm }

  TSettingForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ChangePasswordButton: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ChangePasswordButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  SettingForm: TSettingForm;
  listNetProcess: TProcess;
  nets: TStringList;
  netsUpCommnd, netsDownCommnd: string;

implementation

{$R *.lfm}

{ TSettingForm }


procedure TSettingForm.FormCreate(Sender: TObject);

var
  CounterVar: integer;
begin
  listNetProcess := TProcess.Create(nil);
  listNetProcess.Executable := '/bin/sh';
  listNetProcess.Parameters.Add('-c');
  listNetProcess.Parameters.Add('ls /sys/class/net/');
  listNetProcess.Options := listNetProcess.Options + [poWaitOnExit, poUsePipes];
  listNetProcess.Execute;
  nets := TStringList.Create;
  nets.LoadFromStream(listNetProcess.Output);
  listNetProcess.Free;
  netsUpCommnd := '';
  netsDownCommnd := '';
  for CounterVar := 0 to Pred(nets.Count) do
  begin
    netsUpCommnd += 'sudo ifconfig ' + nets[CounterVar] + ' up;';
    netsDownCommnd += 'sudo ifconfig ' + nets[CounterVar] + ' down;';
  end;
end;

procedure TSettingForm.Button1Click(Sender: TObject);
var
  hProcess: TProcess;
begin
  // The following example will open fdisk in the background and give us partition information

  // Since fdisk requires elevated priviledges we need to
  // pass our password as a parameter to sudo using the -S
  // option, so it will will wait till our program sends our password to the sudo application
  hProcess := TProcess.Create(nil);
  // On Linux/Unix/FreeBSD/macOS, we need specify full path to our executable:
  hProcess.Executable := '/bin/sh';
  // Now we add all the parameters on the command line:
  hprocess.Parameters.Add('-c');
  // Here we pipe the password to the sudo command which then executes fdisk -l:
  hprocess.Parameters.add('pkexec pkexec bash -c "' + netsUpCommnd + '"');
  // Run asynchronously (wait for process to exit) and use pipes so we can read the output pipe
  hProcess.Options := hProcess.Options + [poWaitOnExit, poUsePipes];
  // Now run:
  hProcess.Execute;


  // Clean up to avoid memory leaks:
  hProcess.Free;
end;

procedure TSettingForm.Button2Click(Sender: TObject);
var
  hProcess: TProcess;
begin
  // The following example will open fdisk in the background and give us partition information

  // Since fdisk requires elevated priviledges we need to
  // pass our password as a parameter to sudo using the -S
  // option, so it will will wait till our program sends our password to the sudo application
  hProcess := TProcess.Create(nil);
  // On Linux/Unix/FreeBSD/macOS, we need specify full path to our executable:
  hProcess.Executable := '/bin/sh';
  // Now we add all the parameters on the command line:
  hprocess.Parameters.Add('-c');
  // Here we pipe the password to the sudo command which then executes fdisk -l:
  hprocess.Parameters.add('pkexec pkexec bash -c "' + netsDownCommnd + '"');
  // Run asynchronously (wait for process to exit) and use pipes so we can read the output pipe
  hProcess.Options := hProcess.Options + [poWaitOnExit, poUsePipes];
  // Now run:
  hProcess.Execute;


  // Clean up to avoid memory leaks:
  hProcess.Free;
end;

procedure TSettingForm.ChangePasswordButtonClick(Sender: TObject);
var
  AChangePasswordForm: TChangePasswordForm;
begin
  AChangePasswordForm:=TChangePasswordForm.Create(Self);
  AChangePasswordForm.ShowModal;

end;



end.
