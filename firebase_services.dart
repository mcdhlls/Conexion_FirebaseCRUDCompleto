import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getUsuarios() async {
  List usuarios = [];
  CollectionReference collectionReferenceUsuarios = db.collection('usuarios');
  QuerySnapshot queryUsuarios = await collectionReferenceUsuarios.get();

  for (var documento in queryUsuarios.docs) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final usuario = {
      "uid": documento.id,
      "nombre": data['nombre'],
      "email": data['email'],
      "nocuenta": data['nocuenta'],
    };
    usuarios.add(usuario);
  }

  return usuarios;
}

Future<void> agregarUsuario(
    String nombre, String email, String nocuenta) async {
  await db.collection('usuarios').add({
    'nombre': nombre,
    'email': email,
    'nocuenta': nocuenta,
  });
}

Future<void> editUsuario(
    String uid, String nombre, String email, String nocuenta) async {
  await db.collection('usuarios').doc(uid).set({
    'nombre': nombre,
    'email': email,
    'nocuenta': nocuenta,
  });
}

Future<void> deleteUsuario(String uid) async {
  await db.collection('usuarios').doc(uid).delete();
}
