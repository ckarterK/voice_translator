import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MicrophoneController.dart'; // Ensure this import is correct

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => VoiceRecorder(),
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
  String? translatedToCode;

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

  @override
  Widget build(BuildContext context) {
    final voiceRecorder = Provider.of<VoiceRecorder>(context);

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
                          child: Text(translatedFromLanguage??
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
                          child: Text(voiceRecorder.transcription.isNotEmpty 
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
                        child: Text(translatedToLanguage??
                          'To...',
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
                          color: Colors.grey[200],
                          border: Border.all(
                            width: 1.0,
                          ),
                        ),
                        child: Text(voiceRecorder.translation.isNotEmpty 
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
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 140.0, 0.0),
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.black,
                                      size: 35.0,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Clear transcription before starting new recording
                                      voiceRecorder.clearTranscription();
                                      // Update language code before toggling recording
                                      voiceRecorder.translatedFromCode = translatedFromCode ?? 'en-US';
                                       voiceRecorder.translatedToCode = translatedToCode ?? 'en-US';
                                      voiceRecorder.toggleRecording();
                                      print('Microphone icon pressed ...');
                                    },
                                    child: AnimatedContainer(
                                      width: 50.0,
                                      height: 50.0,
                                      duration: const Duration(milliseconds: 500),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.greenAccent,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.mic,
                                          color: Colors.black,
                                          size: 30.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 412.0,
                            height: 90.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                topRight: Radius.circular(25.0),
                              ),
                              border: Border.all(
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 150.0,
                                  height: 50.0,
                                  margin: const EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 0.0),
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: DropdownButton<String>(
                                    value: translatedFromCode,
                                    isExpanded: true,
                                    underline: Container(),
                                    items: translatedFromLanguages.map((lang) {
                                      return DropdownMenuItem<String>(
                                        value: lang['code'],
                                        child: Text(
                                          lang['language']!,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    hint: const Text(
                                      'Please select a Language',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        translatedFromCode = newValue;
                                        translatedFromLanguage = translatedFromLanguages.firstWhere((lang) => lang['code'] == newValue)['language'];
                                      });
                                    },
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    dropdownColor: Colors.white,
                                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                                  ),
                                ),
                                Container(
                                  width: 50.0,
                                  height: 55.0,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: const Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        Icons.arrow_back_sharp,
                                        color: Colors.black,
                                        size: 24.0,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_sharp,
                                        color: Colors.black,
                                        size: 24.0,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  height: 50.0,
                                  margin: const EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 0.0),
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: DropdownButton<String>(
                                    value: translatedToCode,
                                    isExpanded: true,
                                    underline: Container(),
                                    items: translatedToLanguages.map((lang) {
                                      return DropdownMenuItem<String>(
                                        value: lang['code'],
                                        child: Text(
                                          lang['language']!,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    hint: const Text(
                                      'Please select a Language',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        translatedToCode = newValue;
                                        translatedToLanguage = translatedToLanguages.firstWhere((lang) => lang['code'] == newValue)['language'];
                                      });
                                    },
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    dropdownColor: Colors.white,
                                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
