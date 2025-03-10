create or replace package body  seq_trig
is
    function check_sequence(v_sequence_name varchar2)
    return number
    is
    check_result number(1);
    begin
            select count(*) as result   
            into check_result 
            from USER_SEQUENCES 
            where SEQUENCE_NAME = v_sequence_name;
            return check_result;
    end;
    
    function max_id(v_table varchar2,v_id varchar2)
    return number
    is
            v_max_id number(5);
    begin
            execute immediate ' select nvl(max('||v_id||'),0) +1 from '||v_table
            into v_max_id;
            return v_max_id;
    end;
    
    procedure create_sequence(v_table varchar2,v_max_id varchar2)
    is
    begin
              execute immediate 'CREATE SEQUENCE '||v_table||'_SEQ'||'
                                    START WITH '||v_max_id||'
                                      MAXVALUE 999999999999999999999999999
                                      MINVALUE 1
                                      NOCYCLE
                                      CACHE 20
                                      NOORDER';
    end;
    
    procedure create_trigger(v_table varchar2,v_column varchar2)
    is
    begin
               execute immediate 'CREATE or replace TRIGGER '||v_table||'_TRG
                            BEFORE INSERT
                            ON '||v_table||'
                            REFERENCING NEW AS New OLD AS Old
                            FOR EACH ROW
                            BEGIN                   
                              :new.'||v_column||' := '||v_table||'_SEQ.nextval;
                            END '||v_table||'_TRG;';
    end;


end;
show error;