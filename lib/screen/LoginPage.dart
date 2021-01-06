import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttergithublogin/model/User.dart';
import 'package:fluttergithublogin/request/GitRequest.dart';
import 'package:fluttergithublogin/screen/RepoPage.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  TextEditingController _controller = TextEditingController();
  String errorMessage;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView( child: setUI()),
    );
  }

  setUI() {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      padding: EdgeInsets.all(10),
      child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Container(
                color: Colors.black,
                width: 100,
                height: 100,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      'https://cdn3.iconfinder.com/data/icons/ultimate-social/150/48_github-512.png'),
                )),
            SizedBox(
              height: 50,
            ),
            Card(
                color: Colors.white,
                child: Padding(
                    padding: EdgeInsets.only(
                        left: 20, top: 3.0, right: 20.0, bottom: 3),
                    child: TextField(
                      controller: _controller,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          errorText: errorMessage,
                          hintText: 'UserName'),
                    ))),
            RaisedButton(
              child: Text("Login With GitHub",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              color: Colors.white,
              onPressed: () {
                onClickGitHubLoginButton();
                setState(() {
                  errorMessage="";
                });
              },
            )
          ],
        ),
    );
  }

  void onClickGitHubLoginButton() async {
//     String url = "https://github.com/login/oauth/authorize" +
//        "?client_id=" + GitRequest.client_id +
//        "&scope=public_repo%20read:user%20user:email";
//
//    if (await canLaunch(url)) {
//      await launch(
//        url,
//        forceSafariVC: false,
//        forceWebView: false,
//      );
//    } else {
//      print("CANNOT LAUNCH THIS URL!");
//    }

    if (_controller.text != null) {
      User user;
      await GitRequest(_controller.text).fetchUser().then((data) {
        print(data.statusCode);
        print(data.body);
        if (data.statusCode == 200) {
          user = User.fromJson(json.decode(data.body));
          print(user);
        } else {
          Map<String, dynamic> result = json.decode(data.body);
          setState(() {
            errorMessage=result['message'];
          });
        }
      });

      if (user != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new RepoPage(myObject: user)));
      }
    }
  }
}
