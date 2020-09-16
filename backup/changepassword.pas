unit changepassword;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TChangePasswordForm }

  TChangePasswordForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  ChangePasswordForm: TChangePasswordForm;

implementation

{$R *.lfm}

{ TChangePasswordForm }

procedure TChangePasswordForm.Button2Click(Sender: TObject);
begin
  self.Hide;
end;

procedure TChangePasswordForm.Button1Click(Sender: TObject);
var
  UserDir, ConfigFileName: string;
  Password: TStringList;
begin
  UserDir := GetUserDir;
  ConfigFileName := '.putixin.conf';

  Password := TStringList.Create;
  Password.LoadFromFile(UserDir + ConfigFileName);

  if Trim(Edit1.Text) = Trim(Password.Text) then
  begin
    if trim(Edit2.Text) <> '' and trim(Edit2.Text) = trim(Edit3.Text) then
    begin
     ShowMessage('Success!');
     Password.Text:= trim(Edit2.Text);
     Password.SaveToFile(UserDir + ConfigFileName);
     Self.Hide;
    end
    else
    begin
      ShowMessage('两次输入密码不正确!');
    end;
  end
  else
  begin
    ShowMessage('旧密码错误!');
  end;
end;

end.

