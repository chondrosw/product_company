//
//  GridProductView.swift
//  Computer_Company
//
//  Created by Chondro Satrio Wibowo on 08/11/23.
//

import SwiftUI

struct GridProductView: View {
    @ObservedObject var productController: ProductController
    @ObservedObject var favoriteController: FavoriteController
    @Binding var isAscending: String
    @Binding var isFavorite: String
    @Binding var searchText: String
    
    let columnsMobile = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    let columnsiPad = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns:UIDevice.current.userInterfaceIdiom == .pad ? columnsiPad : columnsMobile, content: {
                ForEach(productController.products){ item in
                    VStack{
                        AsyncImage(url: URL(string: item.image)){ image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                
                        } placeholder: {
                            Image(systemName: "photo.fill")
                        }.frame(width:120,height: 160)
                        Text(item.title).lineLimit(2)
                        Button(action: {
                            Task {
                                do{
                                    let favoriteValue = try favoriteController.favoriteValue(productId: item.id)
                                    if let favorite = favoriteValue {
                                        favoriteController.delete(favorite: favorite)
                                    } else {
                                        favoriteController.addFavorite(title: item.title, imagePath: item.image,id:item.id)
                                    }
                                    await productController.getProducts(type: isAscending,filter:isFavorite,text:searchText)
                                }catch{
                                    
                                }
                            }
                        }, label: {
                            HStack{
                                Text(item.isFavorite ? "Remove" : "Favorite" ).foregroundStyle(item.isFavorite ? .pink : .white).padding(.horizontal)
                                Image(systemName: item.isFavorite ? "heart.fill" : "heart").foregroundStyle(item.isFavorite ? .pink : .white)
                            }.padding(.all).background(
                                
                                RoundedRectangle(
                                    cornerRadius: 20,
                                    style: .continuous
                                )
                                .stroke(item.isFavorite ? .pink : .white, lineWidth: 2)
                                .fill(item.isFavorite ? .white : .pink)

                            )
                        })
                    }
                }
            }).padding(.horizontal)
        }
    }
}

