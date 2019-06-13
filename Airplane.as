package {
import flash.display.MovieClip;
import flash.events.TimerEvent;
import flash.utils.Timer;
import flash.utils.getTimer;
import flash.events.Event;
public class Airplane extends MovieClip {
private var dy:Number; // 飞机的速度、方向
private var lastTime:int; // 控制移动的Timer
//左右移动
public function Airplane(side:String, speed:Number, altitude:Number) {
	this.y = 0; // start to the left
	dy = speed; // fly left to right
	if(side=="left")
		this.scaleX=1
	else
		this.scaleX=-1
	this.x = altitude; 
	this.gotoAndStop(1);
	// set up animation
	addEventListener(Event.ENTER_FRAME,movePlane);
	lastTime = getTimer();
}

//检测边界
public function movePlane(event:Event) {
// get time passed
var timePassed:int = getTimer()-lastTime;
lastTime += timePassed;
// move plane
this.y += dy*timePassed/1000;
// check to see if off screen
if (y>800) {
deletePlane();
} 
}
// 检测碰撞，子弹击中飞机跳转到帧标签"explode"演示爆炸动画。
public function planeHit() {
removeEventListener(Event.ENTER_FRAME,movePlane);
MovieClip(parent).removePlane(this);
gotoAndPlay(2);
}
// 移除舞台上的飞机和事件
public function deletePlane() {
removeEventListener(Event.ENTER_FRAME,movePlane);
MovieClip(parent).removePlane(this);
parent.removeChild(this);
}
}
}