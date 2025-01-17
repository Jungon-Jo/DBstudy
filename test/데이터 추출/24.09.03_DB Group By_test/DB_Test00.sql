// 테이블 생성
create table muser(
id int,
reg_num varchar2(8) not null,
name varchar2(10 char),
grade int,
salary int,
time int);

create sequence muser_no
increment by 1
start with 10;

// 데이터 입력
insert into muser values(muser_no.nextval,'870205-1','이승진',1,10000,34);
insert into muser values(muser_no.nextval,'880405-1','박이진',2,20000,31);
insert into muser values(muser_no.nextval,'770715-2','최이수',4,40000,32);
insert into muser values(muser_no.nextval,'010205-3','류진아',1,10000,30);
insert into muser values(muser_no.nextval,'810205-2','오현식',2,20000,34);
insert into muser values(muser_no.nextval,'820219-2','정승우',3,30000,35);
insert into muser values(muser_no.nextval,'020205-3','이재수',1,10000,30);
insert into muser values(muser_no.nextval,'970214-2','박지영',2,20000,31);
insert into muser values(muser_no.nextval,'040205-4','정은아',4,40000,31);
insert into muser values(muser_no.nextval,'770225-1','정재영',5,50000,30);
insert into muser values(muser_no.nextval,'770905-2','이신수',4,40000,34);
insert into muser values(muser_no.nextval,'050208-3','이발끈',2,20000,30);
insert into muser values(muser_no.nextval,'051205-4','이욱이',1,10000,34);
insert into muser values(muser_no.nextval,'891215-1','지승아',3,30000,30);
insert into muser values(muser_no.nextval,'670805-1','현진수',2,20000,34);
insert into muser values(muser_no.nextval,'840207-1','최이런',1,10000,35);
insert into muser values(muser_no.nextval,'770405-1','이천안',1,10000,31);

select * from muser;

// 문제
// 1. grade가 3인 사람은 몇명인가요?
select count(*) 인원수 from muser where grade=3;
select count(*)
from muser
where grade=3;
-- select절에 grade컬럼을 표출시키기 위해서는 group by를 사용하여 grade 그룹을 형성해주어야 한다.

// 2. grade가 1, 2, 4인 사람의 salary의 평균을 구하시오.
select avg(salary) 평균봉급 from muser where grade=1 or grade=2 or grade=4;
select avg(salary)
from muser
where grade in (1,2,4);
//where grade=1 or grade=2 or grade=4;
// group by  -- 정의 : 그룹별 집계일 경우
// order by

// 3. salary가 20000 미만인 사람은 총 몇명입니까?
select count(*) 인원수 from muser where salary<20000;

// 4. salary가 30000 이상인 사람의 salary 평균을 구하시오.
select avg(salary) 평균봉급 from muser where salary>=30000;

// 5. 77년생 중에 salary가 가장 적은 사람의 이름과 나이와 salary를 출력하시오.
select name, 124-substr(reg_num,1,2) age, salary 
    from muser 
    where substr(reg_num,1,2)='77' and salary=(select min(salary) from muser where substr(reg_num,1,2)='77');
    
select min(salary)
from muser
where substr(reg_num,1,2)='77';

-- 77년생의 데이터를 뽑아본다.
select substr(reg_num,1,2) from muser;

-- 77년생 중 가장 작은 salary를 뽑아 내본다.
select min(salary)
from muser
where substr(reg_num,1,2)='77';

-- 정답(하지만 where절의 salary의 값은 계속 변할 수 있는 값이므로, 상수값 대신 다른 값으로 써주는것이 좋다.)
select name, 124-substr(reg_num,1,2) age, salary 
    from muser 
    where substr(reg_num,1,2)='77' and salary=10000;
    
-- 수식, 함수 모두 사용 불가하므로, 서브쿼리를 사용해준다.(77년생 중 가장 작은 salary를 뽑아낸 쿼리를 서브쿼리로 사용)
select name, 124-substr(reg_num,1,2) age, salary 
    from muser 
    where substr(reg_num,1,2)='77' and salary=
                                            (select min(salary)
                                            from muser
                                            where substr(reg_num,1,2)='77');
                                            
-- 나이를 출력하려고 하는데 주민번호밖에 없고, 분석함수를 사용하기 위해서는 네자리의 출생년도가 필요하다.
select 1900+substr(reg_num,1,2) from muser;
-- 2000년대 출생자들의 경우 오류가 발생
-- 2000년대 출생자들의 주민번호 뒷자리의 첫번째 수가 3과 4로 시작하는것을 이용하여 구분해서 값을 계산해준다.
select substr(reg_num,1,2) a, 
       decode(substr(reg_num,8,1),1,1900,2,1900,2000) b 
       from muser;
select substr(reg_num,1,2) a, 
       decode(substr(reg_num,8,1),1,1900,2,1900,2000) b,
       decode(substr(reg_num,8,1),1,1900,2,1900,2000)+substr(reg_num,1,2) c 
       from muser;
       
-- 최종 답안
select name 이름,
       extract (year from sysdate)-(decode(substr(reg_num,8,1),1,1900,2,1900,2000)+substr(reg_num,1,2)) 나이,
       salary 급여
       from muser 
       where substr(reg_num,1,2)='77'
             and salary=(select min(salary)
                                from muser
                                where substr(reg_num,1,2)='77');
    
// 6. 모든 사람의 이름과 생일(월과 일, 예를 들어 0205)를 출력하시오.
select name, substr(reg_num,3,4) birth from muser;

// 7. 남자의 평균 급여를 구하시오.
select avg(salary) from muser where substr(reg_num,length(reg_num),1) in (1,3);

// 8. 전체 평균급여보다 높은 급여를 받는 사람의 이름과, 급여를 출력하시오.
select name, salary from muser where salary>(select avg(salary) from muser);
-- 평균 급여보다 높은 급여를 받는 사람의 튜플 선택
-- 컬럼 자체로 해결? 수식? 함수? 서브쿼리?
-- 평균급여의 결과값으로 조건을 완성 → 서브쿼리

// 9. 전체 평균급여보다 높은 급여를 받는 사람의 이름과, 급여, 평균급여를 출력하시오.
select name,
       salary,
       (select avg(salary) from muser) avgSalary -- 스칼라 서브 쿼리
    from muser
    where salary>(select avg(salary) from muser);
-- 성능은 좋지 못하다.(본쿼리 select에서 튜플을 하나씩 완성해 갈때마다 서브쿼리를 실행)
-- 동일 서브쿼리를 계속 시행하기 때문이다.

// 10. 여직원의 평균급여보다 높은 남자직원은 모두 몇명입니까
select sum(count(*))
from muser
where salary>(select avg(salary) from muser where substr(reg_num,length(reg_num),1)=2 or substr(reg_num,length(reg_num),1)=4)
group by reg_num
having substr(reg_num,length(reg_num),1)=1 or substr(reg_num,length(reg_num),1)=3;

select sum(count(*))
from muser
where substr(reg_num,length(reg_num),1)=1 or substr(reg_num,length(reg_num),1)=3
group by salary
having salary>(select avg(salary) from muser where substr(reg_num,length(reg_num),1)=2 or substr(reg_num,length(reg_num),1)=4);

// 11. grade별 평균 급여를 출력하세요
select grade, avg(salary) avgsalary from muser group by grade;

// 12. 그룹별 평균급여가 전체 평균보다 높은 그룹을 출력하시오.
select grade from muser group by grade having avg(salary)>(select avg(salary) from muser) order by grade;

// 13. 직원들의 월급 명세서를 출력하시오. (출력 형태는 이름, 월급(grade*salary*time)
select name 이름, grade*salary*time 월급 from muser;

// 14. 직원들의 성별을 출력하시오. (출력 형태 이름, 성별(성별은 남또는 여로 출력한다)
select name 이름
    , case when substr(reg_num, length(reg_num), 1)=1 or substr(reg_num, length(reg_num), 1)=3 then '남' 
           when substr(reg_num, length(reg_num), 1)=2 or substr(reg_num, length(reg_num), 1)=4 then '여' end 성별
from muser;

select name 이름,
       case when substr(reg_num, length(reg_num), 1) in (1,3) then '남' 
           else '여'
       end 성별
       from muser;

select name 이름,
       decode(substr(reg_num,8,1),'1','남',3,'남','여') 성별
       from muser;

select distinct grade, salary from muser;
-- distinct는 중복된 컬럼을 제거하고 select 절에서 한번만 사용이 가능
-- 중복제거 범위는 select에서 지정한 전체 행의 중복이다.
-- #3번 문제에서 연령별(time컬럼) 급여의 합. over 함수 이용
select time 연령,
       sum(salary) over(partition by time) 총합
       from muser;
       
select distinct -- distinct는 select절에 사용된 모든 column에 적용되어 중복을 제거한다.
       time 연령,
       sum(salary) over(partition by time) 총합
       from muser;

// 15. time은 근무시간, 근무시간이 31이상인 사람의 이름을 출력하시오.
select name from muser where time>=31;

// 16. 짝수년도에 태어난 사람들의 이름을 모두 출력하시오.
select name, reg_num from muser where mod(substr(reg_num,1,2),2)=0;

// 17. 직원들의 생년월일을 출력하시오. (출력 형태는 이름과 생년월일(97년1월2일))
select substr(reg_num,1,2)||'년'||replace(substr(reg_num,3,2)||'월'||substr(reg_num,5,2)||'일','0','') 생년월일 from muser;

// 18. 여직원들의 육아를 지원하기 위한 정책으로 time을 2시간가산하기로 했다. 이를 처리 하시오.
select id
    , reg_num
    , name
    , grade
    , salary
    , case when substr(reg_num, length(reg_num), 1)=1 or substr(reg_num, length(reg_num), 1)=3 then time 
           when substr(reg_num, length(reg_num), 1)=2 or substr(reg_num, length(reg_num), 1)=4 then time+2 end time
    from muser;

// 19. 나이별 인원수는 몇명입니까
select substr(reg_num,1,2), count(*) from muser group by substr(reg_num,1,2);

// 20. 2학년그룹과 4학년 그룹은 모두 몇명입니까
select grade, count(*) 인원수 from muser group by grade having grade=2 or grade=4;


// 추가문제

// #1) 모든 사람이 태어난 후 오늘까지 몇 달이 지났는지 출력하시오
// (출력형태: 이름, 주민번호, 지금까지살아온월수)
select name
    , reg_num
    , trunc(months_between(sysdate, (substr(reg_num,1,2)||'-'||substr(reg_num,3,2)||'-'||substr(reg_num,5,2)))) 달 
    from muser;
    
// #2) time을 나이로 봄. 30~31세의 살아온 월수의 합, 32세 이상의 살아온 월수의 합 구하기
select sum(12*(select sum(time) from muser where time>=30 and time <=31)) "31세 이하"
    , sum(12*(select sum(time) from muser where time>=32)) "32세 이상"
    from muser;
    
select
    (select trunc(sum(months_between(sysdate,substr(reg_num,1,6)))) from muser where time in (30,31)) as 삼공삼일,
    (select trunc(sum(months_between(sysdate,substr(reg_num,1,6)))) from muser where time >= 32) as 삼공삼일
    from dual;

// #3) 연령별 급여의 합, over()함수 이용
select time, sum(salary) over(partition by time order by time) "급여의 합" from muser;

// #4) 연령별 인원수, over()함수 이용
select time, count(*) over(partition by time order by time) 인원수 from muser;

// #5) 등급별 급여의 최고급여, over()함수 이용
select grade, max(salary) over(partition by grade order by grade) 최고급여 from muser;

// #6) 구글검색하여 오라클 함수 정리
// 연산함수
-- count(*) : 튜플의 갯수를 추출
-- sum([컬럼명]) : 컬럼명에 해당하는 값의 합
-- like : like '[조건으로 활용될 문자열]%' or '%[조건으로 활용될 문자열]'/특정 문자열을 포함한 문자열을 찾고자 할 때 사용한다.
-- is null : [컬럼명] is null/조건절에서 null값인 경우를 지정할 때 사용하며, =null은 사용할 수 없다.