import 'dart:convert'; // json encode/decode
import 'package:http/http.dart' as http;

class RequestController {
  String path;
  String server;
  http.Response? _res;
  final Map<dynamic, dynamic> _body = {};
  final Map<String, String> _headers = {};
  dynamic _resultData;

  // this constructor takes 2 parameters. the path is a must while server is optional
  // parameter with default value. Default value should be the address of your server device.
  // can use this class later to communicate with 3rd party server by passing the server
  // address while leaving out the server address to communicate with our own server
  // for emulated device, can use 10.0.0.2 as the address to refer to ur computer
  // which runs the emulator if u run the server locally.

  RequestController({
    required this.path,
    this.server = "http://[replace_with_your_address]" /**10.0.0.2 for emulated device*/});
    setBody(Map<String, dynamic> data){
      _body.clear();
      _body.addAll(data);
      _headers["Content-Type"] = "application/json; charset=UTF-8";
    }

    Future<void> post() async{
      _res = await http.post(
        Uri.parse(server + path),
        headers: _headers,
        body: jsonEncode(_body),
      );
      // called to convert the string in http response into JSON format into
      // _resultData if possible
      _parseResult();
    }

    Future<void> get() async{
      _res = await http.get(
        Uri.parse(server + path),
        headers: _headers,
      );
      _parseResult();
    }

    void _parseResult(){
      // Parse result into json structure if possible
      try{
        print("raw response:${_res?.body}");
        _resultData = jsonDecode(_res?.body?? "");
      } catch(ex){
        //otherwise the response body will be stored as:
        _resultData = _res?.body;
        print("exception in http result parsing ${ex}");
      }
    }

    dynamic result(){
      return _resultData;
    }

    int status(){
      return _res?.statusCode ?? 0;
    }
}