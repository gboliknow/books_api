import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'package:books/model/Book.dart';
import 'package:books/screens/formal/book_details_page_formal.dart';
import 'package:books/utils/utils.dart';

class CollectionPreview extends StatefulWidget {
  final List<Book> books;

  final Color color;

  final String title;

  final bool loading;

  CollectionPreview(
      {this.color = Colors.white,
      @required this.title,
      this.books,
      this.loading = false});

  @override
  State<StatefulWidget> createState() => new _CollectionPreviewState();
}

class _CollectionPreviewState extends State<CollectionPreview> {
  @override
  Widget build(BuildContext context) {
    const textStyle = const TextStyle(
        fontSize: 32.0, fontFamily: 'CrimsonText', fontWeight: FontWeight.w400);
    return new ClipRect(
      child: new Align(
        heightFactor: 1,
        alignment: Alignment.topCenter,
        child: new ConstrainedBox(
          constraints: new BoxConstraints(
              minWidth: double.infinity,
              maxWidth: double.infinity,
              minHeight: 0.0,
              maxHeight: double.infinity),
          child: new Container(
              padding: const EdgeInsets.all(8),
              color: widget.color,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //       new Divider(color: Colors.black,),
                  new Text(
                    widget.title,
                    style: textStyle,
                  ),

                  new Stack(
                    children: <Widget>[
                      new SizedBox(
                        height: 200.0,
                        child: new ListView(
                            scrollDirection: Axis.horizontal,
                            children: widget.books
                                .map(
                                  (book) => new Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(new FadeRoute(
                                            builder: (BuildContext context) =>
                                                new BookDetailsPageFormal(book),
                                            settings: new RouteSettings(
                                                name: '/book_detais_formal',
                                                arguments: false),
                                          ));
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(14),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(19),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: Offset(0, 10),
                                                  blurRadius: 33,
                                                  color: Color(0xFFD3D3D3)
                                                      .withOpacity(.84),
                                                ),
                                              ],
                                            ),
                                            child: Image.network(
                                              book.url,
                                              fit: BoxFit.contain,
                                            )),
                                      )),
                                )
                                .toList()),
                      ),
                      widget.loading
                          ? new Center(
                              child: new CircularProgressIndicator(),
                            )
                          : new Container(),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
