import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:voice_translator/TranslationService.dart';
import 'package:voice_translator/TranscriptionService.dart'; // Import the new class

class VoiceRecorder extends ChangeNotifier {
  final AudioRecorder _record = AudioRecorder();
  bool _isRecording = false;
  String _filePath = '';
  String _transcription = '';
  String _translation = '';
  bool get isRecording => _isRecording;

  late final Future<ServiceAccountCredentials> _credentialsFuture;
  final TranslationService _translationService = TranslationService();
  late final TranscriptionService _transcriptionService;

  VoiceRecorder() {
    _credentialsFuture = _loadCredentials();
    _transcriptionService = TranscriptionService(_credentialsFuture);
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
          String path = '$appDocPath/audio_record.wav';

          await _record.start(
            const RecordConfig(
              encoder: AudioEncoder.wav,
              sampleRate: 16000,
              numChannels: 1,
            ),
            path: path,
          );
          debugPrint('Recording started');
        } else {
          debugPrint('Permission denied, cannot start recording');
        }
      }

      _isRecording = !_isRecording;
      notifyListeners();
    } catch (e) {
      debugPrint('Error during recording: $e');
    }
  }

  String _languageFromCode = 'en-US';
  String _languageToCode = 'en-US';

  set translatedFromCode(String code) {
    _languageFromCode = code;
    notifyListeners();
  }

  set translatedToCode(String code) {
    _languageToCode = code;
    notifyListeners();
  }

  Future<void> _transcribeAudio() async {
    try {
      final transcript = await _transcriptionService.transcribeAudio(_filePath, _languageFromCode);
      _transcription = transcript;
      notifyListeners();

      final translatedText = await _translationService.translateText(transcript, _languageToCode);
      _translation = translatedText;
      debugPrint('Translated Text: $translatedText');
    } catch (e) {
      debugPrint('Error during transcription: $e');
    }
  }

  void clearTranscription() {
    _transcription = '';
    notifyListeners();
  }

  String get transcription => _transcription;
  String get translation => _translation;

  @override
  void dispose() {
    _record.dispose();
    super.dispose();
  }
}
