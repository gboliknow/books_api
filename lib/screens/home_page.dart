import 'package:books/res/custom_colors.dart';
import 'package:books/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:books/data/repository.dart';
import 'package:books/model/Book.dart';
import 'package:books/utils/index_offset_curve.dart';
import 'package:books/widgets/collection_preview.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController cardsFirstOpenController;

  bool init = true;

  @override
  void initState() {
    super.initState();
    cardsFirstOpenController = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1300));

    Repository.get().init().then((it) {
      setState(() {
        init = false;
      });
    });
    cardsFirstOpenController.forward(from: 0.2);
  }

  @override
  void dispose() {
    cardsFirstOpenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: init
            ? new Container()
            : new CustomScrollView(
                slivers: <Widget>[
                  new SliverAppBar(
                    actions: <Widget>[
                      GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()));
                        },
                        child: Center(
                          child: Icon(
                            Icons.exit_to_app,
                            color: CustomColors.firebaseOrange,
                          ),
                        ),
                      ),
                      new IconButton(
                        icon: new Icon(
                          Icons.search,
                          color: CustomColors.firebaseOrange,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/search_formal');
                        },
                      ),
                      new IconButton(
                        icon: new Icon(
                          Icons.favorite,
                          color: CustomColors.firebaseOrange,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/stamp_collection_formal');
                        },
                      ),
                    ],
                    backgroundColor: Colors.white,
                    elevation: 2.0,
                    iconTheme: new IconThemeData(color: Colors.black),
                    floating: true,
                    forceElevated: true,
                  ),
                  new SliverList(
                      delegate: new SliverChildListDelegate(
                    [
                      myCollection(),
                      collectionPreview(new Color(0xffffffff), "Biographies", [
                        "wO3PCgAAQBAJ",
                        "_LFSBgAAQBAJ",
                        "8U2oAAAAQBAJ",
                        "yG3PAK6ZOucC"
                      ]),
                      wrapInAnimation(
                          collectionPreview(new Color(0xffffffff), "Fiction", [
                            "OsUPDgAAQBAJ",
                            "3e-dDAAAQBAJ",
                            "-ITZDAAAQBAJ",
                            "rmBeDAAAQBAJ",
                            "vgzJCwAAQBAJ"
                          ]),
                          2),
                      wrapInAnimation(
                          collectionPreview(
                              new Color(0xffffffff),
                              "Mystery & Thriller",
                              ["1Y9gDQAAQBAJ", "Pz4YDQAAQBAJ", "UXARDgAAQBAJ"]),
                          3),
                      wrapInAnimation(
                          collectionPreview(
                              new Color(0xffffffff), "Sience Ficition", [
                            "JMYUDAAAQBAJ",
                            "PzhQydl-QD8C",
                            "nkalO3OsoeMC",
                            "VO8nDwAAQBAJ",
                            "Nxl0BQAAQBAJ"
                          ]),
                          4),
                    ],
                  ))
                ],
              ));
  }

  Widget wrapInAnimation(Widget child, int index) {
    Animation offsetAnimation = new CurvedAnimation(
        parent: cardsFirstOpenController, curve: new IndexOffsetCurve(index));
    Animation fade =
        new CurvedAnimation(parent: offsetAnimation, curve: Curves.ease);
    return new SlideTransition(
        position: new Tween<Offset>(
                begin: new Offset(0.5, 0.0), end: new Offset(0.0, 0.0))
            .animate(fade),
        child: new FadeTransition(
          opacity: fade,
          child: child,
        ));
  }

  Widget collectionPreview(Color color, String name, List<String> ids) {
    return new FutureBuilder<List<Book>>(
      future: Repository.get().getBooksByIdFirstFromDatabaseAndCache(ids),
      builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
        List<Book> books = [];
        if (snapshot.data != null) books = snapshot.data;
        return new CollectionPreview(
          books: books,
          color: color,
          title: name,
          loading: snapshot.data == null,
        );
      },
    );
  }

  Widget myCollection() {
    return new FutureBuilder<List<Book>>(
      future: Repository.get().getFavoriteBooks(),
      builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
        List<Book> books = [];
        if (snapshot.data != null) books = snapshot.data;
        if (books.isEmpty) {
          return new Container();
        }
        return new CollectionPreview(
          books: books,
          //color: new Color(0xffFC96BC),
          color: new Color(0xffffffff),
          title: "My Favorites",
          loading: snapshot.data == null,
        );
      },
    );
  }
}
