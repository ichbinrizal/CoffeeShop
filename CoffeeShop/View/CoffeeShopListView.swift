//
//  CoffeeShopListView.swift
//  CoffeeShop
//
//  Created by Rizal on 03/12/22.
//

import SwiftUI
import ActivityView
import CachedAsyncImage

struct CoffeeShopListView: View {
    // MARK: Properties
    @State var coffeeshops = CoffeeShopList
    
    // MARK: Body
    var body: some View {
        NavigationStack {
            List{
                ForEach(coffeeshops) { coffeshop in
                    VStack (alignment: .leading) {
                        NavigationLink(destination:
                                        CoffeShopDetail(coffeshop: coffeshop)
                        )
                        {
                            EmptyView()
                        }
                        .opacity(0)
                        CoffeeShopView(coffeshop: coffeshop)
                    } //: ZStack
                    
                } //: ForEach
                .onDelete{ indexSet in
                    coffeeshops.remove(atOffsets: indexSet)
                    
                }
                .listRowSeparator(.hidden)
            } //: List
            .listStyle(.plain)
            .navigationTitle("CoffeeShop")
            
        } //: NavigationStack
        .tint(.white)
    }
}


// MARK: View
struct CoffeeShopListView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeShopListView()
    }
}


// MARK: SubView
struct CoffeeShopView: View {
    @State var coffeshop: CoffeeShop
    @State private var item: ActivityItem?
    @State private var showAlert: Bool = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            let url = URL(string: coffeshop.imageURL)
            CachedAsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.1)
            }
            .frame(width: 120, height: 120)
            .cornerRadius(20)
            
            VStack (alignment: .leading) {
                Text(coffeshop.name)
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                Text(coffeshop.location)
                    .font(.system(size: 14, design: .rounded))
                if coffeshop.isFavorite {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .padding(.vertical)
                }
            } // VStack
        } //: HStack
        .swipeActions(edge: .leading, allowsFullSwipe: false) {
            Button {
                
            } label: {
                Image(systemName: "pin")
            }
            .tint(.green)
            Button {
                
            } label: {
                Image(systemName: "square.and.arrow.up")
            }
            .tint(.indigo)
        }
        .alert("Not yet available",
                           isPresented: $showAlert) {
                        Button {} label: {
                           Text("Ok")
                        }
                        
                    } message: {
                        Text("Currently on active development")
                    }
        .contextMenu {
            Button {
                showAlert = true
            } label: {
                HStack {
                    Text("Pin this location")
                    Image(systemName: "pin")
                }
            }
            
            Button {
                coffeshop.isFavorite.toggle()
            } label: {
                HStack {
                    Text(coffeshop.isFavorite ? "Remove as favorite" : "Mark as favorite")
                    Image(systemName: coffeshop.isFavorite ? "heart.slash" : "heart" )
                }
            }
            Button {
                item = ActivityItem(items: "CoffeeShop \(coffeshop.name) will be shared")
            } label: {
                HStack {
                    Text("Share")
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        .activitySheet($item)
    }
}

// MARK: SubView
struct CoffeShopDetail: View {
    @State var coffeshop: CoffeeShop
    
    var body: some View {
        ZStack (alignment: .center) {
            let url = URL(string: coffeshop.imageURL)
            CachedAsyncImage(url: url) { image in image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.1)
            }
            VStack {
                VStack {
                    Text(coffeshop.name)
                        .font(.system(size: 32, design: .rounded))
                        .fontWeight(.bold)
                    Text(coffeshop.location)
                        .font(.system(size: 18, design: .rounded))
                }
                .foregroundColor(.white)
                .padding()
                .background(.black)
                .opacity(0.7)
                .cornerRadius(10)
            }
            .shadow(radius: 10)
            .padding(.trailing,200)
        }
        .ignoresSafeArea()
    }
}
