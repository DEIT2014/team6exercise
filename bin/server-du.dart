import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_cors/shelf_cors.dart' as shelf_cors;
import 'package:shelf_route/shelf_route.dart';

Map<String, String> data = new Map();
final pool = new ConnectionPool(host: "localhost",
    port: 3306,
    user: '10140340109',
//用你自己的账号替代
    password: 'root',
//用你自己的密码替代
    db: '第三小组数据库',
//用你自己的数据库替代
    max: 5); //与数据库相连
//建立路由
  var myRouter = router()
    ..get('/stu',forStu);
   // ..get('/{name}{?faculty}', myHandler)
   //..get('/{name}{?course}',stuCourse)
   // ..get('/{name}{?scanComputer}',scanComputer)
   // ..get('/{name}{?submitHomework}',submitHomework)
  //  ..get('/teacher',responseRoot);
Map <String, String> corsHeader = new Map();
corsHeader["Access-Control-Allow-Origin"] = "*";
corsHeader["Access-Control-Allow-Methods"] = 'POST,GET,OPTIONS';
corsHeader['Access-Control-Allow-Headers'] =
'Origin, X-Requested-With, Content-Type, Accept';
var routerHandler = myRouter.handler;
var handler = const shelf.Pipeline()
    .addMiddleware(shelf.logRequests())
    .addMiddleware(
    shelf_cors.createCorsHeadersMiddleware(corsHeaders: corsHeader))
    .addHandler(routerHandler);

forStu(request){
  ///todo:获取学生的用户名，显示在页头
  return new Response.ok("Hello stu!");
}

//myHandler(request) {
  ///todo:获取学生的专业
  //var name = getPathParameter(request, 'name');
 // var faculty = getPathParameter(request, 'faculty');
 // return new Response.ok("Hello $name of faculty $faculty");
//}
//stuCourse(request) {
  ///todo:获取学生的所选课程
  //var name = getPathParameter(request, 'name');
 // var course = getPathParameter(request, 'course');
 // return new Response.ok("Hello $name of course $course");
//}
//scanComputer(request) {
  ///todo:实现浏览本地电脑文件的功能
  //var name = getPathParameter(request, 'name');
 // var scanComputer = getPathParameter(request, 'scanComputer');
 // return new Response.ok("Hello $name of scanComputer $scanComputer");
//}

//submitHomework(request) {
  ///todo:实现提交作业的功能
  //var name = getPathParameter(request, 'name');
  //var submitHomework = getPathParameter(request, 'submitHomework');
  //return new Response.ok("Hello $name of submitHomework $submitHomework");
//}


//responseRoot(request){
  ///todo:获取老师的用户名，显示在页头
 // return new Response.ok("Hello teacher!");
//}

