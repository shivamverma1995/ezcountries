String fetchCountriesData = '''query Query{
                                countries {
                                  code
                                  name
                                  languages {
                                    name
                                    code
                                  }
                                  currency
                                  continent {
                                    name
                                  }
                                }
                              }''';
String searchCountry = r'''query Query($code: ID!) {
  country(code: $code) {
    code
    name
    languages {
      name
      code
    }
    currency
    continent {
      name
    }
  }
}
''';

String fetchAllLanguages = '''query Query {
  languages {
    code
    name
  }
}
''';
