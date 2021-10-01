import 'package:flutter/material.dart';
import 'package:inspoq/controller/data_fetcher.dart';
import 'package:inspoq/model/response.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DataFetcher _dataFetcher = DataFetcher();
  String? quote;
  String? author;

  @override
  initState() {
    super.initState();
    _fetchNewQuote();
  }

  _fetchNewQuote() async {
    QuoteResponse? response = await _dataFetcher.fetchQuote();
    if (response != null) {
      setState(() {
        quote = response.body;
        author = response.author;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: const Text("inspoq"),
      ),
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.transparent,
        onPressed: () {
          _fetchNewQuote();
        },
        child: const Icon(Icons.refresh),
      ),
      body: SafeArea(
        child: quote == null
            ? const LinearProgressIndicator()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "\"$quote\"",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: "Staatliches",
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      "- $author",
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontFamily: "Bonheur",
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
