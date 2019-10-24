import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app_contactos/model/contactos.dart';



class ContactosScreen extends StatefulWidget {

  final Contactos contactos;
  ContactosScreen(this.contactos);

  @override
  _ContactosScreenState createState() => _ContactosScreenState();
}
final contactosReference = FirebaseDatabase.instance.reference().child('contactos');

class _ContactosScreenState extends State<ContactosScreen> {
  List<Contactos> items;
  TextEditingController _telefonoController;
  TextEditingController _nombreController;
  TextEditingController _apellidoController;
  TextEditingController _tipoSangreController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _telefonoController = new TextEditingController(text: widget.contactos.telefono);
    _nombreController = new TextEditingController(text: widget.contactos.nombre);
    _apellidoController = new TextEditingController(text: widget.contactos.apellido);
    _tipoSangreController= new TextEditingController(text: widget.contactos.tipoSangre);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Base Contactos'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        height: 570.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nombreController,
                  style: TextStyle(
                      fontSize: 17.0 ,
                      color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon:  Icon(Icons.person),
                      labelText: 'Nombre:'),
                ),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                TextField(
                  controller: _apellidoController,
                  style: TextStyle(
                      fontSize: 17.0 ,
                      color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon:  Icon(Icons.perm_identity),
                      labelText: 'Apellido:'),
                ),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                TextField(
                  controller: _telefonoController,
                  style: TextStyle(
                      fontSize: 17.0 ,
                      color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon:  Icon(Icons.phone_android),
                      labelText: 'Telefono:'),
                ),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                TextField(
                  controller: _tipoSangreController,
                  style: TextStyle(
                      fontSize: 17.0 ,
                      color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon:  Icon(Icons.local_hospital),
                      labelText: 'Tipo de Sangre:'),
                ),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                FlatButton(onPressed: (){
                  if(widget.contactos.id != null){
                    contactosReference.child(widget.contactos.id).set({
                      'Nombre' : _nombreController.text,
                      'Apellido' : _apellidoController.text,
                      'Telefono' : _telefonoController.text,
                      'Tipo de Sangre' : _tipoSangreController.text
                    }).then((_){
                      Navigator.pop(context);
                    });
                  }else{
                    contactosReference.push().set({
                      'Nombre' : _nombreController.text,
                      'Apellido' : _apellidoController.text,
                      'Telefono' : _telefonoController.text,
                      'Tipo de Sangre' : _tipoSangreController.text,
                    }).then((_){
                      Navigator.pop(context);
                    });
                  }
                },
                    child: (widget.contactos.id != null) ? Text('Actualizar'): Text('Agregar')),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
