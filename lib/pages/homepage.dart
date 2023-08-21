import 'package:flutter/material.dart';
import 'package:aquasense/pages/monitorpage.dart';

// Creating a Stateful Widget for the Home Page
class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController radiusController = TextEditingController();
  double _height = 0.00;
  double _radius = 0.00;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // The title of the app bar
        centerTitle: true, // Whether to center the title in the app bar
      ),
      body: Container(
        color: Colors.black, // The background color of the container
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: heightController, // The controller for the height input field
              style: const TextStyle(color: Colors.white),
              // The decoration for the input field
              decoration: const InputDecoration(
                  labelText: "Height",
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.blue),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
              obscureText: false,
            ),
            TextFormField(
              controller: radiusController, // The controller for the radius input field
              style: const TextStyle(color: Colors.white),
              // The decoration for the input field
              decoration: const InputDecoration(
                  labelText: "Radius",
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.blue),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                try {
                    _height = double.parse(heightController.text.toString()); // Parse the height input field's text as a double
                    _radius = double.parse(radiusController.text.toString()); // Parse the radius input field's text as a double
                } catch (e) {
                    _height = 1.00;
                    _radius = 1.00;
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MonitorPage(
                        title: "Monitor Page",  // The title for the MonitorPage
                        height: _height,  // The height value to pass to MonitorPage
                        radius: _radius,  // The radius value to pass to MonitorPage
                      ),
                    ));
              },
              child: Container(
                  width: MediaQuery.of(context).size.width, // The width of the container
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
