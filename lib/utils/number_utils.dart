import 'package:intl/intl.dart';

class NumberUtils {
  final numberFormatter = new NumberFormat("#,##0.00", "de_DE");
  final numberFormatterRound = new NumberFormat("#,##0", "de_DE");
}
