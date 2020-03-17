import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageOffsetNotifier with ChangeNotifier {
  double _offset;
  double _page;
  PageOffsetNotifier(PageController pageController) {
    pageController.addListener(() {
      _offset = pageController.offset;
      _page = pageController.page;
      notifyListeners();
    });
  }

  double get offset => _offset;
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PageOffsetNotifier(_pageController),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              PageView(
                controller: _pageController,
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  LeopardPage(),
                  VulturePage(),
                ],
              ),
              AppBar(),
              LeopardImage(),
              VultureImage(),
            ],
          ),
        ),
      ),
    );
  }
}

class LeopardImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder:
          (BuildContext context, PageOffsetNotifier notifier, Widget child) {
        return Positioned(
          width: MediaQuery.of(context).size.width * 1.5,
          height: 250,
          left: notifier.offset == null ? 0 : -0.85 * notifier.offset,
          child: child,
        );
      },
      child: IgnorePointer(child: Image.asset('assets/leopard.png')),
    );
  }
}

class VultureImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder:
          (BuildContext context, PageOffsetNotifier notifier, Widget child) {
        return Positioned(
          left: notifier.offset == null
              ? 0
              : 1.16 * MediaQuery.of(context).size.width -
                  0.85 * notifier.offset,
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: IgnorePointer(
            child: Image.asset(
          'assets/vulture.png',
          height: MediaQuery.of(context).size.height / 3,
        )),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Padding(
        child: Row(
          children: <Widget>[
            Text(
              'SY',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            Spacer(),
            Icon(Icons.menu),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      ),
    );
  }
}

class LeopardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
//      Image.asset('assets/leopard.png');
  }
}

class VulturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
//    return Center(
//      child: Padding(
//        padding: const EdgeInsets.only(bottom: 50.0, right: 35.0),
//        child: Image.asset(
//          'assets/vulture.png',
//          height: MediaQuery.of(context).size.height / 3,
//        ),
//      ),
//    );
  }
}
