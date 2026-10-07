import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopatsharrie/model/productsdata.dart';

class Productdesc extends StatelessWidget {
  final Productsdata product;

  Productdesc({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var availableItem = product.isAvailable;
    String availableText;
    if (availableItem == true) {
      availableText = 'available';
    } else {
      availableText = 'unavailable';
    }
    

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Color(0xffE4F5E0)),
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Image.network(
                        'https://api.timbu.cloud/images/${product.photos[0].url}',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ],
              ),
              // Stack(
              //   children: [
              //     Container(
              //       decoration: BoxDecoration(color: Color(0xffE4F5E0)),
              //     ),
              //     Image.network(
              //         'https://api.timbu.cloud/images/${product.photos[0].url}')
              //   ],
              // ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Image.network(
                      'https://api.timbu.cloud/images/${product.photos[0].url}'),
                ],
              ),
              Row(
                children: [
                  Text("${product.uniqueid}"),
                  const Spacer(),
                  Text("${availableText}")
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      product.description.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
              const Text("Made with perfection"),
              const Row(
                children: [
                  Text("How to use"),
                  Spacer(),
                  Icon(Icons.expand_more)
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  Text("Delivery and dropo-ff"),
                  Spacer(),
                  Icon(Icons.expand_more)
                ],
              ),
              const Divider(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xff408C2B),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'sub',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    '${product.currentprice}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text(
                  "Add to cart",
                  style: TextStyle(color: Color(0xffFAFAFA)),
                ),
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xffFAFAFA)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.83))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
