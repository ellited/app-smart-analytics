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
  final double revenueThisMonth;
  final double overallRevenue;
  final int ordersCountThisMonth;
  final int overallOrdersCount;
  final int ordersCountPreviousMonth;

  OrdersStatistics(
      {this.overallOrdersCountToday,
      this.revenueThisMonth,
      this.overallRevenue,
      this.ordersCountThisMonth,
      this.overallOrdersCount,
      this.ordersCountPreviousMonth});

  factory OrdersStatistics.fromJson(Map<String, dynamic> json) {
    return OrdersStatistics(
      overallOrdersCountToday: json['stats'][0]['overall_orders_count_today'],
      revenueThisMonth: json['stats'][0]['overall_revenue_last_months'][0],
      overallRevenue: json['stats'][0]['overall_revenue'],
      ordersCountThisMonth: json['stats'][0]['overall_orders_count_last_months']
          [0],
      overallOrdersCount: json['stats'][0]['overall_orders_count'],
      ordersCountPreviousMonth: json['stats'][0]
          ['overall_orders_count_last_months'][1],
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
                    Text(
                        'Orders today: ${snapshot.data.overallOrdersCountToday}'),
                    Text(
                        'Revenue this month: ${snapshot.data.revenueThisMonth} €'),
                    Text('Overal revenue: ${snapshot.data.overallRevenue} €'),
                    Text(
                        'Orders count this month: ${snapshot.data.ordersCountThisMonth}'),
                    Text(
                        'Overal orders count: ${snapshot.data.overallOrdersCount}'),
                    Text(
                        'Orders count previous month: ${snapshot.data.ordersCountPreviousMonth}'),
                    Text(
                        'Orders count percentage compare with previous month: ${snapshot.data.ordersCountThisMonth / snapshot.data.ordersCountPreviousMonth * 100 - 100}'),
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
