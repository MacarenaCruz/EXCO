import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gastos_foraneo/src/Widgets/Graphs/graphpie_widget.dart';
import 'package:provider/provider.dart';

import '../Providers/main_provider.dart';
import '../Widgets/BottomMenu/bottom_menu_widget.dart';
import '../Widgets/Graphs/graphlinear_widget.dart';
import '../models/user_expenses_model.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

List<UsuarioGastos> listgst = [];

UsuarioGastos gst = UsuarioGastos(
     cleaningAmount: 0,
      cleaningDescription: "",
      foodAmount: 0,
      foodDescription: "",
      idexp: "",
      studyAmount: 0,
      studyDescription: "",
      totalAmount: 0,
      transportAmount: 0,
      transportDescription: "",
      variousAmount: 0,
      variousDescription: "");

class _InformationPageState extends State<InformationPage> {
  String yeardata = "0";
  int currentPage = DateTime.now().month - 1;
  @override
  void dispose() {
    super.dispose();
    listgst.clear();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    CollectionReference clientegastos = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(mainProvider.token)
        .collection("expenses");
    var streamBuilderGastos = clientegastos.snapshots();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05),
              child: Text(
                "Grafica de Ingresos",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            StreamBuilder(
              stream: streamBuilderGastos,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                  case ConnectionState.none:
                  default:
                    return Stack(
                        children: snapshot.data!.docs.map((gastos) {
                      gst = UsuarioGastos.fromJson(
                          gastos.data() as Map<String, dynamic>);
                      if (listgst.isEmpty || listgst.length <= 12) {
                        listgst.add(gst);
                      }
                      num total = gst.cleaningAmount +
                          gst.foodAmount +
                          gst.studyAmount +
                          gst.transportAmount +
                          gst.variousAmount;

                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.1),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width,
                              child:
                                  (listgst.isNotEmpty && listgst.length == 12)
                                      ? LinearGraphWidget(
                                          incomeData: [
                                            listgst[0].totalAmount.toDouble(),
                                            listgst[1].totalAmount.toDouble(),
                                            listgst[2].totalAmount.toDouble(),
                                            listgst[3].totalAmount.toDouble(),
                                            listgst[4].totalAmount.toDouble(),
                                            listgst[5].totalAmount.toDouble(),
                                            listgst[6].totalAmount.toDouble(),
                                            listgst[7].totalAmount.toDouble(),
                                            listgst[8].totalAmount.toDouble(),
                                            listgst[9].totalAmount.toDouble(),
                                            listgst[10].totalAmount.toDouble(),
                                            listgst[11].totalAmount.toDouble(),
                                          ],
                                        )
                                      : Container(),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width,
                            child: GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                              ),
                              itemCount: 11,
                              itemBuilder: (BuildContext context, int index) {
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text((index == 0)
                                          ? "Enero"
                                          : (index == 1)
                                              ? "Febrero"
                                              : (index == 2)
                                                  ? "Marzo"
                                                  : (index == 3)
                                                      ? "Abril"
                                                      : (index == 4)
                                                          ? "Mayo"
                                                          : (index == 5)
                                                              ? "Junio"
                                                              : (index == 6)
                                                                  ? "Julio"
                                                                  : (index == 7)
                                                                      ? "Agosto"
                                                                      : (index ==
                                                                              8)
                                                                          ? "Septiembre"
                                                                          : (index == 9)
                                                                              ? "Octubre"
                                                                              : (index == 10)
                                                                                  ? "Noviembre"
                                                                                  : (index == 11)
                                                                                      ? "Diciembre"
                                                                                      : ""),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.45,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.95,
                                        child: PieGraphWidget(
                                          incomeData: [
                                            listgst[index]
                                                .totalAmount
                                                .toDouble(),
                                            listgst[index]
                                                .foodAmount
                                                .toDouble(),
                                            listgst[index]
                                                .cleaningAmount
                                                .toDouble(),
                                            listgst[index]
                                                .studyAmount
                                                .toDouble(),
                                            listgst[index]
                                                .transportAmount
                                                .toDouble(),
                                            listgst[index]
                                                .variousAmount
                                                .toDouble()
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList());
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomMenuWidget(selectedIndex: 2),
    );
  }
}
