
import Foundation


class ContentViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    func fetchData() {
        guard let url = URL(string: "https://cryptonews-api.com/api/v1?tickers=BTC&items=20&page=1&token=f1v3kucj6evax2rnrweosw1uzqnit4hzobsqkggs") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(PostResponse.self, from: data)
                    let posts = decodedData.data
                    DispatchQueue.main.async {
                        self.posts = posts
                    }
                } catch {
                    print("JSON decoding error: \(error)")
                }
            } else if let error = error {
                print("API call error: \(error)")
            }
        }
        .resume()
    }
    
    func formatDateString(_ dateString: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "MMM dd, yyyy, HH:mm"
            return formatter.string(from: date)
        } else {
            return nil
        }
    }
}
