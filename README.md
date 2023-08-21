# Aqua Sense

Aqua Sense is a Flutter mobile application designed to calculate and monitor water levels in a container based on user input and real-time data from a database.

## Features

- Input your container's height and radius to calculate water volume and percentage.
- Real-time monitoring of water level using Firebase database.
- Visual representation of water level using a circular progress bar.

## Screenshots

<pre>
<img src=https://github.com/keshavk4/random-mac-generator/assets/63634923/7bf9835e-5733-429e-98f9-82df1081a7c6 height=500>   <img src=https://github.com/keshavk4/random-mac-generator/assets/63634923/fbc2ceae-d018-4b56-8325-e88c4be23a3d height=500>
</pre><br>

## Getting Started

These instructions will help you get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Firebase Account: [Firebase Console](https://console.firebase.google.com/)

### Installation

1. Clone the repository:

   ```sh
   git clone https://github.com/keshavk4/aqua-sense-app.git
   ```

2. Navigate to the project directory:

   ```sh
   cd aqua-sense-app
   ```

3. Install the Flutter packages:

   ```sh
   flutter pub get
   ```

4. Configure Firebase:

   - Create a new Firebase project in the [Firebase Console](https://console.firebase.google.com/).
   - Add your Firebase configuration to the `android/app/google-services.json` and `ios/Runner/GoogleService-Info.plist` files.

5. Run the app:

   ```sh
   flutter run
   ```

## ESP32 Sensor Program

If you're interested in the ESP32 program that updates Firebase data using a sensor, you can check out the repository here: [ESP32 Sensor Program](https://github.com/keshavk4/aqua-sense-esp32)

This program complements the Aqua Sense app by providing real-time sensor data to update water level information in the Firebase database.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request if you find any bugs or want to add new features.

## License

This project is released under the [MIT License](https://opensource.org/license/mit). See [LICENSE](LICENSE) for more details.