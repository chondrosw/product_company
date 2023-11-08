//
//  FavoritesView.swift
//  Computer_Company
//
//  Created by Chondro Satrio Wibowo on 07/11/23.
//

import SwiftUI

struct FavoritesView: View {
    @State private var searchText = ""
    @State private var isPresented = false
    @State private var isPresentingDelete = false
    @State private var isAscending = "Ascending"
    @ObservedObject var favoriteController:FavoriteController
    
    let columnsMobile = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                LazyVGrid(columns: columnsMobile, content: {
                    ForEach(favoriteController.favorites){ item in
                        VStack{
                            AsyncImage(url: URL(string: item.imagePath ?? "")){ image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    
                            } placeholder: {
                                Image(systemName: "photo.fill")
                            }.frame(width:120,height: 160)
                            Text(item.title ?? "").lineLimit(2)
                        }.alert("Do you want to unfavorite your product?", isPresented: $isPresentingDelete, actions: {
                            Button(action: {
                                isPresentingDelete.toggle()
                            }, label: {
                                Text("No").foregroundStyle(.blue)
                            })
                            Button(action: {
                                Task {
                                    do{
                                        let favoriteValue = try favoriteController.favoriteValue(productId: Int(item.productId))
                                        if let favorite = favoriteValue {
                                            favoriteController.delete(favorite: favorite)
                                        } else {
                                            favoriteController.addFavorite(title: item.title ?? "", imagePath: item.imagePath ?? "",id:Int(item.productId))
                                        }
                                        favoriteController.getFavorites()
                                    }catch{
                                        
                                    }
                                    isPresentingDelete.toggle()
                                }
                            }, label: {
                                Text("Yes").foregroundStyle(.red).bold()
                            })
                        }, message: {
                            Text("You can still choose and give favorites to your favorite products")
                        }).onTapGesture{
                            isPresentingDelete.toggle()
                        }
                    }
                }).padding(.horizontal)
            }
        }.searchable(text: $searchText, prompt: "Look for Favorite Product").onChange(of: searchText){ value in
            
            favoriteController.getSearchFavorites(with: value)
            
        }.navigationTitle("Favorites").toolbar(content: {
            Button(action: {
                isPresented.toggle()
            }, label: {
                Image(systemName: "line.3.horizontal.decrease.circle").foregroundStyle(.blue)
            }).sheet(isPresented: $isPresented){
                HStack {
                            Text("Sorting Type")
                                .font(Font.headline)
                            RadioButtonGroups(callback: {
                                selected in
                                    
                                         
                                    
                            }, selectedId: $isAscending)
                        }.padding()
            }
        }).task {
            favoriteController.getFavorites()
        }
    }
}

//#Preview {
//    FavoritesView()
//}
