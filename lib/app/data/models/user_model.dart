import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String username;
  final String name;
  final String address;
  final String email;
  final String phone;
  final String password;
  final String photoUrl;

  UserModel({
    this.id,
    required this.username,
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
    required this.password,
    this.photoUrl = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      address: json['address'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      photoUrl: json['photoUrl'],
    );
  }

  //from snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;

    return UserModel(
      id: snapshot.id,
      username: data['username'],
      name: data['name'],
      address: data['address'],
      email: data['email'],
      phone: data['phone'],
      password: data['password'],
      photoUrl: data['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'address': address,
      'email': email,
      'phone': phone,
      'password': password,
      'photoUrl': photoUrl,
    };
  }
}
