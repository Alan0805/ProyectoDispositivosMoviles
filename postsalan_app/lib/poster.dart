
//Esta clase fue generada por medio de una pagina web llamada "JSONTODART"

//Esta clase sirve para en lugar de irnos parte por parte leyendo el json del atributo que nos
// interesa, mejor le decimos que nos va a responder con el objeto de tipo Poster asi que hara la respuesta de la API.
class Poster {
  List<Post> post;

  Poster({this.post});
//esta funcion en lista los post de l json
  Poster.fromJson(Map<String, dynamic> json) {
    if (json['post'] != null) {
      post = new List<Post>();
      json['post'].forEach((v) {
        post.add(new Post.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.post != null) {
      data['post'] = this.post.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({this.userId, this.id, this.title, this.body});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}