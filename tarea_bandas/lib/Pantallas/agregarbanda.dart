import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:tarea_bandas/Routes/myroutes.dart';
import 'package:tarea_bandas/Widgets/custominput.dart';

class Agregar extends StatefulWidget {
  Agregar({Key? key}) : super(key: key);

  @override
  _AgregarState createState() => _AgregarState();
}

class _AgregarState extends State<Agregar> {
  final _formKey = GlobalKey<FormState>();
  final storage = FirebaseStorage.instance.ref();

  final nombreController = TextEditingController(text: '');
  final albumController = TextEditingController(text: '');
  final lanzamientoController = TextEditingController(text: '');
  final votosController = 0;
  String? urlImagen;
  bool imageUploaded = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Nueva Banda'),
        leading: IconButton(
          onPressed: imageUploaded ? null : () {
            Navigator.pushReplacementNamed(context, MyRoutes.inicio.name);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomInput(
                  controller: nombreController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre';
                    }
                    return null;
                  },
                  obscureText: false,
                  labelText: 'Nombre de la banda',
                  prefixIcon: const Icon(Icons.music_note),
                  bordes: const OutlineInputBorder(),
                ),
                const SizedBox(height: 16.0),
                CustomInput(
                  controller: albumController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre del álbum';
                    }
                    return null;
                  },
                  obscureText: false,
                  labelText: 'Nombre del álbum',
                  prefixIcon: const Icon(Icons.library_music),
                  hintText: 'Nombre del álbum de la banda',
                  bordes: const OutlineInputBorder(),
                ),
                const SizedBox(height: 16.0),
                CustomInput(
                  controller: lanzamientoController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la fecha de lanzamiento';
                    }
                    return null;
                  },
                  obscureText: false,
                  labelText: 'Fecha de Lanzamiento',
                  hintText: 'DD/MM/YY',
                  prefixIcon: const Icon(Icons.date_range),
                  bordes: const OutlineInputBorder(),
                ),
                ElevatedButton(
                  onPressed: imageUploaded ? null : () async {
                    final ImagePicker picker = ImagePicker();
                    XFile? image = await picker.pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      Reference imagenRef = storage.child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
                      try {
                        await imagenRef.putFile(File(image.path));
                        urlImagen = await imagenRef.getDownloadURL();

                        setState(() {
                          imageUploaded = true;
                        });

                        // ignore: use_build_context_synchronously
                        showDialog(context: context, 
                        builder: (BuildContext context)
                        {
                          return AlertDialog(
                                   title: const Text('Imagen Subida'),
                                   content: const Text('Su imagen fue subida con exito'),
                                   actions: <Widget>[
                                            TextButton(
                                                onPressed: () {
                                                      Navigator.of(context).pop();
                                                        },
                                    child: const Text('Aceptar'),
                               ),
                             ]
                         );
                         },
                        );
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        showDialog(context: context, 
                        builder: (BuildContext context)
                        {
                          return AlertDialog(
                                   title: const Text('Error'),
                                   content: const Text('Su imagen presento un error al subirse'),
                                   actions: <Widget>[
                                            TextButton(
                                                onPressed: () {
                                                      Navigator.of(context).pop();
                                                        },
                                    child: const Text('Aceptar'),
                               ),
                             ]
                         );
                         },
                        );
                      }
                    }
                  },
                  child: const Text('Subir foto del álbum (Opcional)'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    final instance = FirebaseFirestore.instance;

                    if (_formKey.currentState!.validate()) {
                      final query = await instance.collection('BandasRock').where('Nombre', isEqualTo: nombreController.text.trim()).get();
                      final quero = await instance.collection('BandasRock').where('Album', isEqualTo: albumController.text.trim()).get();

                      if (query.docs.isEmpty && quero.docs.isEmpty) {
                        final data = {
                            'Nombre': nombreController.text,
                            'Album': albumController.text,
                            'Lanzamiento': lanzamientoController.text,
                            'Votos': votosController,
                            'URLimagen': urlImagen, 
                        };

                        await instance.collection('BandasRock').add(data);
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(context, MyRoutes.inicio.name);
                      } else {
                        // ignore: use_build_context_synchronously
                        showDialog(context: context, 
                        builder: (BuildContext context)
                        {
                          return AlertDialog(
                                   title: const Text('Error'),
                                   content: const Text('Ya existe una banda con el mismo nombre o album'),
                                   actions: <Widget>[
                                            TextButton(
                                                onPressed: () {
                                                      Navigator.of(context).pop();
                                                        },
                                    child: const Text('Aceptar'),
                               ),
                             ]
                         );
                         },
                        );
                      }
                    }
                  },
                  child: const Text('Agregar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
