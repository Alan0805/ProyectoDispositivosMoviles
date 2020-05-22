import 'package:flutter/material.dart';
import 'package:postsalanapp/post_list.dart';

void main(){
  runApp(MaterialApp(
    title: "PostAlan App",
    home: PostList(),
    debugShowCheckedModeBanner: false,
  ));
}