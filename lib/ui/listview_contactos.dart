import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:flutter_app_contactos/ui/contactos_information.dart';
import 'package:flutter_app_contactos/ui/contactos_screen.dart';
import 'package:flutter_app_contactos/model/contactos.dart';

class ListViewContactos extends StatefulWidget {
  @override
  _ListViewContactosState createState() => _ListViewContactosState();
}

final contactosReference = FirebaseDatabase.instance.reference().child('contactos');

class _ListViewContactosState extends State<ListViewContactos> {
  List<Contactos> items;
  StreamSubscription<Event> _agregarContactos;
  StreamSubscription<Event> _editarContactos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = new List();
    _agregarContactos = contactosReference.onChildAdded.listen(_agregarContacto);
    _editarContactos = contactosReference.onChildChanged.listen(_editarContacto);

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _agregarContactos.cancel();
    _editarContactos.cancel();


  }


  @override

  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Contactos',
        home : Scaffold(
          appBar: AppBar(
            title: Text('Informacion de contactos'),
            centerTitle: true,
            backgroundColor: Colors.deepPurpleAccent,
          ),
          body: Center(
              child: ListView.builder(itemCount: items.length ,
                padding: EdgeInsets.only(top: 12.0),
                itemBuilder: (context,position){
                  return Column(
                    children: <Widget>[
                      Divider(height: 7.0,),
                      Row(
                        children: <Widget>[
                          Expanded(child: ListTile(title: Text('${items[position].nombre})',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 21.0,
                            ),
                          ),
                            subtitle:
                            Text('${items[position].telefono})',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 21.0,
                              ),
                            ),
                            leading: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.amberAccent,
                                  radius: 17.0,
                                  child: Text('${items[position+1].telefono}',
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 21.0
                                    ),
                                  ),
                                )
                              ],
                            ),
                            onTap: () => _navegarAInformacionContactos(context, items[position]),)),
                          IconButton(
                              icon: Icon(Icons.delete, color: Colors.red,),
                              onPressed: ()=> _borrarContactos(context, items[position],position) ),
                          IconButton(
                              icon: Icon(Icons.edit, color: Colors.blueAccent,),
                              onPressed: ()=> _navegarAContactos(context, items[position]) ),
                        ],
                      )
                    ],
                  );
                },)
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add,color: Colors.white,),
            backgroundColor: Colors.deepOrangeAccent,
            onPressed: () => _crearContacto(context),
          ),
        )
    );
  }
  void _agregarContacto(Event event ){
    setState(() {
      items.add(new Contactos.fromSnapShot(event.snapshot));
    });
  }

  void _editarContacto(Event event ){
    var antiguoContacto = items.singleWhere((contactos) => contactos.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(antiguoContacto)] = new Contactos.fromSnapShot(event.snapshot);
    });
  }

  void _borrarContactos(BuildContext context, Contactos contactos, int posicion) async{
    await contactosReference.child(contactos.id).remove().then((_){
      setState(() {
        items.removeAt(posicion);
      });
    });

  }

  void _navegarAInformacionContactos(BuildContext context,Contactos contactos) async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => ContactosScreen(contactos)),
    );
  }

  void _navegarAContactos(BuildContext context,Contactos contactos) async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => ContactosInformation(contactos)),
    );
  }

  void _crearContacto(BuildContext context) async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => ContactosScreen(Contactos(null,'','','',''))),
    );
  }

}
