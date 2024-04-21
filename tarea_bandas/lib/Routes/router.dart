import 'package:flutter/material.dart';
import 'package:tarea_bandas/Pantallas/login.dart';
import 'package:tarea_bandas/Routes/myroutes.dart';
import 'package:tarea_bandas/Pantallas/pantallainicio.dart';
import 'package:tarea_bandas/Pantallas/agregarbanda.dart';


final Map<String, Widget Function(BuildContext)> routes = {
  MyRoutes.login.name: (context) => const Login(),
  MyRoutes.inicio.name: (context) => const PantallaInicio(),
  MyRoutes.agregar.name: (context) => Agregar()
};