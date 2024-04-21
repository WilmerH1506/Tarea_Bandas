import 'package:flutter/material.dart';
import 'package:tarea_bandas/Routes/myroutes.dart';



class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 82, 71, 123),
      appBar: AppBar(
        title: const Text(
          'Votacion de Bandas',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 82, 71, 123),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.25,
                margin: const EdgeInsets.only(left: 2.5, top: 250),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                           const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                               'Bienvenido a las Votaciones de Bandas',
                               style: TextStyle(fontSize: 16),
                             ),
                            ],
                           ),
                            const SizedBox(height: 20),
                           const Icon(Icons.how_to_vote, size: 40,),
                           const SizedBox(height: 30),
                           ElevatedButton(onPressed: () {

                              Navigator.pushReplacementNamed(context, MyRoutes.inicio.name);
                           } , 
                           child: const Text('Presione aqui para ingresar'))
                         
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
