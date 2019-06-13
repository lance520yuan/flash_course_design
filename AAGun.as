package {
import flash.display.*;
import flash.events.*;
import flash.utils.getTimer;
public class AAGun extends MovieClip {
static const speed:Number = 500.0;
private var lastTime:int; // 控制移动的Timer
public function AAGun() {
// 枪的初始位置
this.x = 200;
this.y = 780;
//运动
addEventListener(Event.ENTER_FRAME,moveGun);
}
public function moveGun(event:Event) {
// 得到时差
var timePassed:int = getTimer() - lastTime;
lastTime += timePassed;
// 现在的位置
var newx = this.x;
var newy=this.y;
	
// 移动到左边
if (MovieClip(parent).leftArrow) {
newx -= speed*timePassed / 1000;
}
// 移动到右边
if (MovieClip(parent).rightArrow) {
newx += speed*timePassed / 1000;
}
if (MovieClip(parent).upArrow) {
newy -= speed*timePassed / 1000;
}
if (MovieClip(parent).downArrow) {
newy += speed*timePassed / 1000;
}
// 检测边界
if (newx < 10) newx = 10;
if (newx > 380) newx = 380;
if (newy < 10) newy = 10;
if (newy > 780) newy = 780;
// 更新位置
this.x = newx;
this.y = newy;
}
// 移除屏幕上的炮和事件
public function deleteGun() {
parent.removeChild(this);
removeEventListener(Event.ENTER_FRAME,moveGun);
}
}
}