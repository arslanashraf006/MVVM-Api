import 'dart:convert';
import 'dart:io';
import '../app_exceptions.dart';
import 'baseapiservices.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices{
  @override
  Future getGetApiResponse(String url) async{
    dynamic responseJson;
   try{
     final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
     responseJson = returnResponse(response);
   }on SocketException{
     throw FetchDataException('No Internet Connection');
   }

   return responseJson;
  }

  @override
  Future getPostApiResponse(String url,dynamic data) async {
    dynamic responseJson;
    try{
      final response = await http.post(Uri.parse(url),
      body: data,
      );
      responseJson = returnResponse(response);
    }on SocketException{
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException('Error accorded while communicating with status code${response.statusCode}');
    }
  }

}