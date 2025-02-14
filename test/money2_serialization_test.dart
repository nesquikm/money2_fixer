import 'dart:convert';

import 'package:money2/money2.dart';
import 'package:money2_fixer/money2_fixer.dart';
import 'package:test/test.dart';

void main() {
  final amount = '${'9' * 100}.${'9' * 100}';
  final minorUnits = '9' * 200;

  test('Fixed serialization', () {
    final f0 = Fixed.parse(amount);
    final json = f0.toJsonImproved();
    final f1 = FixedFixer.fromJsonImproved(json);
    expect(f1.toString(), amount);
  });

  test('Fixed jsonEncode', () {
    final f0 = Fixed.parse(amount);
    final json = jsonEncode(f0.toJsonImproved());
    final f1 =
        FixedFixer.fromJsonImproved(jsonDecode(json) as Map<String, dynamic>);
    expect(f1.toString(), amount);
  });

  test('Currency serialization (base)', () {
    final c0 = Currency.create('ROFL', 9);
    final json = c0.toJsonImproved();
    final c1 = CurrencyFixer.fromJsonImproved(json);
    expect(c0, c1);

    expect(c1.isoCode, c0.isoCode);
    expect(c1.decimalDigits, c0.decimalDigits);
    expect(c1.symbol, c0.symbol);
    expect(c1.pattern, c0.pattern);
    expect(c1.groupSeparator, c0.groupSeparator);
    expect(c1.decimalSeparator, c0.decimalSeparator);
    expect(c1.country, c0.country);
    expect(c1.unit, c0.unit);
    expect(c1.name, c0.name);
  });

  test('Currency serialization (full)', () {
    final c0 = Currency.create(
      'ROFL',
      9,
      symbol: 'ROFL',
      pattern: '0.######### S',
      groupSeparator: '.',
      decimalSeparator: ',',
      country: 'AA',
      unit: 'abux',
      name: 'AA bux',
    );
    final json = c0.toJsonImproved();
    final c1 = CurrencyFixer.fromJsonImproved(json);
    expect(c0, c1);

    expect(c1.isoCode, c0.isoCode);
    expect(c1.decimalDigits, c0.decimalDigits);
    expect(c1.symbol, c0.symbol);
    expect(c1.pattern, c0.pattern);
    expect(c1.groupSeparator, c0.groupSeparator);
    expect(c1.decimalSeparator, c0.decimalSeparator);
    expect(c1.country, c0.country);
    expect(c1.unit, c0.unit);
    expect(c1.name, c0.name);
  });

  test('Money serialization', () {
    final c = Currency.create('c100', 100, symbol: '=100=');
    final m0 = MoneyFixer.parseWithCurrencyImproved(amount, c);
    final json = m0.toJsonImproved();
    final m1 = MoneyFixer.fromJsonImproved(json);
    expect(m0.integerPart, m1.integerPart);
    expect(m0.decimalPart, m1.decimalPart);
    expect(m1.compareTo(m0), 0);
    expect(m1.minorUnits, BigInt.parse(minorUnits));
  });

  test("Money serialization (Money's toJson is faulty)", () {
    final c = Currency.create('c100', 100, symbol: '=100=');
    Currencies().register(c);
    final m0 = MoneyFixer.parseWithCurrencyImproved(amount, c);
    final json = m0.toJson();
    final m1 = Money.fromJson(json);
    expect(m0.integerPart, isNot(m1.integerPart));
    expect(m0.decimalPart, isNot(m1.decimalPart));
    expect(m1.compareTo(m0), isNot(0));
    expect(m1.minorUnits, isNot(BigInt.parse(minorUnits)));
  });
}
