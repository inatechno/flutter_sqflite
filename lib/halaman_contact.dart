import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database_sqflite/config_database/member_database.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'model/membermodel.dart';

class HalamanContact extends StatefulWidget {
  @override
  _HalamanContactState createState() => _HalamanContactState();
}

class _HalamanContactState extends State<HalamanContact> {
  bool loading;
  List<Result> data;

  _getDataAll() async {
    List<Result> events = [];
    var connectivityResult = await (Connectivity().checkConnectivity());
    var url = "https://udakita.com/Fluttercrud/SelectAllUsers.php";
    if (connectivityResult == ConnectivityResult.mobile) {
      events = await _getDataFromNetwork(url);
      _saveDataToDBLocal(events);
      print("connect inet mobile");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      events = await _getDataFromNetwork(url);
      _saveDataToDBLocal(events);
      print("connect inet wifi");
    } else if (connectivityResult == ConnectivityResult.none) {
      print("not connected");
      events = await _getDatafromDBLocal();
      print("db local running");
    }
    return events;
  }

  @override
  void initState() {
    // TODO: implement initState
    _getDataAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("AllContact"),
        ),
        body: loading == true
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: this.data != null ? this.data.length : 0,
                itemBuilder: (context, index) {
                  final dataMember = this.data[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Card(
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blue[100],
                            child: Text(dataMember?.gender.toString()?? "gender"),
                          ),
                          Flexible(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Text(dataMember?.username.toString() ?? "username"),
                                  Text(dataMember?.firstName.toString() ?? "firstname"),
                                  Text(dataMember?.lastName.toString() ?? "lastname"),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ));
  }

  Future<List<Result>> _getDataFromNetwork(String url) async {
    loading = true;
    List<Result> list;
    var res = await http.get(Uri.encodeFull(url));
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data['result'] as List;
      print(rest);
      list = rest.map<Result>((dataJson) => Result.fromJson(dataJson)).toList();
    }
    print("list size:  ${list.length}");
    setState(() {
      loading = false;
      this.data = list;
    });
    return data;
    // data.map((item) {
    //   return Result(
    //       username: item.username,
    //       firstName: item.firstName,
    //       lastName: item.lastName,
    //       gender: item.gender,
    //       password: item.password,
    //       status: item.status);
    // }).toList();
  }

  _saveDataToDBLocal(List<Result> events) async {
    Database dbClient = await MemberDatabase().db;
    dbClient.delete(MemberDatabase.EVENT_TABLE_NAME);
    events.forEach((member) async {
      var eventId = await dbClient.insert(
          MemberDatabase.EVENT_TABLE_NAME, member.toJson());
      print("simpandatabase" + eventId.toString());
    });
  }

  Future<List<Result>> _getDatafromDBLocal() async {
    loading = true;
    List<Result> list2;
    Database dbClient = await MemberDatabase().db;
    List<Map<String, dynamic>> memberRecords =
        await dbClient.query(MemberDatabase.EVENT_TABLE_NAME);
    list2 = memberRecords.map((e) => Result.fromJson(e)).toList();
    setState(() {
      loading = false;
      this.data = list2;
      // print("showdata dari db" + data.toString());
    });
    return data;
  }
}
