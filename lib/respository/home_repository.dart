import 'package:flutter/cupertino.dart';

import '/model/user_list_model.dart';

import '../data/network/baseapiservices.dart';
import '../data/network/networkapiservices.dart';
import '../res/app_url.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<UserListModel> fetchMoviesList() async{
    try{
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      return response = UserListModel.fromJson(response);

    }catch(e){
      debugPrint('api error' + e.toString());
      throw e;
    }
  }
}