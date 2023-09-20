import 'dart:io';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  final _textController = new TextEditingController();
  final _focusNode      = new FocusNode();

  List<ChatMessage> _mensajes = [];

  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text('Te', style: TextStyle(fontSize: 12) ),
              backgroundColor: Colors.blue[100],
              maxRadius: 12,
            ),
            SizedBox( height: 3 ),
            Text('Josefina Moral', style: TextStyle( color: Colors.black87, fontSize: 14),)
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _mensajes.length,
                itemBuilder: (_, i) => _mensajes[i],
                reverse: true,
              )
            ),
            Divider( height: 1 ),
            
            //TODO: caja de texto
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
   );
  }

  Widget _inputChat(){

    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric( horizontal: 8.0 ),
        child: Row(
          children: [

            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: ( texto ){
                  setState(() {
                    if ( texto.trim().length > 0 ) {
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar mensaje'
                ),
                focusNode: _focusNode,
              )
            ),

            // Botón de enviar
            Container(
              margin: EdgeInsets.symmetric( horizontal: 4.0 ),
              child: Platform.isIOS
              ? CupertinoButton(
                child: const Text('Enviar'), 
                onPressed: _estaEscribiendo
                      ? () => _handleSubmit( _textController.text.trim() )
                      : null, 
              )
              : Container(
                margin: EdgeInsets.symmetric( horizontal: 4.0 ),
                child: IconTheme(
                  data: IconThemeData( color: Colors.blue[400]),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: _estaEscribiendo
                      ? () => _handleSubmit( _textController.text.trim() )
                      : null, 
                    icon: Icon( Icons.send )
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );

  }

  _handleSubmit( String texto ) {

    if ( texto.isEmpty ) return;
    
    print( texto );
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      uid: '123', 
      texto: texto, 
      animationController: AnimationController( vsync: this, duration: Duration( milliseconds: 200 )), 
    );
    _mensajes.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    // TODO: off del socket

    for( ChatMessage message in _mensajes ) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}