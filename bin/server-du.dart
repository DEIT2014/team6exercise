import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_route/shelf_route.dart';

void main() {
  var myRouter = router()
    ..get('/stu',forStu)
    ..get('/{name}{?faculty}', myHandler)
    ..get('/{name}{?course}',stuCourse)
    ..get('/{name}{?scanComputer}',scanComputer)
    ..get('/{name}{?submitHomework}',submitHomework)
    ..get('/teacher',responseRoot);
  io.serve(myRouter.handler, '127.0.0.1', 8080);
}


forStu(request){
  ///todo:获取学生的用户名，显示在页头
  return new Response.ok("Hello stu!");
}

myHandler(request) {
  ///todo:获取学生的专业
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

submitHomework(request) {
  ///todo:实现提交作业的功能
  var name = getPathParameter(request, 'name');
  var submitHomework = getPathParameter(request, 'submitHomework');
  return new Response.ok("Hello $name of submitHomework $submitHomework");
}


responseRoot(request){
  ///todo:获取老师的用户名，显示在页头
  return new Response.ok("Hello teacher!");


}

