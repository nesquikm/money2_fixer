import 'package:test/test.dart';
import 'package:money2/money2.dart';
import 'package:money2_fixer/money2_fixer.dart';

void main() {
  const maxScale = 100;
  const maxInts = 100;

  setUp(() {
    for (var scale = 0; scale <= maxScale; scale++) {
      final c = Currency.create('C$scale', scale, symbol: '=$scale=');
      Currencies().register(c);
    }
  });

  test('test default currency formatting', () {
    final roflWithDefaultFormatting =
        Currency.create('ROFL', 9, symbol: 'ROFL');
    expect(
        MoneyFixer.parseWithCurrencyImproved('2.0', roflWithDefaultFormatting)
            .formatImproved(),
        'ROFL2.00',
        reason: 'Failed default formatting');
  });

  test('test custom currency formatting', () {
    final roflWithDefaultFormatting =
        Currency.create('ROFL', 9, symbol: 'ROFL', pattern: '0.000000000 S');
    expect(
        MoneyFixer.parseWithCurrencyImproved('2.0', roflWithDefaultFormatting)
            .formatImproved(),
        '2.000000000 ROFL',
        reason: 'Failed custom formatting');
  });

  test('test custom currency formatting 2', () {
    final roflWithDefaultFormatting =
        Currency.create('ROFL', 9, symbol: 'ROFL', pattern: '0.000000000 S');
    expect(
        MoneyFixer.parseWithCurrencyImproved('2.01', roflWithDefaultFormatting)
            .formatImproved(),
        '2.010000000 ROFL',
        reason: 'Failed custom formatting');
  });

  test('test custom currency formatting 3 (trim zeros)', () {
    final roflWithDefaultFormatting =
        Currency.create('ROFL', 9, symbol: 'ROFL', pattern: '0.######### S');
    expect(
        MoneyFixer.parseWithCurrencyImproved('2.01', roflWithDefaultFormatting)
            .formatImproved(),
        '2.01 ROFL',
        reason: 'Failed custom formatting');
  });

  test('test custom explicit formatting', () {
    final roflWithDefaultFormatting =
        Currency.create('ROFL', 9, symbol: 'ROFL', pattern: '0.######### S');
    expect(
        MoneyFixer.parseWithCurrencyImproved('2.01', roflWithDefaultFormatting)
            .formatImproved(pattern: 'S 0.#########'),
        'ROFL 2.01',
        reason: 'Failed custom formatting');
  });

  test('scale 0-$maxScale test', () {
    for (var scale = 0; scale <= maxScale; scale++) {
      final c = Currencies().find('C$scale');
      expect(c, isNotNull);
      final str = scale == 0 ? '0' : '0.${'0' * (scale - 1)}1';
      final fmt = scale == 0 ? '0' : '0.${'#' * scale}';
      expect(
          MoneyFixer.parseWithCurrencyImproved(str, c!)
              .formatImproved(pattern: fmt),
          str,
          reason: 'Failed with $scale scale');
    }
  });

  test('integers 0-$maxInts test', () {
    for (var ints = 0; ints <= maxInts; ints++) {
      final c = Currencies().find('C0');
      expect(c, isNotNull);
      final str = ints == 0 ? '0' : '9' * ints;
      final fmt = '0';
      expect(
          MoneyFixer.parseWithCurrencyImproved(str, c!)
              .formatImproved(pattern: fmt),
          str,
          reason: 'Failed with $ints ints');
    }
  });

  test('scale 0-$maxScale and integers 0-$maxInts test', () {
    for (var scale = 0; scale <= maxScale; scale++) {
      for (var ints = 0; ints <= maxInts; ints++) {
        final c = Currencies().find('C$scale');
        expect(c, isNotNull);
        final intsStr = ints == 0 ? '0' : '9' * ints;
        final str = scale == 0 ? intsStr : '$intsStr.${'0' * (scale - 1)}1';
        final fmt = scale == 0 ? '0' : '0.${'0' * scale}';
        expect(
            MoneyFixer.parseWithCurrencyImproved(str, c!)
                .formatImproved(pattern: fmt),
            str,
            reason: 'Failed with $scale scale, $ints ints');
      }
    }
  });
}
