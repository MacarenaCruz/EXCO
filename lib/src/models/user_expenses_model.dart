// To parse this JSON data, do
//
//     final usuarioGastos = usuarioGastosFromJson(jsonString);

import 'dart:convert';

UsuarioGastos usuarioGastosFromJson(String str) =>
    UsuarioGastos.fromJson(json.decode(str));

String usuarioGastosToJson(UsuarioGastos data) => json.encode(data.toJson());

class UsuarioGastos {
  UsuarioGastos(
      {required this.cleaningAmount,
      required this.cleaningDescription,
      required this.foodAmount,
      required this.foodDescription,
      required this.idexp,
      required this.studyAmount,
      required this.studyDescription,
      required this.totalAmount,
      required this.transportAmount,
      required this.transportDescription,
      required this.variousAmount,
      required this.variousDescription
      });

  num cleaningAmount = 0;
  String cleaningDescription = "";
  num foodAmount = 0;
  String foodDescription = "";
  String idexp;
  num studyAmount = 0;
  String studyDescription = "";
  num totalAmount = 0;
  num transportAmount = 0;
  String transportDescription = "";
  num variousAmount = 0;
  String variousDescription = "";

  factory UsuarioGastos.fromJson(Map<String, dynamic> json) => UsuarioGastos(
      cleaningAmount: json["user_cleaningAmount"],
       cleaningDescription: json["user_cleaningDescription"],
      foodAmount: json["user_foodAmount"],
      foodDescription: json["user_foodDescription"],
      idexp: json["user_idexp"],
      studyAmount: json["user_studyAmount"],
      studyDescription: json["user_studyDescription"],
      totalAmount: json["user_totalAmount"],
      transportAmount: json["user_transportAmount"],
      transportDescription: json["user_transportDescription"],
      variousAmount: json["user_variousAmount"],
       variousDescription: json["user_variousDescription"],
  );
  Map<String, dynamic> toJson() => {
        "user_cleaningAmount": cleaningAmount,
        "user_cleaningDescription": cleaningDescription,
        "user_foodAmount": foodAmount,
        "user_foodDescription": foodDescription,
        "user_idexp": idexp,
        "user_studyAmount": studyAmount,
        "user_studyDescription": studyDescription,
        "user_totalAmount": totalAmount,
        "user_transportAmount": transportAmount,
        "user_transportDescription": transportDescription,
        "user_variousAmount": variousAmount,
      };
}
