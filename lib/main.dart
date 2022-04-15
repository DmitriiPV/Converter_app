import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      // home: Scaffold(
      //   appBar: AppBar(
      //     centerTitle: true,
      //     title: Text(
      //       'Converter',
      //     ),
      //   ),
      //   body: HomeScreen(),
      // ),
      initialRoute: '/',
      routes: {
        '/':(context) => HomeScreen(),
        '/weight':(context) => WeightRoute(),
        '/length':(context) => LengthRoute(),
        '/tempe':(context) => TempeRoute(),
        '/coins':(context) => CoinsRoute(),
        '/pressure':(context) => PressureRoute(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}
class _HomeScreen extends State <HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Card(child: ListTile(
              title: Text("Масса"),
              onTap: (){Navigator.pushNamed(context, '/weight');}
          ),),
          Card(child: ListTile(
              title: Text("Длина"),
              onTap: (){Navigator.pushNamed(context, '/length');}
          ),),
          Card(child: ListTile(
              title: Text("Температура"),
              onTap: (){Navigator.pushNamed(context, '/tempe');}
          ),),
          Card(child: ListTile(
              title: Text("Валюта"),
              onTap: (){Navigator.pushNamed(context, '/coins');}
          ),),
          Card(child: ListTile(
              title: Text("Давление"),
              onTap: (){Navigator.pushNamed(context, '/pressure');}
          ),),
        ],
      ),
    );

  }
}

class WeightRoute extends StatefulWidget {
  @override
  _WeightRoute createState() => _WeightRoute();
}
class _WeightRoute extends State<WeightRoute> {

  final TextStyle labelStyle = TextStyle(
    fontSize: 16.0,
  );
  final TextStyle resultSyle = TextStyle(
    color: Colors.teal,
    fontSize: 25.0,
    fontWeight: FontWeight.w700,
  );

  final List<String> _mesaures = [
    'Грамм',
    'Килограмм',
  ];

  double? _value;
  String _fromMesaures = 'Грамм';
  String _toMesaures = 'Килограмм';
  String _results = "";

  final Map<String, int> _mesauresMap = {
    'Грамм': 0,
    'Килограмм': 1,
  };

  dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 2204,62, 35274, 0, 0,],
    '1': [1000, 1, 0, 0, 2.20462, 35.274, 0, 0,],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Введите значение',
                ),
                onChanged: (value) {
                  setState(() {
                    _value = double.parse(value);
                  });
                },
              ),
              SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From',
                        style: labelStyle,
                      ),
                      DropdownButton(
                        items: _mesaures
                            .map((String value) => DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _fromMesaures = val as String;
                          });
                        },
                        value: _fromMesaures,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('To', style: labelStyle),
                      DropdownButton(
                        items: _mesaures
                            .map((String value) => DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _toMesaures = val as String;
                          });
                        },
                        value: _toMesaures,
                      )
                    ],
                  ),
                ],
              ),
              MaterialButton(
                minWidth: double.infinity,
                onPressed: _convert,
                child: Text(
                  'Конвертировать',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 25.0),
              Text(
                _results,
                style: resultSyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _convert() {
    print('Button Clicked');
    print(_mesaures);
    print(_mesauresMap);

    print(_fromMesaures);
    print(_toMesaures);
    print(_formulas);

    if (_value != 0 && _fromMesaures.isNotEmpty && _toMesaures.isNotEmpty) {
      int from = _mesauresMap[_fromMesaures]!;
      int to = _mesauresMap[_toMesaures]!;
      print(from);
      print(to);
      var multiplier = _formulas[from.toString()][to];
      // print(multiplier);
      setState(() {
        _results =
        "$_value $_fromMesaures = ${(_value as dynamic) * multiplier} $_toMesaures";
      });
    } else {
      setState(() {
        _results = "Введите не нулевое значение";
      });
    }
  }
}

class LengthRoute extends StatefulWidget {
  @override
  _LengthRoute createState() => _LengthRoute();
}
class _LengthRoute extends State<LengthRoute> {
  final TextStyle labelStyle = TextStyle(
    fontSize: 16.0,
  );
  final TextStyle resultSyle = TextStyle(
    color: Colors.teal,
    fontSize: 25.0,
    fontWeight: FontWeight.w700,
  );

  final List<String> _mesaures = [
    'Метр',
    'Километр',
    'Миля',
    'Фут',
    'Дюймы',
  ];

  double? _value;
  String _fromMesaures = 'Метр';
  String _toMesaures = 'Километр';
  String _results = "";

  final Map<String, int> _mesauresMap = {
    'Метр': 0,
    'Километр': 1,
    'Миля': 2,
    'Фут': 3,
    'Дюймы' : 4,
  };

  dynamic _formulas = {
    '0': [1, 0.001, 0.000621371, 3.28, 39.37],
    '1': [1000, 1, 0.621371, 3280.84, 39370.08],
    '2': [1609.34, 1.60934, 1, 5280, 63360],
    '3': [0.3048, 0.0003048, 0.00019, 1, 12],
    '4': [0.025, 0,000025, 0,000016, 0.083, 1],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Введите значение',
                ),
                onChanged: (value) {
                  setState(() {
                    _value = double.parse(value);
                  });
                },
              ),
              SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From',
                        style: labelStyle,
                      ),
                      DropdownButton(
                        items: _mesaures
                            .map((String value) => DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _fromMesaures = val as String;
                          });
                        },
                        value: _fromMesaures,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('To', style: labelStyle),
                      DropdownButton(
                        items: _mesaures
                            .map((String value) => DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _toMesaures = val as String;
                          });
                        },
                        value: _toMesaures,
                      )
                    ],
                  ),
                ],
              ),
              MaterialButton(
                minWidth: double.infinity,
                onPressed: _convert,
                child: Text(
                  'Конвертировать',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 25.0),
              Text(
                _results,
                style: resultSyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _convert() {
    print('Button Clicked');
    print(_mesaures);
    print(_mesauresMap);

    print(_fromMesaures);
    print(_toMesaures);
    print(_formulas);

    if (_value != 0 && _fromMesaures.isNotEmpty && _toMesaures.isNotEmpty) {
      int from = _mesauresMap[_fromMesaures]!;
      int to = _mesauresMap[_toMesaures]!;
      print(from);
      print(to);
      var multiplier = _formulas[from.toString()][to];
      // print(multiplier);
      setState(() {
        _results =
        "$_value $_fromMesaures = ${(_value as dynamic) * multiplier} $_toMesaures";
      });
    } else {
      setState(() {
        _results = "Введите не нулевое значение";
      });
    }
  }
}

class TempeRoute extends StatefulWidget {
  @override
  _TempeRoute createState() => _TempeRoute();
}
class _TempeRoute extends State<TempeRoute> {
  late double input;
  late double output;
  late bool fOrC;

  @override
  void initState() {
    super.initState();
    input = 0.0;
    output = 0.0;
    fOrC = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (str) {
                  try {
                    input = double.parse(str);
                  } catch (e) {
                    input = 0.0;
                  }
                },
                decoration: InputDecoration(
                  labelText:
                  "Введите значение в ${fOrC == false ? "Фаренгейтах" : "Цельсиях"}",
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: <Widget>[
                    Text("F"),
                    Radio<bool>(
                        groupValue: fOrC,
                        value: false,
                        onChanged: (v) {
                          setState(() {
                            fOrC = v!;
                          });
                        }),
                    Text("C"),
                    Radio<bool>(
                        groupValue: fOrC,
                        value: true,
                        onChanged: (v) {
                          setState(() {
                            fOrC = v!;
                          });
                        }),
                  ],
                ),
              ),
              Container(
                child: MaterialButton(
                  minWidth: double.infinity,
                  child: Text(
                    'Конвентировать',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,

                  onPressed: () {
                    setState(() {
                      fOrC == false
                          ? output = (input - 32) * (5 / 9)
                          : output = (input * 9 / 5) + 32;
                    });
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: fOrC == false
                            ? Text(
                            "${input.toStringAsFixed(2)} F : ${output.toStringAsFixed(2)} C")
                            : Text(
                            "${input.toStringAsFixed(2)} C : ${output.toStringAsFixed(2)} F"),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}

class CoinsRoute extends StatefulWidget {
  @override
  _CoinsRoute createState() => _CoinsRoute();
}
class _CoinsRoute extends State<CoinsRoute> {
  final TextStyle labelStyle = TextStyle(
    fontSize: 16.0,
  );
  final TextStyle resultSyle = TextStyle(
    color: Colors.teal,
    fontSize: 25.0,
    fontWeight: FontWeight.w700,
  );

  final List<String> _mesaures = [
    'Доллар',
    'Рубль',
  ];

  double? _value;
  String _fromMesaures = 'Доллар';
  String _toMesaures = 'Рубль';
  String _results = "";

  final Map<String, int> _mesauresMap = {
    'Доллар': 0,
    'Рубль': 1,
  };

  dynamic _formulas = {
    '0': [1, 79.63, 0, 0],
    '1': [0.012558, 1, 0, 0],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Введите значение',
                ),
                onChanged: (value) {
                  setState(() {
                    _value = double.parse(value);
                  });
                },
              ),
              SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From',
                        style: labelStyle,
                      ),
                      DropdownButton(
                        items: _mesaures
                            .map((String value) => DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _fromMesaures = val as String;
                          });
                        },
                        value: _fromMesaures,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('To', style: labelStyle),
                      DropdownButton(
                        items: _mesaures
                            .map((String value) => DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _toMesaures = val as String;
                          });
                        },
                        value: _toMesaures,
                      )
                    ],
                  ),
                ],
              ),
              MaterialButton(
                minWidth: double.infinity,
                onPressed: _convert,
                child: Text(
                  'Конвентировать',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 25.0),
              Text(
                _results,
                style: resultSyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _convert() {
    print('Button Clicked');
    print(_mesaures);
    print(_mesauresMap);

    print(_fromMesaures);
    print(_toMesaures);
    print(_formulas);

    if (_value != 0 && _fromMesaures.isNotEmpty && _toMesaures.isNotEmpty) {
      int from = _mesauresMap[_fromMesaures]!;
      int to = _mesauresMap[_toMesaures]!;
      print(from);
      print(to);
      var multiplier = _formulas[from.toString()][to];
      // print(multiplier);
      setState(() {
        _results =
        "$_value $_fromMesaures = ${(_value as dynamic) * multiplier} $_toMesaures";
      });
    } else {
      setState(() {
        _results = "Введите не нулевое значение";
      });
    }
  }
}

class PressureRoute extends StatefulWidget {
  @override
  _PressureRoute createState() => _PressureRoute();
}
class _PressureRoute extends State<PressureRoute> {
  final TextStyle labelStyle = TextStyle(
    fontSize: 16.0,
  );
  final TextStyle resultSyle = TextStyle(
    color: Colors.teal,
    fontSize: 25.0,
    fontWeight: FontWeight.w700,
  );

  final List<String> _mesaures = [
    'мм рт.столба',
    'Па',
  ];

  double? _value;
  String _fromMesaures = 'мм рт.столба';
  String _toMesaures = 'Па';
  String _results = "";

  final Map<String, int> _mesauresMap = {
    'мм рт.столба': 0,
    'Па': 1,
  };

  dynamic _formulas = {
    '0': [1, 133.32, 0, 0],
    '1': [0.0075, 1, 0, 0],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Введите значение',
                ),
                onChanged: (value) {
                  setState(() {
                    _value = double.parse(value);
                  });
                },
              ),
              SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From',
                        style: labelStyle,
                      ),
                      DropdownButton(
                        items: _mesaures
                            .map((String value) => DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _fromMesaures = val as String;
                          });
                        },
                        value: _fromMesaures,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('To', style: labelStyle),
                      DropdownButton(
                        items: _mesaures
                            .map((String value) => DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _toMesaures = val as String;
                          });
                        },
                        value: _toMesaures,
                      )
                    ],
                  ),
                ],
              ),
              MaterialButton(
                minWidth: double.infinity,
                onPressed: _convert,
                child: Text(
                  'Convert',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 25.0),
              Text(
                _results,
                style: resultSyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _convert() {
    print('Button Clicked');
    print(_mesaures);
    print(_mesauresMap);

    print(_fromMesaures);
    print(_toMesaures);
    print(_formulas);

    if (_value != 0 && _fromMesaures.isNotEmpty && _toMesaures.isNotEmpty) {
      int from = _mesauresMap[_fromMesaures]!;
      int to = _mesauresMap[_toMesaures]!;
      print(from);
      print(to);
      var multiplier = _formulas[from.toString()][to];
      // print(multiplier);
      setState(() {
        _results =
        "$_value $_fromMesaures = ${(_value as dynamic) * multiplier} $_toMesaures";
      });
    } else {
      setState(() {
        _results = "Введите не нулевое значение";
      });
    }
  }
}
