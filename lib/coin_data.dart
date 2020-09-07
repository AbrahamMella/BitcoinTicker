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

const coinAPIURL = 'https://min-api.cryptocompare.com/data/price?fsym';
const apiKey =
    'cae6f3ee179ad4471f2e3339750f2bc0b3dc0bb731aa9ef5d7c16e0ab08786df';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map cryptoPrices = {};
    for (String cryptoName in cryptoList) {
      String requestURL =
          '$coinAPIURL=$cryptoName&tsyms=$selectedCurrency&api_key=$apiKey';
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var lastPrice = decodedData[selectedCurrency];
        cryptoPrices[cryptoName] = lastPrice;
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
