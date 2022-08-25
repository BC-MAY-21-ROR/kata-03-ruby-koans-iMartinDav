# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/neo")

class AboutArrayAssignment < Neo::Koan
  def test_non_parallel_assignment
    names = %w[Martin Davila]
    assert_equal %w[Martin Davila], names
  end

  def test_parallel_assignments
    first_name = 'Martin'
    last_name = 'Davila'
    assert_equal 'Martin', first_name
    assert_equal 'Davila', last_name
  end

  def test_parallel_assignments_with_extra_values
    first_name, last_name = %w[Martin Davila III]
    assert_equal 'Martin', first_name
    assert_equal 'Davila', last_name
  end

  def test_parallel_assignments_with_splat_operator
    first_name, *last_name = %w[Martin Davila III]
    assert_equal 'Martin', first_name
    assert_equal %w[Davila III], last_name
  end

  def test_parallel_assignments_with_too_few_variables
    first_name, last_name = ['Goku']
    assert_equal 'Goku', first_name
    assert_equal nil, last_name
  end

  def test_parallel_assignments_with_subarrays
    first_name = %w[Bartolome Casas]
    last_name = 'Martinson'
    assert_equal %w[Bartolome Casas], first_name
    assert_equal 'Martinson', last_name
  end

  def test_parallel_assignment_with_one_variable
    first_name, = %w[Martin Davila]
    assert_equal 'Martin', first_name
  end

  def test_swapping_with_parallel_assignment
    first_name = 'Rodri'
    last_name = 'Roberto'
    first_name, last_name = last_name, first_name
    assert_equal 'Roberto', first_name
    assert_equal 'Rodri', last_name
  end
end
