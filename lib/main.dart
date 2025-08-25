import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'routes.dart';
import 'package:provider/provider.dart';
import 'stores.dart';

void main() {
  runApp(
    MultiProvider(
      providers: AppStores.providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> _checkPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions were denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6B589C)),
      ),
      initialRoute: '/login',
      routes: {
        ...AppRoutes.routes,
        '/location': (context) => FutureBuilder(
          future: _checkPermissions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Scaffold(
                body: Center(child: Text('Error: ${snapshot.error}')),
              );
            }

            return const LocationPage();
          },
        ),
      },
    );
  }
}

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  /// Copy coordinates to clipboard
  void _copyLocation(Position pos, BuildContext context) {
    Clipboard.setData(
      ClipboardData(text: "${pos.latitude}, ${pos.longitude}"),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Coordinates copied")),
    );
  }

  /// Copy Google Maps URL to clipboard
  void _copyGoogleMapsUrl(Position pos, BuildContext context) {
    final url =
        "https://www.google.com/maps/search/?api=1&query=${pos.latitude},${pos.longitude}";
    Clipboard.setData(ClipboardData(text: url));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("URL copied")),
    );
  }

  /// Share Google Maps URL
  void _shareLocation(Position pos) {
    final url =
        "https://www.google.com/maps/search/?api=1&query=${pos.latitude},${pos.longitude}";
    Share.share("Here is my location 📍: $url");
  }

  /// Open in Google Maps (app if installed, otherwise browser)
  Future<void> _openInGoogleMaps(Position pos) async {
    final googleMapsAppUri = Uri.parse(
        "geo:${pos.latitude},${pos.longitude}?q=${pos.latitude},${pos.longitude}");

    final googleMapsWebUri = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=${pos.latitude},${pos.longitude}");

    if (await canLaunchUrl(googleMapsAppUri)) {
      await launchUrl(googleMapsAppUri, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(googleMapsWebUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Real-time Location')),
      body: StreamBuilder<Position>(
        stream: Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation, // ✅ Highest accuracy
            distanceFilter: 1, // Updates every meter
          ),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final pos = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Lat: ${pos.latitude}, Lng: ${pos.longitude}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => _copyLocation(pos, context),
                    icon: const Icon(Icons.copy),
                    label: const Text("Copy coordinates"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () => _copyGoogleMapsUrl(pos, context),
                    icon: const Icon(Icons.link),
                    label: const Text("Copy URL"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () => _shareLocation(pos),
                    icon: const Icon(Icons.share),
                    label: const Text("Share location"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () => _openInGoogleMaps(pos),
                    icon: const Icon(Icons.map),
                    label: const Text("Open in Google Maps"),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Waiting for location...'));
          }
        },
      ),
    );
  }
}