  import 'package:flutter/material.dart';

Widget buildCard(String title, String subtitle, double w) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(32),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: w * 0.04),
          ),
          SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(fontSize: w * 0.035, color: Colors.grey.shade700),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }