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

  Future<String>? zipCode;

  @override
  void initState() {
    super.initState();
    inputZipCode = TextEditingController();
  }

  /*--------------------------------- Controller ---*/
  late final TextEditingController inputZipCode;

  @override
  void dispose() {
    inputZipCode.dispose();
    super.dispose();
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
              // /*--------------------------------- FutureBuilder ---*/
              // das funktioniert auch:
              // FutureBuilder(
              //   future: zipCode,
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       // completed (with data)
              //       log("ConnectionState.hasData");
              //       //return Text(snapshot.data!);
              //       return Text(snapshot.data.toString());
              //     } else if (snapshot.hasError) {
              //       // completed (with error)
              //       log("ConnectionState.hasError");
              //       return Text('Fehler: ${snapshot.error}');
              //     } else if (snapshot.connectionState != ConnectionState.none &&
              //         !snapshot.hasData) {
              //       // uncompleted
              //       log("ConnectionState.waiting");
              //       return const CircularProgressIndicator();
              //     }
              //     log("Container");
              //     return Container();
              //   },
              // ),

              /*--------------------------------- TextField ---*/
              TextField(
                controller: inputZipCode,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Postleitzahl"),
              ),
              const SizedBox(height: 32),

              /*--------------------------------- FutureBuilder ---*/
              FutureBuilder<String>(
                future: zipCode,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // uncompleted
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      // completed (with data)
                      return Text(snapshot.data!);
                      //return Text(snapshot.data.toString()); // das funktioniert auch
                    } else if (snapshot.hasError) {
                      // completed (with error)
                      return Text('Fehler: ${snapshot.error}');
                    }
                  }
                  return const Text('Unbekannter Fehler');
                },
              ),

              /*--------------------------------- OutlinedButton ---*/
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    zipCode = getCityFromZip(inputZipCode.text);
                    log("OutlinedButton SUCHE geklickt");
                  });
                },
                child: const Text("Suche die Stadt nach Eingabe der PLZ"),
              ),

              /*--------------------------------- Text ---*/
              const SizedBox(height: 32),
              Text("Ergebnis: Noch keine PLZ gesucht",
                  style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }
}
