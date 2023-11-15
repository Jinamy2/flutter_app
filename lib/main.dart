
import 'package:flutter/material.dart' ;
import 'package:hello_flutter/api.dart';
import 'package:hello_flutter/geo.dart';
import "package:hello_flutter/geroscop.dart";
import 'package:sensors/sensors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MobileApp",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 232, 13, 240)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Страшное приложение на парах Кирилла В.\n Но вроде уже лучше..вроде'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GyroscopeService gyroscopeService = GyroscopeService();
  int currentPageIndex = 0;
  String? currentPosition;
  @override
  Widget build(BuildContext context) {
    gyroscopeService.startListening();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor:const Color.fromARGB(255, 232, 13, 240),
          title: Text(
              widget.title
          ),
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.location_on),
              label: 'Геолокация',
            ),
            NavigationDestination(
              icon: Icon(Icons.timelapse),
              label: 'Гироскоп',
            ),
            
          ],
        ),
        body: <Widget>[
          Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: determinePosition(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
              
                  return Text(snapshot.data.toString());
                }
                return const CircularProgressIndicator();
              },
            ),
            FutureBuilder(
              future: createAndress(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.toString());
                }
                return const CircularProgressIndicator();
              },
            ),
            const Text(
              'Ничего не понимаю((((',
            ),
          ],
        ),
      ),
         Center(
        
          child: Column (
            children: <Widget>[
              const Text('Гироскоп'),
            StreamBuilder<GyroscopeEvent>(
            stream: gyroscopeEvents, 
            builder: (context, snapshot) {

            if (snapshot.hasData){
              return Text('x: ${snapshot.data!.x.toString()}\n y: ${snapshot.data!.y.toString()}\n z: ${snapshot.data!.z.toString()}\n');
            }
            else {
              return const CircularProgressIndicator();
            }
            
          },),
          const Text('Акселерометр'),
          StreamBuilder<AccelerometerEvent>(
            stream: accelerometerEvents, 
            builder: (context, snapshot) {

            if (snapshot.hasData){
              return Text('x: ${snapshot.data!.x.toString()}\n y: ${snapshot.data!.y.toString()}\n z: ${snapshot.data!.z.toString()}\n ${snapshot.data!.y > 9 ? 'Телефон стоит':'Телефон горизонт'}');
            }
            else {
              return const CircularProgressIndicator();
            }
            
          },)
          ]
          ),
        ),
          
        ][currentPageIndex]
    );
  }
}

