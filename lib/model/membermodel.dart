// To parse this JSON data, do
//
//     final memberModel = memberModelFromJson(jsonString);

import 'dart:convert';

MemberModel memberModelFromJson(String str) =>
    MemberModel.fromJson(json.decode(str));

String memberModelToJson(MemberModel data) => json.encode(data.toJson());

class MemberModel {
  MemberModel({
    this.code,
    this.result,
  });

  int code;
  List<Result> result;

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        code: json["code"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.userId,
    this.username,
    this.firstName,
    this.lastName,
    this.gender,
    this.password,
    this.status,
  });

  String userId;
  String username;
  String firstName;
  String lastName;
  String gender;
  String password;
  String status;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        userId: json["user_id"].toString(),
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        password: json["password"],
        status: json["status"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "password": password,
        "status": status,
      };
}
