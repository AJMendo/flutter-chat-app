
import 'package:chat_app/widgets/boton_azul.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/services/auth_service.dart';

import 'package:chat_app/helpers/mostar_alerta.dart';

import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';



class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  
                Logo( titulo: 'Messenger' ),
                  
                _Form(),
                  
                Labels( 
                  ruta: 'register',
                  titulo: '¿No tienes cuenta?',
                  subTitulo: 'Crea una ahora',
                ),
                  
                Text('Términos y condiciones de uso', style: TextStyle( fontSize: 15, fontWeight: FontWeight.w400 ),)
              ],
            ),
          ),
        ),
      )
   );
  }
}



class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passCtrl  = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>( context );

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric( horizontal: 50 ),
      child: Column(
        children: [
          
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            //keyboardType: TextInputType.emailAddress,
            textController: passCtrl,
            isPasword: true,
          ),             
           
          BotonAzul(
            onPressed: authService.autenticando ? null : () async {

              FocusScope.of(context).unfocus();
              
              final loginOk = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());
              
              if ( loginOk ) {
                // TODO: Conectar a nuestro socket server
                Navigator.pushReplacementNamed(context, 'usuarios');
              } else {
                // Mostar alerta
                mostrarAlerta(context, 'Login incorrecto', 'Revise sus credenciales nuevamente');
              }
              }, 
            text: 'Ingrese',)
                   
        ],
      ),
    );
  }
}

