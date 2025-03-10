set serveroutput on
declare
        CURSOR table_cursor IS
            SELECT ucc.table_name, ucc.column_name
            FROM user_constraints uc JOIN user_cons_columns ucc 
            ON uc.constraint_name = ucc.constraint_name 
            JOIN user_TAB_COLUMNS utc ON ucc.TABLE_NAME = utc.TABLE_NAME AND ucc.COLUMN_NAME = utc.column_name
            WHERE uc.constraint_type = 'P'  AND ucc.table_name IN (
                    SELECT ucc2.table_name
                    FROM user_cons_columns ucc2
                    JOIN user_constraints uc2 
                    ON ucc2.constraint_name = uc2.constraint_name            
                    WHERE uc2.constraint_type = 'P' 
                    GROUP BY ucc2.table_name
                    HAVING COUNT(ucc.position) = 1
                ) AND utc.DATA_TYPE='NUMBER' ;

      -- v_DATA_TYPE ALL_TAB_COLUMNS.TABLE_NAME%type;
      -- seq USER_SEQUENCES.SEQUENCE_NAME%type := '';
       v_max_id number(5);

begin 
        for table_record in table_cursor loop
               
                    --DBMS_OUTPUT.PUT_LINE('TABLE_NAME = ' ||  table_record.TABLE_NAME || ' column_name = '|| table_record.column_name);
                      /*
                    seq := check_sequence(table_record.TABLE_NAME||'_SEQ');
                    DBMS_OUTPUT.PUT_LINE (table_record.TABLE_NAME||'_SEQ' || ' '||seq);
                    */
                    -- drop all sequences first
                    if seq_trig.check_sequence(table_record.TABLE_NAME||'_SEQ') = 1
                    then
                                              -- DBMS_OUTPUT.PUT_LINE('This sequence name exist');
                                               execute immediate ' drop sequence '||table_record.TABLE_NAME||'_SEQ';                                              
                    --else
                         --   DBMS_OUTPUT.PUT_LINE('not exist');
                    end if;
               
                    -- select max id for table 
                       v_max_id := seq_trig.max_id(table_record.TABLE_NAME,table_record.column_name);
                       --DBMS_OUTPUT.PUT_LINE('v_max_id: ' ||v_max_id);
                       
                      -- create Sequence                  
                       seq_trig.create_sequence(table_record.TABLE_NAME,v_max_id);
                             
                        -- create Trigger
                       seq_trig.create_trigger(table_record.TABLE_NAME,table_record.column_name);
                      --DBMS_OUTPUT.PUT_LINE('Trigger created: ' || table_record.table_name || '_TRG');
                      
                      
                        DBMS_OUTPUT.PUT_LINE('All done for table : ' || table_record.table_name);
        end loop;
end;
show errors;
