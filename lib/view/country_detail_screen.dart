import 'package:ezcountries/styles.dart';
import 'package:flutter/material.dart';

import '../models/countriesModel.dart';

class CountryDetailScreen extends StatelessWidget {
  Country country;
  CountryDetailScreen(this.country, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${country.name} Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "${country.name} is a country located in the continent of ${country.continent.name}.\n\nHere are some details about ${country.name}:\n",
                style: TextStyle(fontSize: 28),
              ),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "Country Name: ${country.name}",
                  style: countryDetailText,
                ),
              )),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "Country Code: ${country.code}",
                  style: countryDetailText,
                ),
              )),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "Currency Used: ${country.currency}",
                  style: countryDetailText,
                ),
              )),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "Number of Languages used: ${country.languages.length}",
                  style: countryDetailText,
                ),
              )),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "Languages used: ${country.languages.map((e) => e.name).reduce((value, element) => value + ", " + element)}",
                  style: countryDetailText,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
