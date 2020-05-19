import 'package:flutter/material.dart';

void main() {
  runApp(InfiniteScroll());
}

class InfiniteScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Infinite Scroll',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Infinite Scroll'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> _posts = [
    {
      'id': 1,
      'title': 'Foo',
      'body': 'Lorem',
    },
    {
      'id': 2,
      'title': 'Bar',
      'body': 'Ipsum',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final _post = _posts[index];

          return ListTile(
            title: Text(_post['title']),
            subtitle: Text(_post['body']),
          );
        },
        itemCount: _posts.length,
      ),
    );
  }
}
