create database EventBookingSystem;

use EventBookingSystem;

CREATE TABLE City (
    CityID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(64) NOT NULL,
    State VARCHAR(64),
    PinCode VARCHAR(16)
);

CREATE TABLE Cinema (
    CinemaID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(64) NOT NULL,
    TotalCinemaHalls INT,
    CityID INT,
    FOREIGN KEY (CityID) REFERENCES City(CityID)
);

CREATE TABLE Cinema_Hall (
    CinemaHallID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(64) NOT NULL,
    TotalSeats INT,
    CinemaID INT,
    FOREIGN KEY (CinemaID) REFERENCES Cinema(CinemaID)
);

CREATE TABLE Cinema_Seat (
    CinemaSeatID INT AUTO_INCREMENT PRIMARY KEY,
    SeatNumber INT NOT NULL,
    Type ENUM('Regular', 'Premium', 'VIP'),
    CinemaHallID INT,
    FOREIGN KEY (CinemaHallID) REFERENCES Cinema_Hall(CinemaHallID)
);

CREATE TABLE Movie (
    MovieID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(256) NOT NULL,
    Description VARCHAR(512),
    Duration TIME,
    Language VARCHAR(16),
    ReleaseDate DATETIME,
    Country VARCHAR(64),
    Genre VARCHAR(20)
);

CREATE TABLE eventShow (
    ShowID INT AUTO_INCREMENT PRIMARY KEY,
    Date DATETIME NOT NULL,
    StartTime DATETIME,
    EndTime DATETIME,
    CinemaHallID INT,
    MovieID INT,
    FOREIGN KEY (CinemaHallID) REFERENCES Cinema_Hall(CinemaHallID),
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);

CREATE TABLE User (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(64) NOT NULL,
    Password VARCHAR(20),
    Email VARCHAR(64),
    Phone VARCHAR(16)
);

CREATE TABLE Booking (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    NumberOfSeats INT,
    Timestamp DATETIME,
    Status ENUM('Confirmed', 'Cancelled', 'Pending'),
    UserID INT,
    ShowID INT,
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (ShowID) REFERENCES eventShow(ShowID)
);

CREATE TABLE Show_Seat (
    ShowSeatID INT AUTO_INCREMENT PRIMARY KEY,
    Status ENUM('Available', 'Booked'),
    Price DECIMAL(10,2),
    CinemaSeatID INT,
    ShowID INT,
    BookingID INT,
    FOREIGN KEY (CinemaSeatID) REFERENCES Cinema_Seat(CinemaSeatID),
    FOREIGN KEY (ShowID) REFERENCES eventShow(ShowID),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    Amount DECIMAL(10,2),
    Timestamp DATETIME,
    DiscountCouponID INT,
    RemoteTransactionID INT,
    PaymentMethod ENUM('Card', 'UPI', 'Wallet'),
    BookingID INT,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

CREATE TABLE Tag (
    TagID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(64) NOT NULL
);

CREATE TABLE Movie_Tag (
    MovieID INT,
    TagID INT,
    PRIMARY KEY (MovieID, TagID),
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID),
    FOREIGN KEY (TagID) REFERENCES Tag(TagID)
);

CREATE TABLE Refund (
    RefundID INT AUTO_INCREMENT PRIMARY KEY,
    BookingID INT,
    Amount DECIMAL(10,2),
    Reason VARCHAR(256),
    Timestamp DATETIME,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

CREATE TABLE Review (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    MovieID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    Timestamp DATETIME,
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);

