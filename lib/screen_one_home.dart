import 'package:flutter/material.dart';

class ScreenOneHome extends StatefulWidget {
  const ScreenOneHome({super.key});

  @override
  State<ScreenOneHome> createState() => _ScreenOneHomeState();
}

class _ScreenOneHomeState extends State<ScreenOneHome> {
  TextEditingController weidhtController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus Dados!";

  void _resetField() {
    weidhtController.text = "";
    heightController.text = "";
    setState(
      () {
        _infoText = "Informe seus dados!";
        _formKey = GlobalKey<FormState>();
      },
    );
  }

  void calculate() {
    setState(
      () {
        double weight = double.parse(weidhtController.text);
        double height = double.parse(heightController.text) / 100;
        double imc = weight / (height * height);
        if (imc < 18.6) {
          _infoText = "Peso abaixo do ideal (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 18.6 && imc <= 24.9) {
          _infoText = "Peso ideal (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 25 && imc <= 29.9) {
          _infoText = "Sobrepeso (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 30 && imc <= 34.9) {
          _infoText = "Obesidade Grau 1 (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 35 && imc <= 39.9) {
          _infoText = "Obesidade Grau 2 (${imc.toStringAsPrecision(4)})";
        } else if (imc > 40) {
          _infoText = "Obesidade Grau 3 (${imc.toStringAsPrecision(4)})";
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text("Calculadore de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetField,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                controller: weidhtController, // PESO
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 20.0),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira o peso";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: heightController, //ALTURA
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 20.0),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira sua altura";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      calculate();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        Colors.green, // Text Color (Foreground color)
                  ),
                  child: const Text(
                    'Calcular',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
