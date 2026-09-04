import 'package:flutter/material.dart';

import '../models/restaurant.dart';

const restaurants = <Restaurant>[
  Restaurant(
    category: 'Mexican',
    name: 'El Rio Grande',
    address: '8334 Airline Hwy, Baton Rouge, LA 70815',
    rating: 4.4,
    costLevel: 2,
    description:
        'A longtime Baton Rouge favorite serving scratch-made Tex-Mex, '
        'including enchiladas, tamales, tacos, and fresh salsa.',
    imageUrl: 'https://d1dxs113ar9ebd.cloudfront.net/225batonrouge/2022/10/ElRioGrandeMexicanRestaurant-22.jpg',
    icon: Icons.restaurant_rounded,
  ),
  Restaurant(
    category: 'Asian',
    name: 'Chow Yum',
    address: '2363 Hollydale Ave, Baton Rouge, LA 70808',
    rating: 4.5,
    costLevel: 2,
    description:
        'A playful Asian-fusion spot known for bold ramen, bao, noodles, '
        'and creative dishes with plenty of Baton Rouge personality.',
    imageUrl: 'https://popmenucloud.com/zrlbhedk/f60e064c-2dc4-4f49-a50f-3182672e4349.jpg',
    icon: Icons.ramen_dining_rounded,
  ),
  Restaurant(
    category: 'American',
    name: "Elsie's Plate & Pie",
    address: '3145 Government St, Baton Rouge, LA 70806',
    rating: 4.7,
    costLevel: 2,
    description:
        'A cozy American and Southern restaurant celebrated for savory pot '
        'pies, comfort-food plates, burgers, and memorable dessert pies.',
    imageUrl: 'https://res.cloudinary.com/spothopper/image/fetch/f_auto%2Cq_auto%3Abest%2Cc_fit%2Ch_1200/http%3A/static.spotapps.co/spots/6d/606cf66e4a40e39531c0546134bc37/%3Aoriginal',
    icon: Icons.lunch_dining_rounded,
  ),
  Restaurant(
    category: 'Italian',
    name: "Gino's Restaurant",
    address: '4542 Bennington Ave, Baton Rouge, LA 70808',
    rating: 4.6,
    costLevel: 3,
    description:
        'A family-run Baton Rouge institution serving classic Sicilian and '
        'Italian dishes, handmade pasta, seafood, and rich sauces.',
    imageUrl:
        'https://s3-media0.fl.yelpcdn.com/bphoto/8dytq9w608y5G_rbXoNBBg/l.jpg',
    icon: Icons.local_pizza_rounded,
  ),
  Restaurant(
    category: 'African',
    name: 'BB & PF',
    address: '10248 Florida Blvd, Baton Rouge, LA 70815',
    rating: 4.0,
    costLevel: 2,
    description:
        'A local Nigerian kitchen offering West African favorites such as '
        'jollof rice, fufu, egusi soup, goat, and fried plantains.',
    imageUrl: 'https://d1dxs113ar9ebd.cloudfront.net/225batonrouge/2021/06/225BBPF_020_COLOR.jpg',
    icon: Icons.rice_bowl_rounded,
  ),
  Restaurant(
    category: 'Indian',
    name: 'Bay Leaf Indian Cuisine',
    address: '5160 S Sherwood Forest Blvd, Baton Rouge, LA 70816',
    rating: 4.2,
    costLevel: 2,
    description:
        'A welcoming restaurant with North and South Indian favorites, '
        'including curries, tandoori dishes, biryani, dosa, and fresh naan.',
    imageUrl: 'https://bayleafindiancuisinela.com/img/food-gallery4.jpg',
    icon: Icons.soup_kitchen_rounded,
  ),
  Restaurant(
    category: 'Fast Food',
    name: "Raising Cane's — The Mothership",
    address: '3313 Highland Rd, Baton Rouge, LA 70802',
    rating: 4.5,
    costLevel: 1,
    description:
        "The original Raising Cane's location, serving its famous chicken "
        "fingers, crinkle-cut fries, Texas toast, and Cane's Sauce.",
    imageUrl: 'https://assets.simpleviewinc.com/simpleview/image/upload/crm/batonrouge/RasingCanes_VBROwned2025_1_461940F5-B9C9-4CCE-1055DAEE2572689B-46193fc5921c192_46196770-d727-f387-d3a4e182828f6f09.jpg',
    icon: Icons.fastfood_rounded,
  ),
  Restaurant(
    category: 'Soul Food',
    name: "Dorothy's Soul Food Kitchen",
    address: '1221 Gardere Ln, Suite M, Baton Rouge, LA 70820',
    rating: 4.4,
    costLevel: 2,
    description:
        'A neighborhood favorite for hearty Southern cooking, including '
        'smothered meats, rice and gravy, beans, cornbread, and seafood.',
    imageUrl: 'https://assets.simpleviewinc.com/simpleview/image/upload/crm/batonrouge/DorothysSoulFood_VBROwned2024_1_CBA1AD9E-DD88-9D0F-2326AC7CE0963D42-cba18e15e059e27_cba1b75a-d68d-b476-e952f19e175347de.jpg',
    icon: Icons.dinner_dining_rounded,
  ),
];
