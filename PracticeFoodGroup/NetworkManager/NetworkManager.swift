import UIKit

protocol NetworkManager {
    func getData<T: Decodable>(url: String) async throws -> T
    func getImage(url: String) async throws -> UIImage
}


final class NetworkManagerImpl: NetworkManager {
    static let shared = NetworkManagerImpl()
    private let session: URLSession
    private var imageCache = NSCache<NSString, UIImage>()
    
    private init() {
        let config = URLSessionConfiguration.default
        self.session = URLSession(configuration: config)
    }
    
    // Generic Data Fetching Method
    func getData<T: Decodable>(url: String) async throws -> T {
        guard let serverUrl = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        // Fetch data from the URL
        let (data, _) = try await session.data(from: serverUrl)
        
        // Decode the data into the specified type
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            throw NetworkError.invalidImageData
        }
    }
    
    // Image Fetching Method
    func getImage(url: String) async throws -> UIImage {
        // Check if the image is already cached
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            return cachedImage
        }
        
        // Fetch the image from the network
        guard let serverUrl = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await session.data(from: serverUrl)
        
        guard let image = UIImage(data: data) else {
            throw NetworkError.invalidImageData
        }
        
        // Cache the image
        imageCache.setObject(image, forKey: url as NSString)
        
        return image
    }
}
