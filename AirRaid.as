package {
import flash.display.MovieClip;;
import flash.display.SimpleButton;
import flash.events.KeyboardEvent;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.text.TextField;
import flash.events.Event;
public class AirRaid extends MovieClip {
private var aagun:AAGun;//自己飞机
private var airplanes:Array;//飞机数组
private var bullets:Array;//子弹数组
public var leftArrow, rightArrow,upArrow,downArrow:Boolean;
private var nextPlane:Timer;//不定时生成飞机的计时器
private var shotsHit:int;
private var aa:int=3;
private var Life:int=5;
public function startAirRaid() {
// 初始化得分数和子弹数
shotsHit = 0;
showGameScore();
// 生成炮加入到舞台上
	
aagun = new AAGun();
addChild(aagun);


airplanes = new Array();
bullets = new Array();

// 键盘按下、释放事件侦听器
stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownFunction);
stage.addEventListener(KeyboardEvent.KEY_UP,keyUpFunction);
	
// 进入帧事件侦听器，检测子弹击中飞机的碰撞检测。
addEventListener(Event.ENTER_FRAME,checkForHits);
	
// 生成下一架飞机
setNextPlane();

}
//不定时生成飞机
public function setNextPlane() {
//1000毫秒至2000毫秒之间生成一架飞机
nextPlane = new Timer(1000 + Math.random() * 1000,1);
//
nextPlane.addEventListener(TimerEvent.TIMER_COMPLETE,newPlane);
nextPlane.start();
aa+=5
}

public function newPlane(event:TimerEvent) {
// 随机的边、速度和高度
if (Math.random() > .5) {
var side:String = "left";
} else {
side = "right";
}
var altitude:Number = Math.random()*380+5;
var speed:Number = Math.random()*150+150+aa;
// 生成飞机
var p:Airplane = new Airplane(side,speed,altitude);
addChild(p);
airplanes.push(p);
// set time for next plane
setNextPlane();
}
// 碰撞检测


public function checkForHits(event:Event)
{
for (var airplaneNu:int=airplanes.length-1;airplaneNu>=0;airplaneNu--) 
{
	if (airplanes[airplaneNu].hitTestObject(aagun)) 
	{
		Life--;
		showGameScore();
		airplanes[airplaneNu].planeHit();
	}
}
for(var bulletNum:int=bullets.length-1;bulletNum>=0;bulletNum--)
{
	for(var airplaneNum:int=airplanes.length-1;airplaneNum>=0;airplaneNum--) 
	{
	if (bullets[bulletNum].hitTestObject(airplanes[airplaneNum])) 
		{
		airplanes[airplaneNum].planeHit();
		bullets[bulletNum].deleteBullet();
		shotsHit++;
		showGameScore();
		break;
		}
	}
}

if (Life==0){
endGame();
}
}
// 按下键盘
public function keyDownFunction(event:KeyboardEvent) {
if (event.keyCode == 37) {
leftArrow = true;
} 
else if (event.keyCode == 39) {
rightArrow = true;
} 
else if (event.keyCode == 87) {
fireBullet();
} 
else if(event.keyCode == 38)
{
	upArrow = true;
}
else if(event.keyCode == 40)
{
	downArrow = true;
}
}
// 释放键盘
public function keyUpFunction(event:KeyboardEvent) {
if (event.keyCode == 37) {
leftArrow = false;
} else if (event.keyCode == 39) {
rightArrow = false;
}
else if(event.keyCode == 38)
{
	upArrow = false;
}
else if(event.keyCode == 40)
{
	downArrow =false;
}
}
// 生成新的子弹
public function fireBullet() {
var b:Bullet = new Bullet(aagun.x,aagun.y,-300);
addChild(b);
bullets.push(b);
showGameScore();
}
public function showGameScore() {
showScore.text = String("得分: "+shotsHit);
ming.text=String("生命值："+Life)
}
// 从数组获取飞机
public function removePlane(plane:Airplane) {
for(var i in airplanes) {
if (airplanes[i] == plane) {
airplanes.splice(i,1);
break;
}
}
}
// 获取数组的一个子弹
public function removeBullet(bullet:Bullet) {
for(var i in bullets) {
if (bullets[i] == bullet) {
bullets.splice(i,1);
break;
}
}
}
// 游戏结束，移除界面上的东西。
public function endGame() {
// 移除飞机
for(var i:int=airplanes.length-1;i>=0;i--) {
airplanes[i].deletePlane();
}
airplanes = null;

aagun.deleteGun();
aagun = null;

// 移除侦听器
stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDownFunction);
stage.removeEventListener(KeyboardEvent.KEY_UP,keyUpFunction);
removeEventListener(Event.ENTER_FRAME,checkForHits);

Life=5;
shotsHit = 0;
nextPlane.stop();

gotoAndPlay(3);
}
}
}