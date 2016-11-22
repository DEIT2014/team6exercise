import 'dart:io';
import 'dart:core';
import 'dart:async';
import 'package:sqljocky/sqljocky.dart';
import 'package:sqljocky/utils.dart';
import 'package:options_file/options_file.dart';

/* A simple web server that responds to **ALL** GET requests by returning
 * the contents of data.json file, and responds to ALL **POST** requests
 * by overwriting the contents of the data.json file
 *
 * Browse to it using http://localhost:4042
 *
 * Provides CORS headers, so can be accessed from any other page
 */

final HOST = "localhost"; // eg: localhost
final PORT = 4042;
final DATA_FILE = "C:\\Users\\wen51\\Documents\\GitHub\\team6exercise\\data.json";

void main() {
  //todo 读取服务器上数据
  HttpServer.bind(HOST, PORT).then((server) {
    server.listen((HttpRequest request) {
      switch (request.method) {
        case "GET":
          handleGet(request);
          break;
        default: defaultHandler(request);
      }
    },
        onError: printError);

    print("Listening for GET and POST on http://$HOST:$PORT");
  },
      onError: printError);
  //todo 连接数据库
  var pool = new ConnectionPool(host:"localhost" , port: 3306, user: 'test', password: '111111', db: 'student', max: 5);
  print("Hello,world!");
  // pool.query("SELECT * FROM signup");
  pool.query("SELECT * FROM signup").then((results) {
    results.forEach((row) {
      //使用下标查询结果
      print('${row[0]},${row[1]}');
    });
  });
}

/**
 * Handle GET requests by reading the contents of data.json
 * and returning it to the client
 */
void handleGet(HttpRequest req) {
  HttpResponse res = req.response;
  print("${req.method}: ${req.uri.path}");
  addCorsHeaders(res);

  var file = new File(DATA_FILE);
  if (file.existsSync()) {
    res.headers.add(HttpHeaders.CONTENT_TYPE, "application/json");
    file.readAsBytes().asStream().pipe(res); // automatically close output stream
  }
  else {
    var err = "Could not find file: $DATA_FILE";
    res.addStream(err);
    res.close();
  }

}

/**
 * Handle POST requests by overwriting the contents of data.json
 * Return the same set of data back to the client.
 */


/**
 * Add Cross-site headers to enable accessing this server from pages
 * not served by this server
 *
 * See: http://www.html5rocks.com/en/tutorials/cors/
 * and http://enable-cors.org/server.html
 */
void addCorsHeaders(HttpResponse res) {
  res.headers.add("Access-Control-Allow-Origin", "*");
  res.headers.add("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
  res.headers.add("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
}

void defaultHandler(HttpRequest req) {
  HttpResponse res = req.response;
  addCorsHeaders(res);
  res.statusCode = HttpStatus.NOT_FOUND;
  //res.addString("Not found: ${req.method}, ${req.uri.path}");
  res.close();
}

void printError(error) => print(error);
