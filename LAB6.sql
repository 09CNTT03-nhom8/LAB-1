create trigger trg_InsertNhanVien on NhanVien
for insert
as
	if(select luong from inserted) <15000
		begin
			print 'Luong phai lon hon 15000'
			rollback transaction
		end
select * from NHANVIEN 
insert into NHANVIEN
values('Tran', 'Thanh', 'Huy', '021', '2020-12-12', 'Da Nang', 'Nam', 14000, '004',1)

create trigger trg_InsertNhanVien2 on NhanVien
for insert
as
	declare @age int
	set @age = YEAR(getdate()) - (select year(NgSinh) from inserted)
	if (@age <18 or @age > 65)
		begin
			print 'Tuoi khong hop le'
			rollback transaction
		end
insert into NHANVIEN
values('Tran', 'Thanh', 'Huy', '021', '2020-12-12', 'Da Nang', 'Nam', 14000, '004',1)

create trigger trg_UpdateNhanVien on NhanVien
for update
as
	if(select dchi from inserted) like '%HCM%'
	begin
		print 'Dia Chi khong hop le'
		rollback transaction
	end
select * from NHANVIEN
update NHANVIEN set TENNV = 'NamNV' where NamNV = '001'

-----------------------------------------------------------

create trigger trg_InsertNhanVien2a on NHANVIEN
for insert
as
begin
	select COUNT(case when UPPER(Phai)= 'Nam' then 1 end) Nam, COUNT(case when UPPER(Phai)= 'Nu' then 1 end) Nu
	from NHANVIEN
end
insert into NHANVIEN
values('Tran', 'Thanh', 'Huy', '024', '1980-12-12', 'Da Nang', 'Nu', 16000, '004',1)
select * from NHANVIEN

create trigger trg_updateNhanVien2b on NhanVien
after update
as
begin
	if update(phai)
		begin
			select COUNT(case when UPPER(Phai)= 'Nam' then 1 end) Nam, COUNT(case when UPPER(Phai)= 'Nu' then 1 end) Nu
			from NHANVIEN				
		end
end
update NHANVIEN set PHAI = 'Nam' where MANV = '025'
select * from NHANVIEN

create trigger trg_CountDeAn2c on DeAn
after delete
as 
	begin
		select Ma_NVIEN, Count(MADA) as 'So Luong' from PHANCONG
		group by Ma_NVIEN
	end
select * from DEAN
delete DEAN where MADA = 22

create trigger trg_DeleteNhanThanNV on NhanVien
instead of delete 
as 
begin
	delete from THANNHAN where MA_NVIEN in (select MANV from deleted)
	delete from NHANVIEN where MANV in (select MANV from deleted)
end

delete NHANVIEN where MANV = '026'
select * from NHANVIEN

create trigger trg_InsertNhanVien3b on NHANVIEN
after insert 
as begin
	insert into PHANCONG values((select MANV from inserted), 1, 1, 100)
end

insert into NHANVIEN
values('Tran', 'Thanh', 'Huy', '055', '1980-12-12', 'Da Nang', 'Nu', 16000, '006', 1)


