library vunit_lib;
context vunit_lib.vunit_context;

entity tb_many_ways_to_fail is
  generic (runner_cfg : string := runner_cfg_default);
end entity;

architecture tb of tb_many_ways_to_fail is
begin
  test_runner : process
    variable my_vector : integer_vector(1 to 17);
  begin
    test_runner_setup(runner, runner_cfg);

    while test_suite loop
      if run("Test that fails on an assert") then
        assert false;
      elsif run("Test that crashes on boundary problems") then
        report to_string(my_vector(runner_cfg'length));
      elsif run("Test that fails on VUnit check procedure") then
        check_equal(17, 18);
      end if;
    end loop;

    test_runner_cleanup(runner);
  end process;
end architecture;