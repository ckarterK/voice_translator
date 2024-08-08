import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:googleapis/speech/v1.dart';
import 'package:flutter/services.dart' show rootBundle;

class VoiceRecorder extends ChangeNotifier {
  final AudioRecorder _record = AudioRecorder();
  bool _isRecording = false;
  String _filePath = '';
  String _transcription = '';
  
  late final Future<ServiceAccountCredentials> _credentialsFuture;

  VoiceRecorder() {
    _credentialsFuture = _loadCredentials();
    _checkPermission();
  }

  Future<ServiceAccountCredentials> _loadCredentials() async {
    try {
      final jsonString = await rootBundle.loadString('assets/optical-pillar-431812-k3-03311e42dbb2.json');
      final credentials = ServiceAccountCredentials.fromJson(json.decode(jsonString));
      return credentials;
    } catch (e) {
      debugPrint('Error loading credentials: $e');
      rethrow;
    }
  }

  Future<void> _checkPermission() async {
    try {
      bool hasPermission = await _record.hasPermission();
      if (!hasPermission) {
        debugPrint('Microphone permission denied');
      }
    } catch (e) {
      debugPrint('Error checking microphone permission: $e');
    }
  }

  Future<void> toggleRecording() async {
    try {
      if (_isRecording) {
        final filePath = await _record.stop();
        if (filePath != null) {
          _filePath = filePath;
          debugPrint('Recording stopped, saved to: $_filePath');
          await _transcribeAudio();
        } else {
          debugPrint('Failed to stop recording');
        }
      } else {
        if (await _record.hasPermission()) {
          Directory appDocDir = await getApplicationDocumentsDirectory();
          String appDocPath = appDocDir.path;
          String path = '$appDocPath/audio_record.wav'; // Ensure file extension matches the encoding

          await _record.start(
            const RecordConfig(
              encoder: AudioEncoder.wav, // Make sure this matches your recording format
              sampleRate: 16000,
              numChannels: 1, // Adjust according to your recording settings
            ),
            path: path,
          );
          debugPrint('Recording started');
        } else {
          debugPrint('Permission denied, cannot start recording');
        }
      }

      _isRecording = !_isRecording;
      notifyListeners(); // Use notifyListeners to update listeners instead of setState
    } catch (e) {
      debugPrint('Error during recording: $e');
    }
  }

  Future<void> _transcribeAudio() async {
    try {
      final credentials = await _credentialsFuture;
      final authClient = await clientViaServiceAccount(credentials, [SpeechApi.cloudPlatformScope]);
      final api = SpeechApi(authClient);

      final file = File(_filePath);
      if (!await file.exists()) {
        debugPrint('Audio file does not exist at: $_filePath');
        return;
      }

      final audioBytes = file.readAsBytesSync();
      final base64String = base64Encode(audioBytes);
      debugPrint("Encoded audio: $base64String");

      final request = RecognitionAudio.fromJson({
        'content': base64String, // Correct base64 encoding used here
      });

      final config = RecognitionConfig(
        encoding: 'LINEAR16', // Ensure this matches your file format
        languageCode: 'en-US',
      );

      final response = await api.speech.recognize(
        RecognizeRequest(
          config: config,
          audio: request,
        ),
      );

      if (response.results != null && response.results!.isNotEmpty) {
        debugPrint('Response: ${response.toJson()}');
        response.results!.forEach((result) {
          result.alternatives!.forEach((alternative) {
            debugPrint('Alternative transcript: ${alternative.transcript}');
          });
        });
        final transcript = response.results!
            .map((result) => result.alternatives!.first.transcript)
            .join(' ');
        _transcription = transcript;
        notifyListeners(); // Notify listeners of state change
        debugPrint('Transcription: $_transcription');
      } else {
        debugPrint('No transcription result or empty response');
      }
    } catch (e) {
      debugPrint('Error during transcription: $e');
    }
  }

  String get transcription => _transcription; // Add getter for transcription

  @override
  void dispose() {
    _record.dispose(); // Clean up resources if necessary
    super.dispose();
  }
}
