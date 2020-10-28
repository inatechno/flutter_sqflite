import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _usernameController = TextEditingController();
  var _firstNameController = TextEditingController();
  var _genderController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: ListView(
        children: <Widget>[
          myTextField(Icon(Icons.person), "username :", "username",
              _usernameController),
          myTextField(Icon(Icons.person), "firstname :", "firstname",
              _firstNameController),
          myTextField(
              Icon(Icons.person), "gender :", "gender", _genderController),
          myTextField(
              Icon(Icons.lock), "password :", "password", _passwordController),
          SizedBox(
            height: 30,
          ),
          Container(
            child: RaisedButton(
              onPressed: () {
                prosesRegister();
              },
              child: Text("Register"),
            ),
          )
        ],
      ),
    );
  }

  Widget myTextField(Widget leading, String label, String hint,
      TextEditingController controller) {
    return ListTile(
      leading: leading,
      title: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label, hintText: hint),
      ),
    );
  }

  Future prosesRegister() async {
    var url = "http://udakita.com/Fluttercrud/NewUser.php";
    http.post(url, body: {
      "username": _usernameController.text,
      "firstname": _firstNameController.text,
      "gender": _genderController.text,
      "password": _passwordController.text
    });
    Toast.show("Selamat,anda berhasil register", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    Navigator.pop(context);
  }
}
