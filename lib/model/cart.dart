class Cart {
  String? cartId;
  String? subjectName;
  String? subjectPrice;
  String? cartqty;
  String? subjectId;
  String? pricetotal;

  Cart(
      {this.cartId,
      this.subjectName,
      this.subjectPrice,
      this.cartqty,
      this.subjectId,
      this.pricetotal});

  Cart.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    subjectName = json['subject_name'];
    subjectPrice = json['subject_price'];
    cartqty = json['cart_qty'];
    subjectId = json['subject_id'];
    pricetotal = json['pricetotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cartId;
    data['subject_name'] = subjectName;
    data['subject_price'] = subjectPrice;
    data['cart_qty'] = cartqty;
    data['subject_id'] = subjectId;
    data['pricetotal'] = pricetotal;
    return data;
  }
}
