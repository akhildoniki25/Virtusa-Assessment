

def calculate_fare(km, vehicle_type, hour):
    rates = {
        'Economy': 10,
        'Premium': 18,
        'SUV': 25
    }
    if vehicle_type not in rates:
        return None

    base_fare = km * rates[vehicle_type]
    if 17 <= hour <= 20:
        base_fare =base_fare * 1.5
    return base_fare


def main():
    print( "CityCab Ride Estimate ")

    try:
        km = float(input("Enter distance (in km): "))
        vehicle_type = input("Enter vehicle type (Economy/Premium/SUV): ")
        hour = int(input("Enter hour of day (0-23): "))

        fare = calculate_fare(km, vehicle_type, hour)

        if fare is None:
            print("Service Not Available for selected vehicle type.")
        else:
            print("\n PRICE RECEIPT")
            print(f"Distance: {km} km")
            print(f"Vehicle Type: {vehicle_type}")
            print(f"Time: {hour}:00 hrs")

            if 17 <= hour <= 20:
                print("Surge Pricing Applied: 1.5x")
            else:
                print("Surge Pricing Applied: No")

            print(f"Total Fare: Rs.{fare:.2f}")
            print("=")

    except ValueError:
        print("Invalid input(). Please enter correct values.")


if __name__ == "__main__":
    main()
