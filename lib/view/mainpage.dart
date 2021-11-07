import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //Default dropdownItems(Left/Right)
  String selectCur = "MYR"; //fromCurrency
  String selectConvCur = 'THB'; //toCurrency

  //Take 7 countries' currency
  List<String> countryCurList = [
    "MYR",
    "CNY",
    "JPY",
    "THB",
    "BRL",
    "CHF",
    "USD"
  ];

  //Set the variables
  double value = 0.0, rate = 0.0, inputAmount = 0.0;
  //Output from (fromCurrency) convert to (toCurrency) after press the calc button
  String finalResult = "";

  //TextField that allow to insert amount to retrieve the current value.
  final amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(37, 49, 64, 1),
        title: const Text(
          'Switch Currency Converter',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    decoration: InputDecoration(
                      labelText: 'Insert amount to convert',
                      labelStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      prefixIcon: const Icon(Icons.attach_money_rounded),
                      suffixIcon: IconButton(
                        onPressed: () => amountController.clear(),
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DropdownButton(
                      value: selectCur,
                      onChanged: (String? currentValue) {
                        setState(() {
                          selectCur = currentValue!;
                        });
                      },
                      items: countryCurList.map((selectCur) {
                        return DropdownMenuItem(
                          child: Text(selectCur),
                          value: selectCur,
                        );
                      }).toList(),
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(Icons.arrow_right_alt_outlined),
                      elevation: 0.0,
                      backgroundColor: Colors.blueGrey,
                    ),
                    DropdownButton(
                      value: selectConvCur,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectConvCur = newValue!;
                        });
                      },
                      items: countryCurList.map((selectConvCur) {
                        return DropdownMenuItem(
                          child: Text(selectConvCur),
                          value: selectConvCur,
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey, // background
                          onPrimary: Colors.black, // foreground
                        ),
                        onPressed: _calcCur,
                        child: const Text("CALCULATE",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ]),
                Container(
                  width: 280,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.indigo.withOpacity(0.7),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 3))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Result",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                          ("\n" +
                              inputAmount.toString() +
                              " " +
                              selectCur +
                              " = " +
                              finalResult +
                              " " +
                              selectConvCur),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _calcCur() async {
    var apikey = "4ef146c0-3bd9-11ec-bb53-bbb741900e18";
    var url = Uri.parse(
        'https://freecurrencyapi.net/api/v2/latest?apikey=$apikey&base_currency=$selectCur');
    http.Response res = await http.get(url);
    if (res.statusCode == 200) //if successfully request
    {
      var jsonData = res.body;
      var parsedJson = json.decode(jsonData);
      value = parsedJson['data'][selectConvCur];
      //curconverter = Converter(value, toCurrency);
      setState(() {
        inputAmount = double.parse(amountController.text);
        finalResult = (inputAmount * parsedJson['data'][selectConvCur])
            .toStringAsFixed(2);
      });
    } else {
      print("Failed");
    }
  }
}
