import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink httpLink = HttpLink(
  'https://countries.trevorblades.com/graphql',
);

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  ),
);

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
