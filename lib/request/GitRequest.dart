import 'package:http/http.dart' as http;
class GitRequest {
  final String userName;
  final String url = 'https://api.github.com/';
  static String client_id = '83a73285447ed5294542';
  static String client_secret = 'd475fdc07f837c86063ad4266e25e46e9348733c';

  final String query = "?client_id=${client_id}&client_secret=${client_secret}";

  GitRequest(this.userName);

  Future<http.Response> fetchUser() {
    return http.get(url + 'users/' + userName + query);
  }

  Future<http.Response> fetchRepos() {
    return http.get(url + 'users/' + userName + '/repos' + query);
  }
}