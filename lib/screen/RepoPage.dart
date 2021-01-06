import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttergithublogin/model/RepoVO.dart';
import 'package:fluttergithublogin/model/User.dart';
import 'package:fluttergithublogin/request/GitRequest.dart';


class RepoPage extends StatefulWidget {
  User myObject;

  RepoPage({this.myObject});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RepoState();
  }
}

class RepoState extends State<RepoPage>{
  List<RepoVO> reposList;
  int count=0;
//  User user=widget.myObject;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    setState(() {
      GitRequest(widget.myObject.login).fetchRepos().then((following) {
        Iterable list = json.decode(following.body);
        setState(() {
          reposList = list.map((model) => RepoVO.fromJson(model)).toList();
          count=reposList.length;
        });
      });
    });

    return Scaffold(
      appBar: AppBar(title: Text("Reposetories"),),
      body: setUI(),
    );
  }

  setUI() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (context,index){
      return Container(
        padding: EdgeInsets.all(10),
        child: Card(
          elevation: 2.0,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Project Name", style: getHeaderStyle(),),
                  Text(reposList[index].repoName,style: getDataStyle(),),
                  SizedBox(height: 10,),
                  Text("Date", style: getHeaderStyle(),),
                  Text("${reposList[index].forks}",style: getDataStyle(),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Branch", style: getHeaderStyle(),),
                  Text(reposList[index].branch,style: getDataStyle(),),
                  SizedBox(height: 10,),
                  Text("Open Issues", style: getHeaderStyle(),),
                  Text("${reposList[index].openIssues}",style: getDataStyle(),),
                ],
              ),
              SizedBox(height: 10,),
              Center(child: Column(
                children: <Widget>[
                  Text("Forks", style: getHeaderStyle(),),
                  Text("${reposList[index].forks}",style:TextStyle(color:Colors.red[300],fontSize: 20,fontWeight: FontWeight.bold) ,),
                ],
              ),),
              SizedBox(height: 10,),
            ],
          ),
        ),
      );
    });
  }

  getHeaderStyle() {
    return TextStyle(color: Colors.black45,fontWeight: FontWeight.normal);
  }

  getDataStyle() {
    return TextStyle(color:Colors.red[300],fontWeight: FontWeight.bold);
  }
  
}