import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<OrdersStatistics> fetchOrdersStats() async {
  final response =
  await http.get('');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return OrdersStatistics.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load statistic');
  }
}

class OrdersStatistics {
  final int overallOrdersCountToday;
  final double overallRevenueLastMonths;
  final double overallRevenue;

  OrdersStatistics({
    this.overallOrdersCountToday,
    this.overallRevenueLastMonths,
    this.overallRevenue
  });

  factory OrdersStatistics.fromJson(Map<String, dynamic> json) {
    return OrdersStatistics(
      overallOrdersCountToday: json['stats'][0]['overall_orders_count_today'],
      overallRevenueLastMonths: json['stats'][0]['overall_revenue_last_months'][0],
      overallRevenue: json['stats'][0]['overall_revenue'],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<OrdersStatistics> futureOrdersStatistics;

  @override
  void initState() {
    super.initState();
    futureOrdersStatistics = fetchOrdersStats();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orders Analytics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Orders Analytics'),
        ),
        body: Material(
          child: FutureBuilder<OrdersStatistics>(
            future: futureOrdersStatistics,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Orders today: ${snapshot.data.overallOrdersCountToday}'),
                    Text('Revenue this month: ${snapshot.data.overallRevenueLastMonths} €'),
                    Text('Overal revenue: ${snapshot.data.overallRevenue} €'),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
