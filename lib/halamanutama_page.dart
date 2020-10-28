import 'package:flutter/material.dart';
import 'package:flutter_database_sqflite/halaman_contact.dart';
import 'package:flutter_database_sqflite/halaman_profile.dart';
import 'package:url_launcher/url_launcher.dart';

class HalamanUtama extends StatefulWidget {
  var iduser, username, firstname;

  HalamanUtama({Key key, this.iduser, this.username, this.firstname})
      : super(key: key);

  @override
  _HalamanUtamaState createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("halaman utama"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        "https://onlinejpgtools.com/images/examples-onlinejpgtools/steve-jobs.png"),
                  ),
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "username: ${widget.username}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text("firstname: ${widget.firstname}",
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ))
                ],
              ),
            ),
            ListTile(
              title: Text("Your Profile"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HalamanProfile(
                              iduser: widget.iduser,
                            )));
              },
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: Text("Your Contact"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HalamanContact()));
              },
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: Text("Call Customer Service"),
              onTap: () {},
            ),
            Divider(
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HalamanProfile(
                                iduser: widget.iduser,
                              )));
                },
                child: Text("My Profile"),
              ),
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HalamanContact()));
                },
                child: Text("My Contact"),
              ),
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  _launchURL();
                },
                child: Text("Call Customer SErvice"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'tel:082311445674';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
