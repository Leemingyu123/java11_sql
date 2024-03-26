--테이블 생성
create table member(no int not null, id varchar(20) primary key, 
pw varchar(300), name varchar(100), birth timestamp, email varchar(300));

--시퀀스 생성
create sequence c##teest123.mem_seq increment by 1 start with 1 minvalue 1 maxvalue 9999 nocycle;

--데이터 추가
insert into member values(mem_seq.nextval, 'kim', '1234', '김기태', '1981-12-25', 'kkt09072@naver.com');
insert into member values(mem_seq.nextval, 'lee', '1884', '이민규', '1994-02-11', 'kkt09072@naver.com');
insert into member values(mem_seq.nextval, 'han', '6574', '한상우', '1991-08-22', 'kkt09072@naver.com');
insert into member values(mem_seq.nextval, 'jung', '1134', '정오빈', '1971-11-11', 'kkt09072@naver.com');
insert into member values(mem_seq.nextval, 'park', '9884', '박재훈', '1999-01-29', 'kkt09072@naver.com');

--데이터 검색
select * from member;
select id, name, birth from member;

--생일이 1980~1989년 생인 회원의 id, name 컬럼 검색
select id, name from member where birth between '1980-01-01' and '1989-12-31';

--id에 i나 e가 포함된 회원의 id, name 칼럼을 검색
select id, name, birth from member where id like '%i%' or id like '%e%';
--id like 'i%'; i로 시작하는 아이디
--id like '%i'; i로 끝나는 아이디

-- id가 'kim','lee','cho','park' 인 회원(member) 정보를 검색
select * from member where id ='kim' or id= 'lee' or id='cho' or id='park';

-- id가 'kim','lee','cho' 인 회원(member) 정보를 검색
select * from member where id in ('kim','lee','cho');

-- id가 'kim','lee','cho' 아닌 회원(member) 정보를 검색
select * from member 
where id not in ('kim','lee','cho');

--컬럼명이　너무　길거나　수식이나　함수를　적용하여　컬럼을　구성할　경우　
--컬럼에　대한　ａｌｉａｓ（별칭）을　붙일　수　있다．
--회원(member) 테이블로 부터 id, name, 이름 중에서 성씨를 검색
select id,name,substr(name,1,1) as surname from member;
--　ｊａｖａ에서　ｒｓ．ｇｅｔＳｔｒｉｎｇ（＂ｓｕｒｎａｍｅ＂）；　처럼　ａｌｉａｓ로　호출해야함

select * from member;
update member set email='lee@naver.com' where id='lee'

--id가 'kim'인 회원을 강제탈퇴하도록 한다.
delete from member where id='kim';

alter table member add regdate timestamp default sysdate;

alter table  member add point int default 0;

alter table member rename column regdate to reg;

desc member;

select * from member;

alter table member modify pw varchar(200);
alter table member drop column point;
commit;
alter table member rename to temp1;

desc temp1;

create table temp2(no int, name varchar(200), point int);

insert into temp2 values(1, '김', 90);
insert into temp2 values(2, '박', 80);
insert into temp2 values(3, '최', 85);
insert into temp2(name, point) values ('이', 75);

select * from temp2;

delete from temp2 where no is null;

alter table temp2 add constraints key1 primary key (no);

create table emp(no int, name varchar(100), pcode int, 
constraints key2 primary key (no));

insert into emp values (1, '김', 1);
insert into emp values (2, '이', 2);
insert into emp values (3, '이', 3);
insert into emp values (4, '이', 4);
insert into emp values (5, '이', 5);

select * from emp;

update emp set name='박' where no=3;
update emp set name='최' where no=4;
update emp set name='조' where no=5;

select * from emp;

create table pos(pcode int primary key, pname varchar(100));
insert into pos values (1, '이사');
insert into pos values (2, '부장');
insert into pos values (3, '과장');
insert into pos values (4, '사원');

insert into pos values (5, '인턴');

select * from pos;

alter table emp  add constraints fkey foreign key(pcode) references pos(pcode);
--emp의 pcode 는 pos의 pcode를 참조하겠다 아직 5, 인턴을 추가하지 않았으면 오류가 나온다

select * from ALL_constraints where owner= 'C##TEST123';
select * from ALL_constraints where table_name= 'EMP';

alter table emp drop constraint key2;

drop table pos cascade constraints;
--cascade constraints 연쇄삭제 옵션으로 제약조건 때문에 테이블을 삭제할 수 없는 경우 
--테이블을 제거하면서 제약조건도 연쇄적으로 삭제
desc emp;

commit;

--view의 생성1

create view view_emp as select * from emp;

select * from emp;
select * from view_emp;

--뷰 생성2
create view view_emp2 as select * from emp where no>=3;
select * from emp where no>=3;
select * from view_emp2;

--뷰 제거
drop view view_emp;
--alter view view_emp2 as select * from emp where no>=2 or name like '%e%';
--view는 수정 못함

--시퀀스 생성/수정/제거/적용/조회
--시퀀스 생성
--시퀀스(자동순번) 1씩 증가해라 1부터 시작해서 최소 1부터 최대 9999까지 다시 1로 가지말고
create sequence emp_seq increment by 1 start with 6 minvalue 1 maxvalue 9999 nocycle; 

--시퀀스 수정
--alter sequence emp_seq 수정할 내용
alter sequence emp_seq start with 6 increment by 1; --start with는 바꿀수 없다.

--시퀀스 제거
drop sequence emp_seq;

--emp_seq의 시퀀스 정보 조회
select * from all_sequences where sequence_name = 'EMP_SEQ';
select * from emp;

--emp테이블에 no의 값을 다음 순번으로(nextval)  적용하여 레코드 추가
insert into emp values(emp_seq.nextval, '고', 3);

--현재 시퀀스값 조회
select emp_seq.currval from dual;

--테이블 복제
create table emp2 as select * from emp;
desc emp2; --제약조건은 복제가 안됨

select * from emp2;

--no 컬럼을 기본키로 설정
alter table emp2 modify no int primary key;

--내부조인(inner join)
select a.no, a.name, b.pcode, b.pname from emp a 
inner join pos b on a.pcode=b.pcode;

--외부조인(left (outer) join)
select a.no, a.name, b.pcode, b.pname from emp a 
left join pos b on a.pcode=b.pcode;

--외부조인2(right outer join)
select a.no, a.name, b.pcode, b.pname from emp a 
right join pos b on a.pcode=b.pcode;

--연관쿼리
select a.no, a.name, b.pname from emp a, pos b
where a.pcode=b.pcode;

select emp.no, emp.name, pos.pname from emp, pos
where emp.pcode=pos.pcode;

select * from emp;
delete from emp2 where no=3 or no=5;
insert into emp2 values(7, '오', 4);
insert into emp2 values(8, '정', 5);

--서브쿼리 = 이중쿼리
--서브쿼리(emp2 테이블에 존재하는 no만 emp 테이블 조회) => 교집합(일치쿼리)
select no, name from emp 
where no in(select no from emp2);

--서브쿼리(emp2 테이블에 존재하지 않는 no만 emp 테이블 조회) => 차집합(불일치쿼리)
select no, name from emp 
where no not in(select no from emp2);


select * from emp, pos; --두 테이블 간의 product - emp:6, pos:5 =>6*5=30

update emp set pcode=4 where no=4 or no=6 or no=2;

select distinct pcode, count (*) as cnt from emp group by pcode ;--1이몇명,3이 몇명...

-- 그룹화하는 항목과 출력되는 그룹 항목이 달라서(오류)
select pos.pname, count(emp.no) as cnt
from pos, emp where pos.pcode = emp.pcode
group by pos.pcode;

-- 직위별 인원수 join문 -> 그룹화하는 항목 : 직위명(pname)
select pos.pname, count(emp.no) as cnt
from pos inner join emp on pos.pcode = emp.pcode
group by pos.pname;

-- 직위별 인워수 연관쿼리 -> 그룹화하는 항목: 직위명(pname)
select pos.pname, count(emp.no) as cnt 
from pos, emp where pos.pcode = emp.pcode
group by pos.pname;

--집계함수 : count, sum, avg, max, min

--정렬하여 출력 : order by 컬럼명;
--반드시 order by 는 구절은 맨 끝에 지정해야함
select * from emp order by name; --desc는 내림차순, 생략, asc: 오름차순
select * from emp order by name desc;

--집합 연산시 연산하는 두개의 테이블의 구조가 같거나 
--연산하는 컬럼의 갯수와 타입이 일치해야함. 
--집합연산 UNION(합집합), INTERSECT(교집합), MINUS(차집합)
create view uni_view as (select * from emp union select * from emp2);
select * from uni_view;
create view int_view as (select * from emp intersect select * from emp2);
select * from int_view;
create view min_view1 as (select * from emp minus select * from emp2);
select * from min_view1; -- emp-emp2
create view min_view2 as (select * from emp2 minus select * from emp);
select * from min_view2; -- emp2-emp