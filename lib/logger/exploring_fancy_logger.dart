import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ExploringLogger extends StatefulWidget {
  const ExploringLogger({Key? key}) : super(key: key);

  @override
  State<ExploringLogger> createState() => _ExploringLoggerState();
}

class _ExploringLoggerState extends State<ExploringLogger> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exploring logger',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            // Section for log with stack trace
            _buildLogSection(
              title: 'Log with Stack Trace',
              buttons: [
                _buildLogButton('Log 1 (Debug)', () {
                  logger.d('stack trace log 1', stackTrace: StackTrace.current);
                }),
                _buildLogButton('Log 2 (Error)', () {
                  logger.e('stack trace log 2', stackTrace: StackTrace.current);
                }),
                _buildLogButton('Log 3 (Fatal)', () {
                  logger.f('stack trace log 3', stackTrace: StackTrace.current);
                }),
                _buildLogButton('Log 4 (Info)', () {
                  logger.i('stack trace log 4', stackTrace: StackTrace.current);
                }),
                _buildLogButton('Log 5 (Trace)', () {
                  logger.t('stack trace log 5', stackTrace: StackTrace.current, error: const Text('here!'));
                }),
                _buildLogButton('Log 6 (Warning)', () {
                  logger.w('stack trace log 6', stackTrace: StackTrace.current);
                }),
              ],
            ),

            const Divider(
              height: 30,
            ),

            // Section for log without stack trace
            _buildLogSection(
              title: 'Log without Stack Trace',
              buttons: [
                _buildLogButton('Log 1 (Debug)', () {
                  loggerNoStack.d('Simple log 1 (Debug)');
                }),
                _buildLogButton('Log 2 (Error)', () {
                  loggerNoStack.e('Simple log 2 (Error)');
                }),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Note: 'loggerNoStack' has the same funcs exp .e .f .d... as 'logger' without a stack trace. do explore them :)",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogSection({required String title, required List<Widget> buttons}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.purpleAccent,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buttons,
        ),
      ],
    );
  }

  Widget _buildLogButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
