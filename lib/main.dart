
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main(){



  runApp(const MyApp());
}

class CalorieStorage{


  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _getCals async {
    final path = await _localPath;
    return File('$path/calories.txt');
  }
  Future<File> get _getProtein async {
    final path = await _localPath;
    return File('$path/protein.txt');
  }


  Future<File> writeCalories(int counter) async {
    final file = await _getCals;

    // Write the file
    return file.writeAsString('$counter');
  }
  Future<File> writeProtein(int counter) async {
    final file = await _getProtein;

    // Write the file
    return file.writeAsString('$counter');
  }

  Future<int> readCalories() async {
    try {
      final file = await _getCals;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }
  Future<int> readProtein() async {
    try {
      final file = await _getProtein;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }




  // int _counter = readCalories();
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'quickCal - Calorie Counter .3beta',storage: CalorieStorage(),),
    );
  }
}

class MyHomePage extends StatefulWidget {

  final CalorieStorage storage;
  const MyHomePage({super.key, required this.title, required this.storage});


  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {






  final calController = TextEditingController();
  final proController = TextEditingController();

  int _counter = 0;
  int _proteinCounter = 0;




  _increaseCalories(var calories) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter = _counter + int.parse(calories);

      widget.storage.writeCalories(_counter);

      widget.storage.readCalories().then((value){
        _counter = value;
      });






    });
    // print(calories.toString());
  }
  _increaseProtein(var protein) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _proteinCounter = _proteinCounter + int.parse(protein);

       widget.storage.writeProtein(_proteinCounter);

      widget.storage.readProtein().then((value){
        _proteinCounter = value;
      });






    });
    // print(calories.toString());
  }



  _decreaseCalories(var calories) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if(!((_counter - int.parse(calories)) <= -1) ) {
        _counter = _counter - int.parse(calories);
        widget.storage.writeCalories(_counter);
        widget.storage.readCalories().then((value){
          _counter = value;
        });


      }else{
        var x = _counter - int.parse(calories);
        // print(x);
        showDialog<String>(
          context: this.context,
          builder: (BuildContext context) => AlertDialog(
            title: const Center(child: Text('Calories cannot be below 0')),
            content: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Calories cannot be below 0'),
              ],
            ),
            // content: const Text('AlertDialog description'),
            actions: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ],
          ),
        );

      }
    });
    // print(calories.toString());
  }

  _decreaseProtein(var protein) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if(!((_proteinCounter - int.parse(protein)) <= -1) ) {
        _proteinCounter = _proteinCounter - int.parse(protein);
        widget.storage.writeProtein(_proteinCounter);
        widget.storage.readProtein().then((value){
          _proteinCounter = value;
        });


      }else{
        var x = _proteinCounter - int.parse(protein);
        // print(x);
        showDialog<String>(
          context: this.context,
          builder: (BuildContext context) => AlertDialog(
            title: const Center(child: Text('Protein cannot be below 0')),
            content: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Protein cannot be below 0'),
              ],
            ),
            // content: const Text('AlertDialog description'),
            actions: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ],
          ),
        );

      }
    });
    // print(calories.toString());
  }

  @override
  Widget build(BuildContext context) {

    final CalorieStorage storage;

    widget.storage.readCalories().then((value) {
      setState(() {
        _counter = value;
      });
    });
    widget.storage.readProtein().then((value) {
      setState(() {
        _proteinCounter = value;
      });
    });
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child:
          Padding(
            padding:const EdgeInsets.fromLTRB(5,20,5,10),
            child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text(
              'cals',
            ),
            Row(
              children: [

                  Expanded(
                    child: TextField(
                      controller: calController,
                      keyboardType:  TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        // for below version 2 use this
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// for version 2 and greater you can also use this
                        FilteringTextInputFormatter.digitsOnly

                      ],

                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Calories',
                      ),

                    ),
                  ),

                IconButton(
                  // statesController: statesController,
                  // style: widget.style,
                  // onPressed: widget.onPressed,
                  onPressed: ()=>{
                    if(calController.text!=""){
                      _increaseCalories(calController.text),
                      calController.clear()
                    }else{
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Center(child: Text('Enter Calories')),
                          content: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Calories cannot be blank'),
                            ],
                          ),
                          // content: const Text('AlertDialog description'),
                          actions: <Widget>[

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    }

                  },
                  icon: const Icon(Icons.add,
                    color: Colors.green,),

                ),
                IconButton(
                  // statesController: statesController,
                  // style: widget.style,
                  // onPressed: widget.onPressed,
                  onPressed: ()=>{
                    if(calController.text!=""){
                      _decreaseCalories(calController.text),
                      calController.clear()
                    }else{
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Center(child: Text('Enter Calories')),
                          content: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Calories cannot be blank'),
                            ],
                          ),
                          // content: const Text('AlertDialog description'),
                          actions: <Widget>[

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    }

                  },
                  icon: const Icon(Icons.remove,
                    color: Colors.green,),
                )

              ],
            ),
            Text(
              '$_proteinCounter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text(
              'protein (g)',
            ),
            Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: proController,
                    keyboardType:  TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      // for below version 2 use this
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// for version 2 and greater you can also use this
                      FilteringTextInputFormatter.digitsOnly

                    ],

                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Protein Grams',
                    ),

                  ),
                ),

                IconButton(
                  // statesController: statesController,
                  // style: widget.style,
                  // onPressed: widget.onPressed,
                  onPressed: ()=>{
                    if(proController.text!=""){
                      _increaseProtein(proController.text),
                      proController.clear()
                    }else{
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Center(child: Text('Enter Protein')),
                          content: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Protein cannot be blank'),
                            ],
                          ),
                          // content: const Text('AlertDialog description'),
                          actions: <Widget>[

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    }

                  },
                  icon: const Icon(Icons.add,
                    color: Colors.green,),

                ),
                IconButton(
                  // statesController: statesController,
                  // style: widget.style,
                  // onPressed: widget.onPressed,
                  onPressed: ()=>{
                    if(proController.text!=""){
                      _decreaseProtein(proController.text),
                      proController.clear()
                    }else{
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Center(child: Text('Enter Protein')),
                          content: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Protein cannot be blank'),
                            ],
                          ),
                          // content: const Text('AlertDialog description'),
                          actions: <Widget>[

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    }

                  },
                  icon: const Icon(Icons.remove,
                    color: Colors.green,),
                )

              ],
            ),
          ],
        ),
      ),
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>{


          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Center(child: Text('Clear All?')),
              content:
              // content: const Text('AlertDialog description'),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () =>{

                        Navigator.pop(context, 'OK'),

                        setState(() {
                          _counter=0;
                          widget.storage.writeCalories(_counter);
                          widget.storage.readCalories().then((value){
                            _counter = value;
                          });
                          _proteinCounter=0;
                          widget.storage.writeProtein(_proteinCounter);
                          widget.storage.readProtein().then((value){
                            _proteinCounter = value;
                          });


                        })


                      },
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () =>{

                        Navigator.pop(context, 'OK'),



                      },
                      child: const Text('No'),
                    ),
                  ],
                ),

            ),
          ),





        },
        tooltip: 'Set Calories/Protein to 0',
        child: const Icon(Icons.clear),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


