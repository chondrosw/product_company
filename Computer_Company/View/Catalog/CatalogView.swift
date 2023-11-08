//
//  CatalogView.swift
//  Computer_Company
//
//  Created by Chondro Satrio Wibowo on 07/11/23.
//

import SwiftUI

struct CatalogView: View {
    @State private var searchText = ""
    @StateObject var productController = ProductController()
    @StateObject var favoriteController = FavoriteController()
    @State private var isPresented = false
    @State private var isAscending = "Ascending"
    @State private var isFavorite = "All"
    @State private var isRotating = 0.0
    
    let columnsMobile = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationStack{
            GeometryReader{ geo in
                if productController.products.isEmpty {
                    EmptyDataView(isRotating: $isRotating, size: geo.size)
                } else {
                    GridProductView(productController: productController, favoriteController: favoriteController, isAscending: $isAscending, isFavorite: $isFavorite, searchText: $searchText)
                }
            }.searchable(text: $searchText, prompt: "Look for something").onChange(of: searchText){ value in
                Task{
                    await productController.getProducts(type: isAscending,filter:isFavorite,text:searchText)
                }
            }.navigationTitle("Catalog").toolbar(content: {
                NavigationLink(destination: {
                    FavoritesView(favoriteController:favoriteController)
                }, label: {
                    Image(systemName: "heart.fill").foregroundStyle(.pink)
                })
                Button(action: {
                    isPresented.toggle()
                }, label: {
                    Image(systemName: "line.3.horizontal.decrease.circle").foregroundStyle(.blue)
                }).sheet(isPresented: $isPresented){
                    SortAndFilterSheet(productController: productController, isFavorite: $isFavorite, searchText: $searchText, isAscending: $isAscending).presentationDetents([.medium, .large])
                }
            }).task {
                await productController.getProducts(type: isAscending,filter:isFavorite,text:searchText)
            }
        }
    }
}

#Preview {
    CatalogView()
}
