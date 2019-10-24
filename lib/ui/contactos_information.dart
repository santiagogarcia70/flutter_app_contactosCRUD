import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app_contactos/model/contactos.dart';

class ContactosInformation extends StatefulWidget {
  final Contactos contactos;
  ContactosInformation(this.contactos);


  @override
  _ContactosInformationState createState() => _ContactosInformationState();
}

final contactosReference = FirebaseDatabase.instance.reference().child('contactos');

class _ContactosInformationState extends State<ContactosInformation> {

  List<Contactos> items;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información del contacto'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        height: 400.0,
        padding: const EdgeInsets.all(20.0),
        child:  Card(
          child: Center(
            child: Column(
              children: <Widget>[
                new Text("Nombre : ${widget.contactos.nombre}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Apellido : ${widget.contactos.apellido}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Telefono : ${widget.contactos.telefono}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Tipo de Sangre : ${widget.contactos.tipoSangre}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider()
              ],
            ),
          ),
        ),
      ),
    );

  }
}
