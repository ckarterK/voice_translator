import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/speech/v1.dart';

class TranscriptionService {
  final Future<ServiceAccountCredentials> credentialsFuture;

  TranscriptionService(this.credentialsFuture);

  Future<String> transcribeAudio(String filePath, String languageFromCode) async {
    try {
      final credentials = await credentialsFuture;
      final authClient = await clientViaServiceAccount(credentials, [SpeechApi.cloudPlatformScope]);
      final api = SpeechApi(authClient);

      final file = File(filePath);
      if (!await file.exists()) {
        debugPrint('Audio file does not exist at: $filePath');
        return 'File not found';
      }

      final audioBytes = file.readAsBytesSync();
      final base64String = base64Encode(audioBytes);
      debugPrint("Encoded audio: $base64String");

      final request = RecognitionAudio.fromJson({
        'content': base64String,
      });

      final config = RecognitionConfig(
        encoding: 'LINEAR16',
        languageCode: languageFromCode,
      );

      final response = await api.speech.recognize(
        RecognizeRequest(
          config: config,
          audio: request,
        ),
      );

      if (response.results != null && response.results!.isNotEmpty) {
        final transcript = response.results!
            .map((result) => result.alternatives!.first.transcript)
            .join(' ');
        return transcript;
      } else {
        debugPrint('No transcription result or empty response');
        return 'No transcription result';
      }
    } catch (e) {
      debugPrint('Error during transcription: $e');
      return 'Error during transcription';
    }
  }
}
