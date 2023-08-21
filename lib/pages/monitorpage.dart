import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:percent_indicator/percent_indicator.dart';

// Creating a Stateful Widget for the Monitor Page
class MonitorPage extends StatefulWidget {

  // Constructor that takes in 3 required parameters
  const MonitorPage(
      {Key? key,
      required this.title,
      required this.height,
      required this.radius})
      : super(key: key);

  // Properties for the widget
  final String title;
  final double height;
  final double radius;

  @override
  MonitorPageState createState() => MonitorPageState();
}

// Creating a State object for the MonitorPage widget
class MonitorPageState extends State<MonitorPage> {
  // Instance variable for a database reference object
  late DatabaseReference _database;

  // Variables for storing volume and percentage data
  double _emptyHeight = 0.0;
  double _emptyVolume = 0.0;
  double _totalVolume = 0.0;
  double _filledVolume = 0.0;
  int _percentage = 0;
  Color _barColor = Colors.blue;

  // Boolean value to keep track of database availability
  bool _isDatabaseAvialable = false;

  // Function to return the data value
  returnDataValue(var data) {
    return data;
  }

  // Function to calculate the volume and percentage data based on database values
  void calculateVolume() {
    _database.onValue.listen((DatabaseEvent event) {
      if (mounted) {
        setState(() {
          final value = event.snapshot.value;
          _emptyHeight = double.parse(returnDataValue(value).toString());
          _emptyVolume =
              (22 / 7) * (widget.radius * widget.radius) * _emptyHeight;
          _emptyVolume =
              _emptyVolume <= _totalVolume ? _emptyVolume : _totalVolume;
          _filledVolume = _totalVolume - _emptyVolume;
          _percentage = ((_filledVolume * 100) / _totalVolume).round();
          _barColor = _percentage >= 80 ? Colors.red : Colors.blue;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // Ensuring that the widgets are initialized before initializing Firebase
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp().whenComplete(() {
      // Updating the state to reflect the availability of the database and setting up the database reference
      setState(() {
        _isDatabaseAvialable = true;
        _database = FirebaseDatabase.instance.ref("Distance/value");
        _totalVolume =
            (22 / 7) * (widget.radius * widget.radius) * widget.height;
      });

      // Calling the calculateVolume function if the database is available
      if (_isDatabaseAvialable) calculateVolume();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Creating an app bar with the title
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display a circular progress bar using the CircularPercentIndicator widget.
              CircularPercentIndicator(
                radius: 120,
                lineWidth: 20.0,
                // animation: true,
                percent: double.parse("0.$_percentage"),
                // Display the percentage inside the center of the progress bar.
                center: Text(
                  "$_percentage%",
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                ),
                // Round the ends of the progress bar.
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: _barColor,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Display the total volume value as text.
                    const Text(
                      "Total Volume: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      _totalVolume.toStringAsFixed(2),
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ]),
              const SizedBox(
                height: 7,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Display the current level value as text.
                    const Text(
                      "Current Level: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      _filledVolume.toStringAsFixed(2),
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ]),
              const SizedBox(
                height: 7,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Display a text label indicating the remaining volume.
                    const Text(
                      "Remaining: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      _emptyVolume.toStringAsFixed(2),
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
