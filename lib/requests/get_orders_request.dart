import 'package:app_smart_analytics/models/orders_statistics.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<OrdersStatistics> fetchOrdersStats() async {
  final response = await http.get(
      '');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return OrdersStatistics.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load statistic');
  }
}
