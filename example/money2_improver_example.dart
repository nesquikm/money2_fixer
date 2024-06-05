import 'package:money2/money2.dart';
import 'package:money2_fixer/money2_fixer.dart';

void main() {
  final roflWithDefaultFormatting =
      Currency.create('RoflCoin', 9, symbol: 'ROFL', pattern: '0.######### S');
  print(
    MoneyFixer.parseWithCurrencyImproved('2.01', roflWithDefaultFormatting)
        .formatImproved(),
  );
}
