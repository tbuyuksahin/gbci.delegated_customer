import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  Future<List<Map<String, dynamic>>> getUserTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Token') ?? '';
    String? apiKey = prefs.getString('ApiKey') ?? '';
    try {
      final response = await http.get(
        Uri.parse(
            'https://delegate.gbcinst.com/api/delegates/customer-wallets'),
        headers: {
          'accept': '*/*',
          'API-KEY': apiKey,
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> responseData =
            List<Map<String, dynamic>>.from(jsonDecode(response.body));
        print('response: $responseData');
        return responseData;
      } else {
        print(
            'Failed to get user transactions. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Handle any exceptions that may occur during the request
      print('Error: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: const Color(0xffdfff57),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: size.height,
                        decoration: const BoxDecoration(
                          color: Color(0xff1e1e1e),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Container(
                                height: 50,
                                width: size.width,
                                decoration: const BoxDecoration(
                                  color: Color(0xffdfff57),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Kullanıcı',
                                    style: TextStyle(
                                      color: Color(0xff1e1e1e),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [
                              title(context, size, 'ID'),
                              const SizedBox(width: 10),
                              title(context, size, 'customerId'),
                              const SizedBox(width: 10),
                              title(context, size, 'limitCount'),
                              const SizedBox(width: 10),
                              title(context, size, 'address'),
                              const SizedBox(width: 10),
                              title(context, size, 'stateTypeId'),
                            ]),
                          ),
                          Expanded(
                            flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: size.height,
                                decoration: const BoxDecoration(
                                  color: Color(0xff333333),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                ),
                                child: FutureBuilder(
                                  future: getUserTransactions(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Center(
                                        child: Text('Error: ${snapshot.error}'),
                                      );
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const Center(
                                        child:
                                            Text('No transactions available.'),
                                      );
                                    } else {
                                      List<Map<String, dynamic>>
                                          transactionsData = snapshot.data
                                              as List<Map<String, dynamic>>;
                                      return ListView.builder(
                                        itemCount: transactionsData.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 50,
                                              width: size.width,
                                              decoration: const BoxDecoration(
                                                color: Color(0xff1e1e1e),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25)),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    textData(
                                                        context,
                                                        size,
                                                        transactionsData[index]
                                                                ['id']
                                                            .toString()),
                                                    const SizedBox(width: 10),
                                                    textData(
                                                        context,
                                                        size,
                                                        transactionsData[index]
                                                                ['customerId']
                                                            .toString()),
                                                    const SizedBox(width: 10),
                                                    textData(
                                                        context,
                                                        size,
                                                        transactionsData[index]
                                                                ['limitCount']
                                                            .toString()),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    textData(
                                                        context,
                                                        size,
                                                        transactionsData[index]
                                                                ['address']
                                                            .toString()),
                                                    const SizedBox(width: 10),
                                                    textData(
                                                        context,
                                                        size,
                                                        transactionsData[index]
                                                                ['stateTypeId']
                                                            .toString()),
                                                    const SizedBox(width: 10),
                                                  ],
                                                ),
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget title(BuildContext context, Size size, String title) {
    return Expanded(
      child: Container(
        height: 50,
        width: size.width,
        decoration: const BoxDecoration(
          color: Color(0xff1e1e1e),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xffdfff57),
            ),
          ),
        ),
      ),
    );
  }

  Widget textData(BuildContext context, Size size, String title) {
    return Expanded(
      child: Container(
        height: 50,
        width: size.width,
        decoration: const BoxDecoration(
          color: Color(0xff1e1e1e),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xffdfff57),
            ),
          ),
        ),
      ),
    );
  }
}
