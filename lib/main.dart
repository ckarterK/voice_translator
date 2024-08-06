import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
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
      ),debugShowCheckedModeBanner: false,
      
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String? dropDownValue1;
  String? dropDownValue2;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: theme.primaryColor,
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 20.0),
                          child: Text(
                            'From...',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 10.0, 0.0),
                        child: Container(
                          width: 412.0,
                          height: 200.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(
                              width: 1.0,
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
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 0.0, 20.0),
                        child: Text(
                          'To...',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          10.0, 0.0, 10.0, 0.0),
                      child: Container(
                        width: 403.0,
                        height: 193.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(
                            width: 1.0,
                          ),
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 60.0, 0.0, 36.0),
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 140.0, 0.0),
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.black,
                                      size: 35.0,
                                    ),
                                  ),
                                  Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.mic,
                                        color: Colors.black,
                                        size: 30.0,
                                      ),
                                      onPressed: () {
                                        print('IconButton pressed ...');
                                      },
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
                                  margin: const EdgeInsetsDirectional.fromSTEB(
                                      25.0, 0.0, 0.0, 0.0),
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: DropdownButton<String>(
                                    value: dropDownValue1,
                                    isExpanded: true,
                                    underline: Container(),
                                    items: ['Option 1', 'Option 2', 'Option 3']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                            fontSize: 16.0, // Smaller font size
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    hint: const Text(
                                      'Please select',
                                      style: TextStyle(
                                        fontSize: 16.0, // Smaller font size
                                      ),
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        dropDownValue1 = val;
                                      });
                                    },
                                    style: theme.textTheme.bodyMedium,
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
                                  margin: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 10.0, 0.0),
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: DropdownButton<String>(
                                    value: dropDownValue2,
                                    isExpanded: true,
                                    underline: Container(),
                                    items: ['Option 1', 'Option 2', 'Option 3']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                            fontSize: 16.0, // Smaller font size
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    hint: const Text(
                                      'Please select',
                                      style: TextStyle(
                                        fontSize: 16.0, // Smaller font size
                                      ),
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        dropDownValue2 = val;
                                      });
                                    },
                                    style: theme.textTheme.bodyMedium,
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
