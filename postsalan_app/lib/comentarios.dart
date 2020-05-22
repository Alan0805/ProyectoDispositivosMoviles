
//Esta clase fue generada por medio de una pagina web llamada "JSONTODART"

//Esta clase sirve para en lugar de irnos parte por parte leyendo el json del atributo que nos
// interesa, mejor le decimos que nos va a responder con el objeto de tipo Poster asi que hara la respuesta de la API.
class Comentarios {
  int postId;
  int id;
  String name;
  String email;
  String body;

  Comentarios({this.postId, this.id, this.name, this.email, this.body});

  Comentarios.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['body'] = this.body;
    return data;
  }
}