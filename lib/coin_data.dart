import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String apikey = '199680B7-2AAC-4A18-8E99-C03A1A307595';

class CoinData {
  Future<dynamic> getPrice(String currentCurrency) async {
    http.Response response = await http.get(
        'https://rest.coinapi.io/v1/exchangerate/BTC/$currentCurrency?apikey=199680B7-2AAC-4A18-8E99-C03A1A307595');

    var data = response.body;
    print(jsonDecode(data));

    return jsonDecode(data);
  }
}
