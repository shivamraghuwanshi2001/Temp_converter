import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TemperatureConverterScreen(),
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  @override
  _TemperatureConverterScreenState createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState extends State<TemperatureConverterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      appBar: AppBar(
        title: const Text('Temperature Converter'),
      ),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: ConverterWidget(),
        ),
      ),
    );
  }
}

class ConverterWidget extends StatefulWidget {
  @override
  _ConverterWidgetState createState() => _ConverterWidgetState();
}

class _ConverterWidgetState extends State<ConverterWidget> {
  final TextEditingController _celsiusController = TextEditingController();
  final TextEditingController _fahrenheitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Temperature Converter',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _celsiusController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Celsius'),
          ),
          const SizedBox(height: 40),
          TextField(
            controller: _fahrenheitController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Fahrenheit'),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              convert();
            },
            child: const Text('Convert'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, minimumSize: Size(200, 75)),
          ),
        ],
      ),
    );
  }

  void convert() {
    if (_celsiusController.text.isEmpty) return;
    final celsius = double.parse(_celsiusController.text);
    final fahrenheit = (celsius * 9 / 5) + 32;
    _fahrenheitController.text = fahrenheit.toStringAsFixed(2);
  }
}
