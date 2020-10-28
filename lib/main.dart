import 'package:flutter/material.dart';
import 'package:flutter_database_sqflite/register_page.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'dart:convert';

import 'halamanutama_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();
  List data;

  @override
  Widget build(BuildContext context) {
    var username = ListTile(
      leading: Icon(Icons.person),
      title: TextFormField(
        controller: _usernameController,
        decoration: InputDecoration(
          labelText: "your username",
          hintText: "please input username",
        ),
      ),
    );
// textformfield password
    var password = ListTile(
      // leading: Icon(Icons.remove_red_eye),
      title: TextFormField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: "your passworf",
          icon: IconButton(icon: Icon(Icons.remove_red_eye), onPressed: () {}),
          hintText: "please input password",
        ),
        obscureText: true,
      ),
    );
    ////********************* button login //*********************
    var loginButton = Container(
      child: RaisedButton(
        onPressed: () {
          getLogin(_usernameController.text);
        },
        child: Text("Login"),
        color: Colors.blue,
      ),
    );

//********************* button reset //*********************
    var resetButton = Container(
      child: FlatButton(
          onPressed: () {
            _usernameController.clear();
            _passwordController.clear();
          },
          child: Text("Reset")),
    );
//********************* button register //*********************
    var registerButton = Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          height: 45,
          child: RaisedButton(
            color: Colors.blue,
            child: Text(
              "Register",
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterPage()));
            },
          ),
        ));

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Image.network(
              "https://vignette.wikia.nocookie.net/flutter-butterfly-sanctuary/images/7/7f/FlutterLogo.PNG/revision/latest?cb=20131017172902"),
          SizedBox(
            height: 30,
          ),
          Card(
            elevation: 8,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: <Widget>[
                  username,
                  password,
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[resetButton, loginButton],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          registerButton
        ],
      ),
    );
  }

  Future<String> getLogin(String dataUsername) async {
    var response = await http.get(Uri.encodeFull(
        "http://udakita.com/Fluttercrud/Login.php?Username=${dataUsername}"));
    print(response.body);
    setState(() {
      var convertDataJson = json.decode(response.body);
      data = convertDataJson['result'];
      if (data.length < 1) {
        Toast.show("Gagal,coba lagi", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else {
        verifyData(_usernameController.text, _passwordController.text, data);
      }
    });
  }

  void verifyData(String username, String password, data) {
    if (data[0]['username'] == username) {
      if (data[0]['password'] == password) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HalamanUtama(
                      iduser: data[0]["user_id"],
                      firstname: data[0]["first_name"],
                      username: data[0]["username"],
                    )));
      } else {
        passwordGagal();
      }
    } else {
      usernameGagal();
    }
  }

  void passwordGagal() {
    var alert = AlertDialog(
      title: Text("password Salah"),
      content: Text("password yang anda inputkan salah,silahkan coba lagi"),
    );
    showDialog(context: context, child: alert);
  }

  void usernameGagal() {
    var alert = AlertDialog(
      title: Text("username Salah"),
      content: Text("username yang anda inputkan salah,silahkan coba lagi"),
    );
    showDialog(context: context, child: alert);
  }
}
