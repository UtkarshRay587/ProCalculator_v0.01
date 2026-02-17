
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const ProCalculatorApp());
}

class ProCalculatorApp extends StatelessWidget {
  const ProCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProCalculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen>
    with SingleTickerProviderStateMixin {
  String input = "";
  String result = "0";
  bool showBirthday = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onButtonPressed(String value) {
    setState(() {
      if (value == "=") {
        if (input == "2712") {
          showBirthday = true;
          Timer(const Duration(seconds: 3), () {
            setState(() => showBirthday = false);
          });
        } else {
          result = input;
        }
        input = "";
      } else if (value == "C") {
        input = "";
        result = "0";
      } else {
        input += value;
      }
    });
  }

  Widget buildButton(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: GestureDetector(
          onTap: () => onButtonPressed(text),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(fontSize: 22),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    input.isEmpty ? result : input,
                    style: const TextStyle(fontSize: 48),
                  ),
                ),
              ),
              Column(
                children: [
                  Row(children: [buildButton("1"), buildButton("2"), buildButton("3")]),
                  Row(children: [buildButton("4"), buildButton("5"), buildButton("6")]),
                  Row(children: [buildButton("7"), buildButton("8"), buildButton("9")]),
                  Row(children: [buildButton("C"), buildButton("0"), buildButton("=")]),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "v0.01",
                style: TextStyle(fontSize: 12, color: Colors.white38),
              ),
              const SizedBox(height: 8),
            ],
          ),
          if (showBirthday)
            Center(
              child: FadeTransition(
                opacity: _controller,
                child: const Text(
                  "🎉 Happy Birthday Owner 🎉",
                  style: TextStyle(fontSize: 28, color: Colors.orange),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
