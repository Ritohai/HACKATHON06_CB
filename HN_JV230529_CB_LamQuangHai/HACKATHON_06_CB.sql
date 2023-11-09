DROP DATABASE IF EXISTS QUANLYDIEMTHI;
CREATE DATABASE QUANLYDIEMTHI;
use QUANLYDIEMTHI;

CREATE TABLE STUDENT(
studentId varchar(4) primary key not null,
studentName varchar(100) not null,
birthday date not null,
gender bit default(1) not null,
address text not null,
phoneNumber varchar(45) unique
);

CREATE TABLE SUBJECT(
subjectId varchar(4) primary key not null,
subjectName varchar(45) not null,
priority int(11) not null
);

CREATE TABLE MARK(
studentId varchar(4) not null,
subjectId varchar(4) not null,
point int(11) not null
);

ALTER TABLE MARK add constraint pk_mark_student foreign key (studentId) references STUDENT(studentId);
ALTER TABLE MARK add constraint pk_mark_subject foreign key (subjectId) references SUBJECT(subjectId);

-- 1. Thêm dữ liệu vào các bảng
insert into student(studentId,studentName,birthday,gender,address,phoneNumber) values
("S001","Nguyễn Thế Anh","1999/1/11",1,"Hà Nội","984678082"),
("S002","Đặng Bảo Trâm","1998/12/22",0,"Lào Cai","904982654"),
("S003","Trần Hà Phương","2000/5/5",0,"Nghệ An","947645363"),
("S004","Đỗ Tiến Mạnh","1999/3/26",1,"Hà Nội","983665353"),
("S005","Phạm Duy Nhất","1998/10/4",1,"Tuyên Quang","987242678"),
("S006","Mai Văn Thái","2002/6/22",1,"Nam Định","982754268"),
("S007","Giang Gia Hân","1996/11/10",0,"Phú Thọ","982364753"),
("S008","Nguyễn Ngọc Bảo My","1999/1/22",0,"Hà Nam","927867453"),
("S009","Nguyễn Tiến Đạt","1998/8/7",1,"Tuyên Quang","989274673"),
("S010","Nguyễn Thiều Quang","2000/9/18",1,"Hà Nội","984378291");

INSERT INTO SUBJECT(subjectId,subjectName,priority) VALUE 
("MH01", "Toán",2),("MH02", "Vật Lý",2),("MH03", "Hóa Học",1),("MH04", "Ngữ Văn",1),("MH05", "Tiếng Anh",2); 

INSERT INTO MARK(studentId,subjectId,point) VALUE 
("S001","MH01", 8.5),("S001","MH02", 7),("S001","MH03", 9),("S001","MH04", 9),("S001","MH05", 5),
("S002","MH01", 9),("S002","MH02", 8),("S002","MH03", 6.5),("S002","MH04", 8),("S002","MH05", 6),
("S003","MH01", 7.5),("S003","MH02", 6.5),("S003","MH03", 8),("S003","MH04", 7),("S003","MH05", 7),
("S004","MH01", 6),("S004","MH02", 7),("S004","MH03", 5),("S004","MH04", 6.5),("S004","MH05", 8),
("S005","MH01", 5.5),("S005","MH02", 8),("S005","MH03", 7.5),("S005","MH04", 8.5),("S005","MH05", 9),
("S006","MH01", 8),("S006","MH02", 10),("S006","MH03", 9),("S006","MH04", 7.5),("S006","MH05", 6.5),
("S007","MH01", 9.5),("S007","MH02", 9),("S007","MH03", 6),("S007","MH04", 9),("S007","MH05", 4),
("S008","MH01", 10),("S008","MH02", 8.5),("S008","MH03", 8.5),("S008","MH04", 6),("S008","MH05", 9.5),
("S009","MH01", 7.5),("S009","MH02", 7),("S009","MH03", 9),("S009","MH04", 5),("S009","MH05", 10),
("S010","MH01", 6.5),("S010","MH02", 8),("S010","MH03", 5.5),("S010","MH04", 4),("S010","MH05", 7);

-- 2. Cập nhật dữ liệu:
ALTER TABLE MARK MODIFY COLUMN point FLOAT;
UPDATE  STUDENT SET studentName = "Đỗ Đức Mạnh" where studentId ="S004";
UPDATE  SUBJECT SET subjectName = "Ngoại Ngữ"  , priority=1 where subjectId ="MH05";
UPDATE MARK
SET point = CASE
    WHEN subjectId = 'MH01' THEN 8.5
    WHEN subjectId = 'MH02' THEN 7
    WHEN subjectId = 'MH03' THEN 5.5
    WHEN subjectId = 'MH04' THEN 6
    WHEN subjectId = 'MH05' THEN 9
    
    ELSE point 
END
WHERE studentId = 'S009' AND subjectId IN ('MH01', 'MH02', 'MH03', 'MH04', 'MH05');

-- 3. Xoá dữ liệu
DELETE FROM MARK
WHERE studentId = 'S010';
DELETE FROM STUDENT
WHERE studentId = 'S010';

-- Bài 3: Truy vấn dữ liệu
-- 1. Lấy ra tất cả thông tin của sinh viên trong bảng Student .
SELECT * FROM STUDENT;

-- 2. Hiển thị tên và mã môn học của những môn có hệ số bằng 1.
SELECT subjectId, subjectName FROM subject
WHERE priority = 1;

-- 3. Hiển thị thông tin học sinh bào gồm: mã học sinh, tên học sinh, tuổi (bằng năm hiện tại trừ
-- năm sinh) , giới tính (hiển thị nam hoặc nữ) và quê quán của tất cả học sinh.
SELECT studentId, studentName,  YEAR(now()) - YEAR(birthday) as Tuoi,
CASE WHEN gender = 1 THEN "Nam"
 WHEN gender = 0 THEN "Nữ"
 END as "Giới tính",
 address FROM student;
 
 -- 4. Hiển thị thông tin bao gồm: tên học sinh, tên môn học , điểm thi của tất cả học sinh của môn
-- Toán và sắp xếp theo điểm giảm dần.
SELECT st.studentName, sj.subjectName, point FROM MARK
JOIN STUDENT st ON st.studentId = mark.studentId
JOIN SUBJECT sj ON sj.subjectId = mark.subjectId
WHERE sj.subjectName = "Toán"
ORDER BY point desc;

-- 5. Thống kê số lượng học sinh theo giới tính ở trong bảng (Gồm 2 cột: giới tính và số lượng).
SELECT 
case 
	WHEN gender = 1 then "Nam"
	WHEN gender = 0 then "Nữ"
end as "Giới tính",
count(studentId) as "Số lượng"
FROM STUDENT
group by gender;

-- 6. Tính tổng điểm và điểm trung bình của các môn học theo từng học sinh (yêu cầu sử dụng hàm
-- để tính toán) , bảng gồm mã học sinh, tên hoc sinh, tổng điểm và điểm trung bình.
SELECT st.studentId as "Mã học sinh",st.studentName as "Tên học sinh",sum(m.point) as "Tổng điểm", avg(m.point) as "Điểm trung bình" 
FROM student as st 
JOIN mark as m on st.studentId = m.studentId
JOIN SUBJECT sj on sj.subjectId = m.subjectId
GROUP BY st.studentId, st.studentName;

-- Bài 4: Tạo View, Index, Procedure
-- 1. Tạo VIEW có tên STUDENT_VIEW lấy thông tin sinh viên bao gồm : mã học sinh, tên học
-- sinh, giới tính , quê quán .
CREATE VIEW STUDENT_VIEW as
SELECt studentId, studentName, gender, address 
FROM student;

-- 2. Tạo VIEW có tên AVERAGE_MARK_VIEW lấy thông tin gồm:mã học sinh, tên học sinh,
-- điểm trung bình các môn học .
CREATE VIEW AVERAGE_MARK_VIEW as
SELECT mark.studentId, studentName, avg(mark.point) as"Diểm trung bình"
FROM mark
JOIN student st ON st.studentId = mark.studentId
GROUP BY mark.studentId, studentName;

-- 3. Đánh Index cho trường `phoneNumber` của bảng STUDENT.
CREATE INDEX phoneNumbers ON STUDENT(phoneNumber);

-- 4. Tạo các PROCEDURE sau:
-- - Tạo PROC_INSERTSTUDENT dùng để thêm mới 1 học sinh bao gồm tất cả thông tin học sinh đó.
DELIMITER //
CREATE PROCEDURE PROC_INSERTSTUDENT(
IN studentIdP varchar(4) ,
IN studentNameP varchar(100) ,
IN birthdayP date ,
IN genderP bit ,
IN addressP text ,
IN phoneNumberP varchar(45) 
)
begin
	INSERT INTO STUDENT(studentId, studentName, birthday, gender,address,phoneNumber) VALUE
    (studentIdP, studentNameP, birthdayP, genderP, phoneNumberP);
end
// DELIMITER ;


-- - Tạo PROC_UPDATESUBJECT dùng để cập nhật tên môn học theo mã môn học.
DELIMITER //
CREATE PROCEDURE PROC_UPDATESUBJECT(subName varchar(45), subId varchar(4))
begin
	UPDATE  SUBJECT SET SUBJECTNAME = subName where subjectId = subId;
end 
// DELIMITER ;

-- - Tạo PROC_DELETEMARK dùng để xoá toàn bộ điểm các môn học theo mã học sinh và trả về số bản ghi đã xóa.
DELIMITER //
CREATE PROCEDURE PROC_DELETEMARK(
    IN studentIdP varchar(4),
    OUT deletedCount INT)
BEGIN
    DECLARE affectedRows INT;
    DELETE FROM MARK WHERE studentId = studentIdP;
    SELECT ROW_COUNT() INTO affectedRows;
    SET deletedCount = affectedRows;
END //
DELIMITER ;