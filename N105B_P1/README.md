## Usage
Display all answers:
```
hoff1
```
![all answes](all.png)

### Alternate Usage
Display selected answers using a vector of integers of max index n < 6:
```
...
hoff1(3)
hoff1(2:5)
......
...
```
### Returns
For n options of p<sub>n</sub> perceptrons
```
1x< n > mind
  1x< p > percy
```

### Of lines and half spaces (first option)
1. w = (1,1) and θ = 0 results in f(x) > -x
2. w = (2,1) and θ = 3 results in f(x) > 3 - 2x 

### Learning with perceptrons (second - fifth options)
1. All binary truth functions were solved except A-xor-B and A-iff-B 

|Name|TT/TF/FT/FF|Weights|Trehsold|Actual|
|---|---|---|---|---|
|Never|0000|0 0|2||
|Neither|0001|1 1|1||
|B w/o A|0010|1 -1|1||
|Not A|0011|2 0|0||
|A w/o B|0100|-1 1|1||
|Not B|0101|0 2|0||
|A xor B|0110|0 0|0|0000|
|Not both|0111|1 1|-1||
|Both|1000|-1 -1|1||
|A iff B|1001|0 0|0|0000|
|B|1010|0 -2|0||
|B if A|1011|1 -1|-1||
|A|1100|-2 0|0||
|A if B|1101|-1 1|-1||
|A or B|1110|-1 -1|-1||
|Always|1111|0 0|-2||
2. The operations A IFF B and A XOR B cannot be done by a single perceptron.
A network of two perceptrons in Layer 1 could output to a third perceptron 
in Layer 2. Layer 1 would have a first neuron that fires for A OR B and a 
second neuron that fires for BOTH A AND B. The perceptron in Layer 2 would 
fire for 'first' WITHOUT 'second'. A definition for XOR is then created by
the two layers as A XOR B := (A OR B) WITHOUT (BOTH A AND B).

Also, three perceptrons could set A IFF B := (A NOR B) OR (BOTH A AND B).

