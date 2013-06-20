package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.media.CameraUI;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class DaisyMark extends flash.display.Sprite
	{
		public static var screenWidth:int;
		public static var screenHeight:int;
		
		protected var _starling:Starling;
		protected var starlingRoot:starling.display.Sprite;
		
		public var particles:Vector.<Particle>;
		
		public var particle:Particle;
		
		protected var pScale:Number;
		protected var numParticles:int = 500;
		protected var speed:int = 20;
		
		protected var tf:TextField;
		protected var testCount:int = 0;
		protected var c:int;
		
		public function DaisyMark()
		{
			super();
			
			setTimeout(function(){
				// support autoOrients
				stage.align = StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.color = 0x0;
				stage.frameRate = 60;
				
				_starling = new Starling(starling.display.Sprite, stage);
				_starling.addEventListener(starling.events.Event.ROOT_CREATED, onStarlingComplete);
				_starling.simulateMultitouch = !CameraUI.isSupported;
				_starling.showStats = true;
				_starling.start();
				
			}, 500);
			
		}
		
		protected function onStarlingComplete(event:starling.events.Event):void {
			
			pScale = (stage.stageHeight * .125)/67;
			
			starlingRoot = Starling.current.root as starling.display.Sprite;
			screenWidth = stage.stageWidth;
			screenHeight = stage.stageHeight;
				
			pScale = (screenHeight * .125)/((new Particle()).sprite.height);
			speed *= pScale;
			
			createParticles();
			addEventListener(flash.events.Event.ENTER_FRAME, function(){ onTick(); });
		}
		
		public function onTick():void {
				//canvas.clear();
			for(var i:int = 0, l:int = particles.length; i < l; i++){
				particle = particles[i];
				particle.sprite.x += particle.vx;
				particle.sprite.y -= particle.vy;
				
				particle.vy -= .35;
				particle.vx *= 0.99;
				particle.sprite.rotation += .01;
				if(particle.sprite.y > screenHeight){
					initParticle(particle);
				}
				
			}
		}
		
		protected function createParticles():void {
			
			particles = new <Particle>[];
			for(var i:int = 0; i < numParticles; i++){
				var particle:Particle = new Particle();
				initParticle(particle);
				starlingRoot.addChild(particle.sprite);
				particles.push(particle);
			}
		}
		
		protected function initParticle(particle:Particle):void {
			var a:Number = Math.PI/2*Math.random()-Math.PI*0.75;
			var v:Number = Math.random()*speed;
			particle.vx = Math.cos(a)*v;
			particle.vy = -Math.min(-10 - 10 * Math.random(), Math.sin(a)*v);
			particle.sprite.x = screenWidth >> 1;
			particle.sprite.y = screenHeight;
			
			var scale:Number = (pScale * .5) + (Math.random() * pScale * .5);
			particle.sprite.scaleX = scale;
			particle.sprite.scaleY = scale;
		}
	}
}