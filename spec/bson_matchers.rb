module BsonMatchers
  class BeBsonEql
    def initialize(expected)
      @expected = expected
    end

    def matches?(target)
      @target = target
      @target == @expected
    end

    def failure_message
      "expected\...#{@target.inspect}\n" +
      "to be BSON code equivalent to\...#{@expected.inspect}\n" +
      "Difference:\...#{@expected.diff(@target).inspect}"
    end

    def negative_failure_message
      "expected\...#{@target.inspect}\n" +
      "to be BSON code different from\...#{@expected.inspect}"
    end
  end

  class BeMongoEql
    def initialize(expected, include_id)
      @include_id = include_id
      @expected = include_id ? expected : expected.except('_id')
    end

    def matches?(target)
      @target = @include_id ? target : target.except('_id')
      @target == @expected
    end

    def failure_message
      "expected\...#{@target.inspect}\n" +
      "to be BSON code equivalent to\...#{@expected.inspect}\n" +
      "Difference:\...#{@expected.diff(@target).inspect}"
    end

    def negative_failure_message
      "expected\...#{@target.inspect}\n" +
      "to be BSON code different from\...#{@expected.inspect}"
    end
  end

  def be_bson_eql(expected)
    BeBsonEql.new(expected)
  end

  def be_mongo_eql(expected, include_id = true)
    BeMongoEql.new(expected, include_id)
  end
end
