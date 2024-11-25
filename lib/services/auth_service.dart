import 'dart:convert';
import 'package:http/http.dart' as http;
Future<Map<String, dynamic>> register(String name, String email, String password) async {
try {
var baseUrl;
final response = await http.post(
Uri.parse("$baseUrl/register"),
headers: {"Content-Type": "application/json"},
body: jsonEncode({"name": name, "email": email, "password": password}),
);

if (response.statusCode == 200) {
return jsonDecode(response.body);
} else {
// Assuming the error message is part of the response body
final errorResponse = jsonDecode(response.body);
throw Exception(errorResponse['message'] ?? 'Unknown error');
}
} catch (e) {
throw Exception("Network error: $e");
}
}
