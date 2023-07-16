import SwiftUI
import Kingfisher

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var darkMode = false
    @Environment(\.colorScheme) var colorScheme

    var textColor: Color {
        if colorScheme == .dark {
            return Color.white
        } else {
            return Color.black
        }
    }

    var body: some View {
        NavigationView {
            List(viewModel.posts, id: \.id) { post in
                VStack {
                    NavigationLink(destination: DetailView(url: post.news_url)) {}.hidden()

                    if let imageURL = post.image_url,
                       let url = URL(string: imageURL) {
                        KFImage(url)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.3)
                            .cornerRadius(25)
                            .shadow(radius: 5)
                    }

                    Text(post.source_name ?? "")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 2)

                    Text(post.title ?? "")
                        .font(.system(size: 30))
                        .bold()
                        .lineLimit(4)
                        .padding(5)

                    if let tickers = post.tickers {
                        Text(tickers.joined(separator: " , "))
                            .padding(7)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .clipShape(Capsule())
                    }
                    if let sentiment = post.sentiment {
                        Text(sentiment)
                            .bold()
                            .padding(7)
                            .foregroundColor(.white)
                            .background(sentiment == "Negative" ? Color.red : sentiment == "Positive" ? Color.green : Color.blue)
                            .clipShape(Capsule())
                            .padding(.horizontal, 5)
                    }
                    if let dateString = post.date {
                        Text(viewModel.formatDateString(dateString) ?? "Invalid date")
                            .foregroundColor(.gray)
                            .padding(.horizontal, 5)
                    }
                }
            }
            .navigationBarTitle("CryptoNews")
            .onAppear {
                viewModel.fetchData()
                       
            }
            .toolbar {
                ToolbarItem{
                    Button(action: {
                        darkMode.toggle()
                        if darkMode {
                            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
                        } else {
                            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
                        }
                    }) {
                        Image(systemName: darkMode ? "sun.max.fill" :   "moon.stars.fill").foregroundColor(darkMode ? .white : .black)
                            .font(.largeTitle)
                            
                    }
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



