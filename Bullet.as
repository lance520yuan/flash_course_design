package {
import flash.display.MovieClip;
import flash.events.Event;
import flash.utils.getTimer;
import flash.utils.Timer;
import flash.events.TimerEvent;
public class Bullet extends MovieClip {
private var dy:Number; // 子弹的速度、方向。
private var lastTime:int;
public function Bullet(x,y:Number, speed: Number) {
// 初始位置
this.x = x;
this.y = y;
// 得到速度
dy = speed;
// 动画
lastTime = getTimer();
addEventListener(Event.ENTER_FRAME,moveBullet);
}
public function moveBullet(event:Event) {
// 得到时差
var timePassed:int = getTimer()-lastTime;
lastTime += timePassed;
// 子弹运动
this.y += dy*timePassed/1000;
// 子弹越过屏幕的顶端
if (this.y < 0) {
deleteBullet();
}
}
// 移除舞台的子弹和事件
public function deleteBullet() {
MovieClip(parent).removeBullet(this);
parent.removeChild(this);
removeEventListener(Event.ENTER_FRAME,moveBullet);
}
}
}