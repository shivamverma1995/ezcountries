import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ezcountries/data_provider.dart' as dp;
import 'package:ezcountries/getxIds.dart' as ids;

import '../models/countriesModel.dart';

class CountriesListScreenController extends GetxController {
  TextEditingController codeController = TextEditingController();
  GetConnect gc = GetConnect();
  String? errorText;
  List<Country> countriesList = [];
  List<Language> languagesList = [];
  Map<String, List<Country>> languageToCountries = {};
  bool internetPresent = false;
  bool showingAllCountries = true;

  bool languageDataLoaded = false;

  @override
  void onInit() async {
    super.onInit();
    gc.baseUrl = 'https://countries.trevorblades.com/graphql';
    await checkConnectivity();
    if (internetPresent) {
      loadAllCountries();
      fetchAllLanguages();
    }
  }

  void searchByCode() async {
    await checkConnectivity();
    flushCountriesList();
    if (internetPresent) {
      print('Internet Present');
      showingAllCountries = false;
      if (codeController.text.isEmpty) {
        loadAllCountries();
      } else {
        gc.query(dp.searchCountry, url: "", variables: {
          "code": codeController.text.toUpperCase()
        }).then((value) {
          if (value.hasError) {
            print(value.graphQLErrors![0].message);
            errorText = value.graphQLErrors?[0].message;
          } else {
            print(value.body);
            if (value.body["country"] == null) {
              errorText = "Sorry, No countries found!";
            } else {
              Country country = Country.fromMap(value.body["country"]);
              countriesList = [country];
            }
          }
          update([ids.countriesListBuilder]);
          // print(countriesQueryData.countries.length);
        });
      }
    }
  }

  void loadAllCountries() async {
    await checkConnectivity();
    flushCountriesList();
    if (internetPresent) {
      showingAllCountries = true;
      gc.query(dp.fetchCountriesData, url: "").then((value) {
        if (value.hasError) {
          errorText = value.graphQLErrors?[0].message;
        } else {
          CountriesQueryData countriesQueryData =
              CountriesQueryData.fromMap(value.body);
          countriesList = countriesQueryData.countries;
          //Adding Countries to the Language HashMap
          if (!languageDataLoaded) {
            for (int i = 0; i < countriesQueryData.countries.length; i++) {
              Country country = countriesQueryData.countries[i];
              for (int j = 0; j < country.languages.length; j++) {
                Language language = country.languages[j];
                if (languageToCountries[language.name] == null) {
                  languageToCountries[language.name] = [];
                }
                languageToCountries[language.name]?.add(country);
              }
            }
          }
          languageDataLoaded = true;
        }
        update([ids.countriesListBuilder]);
      });
    }
  }

  void fetchAllLanguages() {
    gc.query(dp.fetchAllLanguages, url: "").then((value) {
      if (value.hasError) {
        errorText = value.graphQLErrors?[0].message;
      } else {
        List<Language> languages = List<Language>.from(
            value.body['languages']?.map((x) => Language.fromMap(x)));
        languagesList = languages;
      }
      // print(countriesQueryData.countries.length);
      update([ids.languagesListBuilder]);
    });
  }

  void filterByLanguage(String name) {
    flushCountriesList();
    if (name == "None") {
      loadAllCountries();
      return;
    } else {
      countriesList = languageToCountries[name] ?? [];
      print(countriesList.length);
      if (countriesList.isEmpty) {
        errorText = "No contry speaks this language!!";
      }
      update([ids.countriesListBuilder]);
    }
  }

  void flushCountriesList() {
    errorText = null;
    countriesList = [];
    update([ids.countriesListBuilder]);
  }

  Future<void> checkConnectivity() async {
    ConnectivityResult value = await Connectivity().checkConnectivity();
    if (value == ConnectivityResult.none ||
        value == ConnectivityResult.bluetooth) {
      errorText = "No Internet Detected!";
      print('Internet Absent');
      internetPresent = false;
      update([ids.countriesListBuilder]);
    } else {
      internetPresent = true;
    }
  }
}
