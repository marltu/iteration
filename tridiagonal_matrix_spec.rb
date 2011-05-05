require './tridiagonal_matrix'

describe TridiagonalMatrix do
    it "should initialize with 2" do
        TridiagonalMatrix.new(2)
    end
    it "should return 0 when no other values are set" do
        m = TridiagonalMatrix.new(2)
        m.get(0, 0).should == 0
        m.get(1, 1).should == 0
    end
    it "should return setted values" do
        m = TridiagonalMatrix.new(5)
        m.set(2, 2, 13)
        m.set(3, 2, 14)
        m.set(1, 2, 12)
        
        m.get(2, 2).should == 13
        m.get(3, 2).should == 14
        m.get(1, 2).should == 12
    end
    it "should throw exception when trying to set value not in triagonal" do
        m = TridiagonalMatrix.new(5)
        lambda { m.set(2, 4, 23) }.should raise_error RangeError
        lambda { m.set(2, 3, 22) }.should_not raise_error
    end

    it "should set values in right places when using set_a, get_a type shortcuts" do
        m = TridiagonalMatrix.new(5)
        m.set_a(1, 6)
        m.set_b(1, 7)
        m.set_c(1, 8)

        m.get_a(1).should == 6
        m.get_b(1).should == 7
        m.get_c(1).should == 8
        
        m.get(0, 1).should == 6
        m.get(1, 1).should == 7
        m.get(2, 1).should == 8
    end

    it "should be diagonally dominant with specific matrix" do
        m = TridiagonalMatrix.new(4)
        m.set_b(0, 4)
        m.set_c(0, 4)
        
        m.set_a(1, 3)
        m.set_b(1, 4)
        m.set_c(1, 1)

        m.set_a(2, 2)
        m.set_b(2, 7)
        m.set_c(2, 4)

        m.set_a(3, 1)
        m.set_b(3, 2)

        m.diagonally_dominant?.should == true

        m.set_b(0, 1)
        
        m.diagonally_dominant?.should == false
    end

    it "should set matrix using array" do
        m = TridiagonalMatrix.new([
            [1, 2, 0],
            [4, 5, 6],
            [0, 8, 9]
        ])

        m.get(1, 1).should == 5

    end

    it "should not solve if wrong parameters given" do
        m = TridiagonalMatrix.new(1)
        m.set(0, 0, 1)
        lambda { m.solve([1, 2]) }.should raise_error ArgumentError
    end

    it "should solve specific matrix with right value" do
        m = TridiagonalMatrix.new([
            [2, -1, 0],
            [-1, 2, -1],
            [0, -1, 2]
        ])

        result = m.solve([1, 0, 1])

        diff = 0.001

        result.each {|x| x.should be_close(1, diff)}
    end

    it "should solve specific matrix with right value" do
        m = TridiagonalMatrix.new([
            [10, 3],
            [3, 8]
        ])

        result = m.solve([60, 192])

        diff = 0.00001
        correct_results = [-1.35211, 24.50704]

        result.each_with_index do |x, i|
            x.should be_close(correct_results[i], diff)
        end
    end
    it "should solve specific matrix with right value" do
        m = TridiagonalMatrix.new([
            [2, 0.5, 0, 0],
            [0.5, 2, 0.5, 0],
            [0, 0.5, 2, 0.5],
            [0, 0, 0.5, 2]
        ])

        result = m.solve([3, 6, 9, 9.5])

        diff = 0.0000001
        correct_results = [1, 2, 3, 4]

        result.each_with_index do |x, i|
            x.should be_close(correct_results[i], diff)
        end
    end

    it "should not solve 4x4 (first line)" do
        m = TridiagonalMatrix.new([
            [2, 3, 0, 0],
            [0.5, 2, 0.5, 0],
            [0, 0.5, 2, 0.5],
            [0, 0, 0.5, 2]
        ])

        lambda { m.solve([3, 6, 9, 9.5]) }.should raise_error RuntimeError
    end


    it "should solve 10x10" do
        m = TridiagonalMatrix.new(10)

        m.set_b(0, 2)
        m.set_c(0, 1)
        m.set_abc(1, 1, 2, 1)
        m.set_abc(2, 1, 2, 1)
        m.set_abc(3, 1, 2, 1)
        m.set_abc(4, 1, 2, 1)
        m.set_abc(5, 1, 2, 1)
        m.set_abc(6, 1, 2, 1)
        m.set_abc(7, 1, 2, 1)
        m.set_abc(8, 1, 2, 1)
        m.set_abc(9, 1, 2, 1)

        m.set_a(9, 1)
        m.set_b(9, 2)

        result = m.solve([4, 8, 12, 16, 20, 24, 28, 32, 36, 29])

        diff = 0.0000001
        correct_results = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

        result.each_with_index do |x, i|
            x.should be_close(correct_results[i], diff)
        end


    end

    it "should fail domination test on 10x10" do
        m = TridiagonalMatrix.new(10)

        m.set_b(0, 2)
        m.set_c(0, 2)
        m.set_abc(1, 1, 2, 1)
        m.set_abc(2, 1, 2, 1)
        m.set_abc(3, 1, 2, 1)
        m.set_abc(4, 1, 2, 1)
        m.set_abc(5, 1, 2, 1)
        m.set_abc(6, 1, 2, 1)
        m.set_abc(7, 1, 2, 1)
        m.set_abc(8, 1, 2, 1)
        m.set_abc(9, 1, 2, 1)

        # all are a+c = b

        m.set_a(9, 2)
        m.set_b(9, 2)

        lambda { result = m.solve([4, 8, 12, 16, 20, 24, 28, 32, 36, 29])}.should raise_error RuntimeError

    end

end
