import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_translator/ComboBoxController.dart';
import 'package:voice_translator/MicrophoneController.dart';

class LanguageSelection extends StatelessWidget {
  const LanguageSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageController = Provider.of<LanguageController>(context);
    final voiceRecorder = Provider.of<VoiceRecorder>(context);


    return Container(
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
              value: languageController.translatedFromCode,
              isExpanded: true,
              underline: Container(),
              items: languageController.translatedFromLanguages.map((lang) {
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
                languageController.setTranslatedFromLanguage(newValue);
                voiceRecorder.translatedFromCode=newValue!;
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
              value: languageController.translatedToCode,
              isExpanded: true,
              underline: Container(),
              items: languageController.translatedToLanguages.map((lang) {
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
                languageController.setTranslatedToLanguage(newValue);
                voiceRecorder.translatedToCode=newValue!;

              },
              style: Theme.of(context).textTheme.bodyMedium,
              dropdownColor: Colors.white,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
