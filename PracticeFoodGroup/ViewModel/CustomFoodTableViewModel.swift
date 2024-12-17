import Foundation
import UIKit





class CustomFoodTableViewModel {
    private var fetchedData: [FoodGroup] = []
    private var networkManager: NetworkManager
    
    private var isLoading: ((Bool) -> ())?
    var fetchedFood:(([FoodGroup]) -> ())?
    
    let foodURL = "https://raw.githubusercontent.com/shobhakartiwari/shobhakar_api_collections/39b4ed9c85833857e7d21c23352bb4857a818919/FoodData.json"
    
    init(networkManager: NetworkManager = NetworkManagerImpl.shared) {
        self.networkManager = networkManager
    }
    
    func fetchData(){
        isLoading?(true)
        
        Task{
            do{
                let storeData: FoodData = try await
                networkManager.getData(url: foodURL)
                DispatchQueue.main.async{
                    self.fetchedData = storeData.food_groups
                    self.isLoading?(false)
                    self.fetchedFood?(self.fetchedData)
                }
            }
        }
    }
        
        func groupCount() -> Int {
            return fetchedData.count
        }
        
        func foodGroupAt( at index: Int) -> FoodGroup? {
            guard index < fetchedData.count else{return nil}
            return fetchedData[index]
        }
    
    
    func fetImage(url: String) async -> UIImage? {
        do{
            return try await networkManager.getImage(url: url)
        }catch{
            return nil
        }
    }
    
}
