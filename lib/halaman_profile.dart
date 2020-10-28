import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HalamanProfile extends StatefulWidget {
  String iduser;

  HalamanProfile({Key key, this.iduser}) : super(key: key);

  @override
  _HalamanProfileState createState() => _HalamanProfileState();
}

class _HalamanProfileState extends State<HalamanProfile> {
  var loading = false;
  var data;
  String username = "username", firstname = "firstname", gender = "gender";
  Future getLogin(String id) async {
    loading = true;
    var response = await http
        .get("https://udakita.com/Fluttercrud/ConsultProfile.php?ID=" + id);
    var convertDataJson = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
        data = convertDataJson['result'];
        username = data[0]["username"];
        firstname = data[0]["firstname"];
        gender = data[0]["gender"];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getLogin(widget.iduser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlutterLogo(
              size: 100,
            ),
            Text(username),
            Text("firstname :" + username),
            Text("gender:" + gender)
          ],
        ),
      ),
    );
  }
}
