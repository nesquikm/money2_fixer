# money2_fixer

[![Analyze and test all][analyze_and_test_badge]][analyze_and_test_link]
[![coverage][coverage_badge]][coverage_link]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]

## Features

This is just a 'fix' package for [Money2](https://money2.onepub.dev/) due to [found bug](https://github.com/onepub-dev/money.dart/issues/75).

## Getting started

```sh
dart pub add money2_fixer
```

## Usage

Call  `MoneyFixer.parseWithCurrencyImproved()` to create Money from string and `formatImproved()` to format Money object to string.

Also you should use `MoneyFixer.fromJsonImproved()` and `MoneyFixer.toJsonImproved()` to serialize and deserialize Money object to and from JSON.

## Example

Why this package is needed? Just run the example file and see the output.

```text
# dart example/money2_improver_example.dart

Test with: integers: 3, decimals: 18
String: 999.999999999999999999
Pattern: 0.################## S
Parse and format:
  with Money.parse: 999.999999999999999999 SV
  with improved method: 999.999999999999999999 SV
To and from json:
 parsing, integer part: 999, decimal part: 999999999999999999
  to and from Money.json: integer part: 999  decimal part: 999999999999999999
  to and from json improved: integer part: 999  decimal part: 999999999999999999

Test with: integers: 3, decimals: 19
String: 999.9999999999999999999
Pattern: 0.################### S
Parse and format:
  with Money.parse: -842.8297329635842064385 SV
  with improved method: 999.9999999999999999999 SV
To and from json:
 parsing, integer part: 999, decimal part: 9999999999999999999
  to and from Money.json: integer part: 999  decimal part: 9223372036854775807
  to and from json improved: integer part: 999  decimal part: 9999999999999999999

Test with: integers: 19, decimals: 3
String: 9999999999999999999.999
Pattern: 0.### S
Parse and format:
  with Money.parse: 9223372036854775807.999 SV
  with improved method: 9999999999999999999.999 SV
To and from json:
 parsing, integer part: 9999999999999999999, decimal part: 999
  to and from Money.json: integer part: 9223372036854775807  decimal part: 999
  to and from json improved: integer part: 9999999999999999999  decimal part: 999
```

[analyze_and_test_badge]: https://github.com/nesquikm/money2_fixer/actions/workflows/analyze-and-test.yaml/badge.svg
[analyze_and_test_link]: https://github.com/nesquikm/money2_fixer/actions/workflows/analyze-and-test.yaml
[coverage_badge]: https://nesquikm.github.io/money2_fixer/coverage_badge.svg
[coverage_link]: https://nesquikm.github.io/money2_fixer/html
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
