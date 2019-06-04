import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController leftScrollController;
  ScrollController rightScrollController;

  @override
  void initState() {
    super.initState();
    leftScrollController = ScrollController()
      ..addListener(() =>
          rightScrollController.jumpTo(leftScrollController.position.pixels));

    rightScrollController = ScrollController()
      ..addListener(() =>
          leftScrollController.jumpTo(rightScrollController.position.pixels));
  }

  @override
  void dispose() {
    super.dispose();
    leftScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
//        print(notification.metrics.toString());TODO
        leftScrollController.jumpTo(notification.metrics.pixels);
      },
      child: DualScroll(
          leftScrollController: leftScrollController,
          rightScrollController: rightScrollController),
    );
  }
}

class DualScroll extends StatelessWidget {
  final ScrollController leftScrollController;
  final ScrollController rightScrollController;

  const DualScroll({Key key, this.leftScrollController, this.rightScrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            controller: leftScrollController,
            itemBuilder: (_, i) => Container(
                  height: 100,
                  child: Center(),
                  color: i % 2 == 0 ? Colors.red : Colors.green,
                ),
          ),
        ),
        SizedBox(
          child: Placeholder(),
          width: 50.0,
        ),
        Expanded(
          child: ListView.builder(
            controller: rightScrollController,
            itemBuilder: (_, i) => Container(
                  height: 100,
                  child: Center(),
                  color: i % 2 == 0 ? Colors.red : Colors.green,
                ),
          ),
        ),
      ],
    );
  }
}
