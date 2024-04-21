import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tarea_bandas/Routes/router.dart';
import 'firebase_options.dart';
import 'package:tarea_bandas/Routes/myroutes.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lift App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Material app',
        initialRoute: MyRoutes.login.name,
        routes: routes,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
          builder: (context) => PageNotFound(name: settings.name),
        );
      },
     );
    }
}

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key, required this.name});

  final String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('La ruta $name no existe'),
            ElevatedButton(
              onPressed: () {
               
                Navigator.pushReplacementNamed(context, MyRoutes.login.name);
                
              },
              child: const Text('Ir a la página principal'),
            ),
          ],
        ),
      ),
    );
  }
}

