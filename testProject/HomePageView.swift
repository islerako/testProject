//
//  HomePageView.swift
//  testProject
//
//  Created by Mark.Che on 25/1/2023.
//

import SwiftUI
import Alamofire
import SDWebImageSwiftUI

struct DemoURLs {
    static var baseURL = "https://api.opendota.com"
}

struct Hero: Codable {
    let localized_name: String
    let primary_attr: String
    let icon: String
}


struct HomePageView: View {
    let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [Color.pink, Color.yellow]),
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        
        NavigationView {
            
            if #available(iOS 16.0, *) {
                ZStack {
                    backgroundGradient.ignoresSafeArea()
                    //Color.red.edgesIgnoringSafeArea(.all)
                    heroList()
                }
                .navigationTitle("DOTA HERO")
                .toolbarBackground( Color.pink, for: .navigationBar)
            } else {
                
            }
        }
    }
        
    }
    
    struct HomePageView_Previews: PreviewProvider {
        static var previews: some View {
            HomePageView()
        }
    }


struct heroList: View {
    @State var heroes: [Hero] = []
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack (alignment: .leading){
                
                ForEach(heroes, id: \.localized_name) { item in
                    
                    
                    VStack(alignment: .leading) {
                        
                        
                        HStack (alignment:.center){
                            
                            WebImage(url: URL(string: DemoURLs.baseURL + item.icon))
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .aspectRatio(contentMode: .fit)
                                .padding()
                            
                            
                            VStack(alignment: .leading) {
                                Group {
                                    Text(item.localized_name)
                                        .font(.title)
                                        .bold()
                                        .frame(width: 300, height: 30, alignment: .leading)
                                    
                                    Text(item.primary_attr)
                                        .font(.title2)
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            
            AF.request(DemoURLs.baseURL + "/api/heroStats").response { response in
                switch response.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONDecoder().decode([Hero].self, from: data!)
                        print(jsonData)
                        self.heroes = jsonData
                    }catch {
                        print(error.localizedDescription)
                    }
                case .failure(let errors):
                    print(errors.localizedDescription)
                }
            }
        }
    }
}
