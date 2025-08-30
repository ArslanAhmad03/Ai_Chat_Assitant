

  import 'package:flutter/material.dart';

Widget buildSectionTitle(String title, double w) {
    return Text(
      title,
      style: TextStyle(fontSize: w * 0.045, fontWeight: FontWeight.bold),
    );
  }