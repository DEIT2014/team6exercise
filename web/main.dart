// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';



void main() {
  querySelector('#sample_text_id')
    ..text = 'Click me!'
    ..onClick.listen(reverseText);//栗子
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
  void main(){
    ///有关作业信息的板块
    //todo:从老师数据库中获取作业信息的截至日期和作业注释
    ///有关作业提交的板块
    //todo:添加附件浏览电脑的功能
  }

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
  querySelector('#teaPreview')
    ..text=listen(teaPreview);

  var teaMark = querySelector('#teaMark');
  querySelector('#teaMark')
    ..text='评分'
    ..onClick.listen(teaMark);

  var teaReview = querySelector('#teaReview');
  querySelector('#teaReview')
    ..text='回复'
    ..onClick.listen(teaReview);

  var teaReview = querySelector('#commentInput');
  querySelector('#commentInput')
    ..text=''
    ..onClick.listen(commentInput);
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

void teaMark(){
  //todo 老师输入分数，上传老师的评分至数据库
}

void teaReview(){
  //todo 跳出新的div回复框，提交已写文字到数据库
}

void commentInput(){
  //todo 输入评论
}