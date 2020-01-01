import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=6660ec69";

void main() async {
//  http.Response response = await http.get(request);
//  print(json.decode(response.body)["results"]["currencies"]["USD"]);

//  print(await getData());

  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        hintColor: Colors.amber,
//        primaryColor: Colors.white
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)))),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar;
  double euro;

  void _realChanged(String text) {
//    print(text);
  if(text.isEmpty){
    _clearAll();
  }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
//    print(text);
    if(text.isEmpty){
      _clearAll();
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
//    print(text);
    if(text.isEmpty){
      _clearAll();
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  child: Text(
                "Carregando dados...",
                style: TextStyle(color: Colors.amber, fontSize: 25.0),
                textAlign: TextAlign.center,
              ));
            default:
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Erro ao carregar dados :(",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
              } else {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

//                    return Container(color: Colors.green,);
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on,
                          size: 150.0, color: Colors.amber),
                      buildTextField(
                          "Reais", "R\$ ", realController, _realChanged),
//                      TextField(
//                        decoration: InputDecoration(
//                            labelText: "Reais",
//                            labelStyle: TextStyle(color: Colors.amber),
//                            border: OutlineInputBorder(),
//                            prefixText: "R\$ "),
//                        style: TextStyle(color: Colors.amber, fontSize: 25.0),
//                      ),
                      Divider(),
                      buildTextField(
                          "Dolares", "US\$ ", dolarController, _dolarChanged),
//                      TextField(
//                        decoration: InputDecoration(
//                            labelText: "Dolares",
//                            labelStyle: TextStyle(color: Colors.amber),
//                            border: OutlineInputBorder(),
//                            prefixText: "US\$ "),
//                        style: TextStyle(color: Colors.amber, fontSize: 25.0),
//                      ),
                      Divider(),
                      buildTextField(
                          "Euros", "€ ", euroController, _euroChanged),
//                      TextField(
//                        decoration: InputDecoration(
//                            labelText: "Euros",
//                            labelStyle: TextStyle(color: Colors.amber),
//                            border: OutlineInputBorder(),
//                            prefixText: "€ "),
//                        style: TextStyle(color: Colors.amber, fontSize: 25.0),
//                      )
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }
}

Widget buildTextField(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(color: Colors.amber, fontSize: 25.0),
    onChanged: f,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
  );
}
