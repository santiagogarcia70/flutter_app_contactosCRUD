import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class Contactos{

  String _id;
  String _telefono;
  String _nombre;
  String _apellido;
  String _tipoSangre;


  Contactos (this._id,this._telefono,this._nombre,this._apellido,this._tipoSangre);

  Contactos.map(dynamic obj){
    // ignore: unnecessary_statements, unrelated_type_equality_checks
    this._id = obj['id'];
    this._telefono = obj['telefono'];
    this._nombre = obj['nombre'];
    this._apellido = obj['apellido'];
    this._tipoSangre = obj['tipoSangre'];
  }

  String get id => _id;
  String get telefono => _telefono;
  String get nombre => _nombre;
  String get apellido => _apellido;
  String get tipoSangre => _tipoSangre;

  Contactos.fromSnapShot(DataSnapshot snapshot){
    _id = snapshot.key;
    _telefono = snapshot.value['telefono'];
    _nombre = snapshot.value['nombre'];
    _apellido = snapshot.value['apellido'];
    _tipoSangre = snapshot.value['tipoSangre'];

  }

}