DROP DATABASE IF EXISTS assigment_05;
CREATE DATABASE IF NOT EXISTS assigment_05;
USE assigment_05;

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
use assigment_05;
INSERT INTO answer (content                                , question_id , is_correct)
VALUES             (N'Ngôn ngữ lập trình hướng đối tượng'  , 11           , TRUE),
                   (N'Có'                                  , 12           , TRUE),
                   (N'SELECT'                              , 13           , TRUE),
                   (N'DELETE'                              , 13           , FALSE),
                   (N'Kiểm thử API'                        , 14           , TRUE),
                   (N'Framework web viết bằng Ruby'        , 15           , TRUE),
                   (N'Đúng'                                , 16           , TRUE),
                   (N'const'                               , 18           , TRUE),
                   (N'PHP: Hypertext Preprocessor'         , 19           , TRUE),
                   (N'git branch'                          , 11          , TRUE);

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

-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
CREATE OR REPLACE VIEW view_01 AS
SELECT *
FROM account
WHERE position_id =
	(SELECT position_id
    FROM position
    WHERE position_name = 'sale');
    
-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
CREATE OR REPLACE VIEW view_02 AS
SELECT account.*, COUNT(group_id) AS group_count
FROM account
LEFT JOIN group_account USING (account_id)
GROUP BY account_id
HAVING COUNT(group_id) = 
	(SELECT MAX(group_count)
	FROM 
		(SELECT COUNT(group_id) AS group_count
		FROM account
		LEFT JOIN group_account USING(account_id)
		GROUP BY account_id) as T);

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ
-- được coi là quá dài) và xóa nó đi
CREATE OR REPLACE VIEW view_03 AS
SELECT *
FROM question
WHERE CHAR_LENGTH(content) - CHAR_LENGTH(REPLACE(content, ' ', '')) + 1 > 300;
DELETE FROM view_03;


-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
CREATE OR REPLACE VIEW view_04 AS
SELECT department.*, COUNT(account_id)
FROM department
LEFT JOIN account USING(department_id)
GROUP BY department_id
HAVING COUNT(department_id) = 
	(SELECT MAX(account_count)
	FROM
		(SELECT COUNT(account_id) AS account_count
		FROM department
		LEFT JOIN account USING(department_id)
		GROUP BY department_id) AS T);

-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo.
CREATE OR REPLACE VIEW view_05 AS
SELECT question.*
FROM question
WHERE creator_id = ANY (
	SELECT account_id
    FROM account
    WHERE full_name LIKE "Nguyễn%");