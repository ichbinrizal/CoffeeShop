//
//  MainView.swift
//  CoffeeShop
//
//  Created by Rizal on 02/12/22.
//

import SwiftUI

struct MainView: View {
    //: MARK Properties
    //@State private var selection: Int = 0
    @State private var selectedTab: Tabs = .coffeeshop
    
    //: MARK Body
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                CoffeeShopListView()
                    .listStyle(.plain)
                    .tabItem {
                        Image(systemName: "square.grid.2x2")
                        Text("CoffeeShop")
                    }
                    .tag(Tabs.coffeeshop)
                VStack {
                    Text("watch".uppercased())
                        .font(.system(.largeTitle, design: .rounded))
                    Button {
                        selectedTab = Tabs.profile
                    } label: {
                        Text("Show Profile")
                            .font(.system(.headline, design: .rounded))
                            .padding()
                            .foregroundColor(.white)
                            .background(.pink)
                            .cornerRadius(10)
                            .padding()
                    }
                } //: VStack
                .tabItem {
                    Image(systemName: "play.rectangle")
                    Text("Watch")
                }
                .tag(Tabs.watch)
                
                Text("loans".uppercased())
                    .font(.system(.largeTitle, design: .rounded))
                    .tabItem {
                        Image(systemName: "rectangle.and.text.magnifyingglass")
                        Text("Loans")
                    }
                    .tag(Tabs.loans)
                Text("profile".uppercased())
                    .font(.system(.largeTitle, design: .rounded))
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                    .tag(Tabs.profile)
            } //: TabView
            .tint(.pink)
            .navigationTitle(selectedTab.rawValue.capitalized)
        } //: NavigationStack
        .tint(.white)
        
    }
}


//: MARK View
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//: MARK Enum
enum Tabs: String {
    case coffeeshop
    case watch
    case loans
    case profile
}
