-- Mệnh đề JOIN
-- Vị trí giữa FROM và WHERE

-- INNER JOIN
-- ON: điều kiện kết hợp
-- USING: dạng rút gọn của ON nếu tên cột trùng nhau và điều kiện là dấu "="
-- VD: lấy ra tất cả thông tin nhân viên
SELECT * 
FROM account
INNER JOIN department USING(department_id)
-- ON account.department_id = department.department_id
INNER JOIN position USING(position_id);

-- LEFT/RIGHT JOIN
-- VD: Thôngs kê số lượng nhân viên trong mỗi phòng ban
SELECT 	department.*, COUNT(account_id)
FROM account
RIGHT JOIN department USING (department_id)
GROUP BY department_id
ORDER BY COUNT(account_id) DESC;

-- LEFT/RIGHT EXCLUDING JOIN
-- VD: Lấy ra phòng ban không có nhân viên
SELECT 	department.*
FROM account
RIGHT JOIN department USING (department_id)
WHERE account_id IS NULL;

-- CROSS JOIN
-- VD: 
SELECT full_name, position_name 
FROM account
CROSS JOIN position;

-- UNION: Hợp kết quả
-- VD: Tìm kiếm account hoặc group chứa ký tự 'n'
SELECT "account" AS type, username AS result
FROM account
WHERE username LIKE "%n%"
UNION
SELECT "group" AS type, group_name AS result
FROM `group`
WHERE group_name LIKE "%n%";

-- UNION ALL: trùng nhau bao nhiêu thì cũng in ra hết
SELECT 1 AS n
UNION ALL
SELECT 1 AS n;






