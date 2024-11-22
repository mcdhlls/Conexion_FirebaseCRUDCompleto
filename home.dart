import 'package:flutter/material.dart';
import 'package:conexionfirebase/services/firebase_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conexión a Firebase (Agregar Usuarios)'),
      ),
      body: FutureBuilder<List>(
        future: getUsuarios(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(data[index]['uid']),
                  onDismissed: (direction) async {
                    await deleteUsuario(data[index]['uid']);
                    setState(() {
                      data.removeAt(index);
                    });
                  },
                  confirmDismiss: (direction) async {
                    bool result = false;
                    result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Confirmación'),
                          content: Text(
                              '¿Estás seguro de querer eliminar a ${data[index]['nombre']}?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text('Sí'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text('Cancelar',
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        );
                      },
                    );
                    return result;
                  },
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 16.0),
                  ),
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(data[index]['nombre']),
                      subtitle: Text(data[index]['email']),
                      leading: CircleAvatar(
                        child: Text(data[index]['nombre'].substring(0, 1)),
                      ),
                      onTap: () async {
                        await Navigator.pushNamed(context, '/edit', arguments: {
                          'uid': data[index]['uid'],
                          'nombre': data[index]['nombre'],
                          'email': data[index]['email'],
                          'nocuenta': data[index]['nocuenta'],
                        });
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
