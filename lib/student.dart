import 'dart:convert';

class Student {
  String? firstName;
  String? lastName;
  String? address;
  int? id;
  double? age;
  List<String>? sub;

  Student({
    this.firstName,
    this.lastName,
    this.address,
    this.id,
    this.age,
    this.sub,
  });

  factory Student.fromRawJson(String str) => Student.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    firstName: json["first_name"],
    lastName: json["last_name"],
    address: json["address"],
    id: json["id"],
    age: json["age"]?.toDouble(),
    sub: json["sub"] == null ? [] : List<String>.from(json["sub"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "address": address,
    "id": id,
    "age": age,
    "sub": sub == null ? [] : List<dynamic>.from(sub!.map((x) => x)),
  };
}
