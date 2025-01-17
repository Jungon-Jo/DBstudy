create table hm (
no number(3) primary key,
name varchar2(10) not null,
point number(5) default 0,
addr varchar2(20),
indate TIMESTAMP default sysdate);

insert into hm values (1, '홍길동', 45, '서울시', default);
insert into hm values (2, '일지매', 50, '수원', default);
insert into hm values (3, '이지매', 43, '서울', default);

select * from hm;
select no, name from hm;

select count(*) from hm;

// 기본
// 1. 모든 사람의 이름과 점수만 출력하시오.
select name, point from hm;

// 2. 점수가 50점 미만인 사람의 이름과 점수를 출력하시오.
select name 이름, point from hm where point < 50;

// 3. 점수가 50점 미만인 사람은 모두 몇명인가요?
select count(*) from hm where point < 50;

// 4. 홍길동의 점수는 몇점인가요?
select point from hm where name = '홍길동';

// 5. 일지매의 모든 정보를 출력하세요.
select * from hm where no = 2;

// 6. 모든 회원을 출력하되 가입 순서대로 출력하시오.
select * from hm order by no desc;


// 별칭
// 1. 모든 학생의 이름과 포인트를 출력합니다. 포인트는 현재 포인트에서 10점 올려서 출력
select name 이름, point+10 포인트 from hm;

// 2. 모든 학생의 이름과 포인트를 출력합니다. 출력은 이름 현재포인트 가산포인트를 출력
select name, point 현재포인트, point+10 가산포인트 from hm;

// 3. 이름은 학생의 이름, 현재 포인트는 저장된 포인트, 가산포인트는 +10점 올린 포인트 출력
select name, point 현재포인트, point+10 가산포인트 from hm;

update hm set point=100, name='김티처';
update hm set point=100, name='김티처' where name='홍길동';
delete from hm where name='홍길동';
delete from hm;


// 함수
select concat('이름','님') 이름 from dual;
/* select 절을 사용하기 위해 빠져서 안되는 절 = form 절,
*  select 절에서 함수 호출의 형태만 보여주기위해 별도의 table을 불러오지 않을 경우
*  dual이라는 임의의 테이블을 불러와 사용한다.
*/
// 1. 이름뒤에 님을 붙혀서 출력하시오. 모든 사람의 이름과 포인트를 출력합니다.
select concat(name,'님') 이름, point from hm;
// 2. 모든 사람의 이름과 포인틀와 등록일을 출력합니다.
//    이때 가입순서에 따라 출력합니다. 가장 나중에 가입한 사람이 제일 먼저 출력
//    가입 날짜는 indate
select name, point, indate from hm order by indate desc;
// 3. 포인트가 50 이상인 사람의 이름과 정보를 출력합니다.
//    정보는 no, 이름, 포인트가 합쳐진 문자열이다.
select name, concat(no,concat(name,point)) 정보 from hm where point >= 50;
// 4. 기준 포인트는 60이다. 모든 회원이 기준포인트를 맞추기 위해서 부족한 포인트를 출력하시오.
//    출력은 이름 현재 포인트, 부족한 포인트
select name 이름, point 현재포인트, 60-point 부족한포인트 from hm;

commit;