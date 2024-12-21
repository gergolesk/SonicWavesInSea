object Form2: TForm2
  Left = 516
  Top = 302
  BorderStyle = bsDialog
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
  ClientHeight = 392
  ClientWidth = 269
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ValueListEditor1: TValueListEditor
    Left = 24
    Top = 72
    Width = 225
    Height = 265
    KeyOptions = [keyEdit]
    Strings.Strings = (
      '10='
      '12.5='
      '16='
      '20='
      '25='
      '31.5='
      '40='
      '50='
      '63='
      '80='
      '100='
      '125='
      '160='
      '200='
      '250='
      '315='
      '400='
      '500='
      '630='
      '800='
      '1000='
      '1250='
      '1600='
      '2000='
      '2500='
      '3150='
      '4000='
      '5000='
      '6300='
      '8000='
      '10000=')
    TabOrder = 0
    TitleCaptions.Strings = (
      #1063#1072#1089#1090#1086#1090#1072', '#1043#1094
      #1059#1089#1082#1086#1088#1077#1085#1080#1077)
    ColWidths = (
      70
      133)
  end
  object LabeledEdit1: TLabeledEdit
    Left = 24
    Top = 32
    Width = 201
    Height = 21
    EditLabel.Width = 141
    EditLabel.Height = 16
    EditLabel.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1084#1077#1093#1072#1085#1080#1079#1084#1072
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -13
    EditLabel.Font.Name = 'MS Sans Serif'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    TabOrder = 1
  end
  object Button1: TButton
    Left = 32
    Top = 352
    Width = 89
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 152
    Top = 352
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
  end
end
