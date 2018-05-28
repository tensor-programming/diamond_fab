import 'package:flutter/material.dart';
import 'package:diamond_fab/diamond_fab.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diamond Fab Example'),
      ),
      body: Container(),
      floatingActionButton: DiamondFab(
        color: Colors.amber,
        child: Icon(Icons.home),
        onPressed: () {},
        notchMargin: 10.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60.0,
          color: Colors.indigoAccent,
        ),
      ),
    );
  }
}
