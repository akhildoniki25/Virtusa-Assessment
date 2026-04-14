import java.util.Scanner;
public class PasswordValidator {
    public static boolean isValidPassword(String password) {
        boolean hasUpperCase = false;
        boolean hasDigit = false;
        if (password.length() < 8) {
            System.out.println("Too short (Minimum 8 characters required)");
            return false;
        }
        for (int i = 0; i < password.length(); i++) {
            char ch = password.charAt(i);
            if (Character.isUpperCase(ch)) {
                hasUpperCase = true;
            }

            if (Character.isDigit(ch)) {
                hasDigit = true;
            }
        }
        if (!hasUpperCase) {
            System.out.println("Missing  uppercase letter");
        }

        if (!hasDigit) {
            System.out.println("Missing A digit");
        }
        return hasUpperCase && hasDigit;
    }

    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);
        String password;
        while (true) {
            System.out.print("Enter your password");
            password = scanner.nextLine();

            if (isValidPassword(password)) {
                System.out.println("Password is valid");
                break;
            } else {
                System.out.println("Please try again");
            }
        }

        scanner.close();
    }
}
