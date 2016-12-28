import 'dart:io';
import 'package:sqljocky/sqljocky.dart';
import 'package:sqljocky/utils.dart';
import 'package:options_file/options_file.dart';
import 'package:shelf/shelf.dart' ;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_route/shelf_route.dart';
import 'package:json_object/json_object.dart';
import 'dart:async';
import 'dart:convert' show JSON;
import 'package:team6exercise/comment-class.dart';
import 'package:jsonx/jsonx.dart';
/* A simple web server that responds to **ALL** GET requests by returning
 * Browse to it using http://localhost:3320
 * Provides CORS headers, so can be accessed from any other page
 */

Map<String, String> data = new Map();
final HOST = "127.0.0.1"; // 便于从console框中直接进入url，调试状态下勿删。
final PORT = 3320;//便于从console框中直接进入url，调试状态下勿删。
var pool = new ConnectionPool(host:"localhost" , port: 3306, user: 'test', password: '111111', db: 'evaltool', max: 5);
var _headers={"Access-Control-Allow-Origin":"*",
  "Access-Control-Allow-Methods": "POST, GET, OPTIONS",
  "Access-Control-Allow-Headers":"Origin, X-Requested-With, Content-Type, Accept",
  "Content-Type":"application/json",
};



Future main() async{

//  var commentList=[];
//  commentList.add(com1);
//  String comListJson=encode(commentList);
//  print(comListJson);
//  List<com> commentList1 = decode(comListJson, type: const TypeHelper<List<com>>().type);
//  print(commentList1);

  //杜谦
  var myRouter = router()
    ..get('/stu/id',stuID)//获取学生的姓名
    ..get('/stu/faculty',stuFaculty)//获取学生的专业
    ..get('/stu/course',stuCourse)//获取学生选取的课程
    ..post('/stu/submitHomework',stuSubHomwork)//学生提交作业
    ..get('/teacher/id',teacherID)//获取老师的姓名
    ..post('/postInfo_basic/',postInfo_basic)//注册界面，注册账号，密码和身份


  //吴怡雯
    ..get('/stupage/mygrade',getComment)//评论区在某同学第几条作业下获取已有评论
    ..post('/stupage/mygrade',getComment)
    ..get('/signin/getid/',getID)//登录获取身份信息
    ..get('/stu/getScore/{id}/{number}/',getScore)//评论区在某同学第几条作业下获取分数
    ..post('/stu/postComment/{id}/{number}/',stuPostComment)//评论区在某同学第几条作业下提交学生的评论
    ..post('/signin/postid/',postID)//登录提交身份信息


  //李志伟
    ..get('/tea/gethprojectlist/{schoolnumber}/',getprojectlist)//获取老师发布的作业列表
    ..get('/tea/gethprojectlist/{schoolnumber}/gethomeworklist',gethomeworklist)//获取老师收到的学生的作业列表
    ..get('/tea/rojectlist/{schoolnumber}/gethomeworklist/gethomeworkdetail',gethomeworkdetail)//获取学生提交的一份作业的具体信息
    ..post('/tea/postjudge/{teaschoolnumber}/{stuschoolnumber}/{id}/',postjudge)//提交教师的评价
    ..get('/{name}{?age}', myHandler);
  io.serve(myRouter.handler, '127.0.0.1', 3320);
  print("Listening for GET,POST and PUT on http://$HOST:$PORT");//便于从console框中直接进入url,可在语句最后加上“/后缀”检验该URL是否取到数据，调试状态下勿删。
}
////todo:获取学生的姓名
stuID(request) async{
  //连接我的数据库,将取出的数据存入到一个列表中
  var singledata=new Map<String,String>();//先建一个数组存放一条数据
  var info_stulist=new List();
  var finalinfo_stulist=new Map<String,String>();
  var result=await pool.query('select id,name,password,career from basic_info');
  await result.forEach((row) {
    singledata={
      '"id"':'"${row.id}"',
      '"name"':'"${row.name}"',
      '"password"':'"${row.password}"',
      '"career"':'"${row.career}"'
    };
    info_stulist.add(singledata);//将该数据加入数组中

  });
  finalinfo_stulist={'"basic_info"':info_stulist};
  return (new Response.ok(finalinfo_stulist.toString(),headers: _headers));
}

////todo：实现post功能
postInfo_basic(request){

}


//todo:把从数据库取出的数据连接到客户端，并在客户端上显示出来
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

getComment(request) async{
  ///todo 在某同学第几条作业下获取已有评论
  //连接我的数据库
  var _headers1={"Access-Control-Allow-Origin":"*",
  "Access-Control-Allow-Methods": "POST, GET, OPTIONS",
  "Access-Control-Allow-Headers":"Origin, X-Requested-With, Content-Type, Accept",
  "Content-Type":"application/json"
  };
  var singledata = new Map<String,String>(); //存放单个用户数据
  var userdata = new List(); //存放所有用户的数据


  var data = await pool.query('select id,comment from comment'); //取数据库中的数据
  var com1 = new com();
  await data.forEach((row) {
//    String index = "id" + i.toString();//index=id0
//    singledata.add(index);//map加一个属性index
//    singledata[index] = row.id;//值为数据库中的id
//    i++;
    singledata={'"comment"':'"${row.comment}"'};//按照这个格式存放单条数据
    userdata.add(singledata);//将该数据加入数组中
//    com1.id = row.id;
//    com1.comment = row.comment;
  });
  String comJson =encode(com1);
//  var commentList=[];
//  commentList.add(com1);
//  String comListJson=encode(commentList);
//  print(comListJson);
//  List<com> commentList1 = decode(comListJson, type: const TypeHelper<List<com>>().type);
//  print(commentList1);

  return (new Response.ok(comJson.toString(),headers: _headers1));//string
//可能是map无法转成String
//也可能是singledata数据错误
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
getprolist(request) async{
  //todo 取老师发布的作业列表
    var _headers1={"Access-Control-Allow-Origin":"*",
      "Access-Control-Allow-Methods": "POST, GET, OPTIONS",
      "Access-Control-Allow-Headers":"Origin, X-Requested-With, Content-Type, Accept",
      "Content-Type":"application/json"
    };
    var data = await pool.query('select question from homework');
    var com1 = new com();
    await data.forEach((row) {
      com1.id = row.id;
      com1.comment = row.comment;
    });
    String comJson =encode(com1);
    return (new Response.ok(comJson.toString(),headers: _headers1));
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