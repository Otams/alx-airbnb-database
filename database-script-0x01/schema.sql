CREATE TABLE User
(
  user_id UUID NOT NULL PRIMARY KEY,
  first_name VARCHAR NOT NULL,
  last_name VARCHAR NOT NULL,
  email VARCHAR NOT NULL UNIQUE,
  password_hash VARCHAR NOT NULL,
  phone_number VARCHAR,
  role ENUM('guest', 'host', 'admin') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (email)
);

CREATE TABLE Property
(
  property_id UUID NOT NULL PRIMARY KEY,
  host_id UUID NOT NULL,
  name VARCHAR NOT NULL,
  description TEXT NOT NULL,
  location VARCHAR NOT NULL,
  pricepernight DECIMAL NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (host_id) REFERENCES User(user_id)
);

CREATE TABLE Booking
(
  booking_id UUID NOT NULL PRIMARY KEY,
  property_id UUID NOT NULL,
  user_id UUID NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  total_price DECIMAL NOT NULL,
  status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES Property(property_id),
  FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE Payment
(
  payment_id UUID NOT NULL PRIMARY KEY,
  booking_id UUID NOT NULL,
  amount DECIMAL NOT NULL,
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
  FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

CREATE TABLE Review
(
  review_id UUID NOT NULL PRIMARY KEY,
  property_id UUID NOT NULL,
  user_id UUID NOT NULL,
  rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
  comment TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES Property(property_id),
  FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE Message
(
  message_id UUID NOT NULL PRIMARY KEY,
  sender_id UUID NOT NULL,
  recipient_id UUID NOT NULL,
  message_body TEXT NOT NULL,
  sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (sender_id) REFERENCES User(user_id),
  FOREIGN KEY (recipient_id) REFERENCES User(user_id)
);
