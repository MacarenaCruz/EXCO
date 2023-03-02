import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'dart:developer' as dev;
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Providers/main_provider.dart';
import '../Widgets/utils/dialog_ulit.dart';
import '../models/user_expenses_model.dart';
import '../models/user_model.dart';

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      //'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  signUpWithEmail(String email, String password, BuildContext context) async {
    try {
      dev.log(email.toString());
      dev.log(password.toString());
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        userSetup(email, value.user!.uid);

        DialogUtils.showAlertAndSendLoginScreen(
            context, "Usuario creado correctamente");
      });
    } catch (e) {
      DialogUtils.showAlertAndSendLoginScreen(
          context, "Error al crear el usuario");
      dev.log(e.toString());
    }
  }

  loginWithEmail(String email, String password, BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        mainProvider.token = value.user!.uid;
        DialogUtils.showAlertAndSendHomeScreen(
            context, "Ha ingresado exitosamente");
      });
    } catch (e) {
      DialogUtils.showAlertAndSendLoginScreen(
          context, "La contraseña o el correo estan incorrectos");
      dev.log(e.toString());
    }
  }

  logoutGoogle(BuildContext context) async {
    await _googleSignIn.signOut().then((value) =>
        DialogUtils.showAlertAndSendLoginScreen(
            context, "Ha salido exitosamente"));
  }

  loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        dev.log(userCredential.toString());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }
  }

//Crud para la creacion de usuario
  Future<void> userSetup(String email, String uid) async {
    Usuario usr = Usuario(correo: email, id: "", name: "", phone: "");
    UsuarioGastos usrgst = UsuarioGastos(
        cleaningAmount: 0,
        cleaningDescription: "",
        foodAmount: 0,
        foodDescription: "",
        idexp: "exp" + uid + "0",
        studyAmount: 0,
        studyDescription: "",
        totalAmount: 0,
        transportAmount: 0,
        transportDescription: "",
        variousAmount: 0,
        variousDescription: "");
    FirebaseFirestore.instance.collection('usuarios').doc(uid).set({
      'user_email': usr.correo,
      'user_id': uid,
      'user_name': usr.name,
      'user_phone': usr.phone,
    });
    FirebaseFirestore.instance
        .collection("usuarios")
        .doc(uid)
        .collection("expenses")
        .doc("exp$uid" + "0")
        .set({
      "user_cleaningAmount": usrgst.cleaningAmount,
      "user_cleaningDescription": usrgst.cleaningDescription,
      "user_foodAmount": usrgst.foodAmount,
      "user_foodDescription": usrgst.foodDescription,
      "user_idexp": usrgst.idexp,
      "user_studyAmount": usrgst.studyAmount,
      "user_studyDescription": usrgst.studyDescription,
      "user_totalAmount": usrgst.totalAmount,
      "user_transportAmount": usrgst.transportAmount,
      "user_transportDescription": usrgst.transportDescription,
      "user_variousAmount": usrgst.variousAmount,
      "user_variousDescription": usrgst.variousDescription,
    });
    FirebaseFirestore.instance
        .collection("usuarios")
        .doc(uid)
        .collection("expenses")
        .doc("exp$uid" + "1")
        .set({
      "user_cleaningAmount": usrgst.cleaningAmount,
      "user_cleaningDescription": usrgst.cleaningDescription,
      "user_foodAmount": usrgst.foodAmount,
      "user_foodDescription": usrgst.foodDescription,
      "user_idexp": "exp$uid" + "1",
            "user_studyAmount": usrgst.studyAmount,
      "user_studyDescription": usrgst.studyDescription,
      "user_totalAmount": usrgst.totalAmount,
      "user_transportAmount": usrgst.transportAmount,
      "user_transportDescription": usrgst.transportDescription,
      "user_variousAmount": usrgst.variousAmount,
      "user_variousDescription": usrgst.variousDescription,
    });
    FirebaseFirestore.instance
        .collection("usuarios")
        .doc(uid)
        .collection("expenses")
        .doc("exp$uid" + "2")
        .set({
      "user_cleaningAmount": usrgst.cleaningAmount,
      "user_cleaningDescription": usrgst.cleaningDescription,
      "user_foodAmount": usrgst.foodAmount,
      "user_foodDescription": usrgst.foodDescription,
      "user_idexp": "exp$uid" + "2",
           "user_studyAmount": usrgst.studyAmount,
      "user_studyDescription": usrgst.studyDescription,
      "user_totalAmount": usrgst.totalAmount,
      "user_transportAmount": usrgst.transportAmount,
      "user_transportDescription": usrgst.transportDescription,
      "user_variousAmount": usrgst.variousAmount,
      "user_variousDescription": usrgst.variousDescription,
    });
    FirebaseFirestore.instance
        .collection("usuarios")
        .doc(uid)
        .collection("expenses")
        .doc("exp$uid" + "3")
        .set({
      "user_cleaningAmount": usrgst.cleaningAmount,
      "user_cleaningDescription": usrgst.cleaningDescription,
      "user_foodAmount": usrgst.foodAmount,
      "user_foodDescription": usrgst.foodDescription,
      "user_idexp": "exp$uid" + "3",
           "user_studyAmount": usrgst.studyAmount,
      "user_studyDescription": usrgst.studyDescription,
      "user_totalAmount": usrgst.totalAmount,
      "user_transportAmount": usrgst.transportAmount,
      "user_transportDescription": usrgst.transportDescription,
      "user_variousAmount": usrgst.variousAmount,
      "user_variousDescription": usrgst.variousDescription,
    });
    FirebaseFirestore.instance
        .collection("usuarios")
        .doc(uid)
        .collection("expenses")
        .doc("exp$uid" + "4")
        .set({
      "user_cleaningAmount": usrgst.cleaningAmount,
      "user_cleaningDescription": usrgst.cleaningDescription,
      "user_foodAmount": usrgst.foodAmount,
      "user_foodDescription": usrgst.foodDescription,
      "user_idexp": "exp$uid" + "4",
           "user_studyAmount": usrgst.studyAmount,
      "user_studyDescription": usrgst.studyDescription,
      "user_totalAmount": usrgst.totalAmount,
      "user_transportAmount": usrgst.transportAmount,
      "user_transportDescription": usrgst.transportDescription,
      "user_variousAmount": usrgst.variousAmount,
      "user_variousDescription": usrgst.variousDescription,
    });
    FirebaseFirestore.instance
        .collection("usuarios")
        .doc(uid)
        .collection("expenses")
        .doc("exp$uid" + "5")
        .set({
      "user_cleaningAmount": usrgst.cleaningAmount,
      "user_cleaningDescription": usrgst.cleaningDescription,
      "user_foodAmount": usrgst.foodAmount,
      "user_foodDescription": usrgst.foodDescription,
      "user_idexp": "exp$uid" + "5",
           "user_studyAmount": usrgst.studyAmount,
      "user_studyDescription": usrgst.studyDescription,
      "user_totalAmount": usrgst.totalAmount,
      "user_transportAmount": usrgst.transportAmount,
      "user_transportDescription": usrgst.transportDescription,
      "user_variousAmount": usrgst.variousAmount,
      "user_variousDescription": usrgst.variousDescription,
    });
    FirebaseFirestore.instance
        .collection("usuarios")
        .doc(uid)
        .collection("expenses")
        .doc("exp$uid" + "6")
        .set({
      "user_cleaningAmount": usrgst.cleaningAmount,
      "user_cleaningDescription": usrgst.cleaningDescription,
      "user_foodAmount": usrgst.foodAmount,
      "user_foodDescription": usrgst.foodDescription,
      "user_idexp": "exp$uid" + "6",
            "user_studyAmount": usrgst.studyAmount,
      "user_studyDescription": usrgst.studyDescription,
      "user_totalAmount": usrgst.totalAmount,
      "user_transportAmount": usrgst.transportAmount,
      "user_transportDescription": usrgst.transportDescription,
      "user_variousAmount": usrgst.variousAmount,
      "user_variousDescription": usrgst.variousDescription,
    });
    FirebaseFirestore.instance
        .collection("usuarios")
        .doc(uid)
        .collection("expenses")
        .doc("exp$uid" + "7")
        .set({
      "user_cleaningAmount": usrgst.cleaningAmount,
      "user_cleaningDescription": usrgst.cleaningDescription,
      "user_foodAmount": usrgst.foodAmount,
      "user_foodDescription": usrgst.foodDescription,
      "user_idexp": "exp$uid" + "7",
           "user_studyAmount": usrgst.studyAmount,
      "user_studyDescription": usrgst.studyDescription,
      "user_totalAmount": usrgst.totalAmount,
      "user_transportAmount": usrgst.transportAmount,
      "user_transportDescription": usrgst.transportDescription,
      "user_variousAmount": usrgst.variousAmount,
      "user_variousDescription": usrgst.variousDescription,
    });
    FirebaseFirestore.instance
        .collection("usuarios")
        .doc(uid)
        .collection("expenses")
        .doc("exp$uid" + "8")
        .set({
      "user_cleaningAmount": usrgst.cleaningAmount,
      "user_cleaningDescription": usrgst.cleaningDescription,
      "user_foodAmount": usrgst.foodAmount,
      "user_foodDescription": usrgst.foodDescription,
      "user_idexp": "exp$uid" + "8",
           "user_studyAmount": usrgst.studyAmount,
      "user_studyDescription": usrgst.studyDescription,
      "user_totalAmount": usrgst.totalAmount,
      "user_transportAmount": usrgst.transportAmount,
      "user_transportDescription": usrgst.transportDescription,
      "user_variousAmount": usrgst.variousAmount,
      "user_variousDescription": usrgst.variousDescription,
    });
    FirebaseFirestore.instance
        .collection("usuarios")
        .doc(uid)
        .collection("expenses")
        .doc("exp$uid" + "9")
        .set({
      "user_cleaningAmount": usrgst.cleaningAmount,
      "user_cleaningDescription": usrgst.cleaningDescription,
      "user_foodAmount": usrgst.foodAmount,
      "user_foodDescription": usrgst.foodDescription,
      "user_idexp": "exp$uid" + "9",
           "user_studyAmount": usrgst.studyAmount,
      "user_studyDescription": usrgst.studyDescription,
      "user_totalAmount": usrgst.totalAmount,
      "user_transportAmount": usrgst.transportAmount,
      "user_transportDescription": usrgst.transportDescription,
      "user_variousAmount": usrgst.variousAmount,
      "user_variousDescription": usrgst.variousDescription,
    });
    FirebaseFirestore.instance
        .collection("usuarios")
        .doc(uid)
        .collection("expenses")
        .doc("exp$uid" + "10")
        .set({
      "user_cleaningAmount": usrgst.cleaningAmount,
      "user_cleaningDescription": usrgst.cleaningDescription,
      "user_foodAmount": usrgst.foodAmount,
      "user_foodDescription": usrgst.foodDescription,
      "user_idexp": "exp$uid" + "10",
            "user_studyAmount": usrgst.studyAmount,
      "user_studyDescription": usrgst.studyDescription,
      "user_totalAmount": usrgst.totalAmount,
      "user_transportAmount": usrgst.transportAmount,
      "user_transportDescription": usrgst.transportDescription,
      "user_variousAmount": usrgst.variousAmount,
      "user_variousDescription": usrgst.variousDescription,
    });
    FirebaseFirestore.instance
        .collection("usuarios")
        .doc(uid)
        .collection("expenses")
        .doc("exp$uid" + "11")
        .set({
      "user_cleaningAmount": usrgst.cleaningAmount,
      "user_cleaningDescription": usrgst.cleaningDescription,
      "user_foodAmount": usrgst.foodAmount,
      "user_foodDescription": usrgst.foodDescription,
      "user_idexp": "exp$uid" + "11",
         "user_studyAmount": usrgst.studyAmount,
      "user_studyDescription": usrgst.studyDescription,
      "user_totalAmount": usrgst.totalAmount,
      "user_transportAmount": usrgst.transportAmount,
      "user_transportDescription": usrgst.transportDescription,
      "user_variousAmount": usrgst.variousAmount,
      "user_variousDescription": usrgst.variousDescription,
    });
    return;
  }

  Future<void> userNonthReport(
      String uid, String Date, UsuarioGastos gastos) async {
    FirebaseFirestore.instance
        .collection("usuarios")
        .doc(uid)
        .collection("expenses")
        .doc("exp$uid$Date")
        .set({
      "user_cleaningAmount": gastos.cleaningAmount,
      "user_cleaningDescription": gastos.cleaningDescription,
      "user_foodAmount": gastos.foodAmount,
      "user_foodDescription": gastos.foodDescription,
      "user_idexp": "exp" + uid + Date,
           "user_studyAmount": gastos.studyAmount,
      "user_studyDescription": gastos.studyDescription,
      "user_totalAmount": gastos.totalAmount,
      "user_transportAmount": gastos.transportAmount,
      "user_transportDescription": gastos.transportDescription,
      "user_variousAmount": gastos.variousAmount,
      "user_variousDescription": gastos.variousDescription,
    });
    return;
  }
}
