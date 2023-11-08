//
//  ApiServiceTest.swift
//  Computer_CompanyTests
//
//  Created by Chondro Satrio Wibowo on 08/11/23.
//

import XCTest

final class ProductApiServiceTest: XCTestCase {
    
    var productService:ProductService!
    var coreDataService: CoredataService = CoredataService.shared
    var favoriteService:FavoriteController!

    override func setUpWithError() throws {
        productService = ProductService()
        favoriteService =  FavoriteController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetProducts() async throws {
       let products = try await productService.getProducts()
        XCTAssertTrue(products.count > 0)
    }
    
    func testGetProductsSearch() async throws {
        let products = try await productService.getProducts(text: "DANVOUY Womens T Shirt Casual Cotton Short")
        XCTAssertTrue(products[0].title == "DANVOUY Womens T Shirt Casual Cotton Short")
    }
    
    func testGetProductsDescending() async throws{
        let products = try await productService.getProductsSort(type: "desc")
        XCTAssert(products[0].id == 20)
    }
    
    func testGetProductsAscending() async throws{
        let products = try await productService.getProductsSort(type: "asc")
        XCTAssert(products[0].id == 1)
    }
    
    func testGetProductsFilteredFavorited() async throws {
        let favorite1 = coreDataService.createFavorite(title: "DANVOUY Womens T Shirt Casual Cotton Short", imagePath: "https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg", id: 20)
        
        var highlightProducts: [HighlightProductModel] = []
        let products = try await productService.getProducts()
        products.forEach{ item in
            highlightProducts.append(HighlightProductModel(id: item.id, title: item.title, description: item.description, category: item.category, image: item.image,isFavorite: item.id == 20 ? true : false))
        }
        XCTAssertTrue(highlightProducts.filter{$0.isFavorite == true}.count > 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
