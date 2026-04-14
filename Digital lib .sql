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
