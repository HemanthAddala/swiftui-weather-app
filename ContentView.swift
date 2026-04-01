import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var city = "Hyderabad"

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Enter city", text: $city)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)

                Button("Get Weather") {
                    Task {
                        await viewModel.getWeather(city: city)
                    }
                }
                .buttonStyle(.borderedProminent)

                if viewModel.isLoading {
                    ProgressView("Loading...")
                }

                if let weather = viewModel.weather {
                    VStack(spacing: 12) {
                        Text(weather.location.name)
                            .font(.largeTitle)
                            .bold()

                        Text("\(weather.current.temp_c, specifier: "%.1f")°C")
                            .font(.system(size: 48))
                            .bold()

                        Text(weather.current.condition.text)
                            .font(.title3)

                        Text("Humidity: \(weather.current.humidity)%")
                        Text("Wind: \(weather.current.wind_kph, specifier: "%.1f") kph")
                    }
                    .padding()
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Weather App")
        }
    }
}
