import 'package:rest_api/Model/RestApiModel.dart';
import 'package:http/http.dart' as http;

class RemoteService{
  Future<List<Welcome>?> getPosts() async{
    var client = http.Client();
    var uri = Uri.parse("");
    var response = await client.get(uri);
    if(response.statusCode==200){
      var json = response.body;
      return welcomeFromJson(json);
    }
    return null;
  }

}
