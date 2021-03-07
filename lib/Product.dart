class ShopingPullData {
  final String name;
  final String price;
  final String image;
  final String color;
 
  ShopingPullData(this.name, this.price, this.image, this.color);
 
 factory ShopingPullData.fromMap(Map<String, dynamic> json) {
   return ShopingPullData(
    json['name'],
    json['price'],
    json['image'],
    json['color'],

   );
    
  }

  
}