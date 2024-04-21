import 'package:flutter/material.dart';
import 'package:tarea_bandas/Routes/myroutes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  
  @override
  State<PantallaInicio> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<PantallaInicio> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final todasBandas = firestore.collection('BandasRock').snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 82, 71, 123),
        title: const Text('Votaciones', style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: todasBandas,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final listaBandas = snapshot.data!.docs;

            return ListView.builder(
              itemCount: listaBandas.length,
              itemBuilder: (context, index) {
                final banda = listaBandas[index];

                // Obtener la URL de la imagen de la banda
                final String? urlImagen = banda['URLimagen'] as String?;

                return Dismissible(
                  key: Key(banda.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction)
                   {
                    banda.reference.delete();
                  },
                  child: ListTile(
                    
                    leading: urlImagen != null
                        ? Image.network(
                            urlImagen,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) 
                            {  
                              return const Icon(Icons.image_not_supported, color: Colors.grey, size: 50);
                            },
                          )
                        : null,
                    title: Text(banda['Nombre']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(banda['Album']),
                        Text(banda['Lanzamiento']),
                      ],
                    ),
                    trailing: GestureDetector(
                      onTap: () {

                        if (urlImagen != null)
                        {
                             banda.reference.update({'Votos': (banda['Votos'] ?? 0) + 1});
                        }
                        else
                        {
                            
                        showDialog(context: context, 
                        builder: (BuildContext context)
                        {
                          return AlertDialog(
                                   title: const Text('Error'),
                                   content: const Text('No se puede votar por bandas sin foto de album'),
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
                        
                      },
                      child: Column(
                        children: [
                          const Icon(Icons.favorite_rounded, color: Colors.redAccent),
                          Text('${banda['Votos'] ?? 0}', style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           Navigator.pushReplacementNamed(context, MyRoutes.agregar.name);
        },
        tooltip: 'Nueva Banda',
        child: const Icon(Icons.add),
      ),
    );
  }
}
