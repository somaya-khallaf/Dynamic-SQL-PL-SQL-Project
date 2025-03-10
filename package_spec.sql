create or replace package seq_trig
is

        function check_sequence(v_sequence_name varchar2)
        return number;
        function max_id(v_table varchar2,v_id varchar2)
        return number;
        procedure create_sequence(v_table varchar2,v_max_id varchar2);
        procedure create_trigger(v_table varchar2,v_column varchar2);
                                             
end;

