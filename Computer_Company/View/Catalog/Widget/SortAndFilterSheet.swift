//
//  SortAndFilterSheet.swift
//  Computer_Company
//
//  Created by Chondro Satrio Wibowo on 08/11/23.
//

import SwiftUI

struct SortAndFilterSheet: View {
    @ObservedObject var productController:ProductController
    @Binding var isFavorite: String
    @Binding var searchText: String
    @Binding var isAscending: String

    var body: some View {
        VStack{
            HStack {
                        Text("Sorting Type")
                            .font(Font.headline)
                Spacer()
                        RadioButtonGroups(callback: {
                            selected in
                                Task{
                                    await productController.getProducts(type: selected,filter:isFavorite,text:searchText)
                                }
                        }, selectedId: $isAscending)
            }.frame(width:UIScreen.main.bounds.size.width - 48)
            HStack {
                        Text("Filter Type")
                            .font(Font.headline)
                Spacer()
                        FavoriteButtonGoups(callback: {
                            selected in
                                Task{
                                    await productController.getProducts(type: isAscending,filter:selected,text:searchText)
                                }
                        }, selectedId: $isFavorite)
            }.frame(width:UIScreen.main.bounds.size.width - 48)
        }.padding(.horizontal,24)
    }
}

