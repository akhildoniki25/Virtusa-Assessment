

def calculate_fare(km, vehicle_type, hour):
    rates = {
        'Economy': 10,
        'Premium': 18,
        'SUV': 25
    }
    if vehicle_type not in rates:
        return None

    basefare = km * rates[vehicle_type]
    if 17 <= hour <= 20:
        basefare =basefare * 1.5
    return basefare


def main():
    print( "CityCab Ride estimate ")

    try:
        km = float(input("enter the  distance (km): "))
        vehicle_type = input("enter vehicle type(in caps) (Economy/Premium/SUV): ")
        hour = int(input("enter hour of day (0-23): "))

        fare = calculate_fare(km, vehicle_type, hour)

        if fare is None:
            print("Service is  Not available for selected vehicle type.")
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
