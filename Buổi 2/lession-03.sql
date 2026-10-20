-- Mệnh đề SELECT
SELECT PI(), 1+1, CURRENT_DATE, NOW(), current_timestamp();

-- Mệnh đề FROM
-- *: Đại diện tất cả các cộtable
-- VD: Lấy ra tất cả phòng ban
SELECT *
FROM department;

SELECT department_id, department_name
FROM department;

-- Mệnh đề WHERE 
-- Điều kiện cho từng bản ghi
-- Toán tử: >, >=, <, <=, =, !=
-- VD: Lấy ra phòng ban có id = 5
SELECT *
FROM department
WHERE department_id = 5;

-- Toán tử: AND, OR
-- VD: Lấy phòng ban có 3 <= id <= 7
SELECT *
FROM department
WHERE department_id >=3 AND department_id <= 7;

-- Toán tử: BETWEEN ... AND...
-- VD: Lấy phòng ban có 3 <= id <= 7
SELECT *
FROM department
WHERE department_id BETWEEN 3 AND 7; 

-- Toán tử: IN, NOT IN
-- VD: Lấy ra phòng ban có id là số chẵn tử 2 đến 8
SELECT *
FROM department
WHERE department_id IN (2,4,6,8); -- Lấy ra các phần tử có department_id trong 2,4,6,8

-- Toán tử: LIKE
-- Tìm kiếm dựa theo khuôn mẫu
-- _: Đại diện cho một ký tự
-- %: Đại diện cho 0 hoặc nhiều ký tự
-- Lấy ra phòng ban có tên chứa ký tự 'n'
SELECT *
FROM department
WHERE department_name like '%n%';

-- Toán tử IS NULL/ IS NOT NULL
-- VD: Lấy ra phòng ban có tên
SELECT *
FROM department
WHERE department_name IS NOT NULL;

-- Mệnh đề: ORDER BY 
-- Vị trí sau WHERE
-- Hướng: ASC, DESC
-- Mặc định: ASC
-- VD: Lấy ra tất cả để thi sắp xếp theo thời gian thi giảm dần, ngày tạo giảm dần. Ưu tiên tiêu chí ghi trước
SELECT *
FROM exam
-- WHERE 
ORDER BY duration DESC, create_date DESC;

-- Mệnh đề LIMIT
-- Vị trí sau ORDER BY
-- VD: Lấy ra 5 phòng ban
SELECT *
FROM department
LIMIT 5;

-- Các hàm tổng hợp: COUNT(), SUM(), MIN(), MAX(), AVG()
-- Các hàm này chỉ tính toán trên các giá trị khác null
-- COUNT(*): Đếm số dòng
-- COUNT(id): Đếm số dòng có id khác NULL

-- VD: đếm số lượng phòng ban
SELECT COUNT(*), SUM(duration), 
	   MIN(duration), MAX(duration), 
       AVG(duration)
FROM exam;

-- Mệnh đề GROUP BY
-- Dùng để gom nhóm, nhóm dựa theo tên cột
-- vị trí sau WHERE trước ORDER BY
SELECT duration, COUNT(exam_id)
FROM exam
GROUP BY duration;

-- Mệnh đề HAVING
-- Điều kiện cho từng nhóm
SELECT duration, COUNT(exam_id)
FROM exam
GROUP BY duration
HAVING COUNT(exam_id) > 3;

-- ALIAS: Đặt bí danh tạm thời, chỉ có hiệu lực trong câu lệnh
SELECT COUNT(*) AS department_count
FROM department;
















