import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:nothing_glyph_interface/nothing_glyph_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late NothingGlyphInterface _glyphInterfacePlugin;

  @override
  void initState() {
    _glyphInterfacePlugin = NothingGlyphInterface();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                future: _glyphInterfacePlugin.is20111(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  return Text('Is Nothing Phone 1: ${snapshot.data}',
                      textAlign: TextAlign.center);
                },
              ),
              FutureBuilder(
                future: _glyphInterfacePlugin.is22111(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  return Text('Is Nothing Phone 2: ${snapshot.data}',
                      textAlign: TextAlign.center);
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  await _glyphInterfacePlugin.buildGlyphFrame(
                      GlyphFrameBuilder()
                          .buildChannelA()
                          .buildChannel(NothingPhone2.c3)
                          .buildPeriod(2000)
                          .buildCycles(3)
                          .buildInterval(1000)
                          .build());
                  await _glyphInterfacePlugin.animate();
                },
                child: const Text("Test"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
