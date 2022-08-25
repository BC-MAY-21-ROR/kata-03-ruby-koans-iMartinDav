# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/neo")

include Java

class AboutJavaInterop < Neo::Koan
  def test_using_a_java_library_class
    java_array = java.util.ArrayList.new
    assert_equal __, java_array.class
  end

  def test_java_class_can_be_referenced_using_both_ruby_and_java_like_syntax
    assert_equal __, Java::JavaUtil::ArrayList == java.util.ArrayList
  end

  def test_include_class_includes_class_in_module_scope
    assert_nil defined?(TreeSet)
    include_class 'java.util.TreeSet'
    assert_equal __, defined?(TreeSet)
  end

  JString = java.lang.String
  def test_also_java_class_can_be_given_ruby_aliases
    java_string = JString.new('A Java String')
    assert_equal __, java_string.class
    assert_equal __, JString
  end

  def test_can_directly_call_java_methods_on_java_objects
    java_string = JString.new('A Java String')
    assert_equal __, java_string.toLowerCase
  end

  def test_jruby_provides_snake_case_versions_of_java_methods
    java_string = JString.new('A Java String')
    assert_equal __, java_string.to_lower_case
  end

  def test_jruby_provides_question_mark_versions_of_boolean_methods
    java_string = JString.new('A Java String')
    assert_equal __, java_string.endsWith('String')
    assert_equal __, java_string.ends_with('String')
    assert_equal __, java_string.ends_with?('String')
  end

  def test_java_string_are_not_ruby_strings
    ruby_string = 'A Java String'
    java_string = java.lang.String.new(ruby_string)
    assert_equal __, java_string.is_a?(java.lang.String)
    assert_equal __, java_string.is_a?(String)
  end

  def test_java_strings_can_be_compared_to_ruby_strings_maybe
    ruby_string = 'A Java String'
    java_string = java.lang.String.new(ruby_string)
    assert_equal __, ruby_string == java_string
    assert_equal __, java_string == ruby_string
  end

  def test_however_most_methods_returning_strings_return_ruby_strings
    java_array = java.util.ArrayList.new
    assert_equal __, java_array.toString
    assert_equal __, java_array.toString.is_a?(String)
    assert_equal __, java_array.toString.is_a?(java.lang.String)
  end

  def test_some_ruby_objects_can_be_coerced_to_java
    assert_equal __, 'ruby string'.to_java.class
    assert_equal __, 1.to_java.class
    assert_equal __, 9.32.to_java.class
    assert_equal __, false.to_java.class
  end

  def test_some_ruby_objects_are_not_coerced_to_what_you_might_expect
    assert_equal __, [].to_java.instance_of?(Java::JavaUtil::ArrayList)
    assert_equal __, {}.to_java.instance_of?(Java::JavaUtil::HashMap)
    assert_equal __, Object.new.to_java.instance_of?(Java::JavaLang::Object)
  end

  def test_java_collections_are_enumerable
    java_array = java.util.ArrayList.new
    java_array << 'one' << 'two' << 'three'
    assert_equal __, java_array.map(&:upcase)
  end

  # ------------------------------------------------------------------

  module Java
    module JavaUtil
      class ArrayList
        def multiply_all
          result = 1
          each do |item|
            result *= item
          end
          result
        end
      end
    end
  end

  def test_java_class_are_open_from_ruby
    java_array = java.util.ArrayList.new
    java_array.add_all([1, 2, 3, 4, 5])

    assert_equal __, java_array.multiply_all
  end
end
