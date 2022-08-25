require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutClasses < Neo::Koan
  class Dog
  end

  def test_instances_of_classes_can_be_created_with_new
    Zeus = Dog.new
    assert_equal AboutClasses::Dog, Zeus.class
  end

  # ------------------------------------------------------------------

  class Dog2
    def set_name(a_name)
      @name = a_name
    end
  end

  def test_instance_variables_can_be_set_by_assigning_to_them
    Zeus = Dog2.new
    assert_equal [], Zeus.instance_variables

    Zeus.set_name("Zeus")
    assert_equal [:@name], Zeus.instance_variables
  end

  def test_instance_variables_cannot_be_accessed_outside_the_class
    Zeus = Dog2.new
    Zeus.set_name("Zeus")

    assert_raise(StandardError) do
      Zeus.name
    end
  end

  def test_you_can_politely_ask_for_instance_variable_values
    Zeus = Dog2.new
    Zeus.set_name("Zeus")

    assert_equal "Zeus", Zeus.instance_variable_get("@name")
  end

  def test_you_can_rip_the_value_out_using_instance_eval
    Zeus = Dog2.new
    Zeus.set_name("Zeus")

    assert_equal "Zeus", Zeus.instance_eval("@name")  # string version
    assert_equal "Zeus", Zeus.instance_eval { @name } # block version
  end

  # ------------------------------------------------------------------

  class Dog3
    def set_name(a_name)
      @name = a_name
    end
    def name
      @name
    end
  end

  def test_you_can_create_accessor_methods_to_return_instance_variables
    Zeus = Dog3.new
    Zeus.set_name("Zeus")

    assert_equal "Zeus", Zeus.name
  end

  # ------------------------------------------------------------------

  class Dog4
    attr_reader :name

    def set_name(a_name)
      @name = a_name
    end
  end


  def test_attr_reader_will_automatically_define_an_accessor
    Zeus = Dog4.new
    Zeus.set_name("Zeus")

    assert_equal "Zeus", Zeus.name
  end

  # ------------------------------------------------------------------

  class Dog5
    attr_accessor :name
  end


  def test_attr_accessor_will_automatically_define_both_read_and_write_accessors
    Zeus = Dog5.new

    Zeus.name = "Zeus"
    assert_equal "Zeus", Zeus.name
  end

  # ------------------------------------------------------------------

  class Dog6
    attr_reader :name
    def initialize(initial_name)
      @name = initial_name
    end
  end

  def test_initialize_provides_initial_values_for_instance_variables
    Zeus = Dog6.new("Zeus")
    assert_equal "Zeus", Zeus.name
  end

  def test_args_to_new_must_match_initialize
    assert_raise(ArgumentError) do
      Dog6.new
    end
    # THINK ABOUT IT:
    # Why is this so?
  end

  def test_different_objects_have_different_instance_variables
    Zeus = Dog6.new("Zeus")
    rover = Dog6.new("Rover")

    assert_equal true, rover.name != Zeus.name
  end

  # ------------------------------------------------------------------

  class Dog7
    attr_reader :name

    def initialize(initial_name)
      @name = initial_name
    end

    def get_self
      self
    end

    def to_s
      @name
    end

    def inspect
      "<Dog named '#{name}'>"
    end
  end

  def test_inside_a_method_self_refers_to_the_containing_object
    Zeus = Dog7.new("Zeus")

    Zeuss_self = Zeus.get_self
    assert_equal Zeus, Zeuss_self
  end

  def test_to_s_provides_a_string_version_of_the_object
    Zeus = Dog7.new("Zeus")
    assert_equal "Zeus", Zeus.to_s
  end

  def test_to_s_is_used_in_string_interpolation
    Zeus = Dog7.new("Zeus")
    assert_equal "My dog is Zeus", "My dog is #{Zeus}"
  end

  def test_inspect_provides_a_more_complete_string_version
    Zeus = Dog7.new("Zeus")
    assert_equal "<Dog named 'Zeus'>", Zeus.inspect
  end

  def test_all_objects_support_to_s_and_inspect
    array = [1,2,3]

    assert_equal "[1, 2, 3]", array.to_s
    assert_equal "[1, 2, 3]", array.inspect

    assert_equal "STRING", "STRING".to_s
    assert_equal '"STRING"', "STRING".inspect
  end

end
