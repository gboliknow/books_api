import 'package:flutter/material.dart';
import 'package:books/data/repository.dart';
import 'package:books/model/Book.dart';

abstract class StampCollectionPageAbstractState<T extends StatefulWidget>
    extends State<T> {
  List<Book> items = [];

  @override
  void initState() {
    super.initState();
    Repository.get().getFavoriteBooks().then((books) {
      setState(() {
        items = books;
      });
    });
  }
}
