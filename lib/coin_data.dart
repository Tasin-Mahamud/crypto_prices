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

class CoinData {
  var rate;
  String ApiKey = '2C3ED01A-3CE6-4658-AEF7-F8DF8A8DBBBD';
  Future getCoinData(String currency, String crypto) async {
    http.Response response = await http.get(Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$ApiKey'));
    var data = await response.body;
    // print(data);
    var decodedjson = await jsonDecode(data);
    print(decodedjson);
    var rate_double = decodedjson['rate'];
    rate = await rate_double.toInt();
    // var rate = await decodedjson['rate'];
    return rate;
  }
}
