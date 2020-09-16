unit loginform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Unit1;

type

  { TALoginForm }

  TALoginForm = class(TForm)
    LoginButton: TButton;
    PasswordField: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure LoginButtonClick(Sender: TObject);
  private

  public

  end;

var
  ALoginForm: TALoginForm;
  UserDir: string;
  ConfigFileName: string;

implementation

{$R *.lfm}

{ TALoginForm }

procedure TALoginForm.FormCreate(Sender: TObject);
var
  DefaultPassword: TStringList;

begin
  UserDir := GetUserDir;
  ConfigFileName := '.putixin.conf';

  if not FileExists(UserDir + ConfigFileName) then
  begin
    DefaultPassword := TStringList.Create;
    DefaultPassword.Text := 'putixin123';
    DefaultPassword.SaveToFile(UserDir + ConfigFileName);
  end;

end;

procedure TALoginForm.LoginButtonClick(Sender: TObject);
var
  Password: TStringList;
  ASettingForm: TSettingForm;
begin
  Password := TStringList.Create;
  Password.LoadFromFile(UserDir + ConfigFileName);

  if Trim(PasswordField.Text) = Trim(Password.Text) then
  begin
    ASettingForm := TSettingForm.Create(Self);
    ASettingForm.Show;
    self.Hide;
  end
  else
  begin
    ShowMessage('Password Wrong!');
  end;

end;

end.
