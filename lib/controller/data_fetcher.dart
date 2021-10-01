import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:inspoq/controller/connection_helper.dart';
import 'package:inspoq/model/response.dart';

class DataFetcher {
  final ConnectionHelper _connectionHelper = ConnectionHelper();
  var random = Random();
  var unescape = HtmlUnescape();

  Future<QuoteResponse?> fetchQuote() async {
    int rand = random.nextInt(9);
    QuoteResponse? quoteResponse;
    String url = "https://quotesondesign.com/wp-json/wp/v2/posts";
    Map<String, dynamic> queryData = {
      "orderby": "rand",
    };
    Response<dynamic> response =
        await _connectionHelper.getData(url, queryData: queryData);
    if (response.statusCode == 200) {
      quoteResponse = QuoteResponse(
        body: unescape.convert(response.data[rand]["content"]["rendered"]),
        author: unescape.convert(response.data[rand]["title"]["rendered"]),
      );
    }
    return quoteResponse;
  }
}
