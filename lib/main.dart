import 'package:dio/dio.dart';
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _http = Dio(
    BaseOptions(baseUrl: 'https://reqres.in/'),
  );

  final List<Map<String, dynamic>> _users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users: ${_users.length}'),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final _post = _users[index];

          return ListTile(
            title: Text(
              _post['name'],
            ),
            subtitle: Text(
              _post['email'],
            ),
          );
        },
        itemCount: _users.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          _fetchData(page: 1, limit: 10);
        },
      ),
    );
  }

  _fetchData({int page, int limit}) {
    _http.get('/api/users?page=$page&per_page=$limit').then((response) {
      final _fetchedUsers = (response.data['data'] as List)
        .map((_user) => {
          'id': _user['id'],
          'email': _user['email'],
          'name': '${_user['first_name']} ${_user['last_name']}',
        })
        .toList();

      setState(() {
        _users.addAll(_fetchedUsers);
      });
    });
  }
}
