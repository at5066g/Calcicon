import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PeopleList(),
    );
  }
}

class PeopleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('About the App'),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade200, Colors.blue.shade400],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'This App was created by:',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Row(
                children: [
                  Expanded(
                    child: PersonInfo(
                      name: 'Abinash Choudhury',
                      image: 'assets/images/Abinash.jpg',
                      contact: 'USN: 1MS22AD004\nEmail: abinash0949@gmail.com',
                    ),
                  ),
                  Expanded(
                    child: PersonInfo(
                      name: 'Anurag Tripathi',
                      image: 'assets/images/Anurag.jpg',
                      contact: 'USN: 1MS22AD012\nEmail: at507760@gmail.com',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class PersonInfo extends StatelessWidget {
  final String name;
  final String image;
  final String contact;

  PersonInfo({required this.name, required this.image, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          image,
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            contact,
            style: TextStyle(
                fontSize: 20, fontStyle: FontStyle.italic, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
