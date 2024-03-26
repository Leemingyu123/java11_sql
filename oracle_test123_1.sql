-- 테이블 생성
create table member(no int not null, id varchar(20) primary key, pw varchar(300), 
		name varchar(100), birth timestamp, email varchar(300));
-- 시퀀스 생성        
create sequence c##test123.mem_seq increment by 1 start with 1 minvalue 1 maxvalue 9999 nocycle;

-- 데이터 추가
insert into member values (mem_seq.nextval, 'kim', '1234', '김기태', '1981-12-25', 'kkt@gmail.com');
insert into member values (mem_seq.nextval, 'park', '1004', '박동수', '1998-03-25', 'park@naver.com');
insert into member values (mem_seq.nextval, 'lee', '1212', '이연정', '1979-08-15', 'lee@daum.net');
insert into member values (mem_seq.nextval, 'cho', '2848', '조대신', '1989-04-05', 'cho@gmail.com');
insert into member values (mem_seq.nextval, 'yu', '7979', '유정환', '1995-10-15', 'yu@naver.com');
insert into member values (mem_seq.nextval, 'bae', '0909', '배곤희', '1999-03-26', 'bae@gmail.com');

-- 데이터 검색
select * from member;

select id, name, birth from member 
where birth>='1980-01-01' and birth<='1989-12-31';

select id, name, birth from member 
where birth between '1980-01-01' and '1989-12-31';

select id, name, birth from member 
where id like '%e%';