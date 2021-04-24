import 'package:flutter/material.dart';


class DetailsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(backgroundColor: Colors.grey,
     appBar: AppBar(title: Text("Details Page"),),
      body: Center(
        child: Text("Welcome To Details Page"),
    ),);
  }

}