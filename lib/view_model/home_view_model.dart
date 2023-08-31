import 'package:flutter/cupertino.dart';
import '/data/response/api_response.dart';
import '/respository/home_repository.dart';

import '../model/user_list_model.dart';

class HomeViewViewModel with ChangeNotifier{
  final _myRepo = HomeRepository();
  
  ApiResponse<UserListModel> moviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<UserListModel> response){
    moviesList = response ;
    notifyListeners();
  }
  Future<void> fetchMoviesListApi() async {
    setMoviesList(ApiResponse.loading());
    _myRepo.fetchMoviesList().then((value) {
      setMoviesList(ApiResponse.completed(value));
    }).onError((error, stackTrace){
      setMoviesList(ApiResponse.error(error.toString()));
      debugPrint(error.toString());
    });
  }
}