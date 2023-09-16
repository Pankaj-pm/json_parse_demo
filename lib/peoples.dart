import 'dart:convert';

class Peoples {
  List<Person>? people;

  Peoples({
    this.people,
  });

  factory Peoples.fromRawJson(String str) => Peoples.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Peoples.fromJson(Map<String, dynamic> json) => Peoples(
    people: json["people"] == null ? [] : List<Person>.from(json["people"]!.map((x) => Person.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "people": people == null ? [] : List<dynamic>.from(people!.map((x) => x.toJson())),
  };
}

class Person {
  String? firstName;
  String? lastName;
  String? gender;
  num? age;
  String? number;

  Person({
    this.firstName,
    this.lastName,
    this.gender,
    this.age,
    this.number,
  });

  factory Person.fromRawJson(String str) => Person.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Person.fromJson(Map<String, dynamic> json) => Person(
    firstName: json["firstName"],
    lastName: json["lastName"],
    gender: json["gender"],
    age: json["age"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "gender": gender,
    "age": age,
    "number": number,
  };
}
