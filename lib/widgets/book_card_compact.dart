import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:books/model/Book.dart';

class BookCardCompact extends StatelessWidget {
  BookCardCompact(this.book, {@required this.onClick});

  final Book book;

  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onClick,
      child: new Container(
        margin: EdgeInsets.fromLTRB(16, 9, 98, 9),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
        child: new Row(
          children: <Widget>[
            new Hero(
              child: new Image.network(
                book.url,
                height: 150.0,
                width: 100.0,
              ),
              tag: book.id,
            ),
            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Text(" by " + book.author),

                    new SizedBox(
                      height: 8.0,
                    ),

                    new Text(
                      book.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.0),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),

                    new SizedBox(
                      height: 8.0,
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[200],
                          borderRadius: BorderRadius.circular(19),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 33,
                              color: Color(0xFFD3D3D3).withOpacity(.84),
                            ),
                          ],
                        ),
                        child: new Text(
                          book.categories,
                          style: TextStyle(
                              color: Colors.lightBlue[700],
                              fontWeight: FontWeight.bold),
                        )),
                    //   new SizedBox(height: 8.0,),
                    //    new Text(_short(book.subtitle, 30)),
                  ],
                ),
              ),
            ),
            new SizedBox(
              width: 16.0,
            )
          ],
        ),
      ),
    );
  }

  String _short(String title, int targetLength) {
    var list = title.split(" ");
    int buffer = 0;
    String result = "";
    bool showedAll = true;
    for (String item in list) {
      if (buffer + item.length <= targetLength) {
        buffer += item.length;
        result += item += " ";
      } else {
        showedAll = false;
        break;
      }
    }
    //Handle case of one very long word
    if (result == "" && title.length > 18) {
      result = title.substring(0, 18);
      showedAll = false;
    }

    if (!showedAll) result += "...";
    return result;
  }
}
