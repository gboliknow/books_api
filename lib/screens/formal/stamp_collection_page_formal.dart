import 'package:flutter/material.dart';
import 'package:books/model/Book.dart';
import 'package:books/screens/abstract/stamp_collection_page_abstract.dart';
import 'package:books/screens/formal/book_details_page_formal.dart';
import 'package:books/utils/utils.dart';

class StampCollectionFormalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _StampCollectionPageFormalState();
}

class _StampCollectionPageFormalState
    extends StampCollectionPageAbstractState<StampCollectionFormalPage> {
  @override
  Widget build(BuildContext context) {
    Widget body;

    if (items.isEmpty) {
      body = new Center(child: new Text("You have no Favorites yet"));
    } else {
      body = new GridView.extent(
        maxCrossAxisExtent: 190.0,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20,
        children: items
            .map(
              (Book book) => new Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(new FadeRoute(
                        builder: (BuildContext context) =>
                            new BookDetailsPageFormal(book),
                        settings: new RouteSettings(
                            name: '/book_detais_formal', arguments: false),
                      ));
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(19),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 33,
                              color: Color(0xFFD3D3D3).withOpacity(.84),
                            ),
                          ],
                        ),
                        child: Image.network(
                          book.url,
                          fit: BoxFit.contain,
                        )),
                  )),
            )
            .toList(),
      );
    }

    body = new Container(
      padding: const EdgeInsets.all(16.0),
      child: body,
      color: new Color(0xFFF5F5F5),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "My Favorites",
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      body: body,
    );
  }
}
