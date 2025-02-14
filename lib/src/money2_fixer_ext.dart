import 'package:money2/money2.dart';

/// Extension on [Money] to add improved serialization and formatting methods.
extension MoneyFixer on Money {
  /// Creates a Money from a [Fixed] [amount].
  ///
  /// The [amount] is scaled to match the currency selected via
  /// [currency].
  static Money parseWithCurrencyImproved(
    String amount,
    Currency currency, {
    int? scale,
  }) =>
      Money.fromFixedWithCurrency(
        Fixed.parse(amount, scale: scale ?? currency.decimalDigits),
        currency,
      );

  /// Formats a [Money] value into a String according to the
  /// passed [pattern].
  ///
  /// If [invertSeparator] is true then the role of the '.' and ',' are
  /// rroflsed. By default the '.' is used as the decimal separator
  /// whilst the ',' is used as the grouping separator.
  ///
  /// S outputs the currencies symbol e.g. $.
  /// 0 A single digit
  /// # A single digit, omitted if the value is zero (works only for integer
  /// part and as last fractional symbol as flag for trimming zeros)
  /// . or , Decimal separator dependant on [invertSeparator]
  /// - Minus sign
  /// , or . Grouping separator dependant on [invertSeparator]
  /// space Space character.
  String formatImproved({String? pattern, bool invertSeparator = false}) {
    final p = pattern ?? currency.pattern;
    final decimalSeparator = invertSeparator ? ',' : '.';
    return p.replaceAllMapped(RegExp(r'([0#.\-,]+)'), (m) {
      final result = amount.format(m[0]!, invertSeparator: invertSeparator);
      final trimZerosRight = RegExp(r'#$').hasMatch(m[0]!);
      return trimZerosRight
          ? result
              .replaceFirst(RegExp(r'0*$'), '')
              .replaceFirst(RegExp('\\$decimalSeparator\$'), '')
          : result;
    }).replaceAllMapped(RegExp('S'), (m) => currency.symbol);
  }

  /// Serializes a [Money] value into a Map&lt;String, dynamic&gt;.
  Map<String, dynamic> toJsonImproved() {
    return {
      'amount': amount.toJsonImproved(),
      'currency': currency.toJsonImproved(),
    };
  }

  /// Deserializes a [Money] value from a Map&lt;String, dynamic&gt;.
  static Money fromJsonImproved(Map<String, dynamic> json) {
    return Money.fromFixedWithCurrency(
      FixedFixer.fromJsonImproved(json['amount'] as Map<String, dynamic>),
      CurrencyFixer.fromJsonImproved(json['currency'] as Map<String, dynamic>),
    );
  }
}

/// Extension on [Currency] to add improved serialization and formatting methods
extension CurrencyFixer on Currency {
  /// Serializes a [Currency] value into a Map&lt;String, dynamic&gt;.
  Map<String, dynamic> toJsonImproved() {
    return {
      'isoCode': isoCode,
      'decimalDigits': decimalDigits,
      'symbol': symbol,
      'pattern': pattern,
      'groupSeparator': groupSeparator,
      'decimalSeparator': decimalSeparator,
      'country': country,
      'unit': unit,
      'name': name,
    };
  }

  /// Deserializes a [Currency] value from a Map&lt;String, dynamic&gt;.
  static Currency fromJsonImproved(Map<String, dynamic> json) {
    return Currency.create(
      json['isoCode'] as String,
      json['decimalDigits'] as int,
      symbol: (json['symbol'] ?? r'$') as String,
      pattern: (json['pattern'] ?? Currency.defaultPattern) as String,
      groupSeparator: (json['groupSeparator'] ?? ',') as String,
      decimalSeparator: (json['decimalSeparator'] ?? '.') as String,
      country: (json['country'] ?? '') as String,
      unit: (json['unit'] ?? '') as String,
      name: (json['name'] ?? '') as String,
    );
  }
}

/// Extension on [Fixed] to add improved serialization and formatting methods.
extension FixedFixer on Fixed {
  /// Serializes a [Fixed] value into a Map&lt;String, dynamic&gt;.
  Map<String, dynamic> toJsonImproved() {
    return {
      'minorUnits': minorUnits.toString(),
      'scale': scale,
    };
  }

  /// Deserializes a [Fixed] value from a Map&lt;String, dynamic&gt;.
  static Fixed fromJsonImproved(Map<String, dynamic> json) {
    return Fixed.fromBigInt(
      BigInt.parse(json['minorUnits'] as String),
      scale: (json['scale'] ?? 2) as int,
    );
  }
}
