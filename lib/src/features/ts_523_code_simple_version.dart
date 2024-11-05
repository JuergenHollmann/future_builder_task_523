import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title= "hjh"});
   
  final String title;
 
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 
 // Simulierte Funktion, die Daten asynchron lädt (z.B. aus einer API)
  Future<String> fetchString() async {
    await Future.delayed(const Duration(seconds: 3)); // Wartezeit simulieren
    return "Cooler Text";
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),

      body: Center(
        child:  FutureBuilder(

         future: fetchString(), // Box

          builder: (context, snapshot) { 
            if (snapshot.connectionState == ConnectionState.waiting){ // Box leer
             return const CircularProgressIndicator();
            }
            else{ // Box voll
              return Text(snapshot.data!);
            } 

          }
        )
        )
      );
  }
}


