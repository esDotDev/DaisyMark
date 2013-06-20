package
{
	import starling.display.Image;
	import starling.textures.Texture;
	
	
	public class Particle {
		
		[Embed(source="/assets/daisy.png")]
		public var Daisy:Class;
		
		protected static var texture:Texture;
		
		public var vx:Number;
		public var vy:Number;
		public var sprite:Image;
		
		public function Particle(){
			if(!texture){
				texture = Texture.fromBitmap(new Daisy());
			}
			sprite = new Image(texture);
			
		}
	}
}