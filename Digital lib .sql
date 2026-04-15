--- it is students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    JoinDate DATE,
    Status VARCHAR(20) DEFAULT 'Active'
);
-- it is books table 
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    Author VARCHAR(100),
    Category VARCHAR(50)
);
-- it is issued books table
CREATE TABLE IssuedBooks (
    IssueID INT PRIMARY KEY,
    StudentID INT,
    BookID INT,
    IssueDate DATE NOT NULL,
    ReturnDate DATE,

    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);
INSERT INTO Students (StudentID, Name, Email, JoinDate, Status) VALUES
(1, 'Ravi Kumar', 'ravi@example.com', '2021-06-15', 'Active'),
(2, 'Sneha Reddy', 'sneha@example.com', '2020-08-10', 'Active'),
(3, 'Arjun Rao', 'arjun@example.com', '2019-01-20', 'Active'),
(4, 'Priya Sharma', 'priya@example.com', '2018-03-05', 'Active'),
(5, 'Kiran Patel', 'kiran@example.com', '2017-11-25', 'Active');

INSERT INTO Books (BookID, Title, Author, Category) VALUES
(101, 'The Alchemist', 'Paulo Coelho', 'Fiction'),
(102, 'Clean Code', 'Robert C. Martin', 'Programming'),
(103, 'Data Structures', 'Seymour Lipschutz', 'Education'),
(104, 'Rich Dad Poor Dad', 'Robert Kiyosaki', 'Finance'),
(105, 'Harry Potter', 'J.K. Rowling', 'Fantasy');

INSERT INTO IssuedBooks (IssueID, StudentID, BookID, IssueDate, ReturnDate) VALUES
(1, 1, 101, '2026-03-01', NULL),
(2, 2, 102, '2026-03-20', '2026-04-01'),
(3, 3, 103, '2025-12-01', NULL),
(4, 4, 104, '2022-01-15', '2022-02-01'),
(5, 1, 105, '2026-04-01', NULL);
-- students who didn't returned books for more than 14 days
SELECT 
    s.StudentID,
    s.Name,
    b.Title,
    ib.IssueDate
FROM IssuedBooks ib
JOIN Students s ON ib.StudentID = s.StudentID
JOIN Books b ON ib.BookID = b.BookID
WHERE 
    ib.ReturnDate IS NULL
    AND ib.IssueDate < DATE('now', '-14 days');
-- based on categorys
SELECT 
    b.Category,
    COUNT(*) AS TotalBorrows
FROM IssuedBooks ib
JOIN Books b 
    ON ib.BookID = b.BookID
GROUP BY b.Category
ORDER BY TotalBorrows DESC;
-- no active since 3 years

UPDATE Students
SET Status = 'Inactive'
WHERE StudentID NOT IN (
    SELECT DISTINCT StudentID
    FROM IssuedBooks
    WHERE DATE('now', '-3 years')
);
