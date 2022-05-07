import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  @override
  var BTC_rate_value;
  var ETH_rate_value;
  var LTC_rate_value;
  var data;
  String ApiKey = '2C3ED01A-3CE6-4658-AEF7-F8DF8A8DBBBD';
  var decodedjson;
  String selected_Currency = 'USD';

  DropdownButton<String> Android_dropdown() {
    List<DropdownMenuItem<String>> newlist = [];
    for (int i = 0; i < currenciesList.length; i++) {
      var newitem = DropdownMenuItem<String>(
          child: Text(currenciesList[i]), value: currenciesList[i]);
      newlist.add(newitem);
    }
    return DropdownButton<String>(
        value: selected_Currency,
        items: newlist,
        onChanged: (value) {
          setState(() {
            selected_Currency = value ?? 'USD';
            get_BTC_Data();
            get_ETH_Data();
            get_LTC_Data();
          });
        });
  }

  CupertinoPicker ios_picker() {
    List<Widget> mylist = [];
    for (int i = 0; i < currenciesList.length; i++) {
      var new_item = Text(currenciesList[i]);
      mylist.add(new_item);
    }
    return CupertinoPicker(
      itemExtent: 40,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: mylist,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      get_BTC_Data();
      get_ETH_Data();
      get_LTC_Data();
    });
  }

  void get_BTC_Data() async {
    CoinData coinData = CoinData();
    data = await coinData.getCoinData(selected_Currency, 'BTC');
    setState(() {
      BTC_rate_value = coinData.rate;
    });
    return BTC_rate_value;
  }

  void get_ETH_Data() async {
    CoinData coinData = CoinData();
    data = await coinData.getCoinData(selected_Currency, 'ETH');
    setState(() {
      ETH_rate_value = coinData.rate;
    });
    return ETH_rate_value;
  }

  void get_LTC_Data() async {
    CoinData coinData = CoinData();
    data = await coinData.getCoinData(selected_Currency, 'LTC');
    setState(() {
      LTC_rate_value = coinData.rate;
    });
    return LTC_rate_value;
  }

  Widget select_os() {
    if (Platform.isIOS) {
      return ios_picker();
    } else {
      return Android_dropdown();
    }
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
                child: Center(
                  child: Text(
                    '1 BTC = ${BTC_rate_value ?? 0} $selected_Currency',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
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
                child: Center(
                  child: Text(
                    '1 ETH = ${ETH_rate_value ?? 0} $selected_Currency',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
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
                child: Center(
                  child: Text(
                    '1 LTC = ${LTC_rate_value ?? 0} $selected_Currency',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
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
            // child: Platform.isIOS ? ios_picker() : Android_dropdown(),
            child: select_os(),
          )
        ],
      ),
    );
  }
}
