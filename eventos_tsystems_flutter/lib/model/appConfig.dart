import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppConfig {
  Color color;
  String descriptionLabel;
  String loadingLabel;
  String nextLabel;
  String backLabel;
  String titleLabel;
  String restartLabel;


  AppConfig(AsyncSnapshot<DocumentSnapshot> snapshot) {
    String color = snapshot.data["color"];
    String descriptionLabel = snapshot.data["descriptionLabel"];
    String loadingLabel = snapshot.data["loadingLabel"];
    String nextLabel = snapshot.data["nextLabel"];
    String backLabel = snapshot.data["backLabel"];
    String titleLabel = snapshot.data["titleLabel"];
    String restartLabel = snapshot.data["restartLabel"];
    this.color = Color.fromRGBO(int.parse(color.split(".")[0]), int.parse(color.split(".")[1]), int.parse(color.split(".")[2]), 1.0);
    this.descriptionLabel = descriptionLabel;
    this.loadingLabel = loadingLabel;
    this.nextLabel = nextLabel;
    this.backLabel = backLabel;
    this.titleLabel = titleLabel;
    this.restartLabel = restartLabel;
  }

}