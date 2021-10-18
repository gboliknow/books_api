import 'package:books/screens/formal/search_book_page_formal.dart';
import 'package:books/screens/formal/stamp_collection_page_formal.dart';
import 'package:flutter/material.dart';
import 'package:books/screens/sign_in_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterFire Samples',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: new Color(0xFF0F2533),
      ),
      home: SignInScreen(),
      routes: {
        '/search_formal': (BuildContext context) => new SearchBookPageNew(),
        '/stamp_collection_formal': (BuildContext context) =>
            new StampCollectionFormalPage(),
      },
    );
  }
}
