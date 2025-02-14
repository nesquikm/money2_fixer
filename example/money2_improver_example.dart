import 'package:money2/money2.dart';
import 'package:money2_fixer/money2_fixer.dart';

void main() {
  testWith(3, 18);
  testWith(3, 19);
  testWith(19, 3);
}

void testWith(int integers, int decimals) {
  print('\nTest with: integers: $integers, decimals: $decimals');
  final string = '${'9' * integers}.${'9' * decimals}';
  final pattern = '0.${'#' * decimals} S';

  final code = 'SV';

  final superValuableCurrency =
      Currency.create(code, decimals, symbol: code, pattern: pattern);

  Currencies().register(superValuableCurrency);

  print('String: $string');
  print('Pattern: $pattern');

  print('Parse and format:');

  print(
    '  with Money.parse: ${Money.parse(string, isoCode: code).format(
      pattern,
    )}',
  );
  print(
      '  with improved method: ${MoneyFixer.parseWithCurrencyImproved(string, superValuableCurrency).formatImproved()}');

  print('To and from json:');

  final m = MoneyFixer.parseWithCurrencyImproved(string, superValuableCurrency);

  print(
      ' parsing, integer part: ${m.integerPart}, decimal part: ${m.decimalPart}');

  final mToFromJson = Money.fromJson(m.toJson());
  final mToFromJsonImproved = MoneyFixer.fromJsonImproved(m.toJsonImproved());

  print(
      '  to and from Money.json: integer part: ${mToFromJson.integerPart}  decimal part: ${mToFromJson.decimalPart}');
  print(
      '  to and from json improved: integer part: ${mToFromJsonImproved.integerPart}  decimal part: ${mToFromJsonImproved.decimalPart}');
}
