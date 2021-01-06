import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  void initState() {
    super.initState();
    getCurrencyPrice();
  }

  String selectedCurrency = 'USD';
  String currencyPrice;
  CoinData coin = CoinData();
  Future<void> getCurrencyPrice() async {
    var allData = await coin.getPrice(selectedCurrency);

    double price = await allData['rate'];

    setState(() {
      currencyPrice = price.round().toString();
    });
  }

  List<DropdownMenuItem> getDropDownItems() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      dropDownItems.add(newItem);
    }

    return dropDownItems;
  }

  List<Widget> getPickerItems() {
    List<Text> pickerItems = [];

    for (int i = 0; i < currenciesList.length; i++) {
      pickerItems.add(Text(currenciesList[i]));
    }

    return pickerItems;
  }

  DropdownButton androidPicker() {
    return DropdownButton<String>(
        value: selectedCurrency,
        items: getDropDownItems(),
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            //currencyPrice = await getCurrencyPrice();
            getCurrencyPrice();
          });
        });
  }

  CupertinoPicker IOSpicker() {
    return CupertinoPicker(
      itemExtent: 28.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getCurrencyPrice();
        });
      },
      children: getPickerItems(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  "1 BTC = $currencyPrice.00 $selectedCurrency",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? IOSpicker() : androidPicker()),
        ],
      ),
    );
  }
}
////
