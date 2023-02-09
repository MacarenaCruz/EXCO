import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gastos_foraneo/src/Providers/main_provider.dart';
import 'package:gastos_foraneo/src/models/user_model.dart';
import 'package:provider/provider.dart';

import '../Widgets/BottomMenu/bottom_menu_widget.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  CollectionReference cliente =
      FirebaseFirestore.instance.collection('usuarios');

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil de usuario"),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: cliente
                .where("user_id", isEqualTo: mainProvider.token)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                  children: snapshot.data!.docs.map((usuarios) {
                var usuario =
                    Usuario.fromJson(usuarios.data() as Map<String, dynamic>);
                return Container(
                  child: Card(
                      child: Column(
                    children: [
                      ListTile(
                          leading: Icon(Icons.email),
                          title: Text(
                            usuario.correo,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          trailing: IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined)),
                          ),
                        
                      ListTile(
                          leading: Icon(Icons.person),
                          title: Text(
                            usuario.name,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                           trailing: IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined)),
                          ),
                          ListTile(
                          leading: Icon(Icons.phone),
                          title: Text(
                            usuario.phone,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                           trailing: IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined)),
                          ),
                    ],
                  )),
                );
              }).toList());
            }),
      ),
      bottomNavigationBar: const BottomMenuWidget(selectedIndex: 0),
    );
  }
  _editParam(String type){


    

  }
}