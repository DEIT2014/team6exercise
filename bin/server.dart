import 'dart:io';
import 'package:sqljocky/sqljocky.dart';
import 'package:shelf/shelf.dart' ;
import 'package:sqljocky/utils.dart';
import 'package:options_file/options_file.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_route/shelf_route.dart';
import 'dart:core';
import 'dart:async';
/* A simple web server that responds to **ALL** GET requests by returning
 * the contents of data.json file, and responds to ALL **POST** requests
 * by overwriting the contents of the data.json file
 *
 * Browse to it using http://localhost:4042
 *
 * Provides CORS headers, so can be accessed from any other page
 */

Map<String, String> data = new Map();
var host = "127.0.0.1:8080";
final DATA_FILE="C:\\Users\\wen51\\Documents\\GitHub\\team6exercise\\bin\\data.json";
final _headers={"Access-Control-Allow-Origin":"*",
  "Access-Control-Allow-Methods": "POST, GET, OPTIONS",
  "Access-Control-Allow-Headers":"Origin, X-Requested-With, Content-Type, Accept"};


main(){
  var myRouter = router()
    ..get('/stu/id',stuID)
    ..get('/stu/faculty',stuFaculty)
    ..get('/stu/course',stuCourse)
    ..get('/stu/submitHomework',stuSubHomwork)
    ..get('/teacher/id',teacherID)
  //吴怡雯
   ..get('/stu/getComment',getComment)//评论区在某同学第几条作业下获取已有评论
   ..get('/signin/getid/',getID)//登录获取身份信息
   ..get('/stu/getScore/{id}/{number}/',getScore)//评论区在某同学第几条作业下获取分数
   ..post('/stu/postComment/{id}/{number}/',stuPostComment)//评论区在某同学第几条作业下提交学生的评论
   ..post('/signin/postid/',postID)//登录提交身份信息
   ..post('/signup/postid/',postID)//注册提交身份信息
  //李志伟
    ..get('/tea/gethprojectlist/{schoolnumber}/',getprojectlist)//获取老师发布的作业列表
    ..get('/tea/gethprojectlist/{schoolnumber}/gethomeworklist',gethomeworklist)//获取老师收到的学生的作业列表
    ..get('/tea/rojectlist/{schoolnumber}/gethomeworklist/gethomeworkdetail',gethomeworkdetail)//获取学生提交的一份作业的具体信息
    ..post('/tea/postjudge/{teaschoolnumber}/{stuschoolnumber}/{id}/',postjudge)//提交教师的评价
    ..get('/{name}{?age}', myHandler);
  io.serve(myRouter.handler, '127.0.0.1', 8080);




/**
 * Handle GET requests by reading the contents of data.json
 * and returning it to the client
 */
//杜谦
//get数据库中的数据的实现
//todo:获取学生的姓名
getComment(request) async{
  //连接我的数据库

  var pool = new ConnectionPool(host:"localhost" , port: 3306, user: 'test',password: '111111' , db: 'student', max: 5);
  var singledata=new Map<String,String>();//存放单个用户数据
  var userdata=new List();//存放所有用户的数据
  var data=await pool.query('select comment from comment'); //去数据库中的数据
  await data.forEach((row){
    singledata={'"ID"':'"${row.ID}"','"comment"':'"${row.comment}"'};//按照这个格式存放单条数据
    userdata.add(singledata);//将该数据加入数组中);
  return new Response.ok(userdata);

}

myHandler(request) {
  var name = getPathParameter(request, 'name');
  var age = getPathParameter(request, 'age');
  return new Response.ok("Hello $name of age $age");
}

teacherID(request){
///todo:获取老师的姓名
}
stuFaculty(request) {
//todo:获取学生的专业
 var name = getPathParameter(request, 'name');
 var faculty = getPathParameter(request, 'faculty');
return new Response.ok("Hello $name of faculty $faculty");
}
stuCourse(request) {
///todo:获取学生的所选课程
 var name = getPathParameter(request, 'name');
  var course = getPathParameter(request, 'course');
 return new Response.ok("Hello $name of course $course");
}
scanComputer(request) {
///todo:实现浏览本地电脑文件的功能
 var name = getPathParameter(request, 'name');
 var scanComputer = getPathParameter(request, 'scanComputer');
 return new Response.ok("Hello $name of scanComputer $scanComputer");
}

stuSubHomwork(request) {
///todo:实现提交作业的功能
  var name = getPathParameter(request, 'name');
  var submitHomework = getPathParameter(request, 'submitHomework');
  return new Response.ok("Hello $name of submitHomework $submitHomework");
 }


responseRoot(request){
///todo:获取老师的用户名，显示在页头
return new Response.ok("Hello teacher!");


}

stuID(request) async{
  ///todo 在某同学第几条作业下获取已有评论
  var pool = new ConnectionPool(host:"localhost" , port: 3306, user: 'root',  db: 'STU_SQL', max: 5);
  await pool.query('select * from STU_SQL').then((results) {
    results.forEach((row) {
      print('ID: ${row[0]}, user-name: ${row[1]}');
    });
  });
  return new Response.ok("Hello stu!");
}

getID(request){
  //todo 获取身份信息
}
stuPostComment(request){
  ///todo 在某同学第几条作业下提交学生的评论
}
postID(request){
  //todo 提交身份信息
}
getScore(request){
  //todo 在某同学第几条作业下获取分数
}
//李志伟
getprojectlist(request){
  //todo 取老师发布的作业列表
}
gethomeworklist(request){
  //todo 获取老师收到的学生的作业列表
}
gethomeworkdetail(request){
  //todo 获取学生提交的一份作业的具体信息
}
postjudge(request){
//todo 提交教师的评价
}