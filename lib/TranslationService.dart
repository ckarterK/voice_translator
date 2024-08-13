// translation_service.dart
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis/translate/v3.dart';
import 'package:googleapis_auth/auth_io.dart';

class TranslationService {
  late final TranslateApi _api;

  TranslationService() {
    _initializeApi();
  }

  Future<void> _initializeApi() async {
    try {
      final credentials = await _loadCredentials();
      final authClient = await clientViaServiceAccount(
        credentials,
        [TranslateApi.cloudTranslationScope],
      );
      _api = TranslateApi(authClient);
    } catch (e) {
      throw Exception('Error initializing API: $e');
    }
  }

  Future<ServiceAccountCredentials> _loadCredentials() async {
    try {
      final jsonString = await rootBundle.loadString('assets/optical-pillar-431812-k3-03311e42dbb2.json');
      return ServiceAccountCredentials.fromJson(json.decode(jsonString));
    } catch (e) {
      throw Exception('Error loading credentials: $e');
    }
  }

  Future<String> translateText(String text, String targetLanguage) async {
    try {
      final request = TranslateTextRequest(
        contents: [text],
        targetLanguageCode: targetLanguage,
      );
      final response = await _api.projects.translateText(
        request,
        'projects/optical-pillar-431812-k3',
      );

      if (response.translations != null && response.translations!.isNotEmpty) {
        return response.translations!.first.translatedText ?? 'Translation error';
      } else {
        return 'No translation result';
      }
    } catch (e) {
      throw Exception('Error during translation: $e');
    }
  }
}
