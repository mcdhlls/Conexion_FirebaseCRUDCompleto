import 'package:flutter/material.dart';
import 'package:conexionfirebase/services/firebase_services.dart';

class EditUsuario extends StatefulWidget {
  const EditUsuario({super.key});

  @override
  State<EditUsuario> createState() => _EditUsuarioState();
}

class _EditUsuarioState extends State<EditUsuario> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nocuentaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    nombreController.text = arguments['nombre'];
    emailController.text = arguments['email'];
    nocuentaController.text = arguments['nocuenta'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: nocuentaController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'No. cuenta',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await editUsuario(
                    arguments['uid'],
                    nombreController.text,
                    emailController.text,
                    nocuentaController.text,
                  ).then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Usuario actualizado con éxito')),
                    );
                    Navigator.pop(context);
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $error')),
                    );
                  });
                },
                child: const Text('Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
