import 'package:books/screens/formal/search_book_page_formal.dart';
import 'package:books/screens/formal/stamp_collection_page_formal.dart';
import 'package:flutter/material.dart';
import 'package:books/screens/sign_in_screen.dart';
import 'package:flutter_screenutil/screenutil_init.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter_Books_Store',
        theme: new ThemeData(
          primaryColor: new Color(0xFF0F2533),
        ),
        home: SignInScreen(),
        routes: {
          '/search_formal': (BuildContext context) => new SearchBookPageNew(),
          '/stamp_collection_formal': (BuildContext context) =>
              new StampCollectionFormalPage(),
        },
      ),
    );
  }
}
