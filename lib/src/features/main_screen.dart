/* ts_523 FutureBuilder
Die App besteht aus nur einem Screen und soll zu einer beliebigen Postleitzahl aus der Eingabe die entsprechende Stadt finden und im Text unter dem Button anzeigen.

√ Eine asynchrone Funktion getCityFromZip für die Suche ist bereits implementiert.
√ Implementiere im UI einen FutureBuilder, sodass du ein Ladesymbol anzeigen kannst, solange die Methode noch lädt.

Schritte zur Lösung der Aufgabe:
Erstelle einen TextEditingController, sodass du das Textfeld auslesen kannst, wenn der Button gedrückt wird.
Erstelle eine Variable im State für das Future (nullable).
Erstelle einen FutureBuilder, der das Future verwendet.
√ Reagiere auf die 3 Zustände uncompleted, completed (with data), completed (with error).
√ Setze die Variable (State), sobald der Button gedrückt wird.
Pushe deine Änderungen dann auf GitHub und kopiere den Link zu deinem GitHub-Repository in das Antwortfeld. */

import 'dart:developer';

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<String> getCityFromZip(String zip) async {
    log("simuliere Dauer der Datenbank-Anfrage");
    await Future.delayed(const Duration(seconds: 1));

    switch (zip) {
      case "10115":
        return 'Berlin';
      case "20095":
        return 'Hamburg';
      case "80331":
        return 'München';
      case "50667":
        return 'Köln';
      case "60311":
      case "60313":
        return 'Frankfurt am Main';
      case "73525":
        return 'Schwäbisch Gmünd';
      case "11111":
        return 'Gurkenstadt';
      default:
        return 'Unbekannte Stadt';
    }
  }

  //String get zip => "";

  @override
  void initState() {
    super.initState();

    // Future<String> getCityFromZip; //(String zip);
    // Future<String> getCityFromZip(zipCode);
    getCityFromZip;
    // String zipCode = "11111";
    /*--------------------------------- Controller ---*/
    // final TextEditingController inputZipCode = TextEditingController();
    // String inputZipCode = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*--------------------------------- FutureBuilder ---*/
              FutureBuilder(
                // future: getCityFromZip, // funzt nicht
                // future: getCityFromZip(zip), // funzt nicht
                // future: getCityFromZip("11111"), // funzt nicht
                future: getCityFromZip(), // Berlin
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // completed (with data)
                    log("ConnectionState.hasData");
                    return Text(snapshot.data!);
                    //return Text(snapshot.data.toString());
                  } else if (snapshot.hasError) {
                    // completed (with error)
                    log("ConnectionState.hasError");
                    return Text('Fehler: ${snapshot.error}');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    // uncompleted
                    log("ConnectionState.waiting");
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    log("ConnectionState.done");
                    //return Text(snapshot.data!);
                  }
                  log("Unbekannter Fehler");
                  return const Text('Unbekannter Fehler');
                },
              ),

              /*--------------------------------- TextField ---*/
              const TextField(
                //controller: inputZipCode,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Postleitzahl"),
              ),
              const SizedBox(height: 32),

              // /*--------------------------------- FutureBuilder ---*/
              // FutureBuilder<String>(
              //   // future: getCityFromZip, // funzt nicht
              //   // future: getCityFromZip(zip), // funzt nicht
              //   future: getCityFromZip(""), // funzt nicht
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       // uncompleted
              //       return const CircularProgressIndicator();
              //     } else if (snapshot.connectionState == ConnectionState.done) {
              //       if (snapshot.hasData) {
              //         // completed (with data)
              //         return Text(snapshot.data!);
              //         //return Text(snapshot.data.toString());
              //       } else if (snapshot.hasError) {
              //         // completed (with error)
              //         return Text('Fehler: ${snapshot.error}');
              //       }
              //     }
              //     return const Text('Unbekannter Fehler');
              //   },
              // ),

              /*--------------------------------- OutlinedButton ---*/
              OutlinedButton(
                onPressed: () {
                  // todo: implementiere Suche
                  setState(() {
                    getCityFromZip;

                    // log("OutlinedButton SUCHE geklickt");
                    // getCityFromZip;
                  });
                  log("OutlinedButton SUCHE geklickt");
                  //getCityFromZip;
                },
                child: const Text("Suche die Stadt nach Eingabe der PLZ"),
              ),
              //--------------------------------- Text ---*/
              const SizedBox(height: 32),

              // /*--------------------------------- FutureBuilder ---*/
              // FutureBuilder(
              //   // future: getCityFromZip, // funzt nicht
              //   // future: getCityFromZip(zip), // funzt nicht
              //   future: getCityFromZip(), // funzt nicht
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       // uncompleted
              //       return const CircularProgressIndicator();
              //     } else if (snapshot.connectionState == ConnectionState.done) {
              //       if (snapshot.hasData) {
              //         // completed (with data)
              //         return Text(snapshot.data!);
              //         //return Text(snapshot.data.toString());
              //       } else if (snapshot.hasError) {
              //         // completed (with error)
              //         return Text('Fehler: ${snapshot.error}');
              //       }
              //     }
              //     return const Text('Unbekannter Fehler');
              //   },
              // ),

              Text("Ergebnis: Noch keine PLZ gesucht",
                  style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // todo: dispose controllers // contoller entsorgen
    super.dispose();
  }
}
