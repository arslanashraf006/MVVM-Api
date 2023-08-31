import 'package:flutter/material.dart';
import 'package:mvvm_api/data/response/status.dart';
import 'package:mvvm_api/model/user_list_model.dart';
import '/utils/routes/routes_name.dart';
import '/view_model/home_view_model.dart';
import '/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();

  @override
  void initState() {
    homeViewViewModel.fetchMoviesListApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              userPreference.remove().then((value){
                Navigator.pushNamed(context, RoutesName.login);
              });
            },
            child: const Center(child: Text('Logout')),
          ),
          const SizedBox(width: 20.0,),
        ],
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
        create: (context) => homeViewViewModel,
        child: Consumer<HomeViewViewModel>(
          builder: (context, value, _) {
            switch(value.moviesList.status){
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                debugPrint(value.moviesList.message.toString());
                return Center(child: Text(value.moviesList.message.toString()));
              case Status.COMPLETED:
                return ListView.builder(
                  itemCount: value.moviesList.data!.data!.length,
                  itemBuilder: (context, index) {
                  return SizedBox(
                    height: 130,
                    child: Card(
                      child: Center(
                        child: ListTile(
                          leading: Image.network(value.moviesList.data!.data![index].avatar.toString(),
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error_outline,color: Colors.red,);
                          },
                            //height: 200,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          title: Text(value.moviesList.data!.data![index].firstName.toString()),
                          subtitle: Text('Email: ${value.moviesList.data!.data![index].email}'),
                        ),
                      ),
                    ),
                  );
                },);
              default:
                return const Text('Unknown Error');
            }
            return Container();
          },
        ),
      ),
    );
  }
}
