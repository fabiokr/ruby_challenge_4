class Polynomial
  def initialize(values)
    raise ArgumentError.new('Need at least 2 coefficients') unless !values.nil? && values.compact.size >= 2
    @terms = to_terms(values.compact)
  end

  def to_s
    return "0" if all_zero
    @terms.reject { |t| t.value == 0 }.collect { |t| t.value < 0 || t == @terms.first ? t.to_s : "+#{t.to_s}" }.to_s
  end

  private

  def to_terms(values)
    power = values.size
    @terms = values.collect {|v| Term.new(v, power-=1)}
  end

  def all_zero
    @terms.each {|t| return false if t.value != 0}
    return true
  end
end

class Term
  attr_reader :value, :power

  def initialize(value, power, isFirstTerm = false)
    @value, @power = value, power
  end

  def to_s
    "#{format_value}#{format_power}"
  end

  private

  def format_value
    return "-" if value == -1
    return "" if value == 1
    return value
  end

  def format_power
    return "" if power == 0
    return "x" if power == 1
    return "x^#{power}"
  end
end

