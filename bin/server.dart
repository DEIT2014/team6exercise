import 'dart:io';
import 'package:sqljocky/sqljocky.dart';
import 'package:sqljocky/utils.dart';
import 'package:options_file/options_file.dart';
import 'package:shelf/shelf.dart' ;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_route/shelf_route.dart';
/* A simple web server that responds to **ALL** GET requests by returning
 * the contents of data.json file, and responds to ALL **POST** requests
 * by overwriting the contents of the data.json file
 *
 * Browse to it using http://localhost:4042
 *
 * Provides CORS headers, so can be accessed from any other page
 */

final HOST = "localhost"; // eg: localhost
final PORT = 8080;
final DATA_FILE = "C:\\Users\\Qian\\WebstormProjects\\作业评价系统\\team6exercise\\team6exercise\\team6exercise\\team6exercise\\web\\data.json";

void main() {
  //杜谦
  var myRouter = router()
    ..get('/stu', forStu)..get('/{name}{?faculty}', myHandler)
    ..get('/{name}{?course}', stuCourse)
    ..get('/{name}{?scanComputer}', scanComputer)
    ..get('/{name}{?submitHomework}', submitHomework)
    ..get('/teacher', responseRoot)
  //吴怡雯
    ..get('/stu/getComment/{id}/{number}/',getComment)//评论区在某同学第几条作业下获取已有评论
    ..get('/signin/getid/',getID)//登录获取身份信息
    ..get('/stu/getScore/{id}/{number}/',getScore)//评论区在某同学第几条作业下获取分数
    ..post('/stu/postComment/{id}/{number}/',stuPostComment)//评论区在某同学第几条作业下提交学生的评论
    ..post('/signin/postid/',postID)//登录提交身份信息
    ..post('/signup/postid/',postID);//注册提交身份信息

  io.serve(myRouter.handler, '127.0.0.1', 8080);
}

//todo 读取服务器上数据

//todo 连接数据库



/**
 * Handle GET requests by reading the contents of data.json
 * and returning it to the client
 */

//杜谦
forStu(request){
  ///todo:获取学生的用户名，显示在页头
  var pool = new ConnectionPool(host:"localhost" , port: 3306, user: 'test', password: '111111', db: 'student', max: 5);
  print("Hello,world!");
  pool.query("SELECT * FROM signup").then((results) {
    results.forEach((row) {
      //使用下标查询结果
      print('${row[0]},${row[1]}');
    });
  });
  return new Response.ok("Hello stu!");

}

///myHandler(request) {
///todo:获取学生的专业
// var name = getPathParameter(request, 'name');
// var faculty = getPathParameter(request, 'faculty');
//return new Response.ok("Hello $name of faculty $faculty");
//}
//stuCourse(request) {
///todo:获取学生的所选课程
// var name = getPathParameter(request, 'name');
//  var course = getPathParameter(request, 'course');
// return new Response.ok("Hello $name of course $course");
//}
//scanComputer(request) {
///todo:实现浏览本地电脑文件的功能
// var name = getPathParameter(request, 'name');
//var scanComputer = getPathParameter(request, 'scanComputer');
//return new Response.ok("Hello $name of scanComputer $scanComputer");
//}

//submitHomework(request) {
///todo:实现提交作业的功能
//var name = getPathParameter(request, 'name');
//var submitHomework = getPathParameter(request, 'submitHomework');
//return new Response.ok("Hello $name of submitHomework $submitHomework");
//}


//responseRoot(request){
///todo:获取老师的用户名，显示在页头
//return new Response.ok("Hello teacher!");


//}

getComment(request){
  //todo 在某同学第几条作业下获取已有评论
}

getID(request){
  //todo 获取身份信息
}
stuPostComment(request){
  //todo 在某同学第几条作业下提交学生的评论
}
postID(request){
  //todo 提交身份信息
}
getScore(request){
  //todo 在某同学第几条作业下获取分数
}