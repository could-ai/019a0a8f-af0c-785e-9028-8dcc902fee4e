import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hacker App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.green,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.green),
          bodyMedium: TextStyle(color: Colors.green),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.black,
          ),
        ),
      ),
      home: const HackerScreen(),
    );
  }
}

class HackerScreen extends StatefulWidget {
  const HackerScreen({super.key});

  @override
  State<HackerScreen> createState() => _HackerScreenState();
}

class _HackerScreenState extends State<HackerScreen> {
  bool _isHacking = false;
  final List<String> _hackingMessages = [];
  final ScrollController _scrollController = ScrollController();

  void _startHacking() {
    setState(() {
      _isHacking = true;
      _hackingMessages.clear();
    });

    _addMessage("Initiating hack sequence...");
    Future.delayed(const Duration(seconds: 1), () => _addMessage("Bypassing firewall..."));
    Future.delayed(const Duration(seconds: 2), () => _addMessage("Accessing main server..."));
    Future.delayed(const Duration(seconds: 3), () => _addMessage("Connection established."));
    Future.delayed(const Duration(seconds: 4), () => _addMessage("Downloading data... 10%"));
    Future.delayed(const Duration(seconds: 5), () => _addMessage("Downloading data... 35%"));
    Future.delayed(const Duration(seconds: 6), () => _addMessage("Downloading data... 78%"));
    Future.delayed(const Duration(seconds: 7), () => _addMessage("Downloading data... 100%"));
    Future.delayed(const Duration(seconds: 8), () => _addMessage("Data transfer complete."));
    Future.delayed(const Duration(seconds: 9), () => _addMessage("Erasing tracks..."));
    Future.delayed(const Duration(seconds: 10), () => _addMessage("Hack successful. Disconnecting."));
    Future.delayed(const Duration(seconds: 11), () {
      setState(() {
        _isHacking = false;
      });
    });
  }

  void _addMessage(String message) {
    if (!mounted) return;
    setState(() {
      _hackingMessages.add("> $message");
    });
    // Scroll to the bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hacker Terminal'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.green.withOpacity(0.5)),
                ),
                child: _hackingMessages.isNotEmpty
                    ? ListView.builder(
                        controller: _scrollController,
                        itemCount: _hackingMessages.length,
                        itemBuilder: (context, index) {
                          return Text(
                            _hackingMessages[index],
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          "Awaiting command...",
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: Colors.green,
                            fontSize: 18,
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isHacking ? null : _startHacking,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: Colors.green,
                disabledBackgroundColor: Colors.green.withOpacity(0.5),
              ),
              child: _isHacking
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'HACK IN PROGRESS...',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    )
                  : const Text(
                      'INITIATE HACK',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
