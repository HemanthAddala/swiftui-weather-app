import Foundation

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = WeatherService()

    func getWeather(city: String) async {
        isLoading = true
        errorMessage = nil

        do {
            weather = try await service.fetchWeather(for: city)
        } catch {
            errorMessage = "Failed to fetch weather. Please try again."
        }

        isLoading = false
    }
}
