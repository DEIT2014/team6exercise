// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:math';
import 'dart:convert' show JSON;
import 'dart:core'as core;
import 'dart:async';

var host = "localhost:8080";
HttpRequest request;
void click(MouseEvent e){
  var url = 'http://localhost:8080/stu/id';
  request = new HttpRequest();
  request.onReadyStateChange.listen(onData);
  request.open('POST', url);
  request.send(" jsonstring");
}

void onData(_) {
  if (request.readyState == HttpRequest.DONE && request.status == 200) {
    var data=request.responseText;
    var datalist=JSON.decode(data);
    var stuname=datalist[0]["number_stu"];
    querySelector("#name").text=stuname;

  }
}


void main() {

  querySelector("#btn").onClick.listen(click);
//登录界面
  var signup = querySelector('#signup');
  querySelector('#signup')
    ..text='注册'
    ..onClick.listen(signup);

  var signin = querySelector('#signin');
  querySelector('#signin')
    ..text='登录'
    ..onClick.listen(signin);

  //提交作业界面
  var getprojectlist = querySelector('#projectlist');
  querySelector('#projectlist')
    ..text='信息技术课程作业'
    ..onClick.listen(projectlist);

  var gethomeworklist = querySelector('#homeworklist');
  querySelector('#homeworklist')
    ..text='信息技术课程作业三'
    ..onClick.listen(homeworklist);

  var gethomeworkdetail = querySelector('#homeworkdetail');
  querySelector('#homeworkdetail')
    ..text='信息技术课程作业三：吴同学'
    ..onClick.listen (homeworkdetail );


  var getstuhomeworklist = querySelector('#stuhomeworklist');
  querySelector('#stuhomeworklist')
    ..text='信息技术课程作业三'
    ..onClick.listen(stuhomeworklist);

  var submitbutton = querySelector('#submitbutton');
  querySelector('#submitbutton')
    ..text = '提交'
    ..onClick.listen(submitbutton);

  var postjudge = querySelector('#judge');
  querySelector('#judge')
    ..text = '信息技术课程作业三：吴同学 图书馆预定座位小程序'
    ..onClick.listen(judge);
  //作业提交界面——杜谦
  ///有关作业信息的板块
  //todo:从老师数据库中获取作业信息的截至日期和作业注释
  var posthomework = querySelector('#posthomework');
  querySelector('#posthomework')
    ..text='写入提交'
    ..onClick.listen(posthomework);

  var browseComputer = querySelector('#browseComputer');
  querySelector('#browseComputer')
    ..text='浏览我的电脑'
    ..onClick.listen(browseComputer);
  ///有关作业提交的板块
  //todo:添加附件浏览电脑的功能


  var postHomework = querySelector('#postHomework');
  querySelector('#postHomework')
    ..text='写入提交'
    ..onClick.listen(postHomework);//todo：点击写入提交按钮就能够出现填写文本的输入框

  var cancel = querySelector('#cancel');
  querySelector('#cancel')
    ..text='取消'
    ..onClick.listen(cancel);

  var saveDraft = querySelector('#saveDraft');
  querySelector('#saveDraft')
    ..text='保存草稿'
    ..onClick.listen(saveDraft);

  var submit = querySelector('#submit');
  querySelector('#submit')
    ..text='提交'
    ..onClick.listen(submit);


//评论区界面
  var teaPreview = querySelector('#teaPreview');
  querySelector('#teaPreview');


  var teaReview = querySelector('#teaReview');
  querySelector('#teaReview')
    ..text='回复'
    ..onClick.listen(teaReview);

  var commentInput = querySelector('#commentInput');
  querySelector('#commentInput')
    ..text=''
    ..onClick.listen(commentInput);

  var comment = querySelector('#comment');
  querySelector('#commentInput')
    ..text=''
    ..onClick.listen(comment);


}



/// reverseText用来接受用户点击按钮翻转字符的响应工作。
/// 参数[event]是鼠标事件....
void reverseText(MouseEvent event) {
  //todo 在这里添加代码处理鼠标点击之后的工作。//栗子
}
void signin(){
//与数据库中核对，正确就打开相应的div；若错，弹出对话框，重新输入
}

void signup(){
//todo 将用户输入的数据上传到数据库中
  json();
}


void json(){
  // todo 将提交的数据转成json数据
}

void teaPreview(){
  //todo 显示数据库中的学生作业
}



void teaReview(){
  //todo 跳出新的div回复框，提交已写文字到数据库
}

void commentInput(){
  //todo 输入评论
}

void comment(){
  //todo 显示评论
  var url = "http://$host/stu/comment/"; // call the web server asynchronously
  var request = HttpRequest.getString(url).then(onDataLoaded);
}
onDataLoaded(responseText) {
  var jsonString = responseText;
  var student=JSON.decode(jsonString);
  var commentlist=student['comments']['comment'];
  querySelector('#sample').text=commentlist;
}
//教师页面—李志伟

void projectlist() {
  //todo 获取老师发布的作业列表
}

void homeworklist() {
  //todo 获取老师收到的学生的作业列表
}

void stuhomeworklist() {
  //todo 获取学生提交的作业列表
}

void homeworkdetail() {
  //todo 获取学生提交的一份作业的具体信息
}
//评价页面—李志伟

void judge() {
  //todo 教师的评价
}

void submitbutton() {
  //todo 提交
}

