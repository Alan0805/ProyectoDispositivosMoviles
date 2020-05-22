
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//importamos el paquete http pero agregamos un nombre "as http" para que la importacion la englobe en una variable y asi
// la variable podamos llamrala cuantas veces queramos
import 'package:http/http.dart' as http;
import 'package:postsalanapp/post_detail.dart';
import 'package:postsalanapp/poster.dart';
import 'globals.dart' as globals;


class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  //declaramos una variable de tipo String para ingresar el URL del JSon que generamos,con esto simulamos una API request
  String url = "https://raw.githubusercontent.com/Alan0805/PruebaPost/master/post.json";
  //Declaramos una variable tipo Poster sin valor
  Poster post;

  @override
  //se ejecuta antes del Build, es un metodo muy util para mostrar datos que se necesitan ver antes de ejecutar el metodo Build.
  void initState() {
    super.initState();
    //Mandamos a llamar un metodo llamado "fetchData"
    fetchData();
  }
 //Creamos el metodo "fetchData", con este metodo void vamos a hacer la peticion con el "http"
  void fetchData() async{
    //Creamos una variable para que nos  llame y responda mediante la url que con anterioridad declaramos
    // "http.get(url) es una peticion asincrona
    var response = await http.get(url);
    //jsonDecode es una funcion para convertir a objetos JSON el texto que tenemos
    var decodedJson = jsonDecode(response.body);
    post = Poster.fromJson(decodedJson);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

//Aqui agregaremos el diseño a nuestra aplicacion de la pantalla de "POST"
    return Scaffold(
      appBar: AppBar(
        title: Text("PostAlan"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      drawer: Drawer(), //para agregar una barra de menu
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/foto.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: post==null ? Center(child: CircularProgressIndicator(),) : // Agregamos un indicador de progreso para ver que se esta cargando la pagina
//Usamos LIstView para generar una lista continua de las tarjetas de Post
        ListView(
          //Hacemos un mapeo para recorrear cada objeto de nuestro archivo y lo guardamos en nuestra variable "p" y por cada objeto p nos va a regresar
          //una card.
          children: post.post.map((p)=> Padding( //Utilizamos un Padding para poder ajustar uniformente el texto en la nuestra Card
            padding: const EdgeInsets.all(1.0),
            //una forma correcta de usar una navegacion entre pantallas con "InkWell"
            child: InkWell(
              onTap: (){
                //asignamos a la varibale global el id del post
                globals.id_post=p.id.toString();
                // usamos MaterialRoute para al dar click en el post nos mande a la siguiente pantalla que seria "Post_Detail"
               Navigator.push(context, MaterialPageRoute(builder: (context)=>Post_Detail(post:p)));
              },

              child: Hero(
                tag: p.title,
                child: Container( //Agregamos un container para poder poner mas estilo ala tarjeta asi como bordes, y tamaños
                  height: 120,
                  child: Card(
                    color: Colors.black,
                    elevation: 3.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border( //Agregamos un borde superior e inferior para darle un poco de detalle a nuestra Card
                              bottom: BorderSide(
                               width: 3.0 , color: Colors.red
                              ),
                              top: BorderSide(
                                width: 3.0, color: Colors.red
                              ),

                            )
                          ),
                          padding: const EdgeInsets.all(20.0),
                          height: 110,
                          child: Container( //De igual forma nuestro texto lo encerramos en un container para facilitar el diseño del texto
                            //al momento de cambiarle el tamaño para poder ajustarlo a la Card
                            child: Text(
                              //mandamos a llamar el texto lo usamos de esta manera ya que cada tarjeta tiene diferente texto
                              p.title,
                              textAlign: TextAlign.center,
                              //Agregamos al texto estilo, color, tamaño y tipografia
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.white, fontStyle: FontStyle.italic ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
          ).toList(),
        ),
      ),
    );
  }
}