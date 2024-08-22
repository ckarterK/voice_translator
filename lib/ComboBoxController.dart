import 'package:flutter/material.dart';

class LanguageController with ChangeNotifier {
  String? translatedFromCode;
  String? translatedToCode;
  String? translatedFromLanguage;
  String? translatedToLanguage;

  final List<Map<String, String>> translatedFromLanguages = [
    {'language': 'Zulu', 'code': 'zu-ZA'},
    {'language': 'Xhosa', 'code': 'xh-ZA'},
    {'language': 'Venda', 'code': 've-ZA'},
    {'language': 'Tswana', 'code': 'tn-Latn-ZA'},
    {'language': 'Tsonga', 'code': 'ts-ZA'},
    {'language': 'Swati', 'code': 'ss-Latn-ZA'},
    {'language': 'Southern Sotho', 'code': 'st-ZA'},
    {'language': 'English', 'code': 'en-ZA'},
    {'language': 'Afrikaans', 'code': 'af-ZA'},
    {'language': 'German', 'code': 'de-DE'},
  ];

  final List<Map<String, String>> translatedToLanguages = [
    {'language': 'Zulu', 'code': 'zu'},
    {'language': 'Xhosa', 'code': 'xh'},
    {'language': 'Tsonga', 'code': 'ts'},
    {'language': 'Southern Sotho', 'code': 'st'},
    {'language': 'English', 'code': 'en'},
    {'language': 'Afrikaans', 'code': 'af'},
    {'language': 'German', 'code': 'de'},
  ];
  


  void setTranslatedFromLanguage(String? code) {
    translatedFromCode = code;
    translatedFromLanguage = translatedFromLanguages.firstWhere((lang) => lang['code'] == code)['language'];
    notifyListeners();
  }

  void setTranslatedToLanguage(String? code) {
    translatedToCode = code;
    translatedToLanguage = translatedToLanguages.firstWhere((lang) => lang['code'] == code)['language'];
    notifyListeners();
  }
    String? get fromLanguage => translatedFromLanguage;
    String? get toLanguage => translatedToLanguage;
    String? get fromCode => translatedFromLanguage;
    String? get toCode => translatedToLanguage;
 
}
