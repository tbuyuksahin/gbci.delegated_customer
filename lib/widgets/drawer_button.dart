import 'package:flutter/material.dart';

abstract class Buttons {
  static GestureDetector drawerButton(
      BuildContext context, String text, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xffdfff57),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: const ListTile(
            leading: Icon(Icons.person),
            title: Text('Kullanıcı'),
          ),
        ),
      ),
    );
  }
}
