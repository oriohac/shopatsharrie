import 'dart:convert';
import 'dart:math';

import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopatsharrie/Screens/animatedloading.dart';
import 'package:shopatsharrie/model/productsdata.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<ProductsResponse> getProducts() async {
    final apiKey = dotenv.env['Apikey'];
    final appId = dotenv.env['Appid'];
    final orgId = dotenv.env['organization_id'];
    const url = 'https://api.timbu.cloud/products';
    final response = await http.get(
        Uri.parse("$url?organization_id=$orgId&Apikey=$apiKey&Appid=$appId"));
    if (response.statusCode == 200) {
      return ProductsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error: Could not retrieve data");
    }
  }

  late Future<ProductsResponse> products;
  @override
  void initState() {
    super.initState();
    products = getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 213, 214, 215),
        automaticallyImplyLeading: false,
        actions: const [Row(children: [Text("Sharrie's Signature"),Spacer(),Icon(Icons.shopping_cart_outlined)],)],
      ),
      backgroundColor: const Color.fromARGB(255, 213, 214, 215),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
              child: Text(
                'Hot Sellers 🔥',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: FutureBuilder<ProductsResponse>(
                  future: products,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Animatedloading(),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!.items.isEmpty) {
                      return const Center(
                        child: Text('No products found'),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      final random = Random();
                      final List<Productsdata> items =
                          List.from(snapshot.data!.items);
                      items.shuffle(random);
                      const int subsetLength = 5;
                      final List<Productsdata> randomSubset =
                          items.take(subsetLength).toList();
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: randomSubset.length,
                        itemBuilder: (context, index) {
                          var prefix = randomSubset[index];
                          return Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                                child: Card(
                                  elevation: 4,
                                  color: Colors.white,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: prefix.photos.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                              2,
                                              2,
                                              2,
                                              2,
                                            ),
                                            child: Image.network(
                                              'https://api.timbu.cloud/images/${prefix.photos[0].url}',
                                              height: 60,
                                              width: 60,
                                            ),
                                          )
                                        : Container(),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: FutureBuilder<ProductsResponse>(
                  future: products,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Animatedloading(),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!.items.isEmpty) {
                      return const Center(child: Text('No products found'));
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.items.length,
                        itemBuilder: (context, index) {
                          var prefix = snapshot.data!.items[index];
                          var availableItem = prefix.isAvailable;
                          String availableText;
                          if (availableItem == true) {
                            availableText = 'available';
                          } else {
                            availableText = 'unavailable';
                          }

                          return Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: prefix.photos.isNotEmpty
                                        ? Image.network(
                                            'https://api.timbu.cloud/images/${prefix.photos[0].url}')
                                        : const Center(
                                          child:
                                              Text('Image will show here'),
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        prefix.name,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        prefix.description.toString(),
                                        maxLines: 2,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        '₦${prefix.currentprice.toString()}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "${prefix.availableQuantity.toInt()} In Stock",
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        availableText,
                                        style: const TextStyle(color: Colors.green),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      SizedBox(
                                        height: 46,
                                        width: double.maxFinite,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text("Item Added"),
                                                content: const Text(
                                                    "check it in your cart"),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                          child: const Text(
                                            'Add to Cart',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
