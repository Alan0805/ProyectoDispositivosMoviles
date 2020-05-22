//Clase para enlistar los comentarios de la clase post que le corresponde a cada uno
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postsalanapp/poster.dart';
import 'package:postsalanapp/comentarios.dart';
import 'comentarios.dart';
import 'package:postsalanapp/globals.dart';

//Metodo Post_detail que recibe una variable de tipo post
class Post_Detail extends StatefulWidget {
  @override
  Post post;
  Post_Detail({
    this.post
});
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<Post_Detail> {

  bool loading = true;
  //asignamos a la variable url su respectiva ruta pero en forma anidad con el url de la clas post
  final String url = 'https://jsonplaceholder.typicode.com/posts/'+id_post+'/comments';
  var client = http.Client();
  List<Comentarios> users = List<Comentarios>();


  //se ejecuta antes del Build, es un metodo muy util para mostrar datos que se necesitan ver antes de ejecutar el metodo Build.
  @override
  void initState(){
    //Mandamos a llamar un metodo llamado "fetchData"
    fetchData();
    super.initState();
  }

//Creamos el metodo "fetchData", con este metodo void vamos a hacer la peticion con el "http"
  //Creamos una variable para que nos  llame y responda mediante la url que con anterioridad declaramos
  // "http.get(url) es una peticion asincrona
  Future<void> fetchData() async {
    http.Response response = await client.get(url);
    if(response.statusCode == 200){ // Connection Ok
      List responseJson = json.decode(response.body);
      responseJson.map((m) => users.add(new Comentarios.fromJson(m))).toList();
      setState(() {
        loading = false;
      });
    } else {
      throw('error');
    }
  }


//Aqui se construye la pantalla de nuestra aplicacion con sus diversos atributos
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Comentarios"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("img/foto.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: loading ?
          Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ) :
          ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index){
              return Card(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 2.0,color: Colors.red
                      ),
                      top: BorderSide(
                          width: 3.0, color: Colors.red
                      ),
                    ),
                  ),
                  child: Container(
                    color: Colors.black,
                    child: ListTile(
                      title: Text(users[index].name,style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                      subtitle: Text(users[index].email),
                      leading: Icon(Icons.email,color: Colors.cyan,),

                    ),
                  ),
                ),
              );
            },
          )
      ),
    );
  }
}