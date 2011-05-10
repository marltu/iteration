require './generic_matrix'

describe GenericMatrix do
    it "should initialize with 2" do
        GenericMatrix.new(2)
    end
    it "should return 0 when no other values are set" do
        m = GenericMatrix.new(2)
        m.get(0, 0).should == 0
        m.get(1, 1).should == 0
    end
    it "should return setted values" do
        m = GenericMatrix.new(5)
        m.set(1, 2, 15)
        m.get(1, 2).should == 15
        m.get(2, 1).should == 0
    end

    it "should set matrix using array" do
        m = GenericMatrix.new([
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9]
        ])

        m.get(1, 1).should == 5

    end

    it "should multiply matrix by scalar value" do
        c = GenericMatrix.new([
            [0.01,   0,    0,    0],
            [0,   0.01,    0,    0],
            [0,      0, 0.01,    0],
            [0,      0,    0, 0.01]
        ])
        k = 7
        m = c * k

        m.get(0, 0).should == 0.07
        m.get(0, 1).should == 0
        m.get(1, 1).should == 0.07
    end


    it "should not modify initial values" do
        c = GenericMatrix.new([
            [0.01,   0,    0,    0],
            [0,   0.01,    0,    0],
            [0,      0, 0.01,    0],
            [0,      0,    0, 0.01]
        ])
        k = 7
        m = c * k

        c.get(0, 0).should == 0.01
        c.get(0, 1).should == 0
        c.get(1, 1).should == 0.01
    end

    it "should add two matrices" do
        a = GenericMatrix.new([
            [1, 2],
            [3, 4]
        ])

        b = GenericMatrix.new([
            [1, 2],
            [3, 4]
        ])

        c = a + b

        c.get(0, 0).should == 2
        c.get(0, 1).should == 4
        c.get(1, 0).should == 6
        c.get(1, 1).should == 8

    end

    it "should multiply by vector" do
        a = GenericMatrix.new([
            [1, 2],
            [3, 4]
        ])

        b = [2,3]

        c = a * b
        c.should == [8, 18]
    end

    it "should be diagonally max for specific matrix" do
        a = GenericMatrix.new([
            [7, 2, 4],
            [2, 7, 4],
            [4, 2, 7]
        ]).diagonally_dominant?.should be_true
    end


    it "should be not diagonally max for specific matrix" do
        a = GenericMatrix.new([
            [7, 2, 4],
            [2, 7, 4],
            [-5, 5, 7]
        ]).diagonally_dominant?.should be_false
    end

    it "should be symmetrical" do
        d = GenericMatrix.new([
            [ 1.342,  0.202, -0.599,  0.432],
            [ 0.202,  1.342,  0.202, -0.599],
            [-0.599,  0.202,  1.342,  0.202],
            [ 0.432, -0.599,  0.202,  1.342] 
        ]).diagonally_dominant?.should be_true
    end
end
