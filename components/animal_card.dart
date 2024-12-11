import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalCard {
  String name;
  String species;
  double age;
  String size;
  String gender;
  String note;
  String user;

  AnimalCard({
    required this.name,
    required this.species,
    required this.age,
    required this.size,
    required this.gender,
    required this.note,
    required this.user,
  });

  AnimalCard.fromJson(Map<String, Object?> json) : this(
    name: json["name"]! as String,
    species: json["species"]! as String,
    age: json["age"]! as double,
    size: json["size"]! as String,
    gender: json["gender"]! as String,
    note: json["note"]! as String,
    user: json["user"]! as String,
    );

  AnimalCard copyWith({
      String? name,
      String? species,
      double? age,
      String? size,
      String? gender,
      String? note,
  }) {
    return AnimalCard(
      name: name ?? this.name,
      species: species ?? this.species,
      age: age ?? this.age,
      size: size ?? this.size,
      gender: gender ?? this.gender,
      note: note ?? this.note,
      user: user
      );
  }

  Map<String, Object?> toJson() {
    return {
      "name": name,
      "species": species,
      "age": age,
      "size": size,
      "gender": gender,
      "note": note,
      "user": user,
    };
  }
}