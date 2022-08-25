require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutModules < Neo::Koan
  module Nameable
    def set_name(new_name)
      @name = new_name
    end

    def here
      :in_module
    end
  end

  def test_cant_instantiate_modules
    assert_raise(NoMethodError) do
      Nameable.new
    end
  end

  # ------------------------------------------------------------------

  class Dog
    include Nameable

    attr_reader :name

    def initialize
      @name = "Zeus"
    end

    def bark
      "WOOF"
    end

    def here
      :in_object
    end
  end

  def test_normal_methods_are_available_in_the_object
    Zeus = Dog.new
    assert_equal "WOOF", Zeus.bark
  end

  def test_module_methods_are_also_available_in_the_object
    Zeus = Dog.new
    assert_nothing_raised do
      Zeus.set_name("Rover")
    end
  end

  def test_module_methods_can_affect_instance_variables_in_the_object
    Zeus = Dog.new
    assert_equal "Zeus", Zeus.name
    Zeus.set_name("Rover")
    assert_equal "Rover", Zeus.name
  end

  def test_classes_can_override_module_methods
    Zeus = Dog.new
    assert_equal :in_object, Zeus.here
  end
end
