import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gastos_foraneo/src/Providers/main_provider.dart';
import 'package:gastos_foraneo/src/models/user_expenses_model.dart';
import 'package:provider/provider.dart';

import '../Widgets/BottomMenu/bottom_menu_widget.dart';
import '../Widgets/utils/dialog_ulit.dart';
import '../services/auth.services.dart';
import '../../Core/Colors/Hex_Color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controllerTextLimp = TextEditingController();
  TextEditingController controllerTextComi = TextEditingController();
  TextEditingController controllerTextEstu = TextEditingController();
  TextEditingController controllerTextTota = TextEditingController();
  TextEditingController controllerTextTrasn = TextEditingController();
  TextEditingController controllerTextVario = TextEditingController();

  bool isVisible = true;

  AuthServices auth = AuthServices();
  PageController _controller = PageController();
  int currentPage = DateTime.now().month - 1;
  String tipodepago = "";
  String yeardata = "0";
  bool hasDataf = true;
  FirebaseFirestore dataUserFuture = FirebaseFirestore.instance;
  UsuarioGastos usrgst = UsuarioGastos(
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
  @override
  void initState() {
    super.initState();
    hasDataf = true;
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    CollectionReference clientegastos = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(mainProvider.token)
        .collection("expenses");
    _editParamGastos(String type, String newValue) {
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
      (type == "limpieza")
          ? gst.cleaningAmount = num.parse(newValue)
          : (type == "comida")
              ? gst.foodAmount = num.parse(newValue)
              : (type == "estudio")
                  ? gst.studyAmount = num.parse(newValue)
                  : (type == "transporte")
                      ? gst.transportAmount = num.parse(newValue)
                      : (type == "varios")
                          ? gst.variousAmount = num.parse(newValue)
                          : (type == "fondos")
                              ? gst.totalAmount = num.parse(newValue)
                              : gst.totalAmount;
      clientegastos
          .doc("exp" + mainProvider.token + yeardata)
          .update((type == "limpieza")
              ? {
                  'user_cleaningAmount': num.parse(newValue),
                }
              : (type == "comida")
                  ? {
                      'user_foodAmount': num.parse(newValue),
                    }
                  : (type == "estudio")
                      ? {
                          'user_studyAmount': num.parse(newValue),
                        }
                      : (type == "transporte")
                          ? {
                              'user_transportAmount': num.parse(newValue),
                            }
                          : (type == "varios")
                              ? {
                                  'user_variousAmount': num.parse(newValue),
                                }
                              : (type == "fondos")
                                  ? {
                                      'user_totalAmount': num.parse(newValue),
                                    }
                                  : {});
    }

    _editDescriptionGastos(String type, String newValue) {
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
      (type == "limpieza")
          ? gst.cleaningDescription = newValue
          : (type == "comida")
              ? gst.foodDescription = newValue
              : (type == "estudio")
                  ? gst.studyDescription = newValue
                  : (type == "transporte")
                      ? gst.transportDescription = newValue
                      : (type == "varios")
                          ? gst.variousDescription = newValue
                          : gst.totalAmount;
      clientegastos
          .doc("exp" + mainProvider.token + yeardata)
          .update((type == "limpieza")
              ? {
                  'user_cleaningDescription': num.parse(newValue),
                }
              : (type == "comida")
                  ? {
                      'user_foodDescription': num.parse(newValue),
                    }
                  : (type == "estudio")
                      ? {
                          'user_studyDescription': num.parse(newValue),
                        }
                      : (type == "transporte")
                          ? {
                              'user_transportDescription': num.parse(newValue),
                            }
                          : (type == "varios")
                              ? {
                                  'user_variousDescription':
                                      num.parse(newValue),
                                }
                              : {});
    }

    TextEditingController _amountcontroller = TextEditingController();
    TextEditingController _descriptioncontroller = TextEditingController();
    _alertDialog(String type, TextEditingController controller) {
      DialogUtils.showAlertWithCustomActions(context, "", [
        (type != "reporte")
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Agrege un nuevo monto a $type"),
                      controller: _amountcontroller,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^[1-9][\.\d]*(,\d+)?$')),
                      ],
                      onTap: () {
                        _amountcontroller.clear();
                      },
                      onChanged: (value) {
                         setState(() {
                          if (type != "reporte" && value != "") {
                            _editDescriptionGastos(type, value);
                          }
                        });
                      },
                      onFieldSubmitted: (newValue) {
                        setState(() {
                          if (type != "reporte" && newValue != "") {
                            _editParamGastos(type, newValue);
                          }
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Agrege una descriptiocn para $type"),
                      controller: _descriptioncontroller,
                      keyboardType: TextInputType.multiline,
                      onTap: () {
                        _descriptioncontroller.clear();
                      },
                      onChanged: (newValue){
                         setState(() {
                          if (type != "reporte" && newValue != "") {
                            _editDescriptionGastos(type, newValue);
                          }
                        });
                      },
                      onFieldSubmitted: (newValue) {
                        setState(() {
                          if (type != "reporte" && newValue != "") {
                            _editDescriptionGastos(type, newValue);
                          }
                        });
                      },
                    ),
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                      },
                      child: Text("Enviar"))
                ],
              )
            : Row(
                children: [
                  OutlinedButton(
                      onPressed: () {
                        auth.userNonthReport(
                            mainProvider.token, yeardata, usrgst);
                        Navigator.pop(context, 'OK');
                      },
                      child: Text("Enviar")),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                        // print("gasos " + controllerTextEstu.toString());
                      },
                      child: Text("Cancelar")),
                ],
              )
      ]);
    }

    var streamBuilderGastos = clientegastos
        .where("user_idexp", isEqualTo: "exp" + mainProvider.token + yeardata)
        .snapshots();

    Widget _selector() {
      return SizedBox.fromSize(
        size: Size.fromHeight(70.0),
        child: PageView(
          onPageChanged: (newPage) {
            setState(() {
              yeardata = newPage.toString();
              streamBuilderGastos = clientegastos
                  .where("user_idexp",
                      isEqualTo: "exp" + mainProvider.token + yeardata)
                  .snapshots();
            });
          },
          controller: _controller,
          children: <Widget>[
            _pageItem("------- Enero -------", 0),
            _pageItem("------- Febrero -------", 1),
            _pageItem("------- Marzo -------", 2),
            _pageItem("------- Abril -------", 3),
            _pageItem("------- Mayo -------", 4),
            _pageItem("------- Junio -------", 5),
            _pageItem("------- Julio -------", 6),
            _pageItem("------- Augosto -------", 7),
            _pageItem("----- Septiembre -----", 8),
            _pageItem("------- Octubre -------", 9),
            _pageItem("------ Noviembre ------", 10),
            _pageItem("------ Diciembre ------", 11),
          ],
        ),
      );
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Pagina Principal"),
      // ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 50.0)),
          Container(
              height: MediaQuery.of(context).size.height.round() * 0.1,
              width: MediaQuery.of(context).size.width.round() * 0.97,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.1, 0.4, 0.7, 0.9],
                    colors: [
                      HexColor("#4b4293").withOpacity(0.4),
                      HexColor("#4b4293").withOpacity(0.4),
                      HexColor("#08418e").withOpacity(0.4),
                      HexColor("#08418e").withOpacity(0.4)
                    ],
                  )),
              child: Image.asset('assets/gasto.png')),
          _selector(),
          Visibility(
            visible: isVisible,
            child: OutlinedButton(
                onPressed: () {
                  tipodepago = "reporte";
                  _alertDialog(tipodepago, controllerTextTota);
                },
                child: Text("Generar un Nuevo Reporte")),
          ),
          StreamBuilder(
              stream: streamBuilderGastos,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data?.docs.length == 0) {
                  isVisible = true;
                } else if (snapshot.data?.docs.length != 0) {
                  isVisible = false;
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.active:

                  case ConnectionState.none:
                  default:
                    if (snapshot.data?.docs.length == 0) {
                      hasDataf = false;
                    } else {
                      hasDataf = true;
                    }
                }

                return Column(
                    children: snapshot.data!.docs.map((gastos) {
                  var gasto = UsuarioGastos.fromJson(
                      gastos.data() as Map<String, dynamic>);

                  usrgst = gasto;

                  num total = gasto.cleaningAmount +
                      gasto.foodAmount +
                      gasto.studyAmount +
                      gasto.transportAmount +
                      gasto.variousAmount;

                  return Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            gasto.totalAmount.toString(),
                            style: (total > gasto.totalAmount)
                                ? TextStyle(
                                    fontSize: 50,
                                    color: Color.fromARGB(244, 203, 28, 89))
                                : TextStyle(
                                    fontSize: 50,
                                    color: Color.fromARGB(145, 1, 182, 122)),
                          ),
                          Text(
                            "Fondos",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Card(
                            child: Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              children: [
                                Card(
                                  child: ListTile(
                                    onTap: () {
                                      tipodepago = "limpieza";
                                      _alertDialog(
                                          tipodepago, controllerTextLimp);
                                    },
                                    leading: Icon(Icons.wash),
                                    title: const Text("Limpieza"),
                                    subtitle: Text(
                                        (usrgst.cleaningDescription != "")
                                            ? usrgst.cleaningDescription
                                            : "Sin Descipcion"),
                                    trailing: Text(
                                        gasto.cleaningAmount.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall),
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    onTap: () {
                                      tipodepago = "comida";
                                      _alertDialog(
                                          tipodepago, controllerTextComi);
                                    },
                                    leading: Icon(Icons.food_bank),
                                    title: const Text("Comida"),
                                    subtitle: Text(
                                        (usrgst.foodDescription != "")
                                            ? usrgst.foodDescription
                                            : "Sin Descipcion"),
                                    trailing: Text(gasto.foodAmount.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall),
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    onTap: () {
                                      tipodepago = "estudio";
                                      _alertDialog(
                                          tipodepago, controllerTextComi);
                                    },
                                    leading: Icon(Icons.book),
                                    title: const Text("Estudios"),
                                    subtitle: Text(
                                        (usrgst.studyDescription != "")
                                            ? usrgst.studyDescription
                                            : "Sin Descipcion"),
                                    trailing: Text(gasto.studyAmount.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall),
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    onTap: () {
                                      tipodepago = "transporte";
                                      _alertDialog(
                                          tipodepago, controllerTextComi);
                                    },
                                    leading: Icon(Icons.bus_alert),
                                    title: const Text("Transporte"),
                                    subtitle: Text(
                                        (usrgst.transportDescription != "")
                                            ? usrgst.transportDescription
                                            : "Sin Descipcion"),
                                    trailing: Text(
                                        gasto.transportAmount.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall),
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    onTap: () {
                                      tipodepago = "varios";
                                      _alertDialog(
                                          tipodepago, controllerTextComi);
                                    },
                                    leading: Icon(Icons.festival),
                                    title: const Text("Varios"),
                                    subtitle: Text(
                                        (usrgst.variousDescription != "")
                                            ? usrgst.variousDescription
                                            : "Sin Descipcion"),
                                    trailing: Text(
                                        gasto.variousAmount.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      OutlinedButton(
                          onPressed: () {
                            tipodepago = "fondos";
                            _alertDialog(tipodepago, controllerTextTota);
                          },
                          child: Text("Agregar Fondos ")),
                    ],
                  );
                }).toList());
              }),
        ],
      )),
      bottomNavigationBar: const BottomMenuWidget(selectedIndex: 1),
    );
  }

  Widget _pageItem(String name, int position) {
    var _alignment;
    final selected = TextStyle(
      fontSize: 40.0,
      fontWeight: FontWeight.normal,
      //fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 15, 14, 40).withOpacity(0.7),
    );
    final unselected = TextStyle(
      fontSize: 40.0,
      fontWeight: FontWeight.normal,
      color: Color.fromARGB(255, 15, 14, 40).withOpacity(0.7),
    );

    if (position == currentPage) {
      _alignment = Alignment.center;
    } else if (position > currentPage) {
      _alignment = Alignment.center;
    } else {
      _alignment = Alignment.center;
    }

    return Align(
      alignment: _alignment,
      child: Text(
        name,
        style: position == currentPage ? selected : unselected,
      ),
    );
  }
}

class MyFormWidget extends StatefulWidget {
  @override
  _MyFormWidgetState createState() => _MyFormWidgetState();
}

class _MyFormWidgetState extends State<MyFormWidget> {
  final _formKey = GlobalKey<FormState>();

  void _resetForm() {
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: _resetForm,
            child: Text('Reset'),
          ),
        ],
      ),
    );
  }
}
