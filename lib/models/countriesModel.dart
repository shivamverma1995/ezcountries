import 'dart:convert';

import 'package:flutter/foundation.dart';

class CountriesModel {
  final CountriesQueryData data;
  CountriesModel({
    required this.data,
  });

  CountriesModel copyWith({
    CountriesQueryData? data,
  }) {
    return CountriesModel(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.toMap(),
    };
  }

  factory CountriesModel.fromMap(Map<String, dynamic> map) {
    return CountriesModel(
      data: CountriesQueryData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CountriesModel.fromJson(String source) =>
      CountriesModel.fromMap(json.decode(source));

  @override
  String toString() => 'CountriesModel(data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountriesModel && other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}

class CountriesQueryData {
  final List<Country> countries;
  CountriesQueryData({
    required this.countries,
  });

  CountriesQueryData copyWith({
    List<Country>? countries,
  }) {
    return CountriesQueryData(
      countries: countries ?? this.countries,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'countries': countries.map((x) => x.toMap()).toList(),
    };
  }

  factory CountriesQueryData.fromMap(Map<String, dynamic> map) {
    return CountriesQueryData(
      countries: List<Country>.from(
          map['countries']?.map((x) => Country.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CountriesQueryData.fromJson(String source) =>
      CountriesQueryData.fromMap(json.decode(source));

  @override
  String toString() => 'Data(countries: $countries)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountriesQueryData &&
        listEquals(other.countries, countries);
  }

  @override
  int get hashCode => countries.hashCode;
}

class Country {
  final String code;
  final String name;
  final List<Language> languages;
  final String currency;
  // final List<dynamic> states;
  final Continent continent;
  Country({
    required this.code,
    required this.name,
    required this.languages,
    required this.currency,
    // required this.states,
    required this.continent,
  });

  Country copyWith({
    String? code,
    String? name,
    List<Language>? languages,
    String? currency,
    List<dynamic>? states,
    Continent? continent,
  }) {
    return Country(
      code: code ?? this.code,
      name: name ?? this.name,
      languages: languages ?? this.languages,
      currency: currency ?? this.currency,
      // states: states ?? this.states,
      continent: continent ?? this.continent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'languages': languages.map((x) => x.toMap()).toList(),
      'currency': currency,
      // 'states': states,
      'continent': continent.toMap(),
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      code: map['code'] ?? '',
      name: map['name'] ?? '',
      languages: List<Language>.from(
          map['languages']?.map((x) => Language.fromMap(x))),
      currency: map['currency'] ?? '',
      // states: List<dynamic>.from(map['states']),
      continent: Continent.fromMap(map['continent']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Countrie(code: $code, name: $name, languages: $languages, currency: $currency, continent: $continent)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Country &&
        other.code == code &&
        other.name == name &&
        listEquals(other.languages, languages) &&
        other.currency == currency &&
        // listEquals(other.states, states) &&
        other.continent == continent;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        name.hashCode ^
        languages.hashCode ^
        currency.hashCode ^
        // states.hashCode ^
        continent.hashCode;
  }
}

class Language {
  final String name;
  final String code;
  Language({
    required this.name,
    required this.code,
  });

  Language copyWith({
    String? name,
    String? code,
  }) {
    return Language(
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
    };
  }

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      name: map['name'] ?? '',
      code: map['code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Language.fromJson(String source) =>
      Language.fromMap(json.decode(source));

  @override
  String toString() => 'Language(name: $name, code: $code)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Language && other.name == name && other.code == code;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode;
}

class Continent {
  final String name;
  Continent({
    required this.name,
  });

  Continent copyWith({
    String? name,
  }) {
    return Continent(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory Continent.fromMap(Map<String, dynamic> map) {
    return Continent(
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Continent.fromJson(String source) =>
      Continent.fromMap(json.decode(source));

  @override
  String toString() => 'Continent(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Continent && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
