DROP DATABASE IF EXISTS assigment_04;
CREATE DATABASE IF NOT EXISTS assigment_04;
USE assigment_04;

-- Tắt kiểm tra khóa ngoại để DROP theo bất kỳ thứ tự nào
SET FOREIGN_KEY_CHECKS = 0;

-- Table 1: department
DROP TABLE IF EXISTS department;
CREATE TABLE department (
    department_id   TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    department_name NVARCHAR(50) NOT NULL UNIQUE
);

-- Table 2: position
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position` (
    position_id     TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    position_name   ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL UNIQUE
);

-- Table 3: account
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
    account_id      INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    email           VARCHAR(100) NOT NULL UNIQUE,
    username        VARCHAR(50)  NOT NULL UNIQUE,
    full_name       NVARCHAR(100) NOT NULL,
    department_id   TINYINT UNSIGNED NOT NULL,
    position_id     TINYINT UNSIGNED NOT NULL,
    create_date     DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (department_id) REFERENCES department(department_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (position_id)   REFERENCES `position`(position_id)   ON UPDATE CASCADE ON DELETE CASCADE
);

-- Table 4: group
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
    group_id        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    group_name      NVARCHAR(50) NOT NULL UNIQUE,
    creator_id      INT UNSIGNED,
    create_date     DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (creator_id) REFERENCES `account`(account_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Table 5: group_account
DROP TABLE IF EXISTS group_account;
CREATE TABLE group_account (
    group_id        INT UNSIGNED NOT NULL,
    account_id      INT UNSIGNED NOT NULL,
    join_date       DATE DEFAULT (CURRENT_DATE),
    PRIMARY KEY (group_id, account_id),
    FOREIGN KEY (group_id)   REFERENCES `group`(group_id)     ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (account_id) REFERENCES `account`(account_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Table 6: type_question
DROP TABLE IF EXISTS type_question;
CREATE TABLE type_question (
    type_id         TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    type_name       ENUM('Essay', 'Multiple-Choice') NOT NULL UNIQUE
);

-- Table 7: category_question
DROP TABLE IF EXISTS category_question;
CREATE TABLE category_question (
    category_id     TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    category_name   NVARCHAR(50) NOT NULL UNIQUE
);

-- Table 8: question
DROP TABLE IF EXISTS question;
CREATE TABLE question (
    question_id     INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    content         NVARCHAR(500) NOT NULL,
    category_id     TINYINT UNSIGNED NOT NULL,
    type_id         TINYINT UNSIGNED NOT NULL,
    creator_id      INT UNSIGNED,
    create_date     DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (category_id) REFERENCES category_question(category_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (type_id)     REFERENCES type_question(type_id)         ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (creator_id)  REFERENCES `account`(account_id)         ON UPDATE CASCADE ON DELETE CASCADE
);

-- Table 9: answer
DROP TABLE IF EXISTS answer;
CREATE TABLE answer (
    answer_id       INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    content         NVARCHAR(500) NOT NULL,
    question_id     INT UNSIGNED NOT NULL,
    is_correct      BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (question_id) REFERENCES question(question_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Table 10: exam
DROP TABLE IF EXISTS exam;
CREATE TABLE exam (
    exam_id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `code`          VARCHAR(20) NOT NULL UNIQUE,
    title           NVARCHAR(100) NOT NULL,
    category_id     TINYINT UNSIGNED NOT NULL,
    duration        TINYINT UNSIGNED NOT NULL,   -- phút
    creator_id      INT UNSIGNED,
    create_date     DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (category_id) REFERENCES category_question(category_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (creator_id)  REFERENCES `account`(account_id)         ON UPDATE CASCADE ON DELETE CASCADE
);

-- Table 11: exam_question
DROP TABLE IF EXISTS exam_question;
CREATE TABLE exam_question (
    exam_id         INT UNSIGNED NOT NULL,
    question_id     INT UNSIGNED NOT NULL,
    PRIMARY KEY (exam_id, question_id),
    FOREIGN KEY (exam_id)     REFERENCES exam(exam_id)         ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES question(question_id) ON UPDATE CASCADE ON DELETE CASCADE
);

SET FOREIGN_KEY_CHECKS = 1;

-- ===================== INSERT DATA =====================

INSERT INTO department (department_name)
VALUES                 ('Sale'),
                       ('Marketing'),
                       ('IT'),
                       ('HR'),
                       ('Finance'),
                       ('Accounting'),
                       ('Legal'),
                       ('Admin'),
                       ('R&D'),
                       ('Customer Service');

INSERT INTO `position` (position_name)
VALUES                 ('Dev'),
                       ('Test'),
                       ('Scrum Master'),
                       ('PM');

INSERT INTO `account` (email                 , username   , full_name           , department_id , position_id , create_date)
VALUES                ('an.nguyen@gmail.com' , 'annguyen' , N'Nguyễn Văn An'    , 3             , 1           , '2024-01-05'),
                      ('binh.tran@gmail.com' , 'binhtran' , N'Trần Thị Bình'    , 3             , 2           , '2024-01-10'),
                      ('cuong.le@gmail.com'  , 'cuongle'  , N'Lê Văn Cường'     , 3             , 3           , '2024-02-01'),
                      ('dung.pham@gmail.com' , 'dungpham' , N'Phạm Thị Dung'    , 1             , 4           , '2024-02-15'),
                      ('em.hoang@gmail.com'  , 'emhoang'  , N'Hoàng Văn Em'     , 2             , 1           , '2024-03-01'),
                      ('giang.vu@gmail.com'  , 'giangvu'  , N'Vũ Thị Giang'     , 9             , 2           , '2024-03-12'),
                      ('hai.dang@gmail.com'  , 'haidang'  , N'Đặng Văn Hải'     , 3             , 1           , '2024-04-02'),
                      ('khanh.bui@gmail.com' , 'khanhbui' , N'Bùi Thị Khánh'    , 3             , 3           , '2024-04-20'),
                      ('long.do@gmail.com'   , 'longdo'   , N'Đỗ Văn Long'      , 9             , 2           , '2024-05-05'),
                      ('mai.ngo@gmail.com'   , 'maingo'   , N'Ngô Thị Mai'      , 4             , 4           , '2024-05-18');

INSERT INTO `group` (group_name     , creator_id , create_date)
VALUES              ('Java Fresher' , 1          , '2024-06-01'),
                    ('Testing Team' , 2          , '2024-06-05'),
                    ('Scrum Team A' , 3          , '2024-06-10'),
                    ('PM Club'      , 4          , '2024-06-15'),
                    ('BA Group'     , 5          , '2024-06-20'),
                    ('Design Team'  , 6          , '2024-07-01'),
                    ('DevOps Team'  , 7          , '2024-07-05'),
                    ('Tech Leads'   , 8          , '2024-07-10'),
                    ('Data Team'    , 9          , '2024-07-15'),
                    ('QA Group'     , 10         , '2024-07-20');

INSERT INTO group_account (group_id , account_id , join_date)
VALUES                   (1        , 1          , '2024-06-02'),
                         (1        , 2          , '2024-06-03'),
                         (1        , 3          , '2024-06-04'),
                         (2        , 4          , '2024-06-06'),
                         (2        , 5          , '2024-06-07'),
                         (3        , 6          , '2024-06-11'),
                         (4        , 7          , '2024-06-16'),
                         (5        , 8          , '2024-06-21'),
                         (6        , 9          , '2024-07-02'),
                         (7        , 10         , '2024-07-06');

INSERT INTO type_question (type_name)
VALUES                   ('Essay'),
                         ('Multiple-Choice');

INSERT INTO category_question (category_name)
VALUES                       ('Java'),
                             ('.NET'),
                             ('SQL'),
                             ('Postman'),
                             ('Ruby'),
                             ('Python'),
                             ('C++'),
                             ('JavaScript'),
                             ('PHP'),
                             ('Git');

INSERT INTO question (content                                           , category_id , type_id , creator_id , create_date)
VALUES               (N'Java là ngôn ngữ gì?'                           , 1           , 1       , 1          , '2024-08-01'),
                     (N'.NET Core chạy được trên Linux không?'          , 2           , 2       , 2          , '2024-08-02'),
                     (N'Câu lệnh nào dùng để lấy dữ liệu trong SQL?'    , 3           , 2       , 3          , '2024-08-03'),
                     (N'Postman dùng để làm gì?'                        , 4           , 1       , 4          , '2024-08-04'),
                     (N'Ruby on Rails là gì?'                           , 5           , 1       , 5          , '2024-08-05'),
                     (N'Python có phải ngôn ngữ thông dịch không?'      , 6           , 2       , 6          , '2024-08-06'),
                     (N'Con trỏ trong C++ là gì?'                       , 7           , 1       , 7          , '2024-08-07'),
                     (N'Từ khóa nào khai báo hằng trong JavaScript?'    , 8           , 2       , 8          , '2024-08-08'),
                     (N'PHP viết tắt của từ gì?'                        , 9           , 1       , 9          , '2024-08-09'),
                     (N'Lệnh nào dùng để tạo nhánh mới trong Git?'      , 10          , 2       , 10         , '2024-08-10');

INSERT INTO answer (content                                , question_id , is_correct)
VALUES             (N'Ngôn ngữ lập trình hướng đối tượng'  , 1           , TRUE),
                   (N'Có'                                  , 2           , TRUE),
                   (N'SELECT'                              , 3           , TRUE),
                   (N'DELETE'                              , 3           , FALSE),
                   (N'Kiểm thử API'                        , 4           , TRUE),
                   (N'Framework web viết bằng Ruby'        , 5           , TRUE),
                   (N'Đúng'                                , 6           , TRUE),
                   (N'const'                               , 8           , TRUE),
                   (N'PHP: Hypertext Preprocessor'         , 9           , TRUE),
                   (N'git branch'                          , 10          , TRUE);

INSERT INTO exam (`code`   , title                      , category_id , duration , creator_id , create_date)
VALUES           ('EX001'  , N'Đề thi Java cơ bản'      , 1           , 60       , 1          , '2024-09-01'),
                 ('EX002'  , N'Đề thi .NET'             , 2           , 90       , 2          , '2024-09-02'),
                 ('EX003'  , N'Đề thi SQL'              , 3           , 60       , 3          , '2024-09-03'),
                 ('EX004'  , N'Đề thi Postman'          , 4           , 45       , 4          , '2024-09-04'),
                 ('EX005'  , N'Đề thi Ruby'             , 5           , 60       , 5          , '2024-09-05'),
                 ('EX006'  , N'Đề thi Python'           , 6           , 120      , 6          , '2024-09-06'),
                 ('EX007'  , N'Đề thi C++'              , 7           , 90       , 7          , '2024-09-07'),
                 ('EX008'  , N'Đề thi JavaScript'       , 8           , 60       , 8          , '2024-09-08'),
                 ('EX009'  , N'Đề thi PHP'              , 9           , 45       , 9          , '2024-09-09'),
                 ('EX010'  , N'Đề thi Git'              , 10          , 30       , 10         , '2024-09-10');

INSERT INTO exam_question (exam_id , question_id)
VALUES                   (1       , 1),
                         (2       , 2),
                         (3       , 3),
                         (4       , 4),
                         (5       , 5),
                         (6       , 6),
                         (7       , 7),
                         (8       , 8),
                         (9       , 9),
                         (10      , 10);

-- 1.Join.
USE assigment_04;
-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT *
FROM account
INNER JOIN department USING(department_id)
INNER JOIN position USING(position_id);

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/01/2024
SELECT *
FROM account
INNER JOIN department USING(department_id)
INNER JOIN position USING(position_id)
WHERE create_date > "2024-01-20";

-- Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT *
FROM account
INNER JOIN department USING(department_id)
INNER JOIN position USING(position_id)
WHERE position_name = "DEV";

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT department.*, COUNT(department_id)
FROM account
RIGHT JOIN department USING(department_id)
GROUP BY department_id
HAVING COUNT(department_id) > 3;

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT question.*, COUNT(exam_id) 
FROM question
LEFT JOIN exam_question USING(question_id)
GROUP BY question_id
ORDER BY COUNT(exam_id) DESC
LIMIT 1;
-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT category_question.*, COUNT(question_id) 
FROM question
RIGHT JOIN category_question USING(category_id)
GROUP BY category_id;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT question_id, content, COUNT(exam_id)
FROM question
LEFT JOIN exam_question USING(question_id)
GROUP BY question_id;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
SELECT question_id, question.content, COUNT(answer_id) as "số lượng"
FROM question
LEFT JOIN answer USING(question_id)
GROUP BY question_id
ORDER BY COUNT(answer_id) DESC
LIMIT 1;

-- Question 9: Thống kê số lượng account trong mỗi group
SELECT group_id, group_name, COUNT(account_id)
FROM `group`
LEFT JOIN group_account USING(group_id)
GROUP BY group_id, group_name 
ORDER BY COUNT(account_id) ASC;

-- Question 10: Tìm chức vụ có ít người nhất
SELECT position_id, position_name, COUNT(account_id)
FROM account
RIGHT JOIN position USING(position_id)
GROUP BY position_id
ORDER BY COUNT(account_id) ASC
LIMIT 1;

-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT department_name, position_name, COUNT(account_id)
FROM department
CROSS JOIN position
LEFT JOIN account USING(department_id, position_id)
GROUP BY department_id, position_id;

-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
-- question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …
SELECT  question_id, 
		question.content as "câu hỏi", 
		type_name as "loại câu hỏi", 
        full_name as "người tạo", 
        answer.content as "câu trả lời"
FROM question
LEFT JOIN type_question USING(type_id)
LEFT JOIN account ON question.creator_id = account.account_id
LEFT JOIN answer USING(question_id);

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT type_id, type_name, COUNT(question_id)
FROM question
RIGHT JOIN type_question USING(type_id)
GROUP BY type_id;

-- Question 14:Lấy ra group không có account nào
SELECT `group`.*
FROM `group`
LEFT JOIN group_account USING(group_id)
WHERE account_id IS NULL;

-- Question 15: Lấy ra group không có account nào
-- Question 16: Lấy ra question không có answer nào.
SELECT question.*
FROM question
LEFT JOIN answer USING(question_id)
WHERE answer_id IS NULL;

-- 2. Union.
-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
SELECT *
FROM account
LEFT JOIN group_account USING(account_id)
WHERE group_id = 1;
-- b) Lấy các account thuộc nhóm thứ 2
SELECT *
FROM account
LEFT JOIN group_account USING(account_id)
WHERE group_id = 2;
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT *
FROM account
LEFT JOIN group_account USING(account_id)
WHERE group_id = 1
UNION
SELECT *
FROM account
LEFT JOIN group_account USING(account_id)
WHERE group_id = 2;
-- Question 18:
-- a) Lấy các group có lớn hơn 2 thành viên
SELECT group_id, group_name, COUNT(account_id)
FROM group_account
LEFT JOIN `group` USING(group_id)
GROUP BY group_id
HAVING COUNT(group_id) > 2;

-- b) Lấy các group có nhỏ hơn 7 thành viên
SELECT group_id, group_name, COUNT(account_id)
FROM group_account
LEFT JOIN `group` USING(group_id)
GROUP BY group_id
HAVING COUNT(group_id) < 7;
-- c) Ghép 2 kết quả từ câu a) và câu b).
SELECT group_id, group_name, COUNT(account_id)
FROM group_account
LEFT JOIN `group` USING(group_id)
GROUP BY group_id
HAVING COUNT(group_id) > 2
UNION
SELECT group_id, group_name, COUNT(account_id)
FROM group_account
LEFT JOIN `group` USING(group_id)
GROUP BY group_id
HAVING COUNT(group_id) < 7;








