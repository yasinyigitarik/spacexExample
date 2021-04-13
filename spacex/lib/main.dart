import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacex/appRepo.dart';
import 'package:spacex/styles.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => AppRepo(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AppRepo>().getSpacexData(context);
  }

  @override
  Widget build(BuildContext context) {
    var _appRepo = Provider.of<AppRepo>(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Colors.yellow[800],
            Colors.yellow[700],
            Colors.yellow[600],
            Colors.yellow[400],
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                onPressed: () {
                  _appRepo.getSpacexData(context);
                })
          ],
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Text(
            'SpaceX',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                _appRepo.data['links']['patch']['small']))),
                  ),
                  Text(
                    _appRepo.data['name'].toString(),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(_appRepo.data['details']),
              )
            ],
          ),
        ),
      ),
    );
  }
}
