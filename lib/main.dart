import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_translator/ComboBoxController.dart';
import 'MicrophoneDesign.dart';
import 'ComboBoxDesign.dart';
import 'MicrophoneController.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => VoiceRecorder()),
        ChangeNotifierProvider(create: (context) => LanguageController()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        primaryColor: Colors.blue,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Readex Pro',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? translatedFromLanguage;
  String? translatedFromCode;
  String? translatedToLanguage;

  @override
  Widget build(BuildContext context) {
    final voiceRecorder = Provider.of<VoiceRecorder>(context);
    final languageController = Provider.of<LanguageController>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          width: 416.0,
          height: 912.0,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                child: Container(
                  width: 418.0,
                  height: 350.0,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(-1.0, -1.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 20.0),
                          child: Text(languageController.fromLanguage ??
                              'From...',
                              style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                        child: Container(
                          width: 412.0,
                          height: 200.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1.0,
                            ),
                          ),
                          child: Text(
                            voiceRecorder.transcription.isNotEmpty
                                ? voiceRecorder.transcription
                                : 'click and start recording',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 412.0,
                height: 3.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF403F3F),
                ),
              ),
              Container(
                width: 418.0,
                height: 488.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(-1.0, -1.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 20.0),
                        child: Text(
                          languageController.toLanguage  ?? 'To...',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                      child: Container(
                        width: 403.0,
                        height: 193.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1.0,
                          ),
                        ),
                        child: Text(
                          voiceRecorder.translation.isNotEmpty
                              ? voiceRecorder.translation
                              : '',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    Container(
                      width: 417.0,
                      height: 236.0,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 60.0, 0.0, 36.0),
                            child: Container(
                              width: 423.0,
                              height: 50.0,
                              decoration: const BoxDecoration(
                                color: Colors.white24,
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 140.0, 0.0),
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 35.0,
                                    ),
                                  ),
                                  MicrophoneDesign()
                                ],
                              ),
                            ),
                          ),
                          const LanguageSelection(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
