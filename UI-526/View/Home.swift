//
//  Home.swift
//  UI-526
//
//  Created by nyannyan0328 on 2022/03/31.
//

import SwiftUI

struct Home: View {
    @State var currentIndex : Int = 0
    @State var currentTab :  String = "Flims"
    @Environment(\.colorScheme) var scheme
    @Namespace var aniamiton
    
    @State var currentSize : CGSize = .zero
    @State var showDetail : Bool = false
    @State var detailMovie : Movie?
    var body: some View {
        ZStack{
            
            BGView()
            
            VStack{
                
                navBar()
                
                SnapCarousel(spacing: 15, trailingSpace: 110, index: $currentIndex, items: movies) { movie in
                    
                    
                    GeometryReader{proxy in
                        
                        let size = proxy.size
                        
                        Image(movie.artwork)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .cornerRadius(15)
                            .matchedGeometryEffect(id: movie.id, in: aniamiton)
                            .onTapGesture {
                                
                                detailMovie = movie
                                currentSize = size
                                
                                withAnimation{
                                    
                                    showDetail = true
                                }
                            }

                    }
                }
                .padding(.top,80)
                
                
                customIndicator()
                
                
                HStack{
                    
                    Text("Popular")
                        .font(.title3.weight(.semibold))
                    
                    Spacer()
                    
                    
                    Button("See More"){
                        
                        
                        
                    }
                    
                }
                .padding(.top,5)
                .padding(.horizontal)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing:13){
                        
                        ForEach(movies){mov in
                            
                            Image(mov.artwork)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 150)
                                .cornerRadius(15)
                        }
                    }
                    .padding(.horizontal)
                    
                }
                
            }
            .overlay {
                
                
                if let movie = detailMovie,showDetail{
                    
                    
                    DetailView(movie: movie, showDetail: $showDetail, detailMovie: $detailMovie, currentSize: $currentSize, animation: aniamiton)
                    
                    
                    
                }
                
                
            }
            
            
            
        }
    
    }
    @ViewBuilder
    func customIndicator()->some View{
        
        
        HStack(spacing:10){
            
            
            ForEach(movies.indices,id:\.self){index in
                
                
                Circle()
                    .fill(currentIndex == index ? .blue : .gray.opacity(0.3))
                    .frame(width: currentIndex == index ? 10 : 5, height: currentIndex == index ? 10 : 5)
                    .animation(.spring(), value: currentIndex)
                
                
                
            }
            
        }
        
        
        
    }
    @ViewBuilder
    func navBar()->some View{
        
        
        HStack(spacing:20){
            
            
            ForEach(["Flims","Locality"],id:\.self){index in
                
                Button {
                    withAnimation{
                        
                        currentTab = index
                        
                    }
                } label: {
                    Text(index)
                        .font(.title2.weight(.light))
                        .foregroundColor(.white)
                        .padding(.vertical,10)
                        .padding(.horizontal)
                        .background{
                            
                            
                            if currentTab == index{
                                
                                Capsule()
                                    .fill(.regularMaterial)
                                    .matchedGeometryEffect(id: "TAB", in: aniamiton)
                                    .environment(\.colorScheme, .dark)
                                
                                    
                                
                                
                            }
                        }
                }

                
                    
                
                
            }
        }
        
    }
    @ViewBuilder
    func BGView()->some View{
        
        GeometryReader{proxy in
            
            let size = proxy.size
            
            TabView(selection: $currentIndex) {
                
                
                ForEach(movies.indices,id:\.self){index in
                    
                    Image(movies[index].artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .tag(index)
                    
                }
                
                
                
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentIndex)
            
            
            let color : Color = (scheme == .dark ? .black : .white)
            
            
            LinearGradient(colors: [
            
                .black,
                .clear,
                color.opacity(0.6),
                color.opacity(0.8),
                color.opacity(0.7),
                color,
                color
            
            
            ], startPoint: .top, endPoint: .bottom)
            
            
            Rectangle()
                .fill(.ultraThinMaterial)
            
            
        }
        .ignoresSafeArea()
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
