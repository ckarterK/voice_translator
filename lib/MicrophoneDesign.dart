import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MicrophoneController.dart'; // Import the VoiceRecorder class

class MicrophoneDesign extends StatelessWidget {
  const MicrophoneDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final voiceRecorder = Provider.of<VoiceRecorder>(context);

    return GestureDetector(
      onTap: () {
       
        voiceRecorder.clearTranscription();
        voiceRecorder.toggleRecording();
        print('Microphone icon pressed ...');
      },
      child: AnimatedContainer(
        width: 50.0,
        height: 50.0,
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          color: voiceRecorder.isRecording ? Colors.green : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black,
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
    );
  }
}
