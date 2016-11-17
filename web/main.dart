// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

void main() {
  querySelector('#output').text = 'WEB APP IS RUNNING!';

}

void main() {
  querySelector('#sample_text_id')
    ..text = 'Click me!'
    ..onClick.listen(reverseText);
}
/// reverseText用来接受用户点击按钮翻转字符的响应工作。
/// 参数[event]是鼠标事件....
void reverseText(MouseEvent event) {
  //todo 在这里添加代码处理鼠标点击之后的工作。
}