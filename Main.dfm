object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Demo'
  ClientHeight = 132
  ClientWidth = 589
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object GaugeAni: TGauge
    Left = 8
    Top = 8
    Width = 129
    Height = 107
    Progress = 0
  end
  object btnLongQuery: TButton
    Left = 176
    Top = 32
    Width = 377
    Height = 57
    Caption = 'Start long SQL Query'
    TabOrder = 0
    OnClick = btnLongQueryClick
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer1Timer
    Left = 8
    Top = 64
  end
end
