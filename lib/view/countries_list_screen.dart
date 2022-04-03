import 'package:ezcountries/controller/countries_list_screen_controller.dart';
import 'package:ezcountries/models/countriesModel.dart';
import 'package:ezcountries/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ezcountries/getxIds.dart' as ids;

import 'country_detail_screen.dart';

class CountriesListScreen extends StatelessWidget {
  final CountriesListScreenController controller =
      Get.put(CountriesListScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Countries",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                autofocus: false,
                controller: controller.codeController,
                onSubmitted: (value) {
                  controller.searchByCode();
                },
                onChanged: (value) {
                  controller.searchByCode();
                },
                decoration: InputDecoration(
                    prefixIcon: InkWell(
                        onTap: () {
                          controller.searchByCode();
                        },
                        child: Icon(Icons.search)),
                    hintText: "Search Country",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            Expanded(
              child: Center(
                child: GetBuilder<CountriesListScreenController>(
                  id: ids.countriesListBuilder,
                  builder: (controller) {
                    if (!controller.internetPresent) {
                      return Text('No Internet Detected!');
                    }
                    if (controller.countriesList.isEmpty) {
                      if (controller.errorText != null) {
                        return Text(controller.errorText!);
                      }
                      return CircularProgressIndicator();
                    }
                    return ListView.builder(
                        itemCount: controller.countriesList.length,
                        itemBuilder: (context, index) {
                          return CountryView(
                              country: controller.countriesList[index]);
                        });
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.filter_alt_sharp),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Get.bottomSheet(FilterBottomSheet());
            }));
  }
}

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        // enableDrag: false,
        onClosing: () {},
        builder: (context) {
          return GetBuilder<CountriesListScreenController>(
              id: ids.languagesListBuilder,
              builder: ((controller) {
                return Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Filter By Language',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Card(
                                child: InkWell(
                              onTap: () {
                                controller.filterByLanguage("None");
                                Get.back();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Center(
                                  child: Text(
                                    "None",
                                    style: countryDetailText,
                                  ),
                                ),
                              ),
                            )),
                            ...controller.languagesList.map((e) {
                              String languageName = e.name;
                              return Card(
                                  child: InkWell(
                                onTap: () {
                                  controller.filterByLanguage(languageName);
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Center(
                                    child: Text(
                                      languageName,
                                      style: countryDetailText,
                                    ),
                                  ),
                                ),
                              ));
                            })
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }));
        });
  }
}

class CountryView extends StatelessWidget {
  const CountryView({
    Key? key,
    required this.country,
  }) : super(key: key);

  final Country country;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          Get.to(() => CountryDetailScreen(country));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          '(${country.code}) ',
                          style: countryNameText,
                        ),
                        Text(
                          country.name.length > 30
                              ? country.name.substring(0, 30) + '...'
                              : country.name,
                          style: countryNameText,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Row(
                            children: [
                              Icon(Icons.map),
                              Text(
                                country.continent.name,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: Icon(Icons.money),
                            ),
                          ],
                        ),
                        Text(
                          country.currency.isNotEmpty
                              ? country.currency.length > 10
                                  ? country.currency.substring(0, 10) + '...'
                                  : country.currency
                              : 'N/A',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Icon(Icons.arrow_forward)
            ],
          ),
        ),
      ),
    );
  }
}
