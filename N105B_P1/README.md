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
I. All binary truth functions were solved except A-xor-B and A-iff-B. Figure 2 is plotted by showing each ouput in red, white, or blue from each of the sixteen perceptrons for each of the four possible inputs. The output is red if incorrect, white if zero, and blue if one. Each perceptron can be characterized by its outputs to the four possible inputs, by its weights for each of the two bits, and by the threshold used to decide, as seen in the table below.

|Name|TT/TF/FT/FF|Weights|Trehsold|Actual|
|---|---|---|---|---|
|Never|0000|0 0|2||
|Neither|0001|-1 -1|1||
|B w/o A|0010|-1 1|1||
|Not A|0011|-2 0|0||
|A w/o B|0100|1 -1|1||
|Not B|0101|0 -2|0||
|A xor B|0110|0 0|0|0000|
|Not both|0111|-1 -1|-1||
|Both|1000|1 1|1||
|A iff B|1001|0 0|0|0000|
|B|1010|0 2|0||
|B if A|1011|-1 1|-1||
|A|1100|2 0|0||
|A if B|1101|1 -1|-1||
|A or B|1110|1 1|-1||
|Always|1111|0 0|-2||

II. The operations A IFF B and A XOR B cannot be done by a single perceptron. A network of two perceptrons in Layer 1 could output to a third perceptron in Layer 2. Layer 1 would have a first neuron that fires for A OR B and a second neuron that fires for BOTH A AND B. The perceptron in Layer 2 would fire for 'first' WITHOUT 'second'. A definition for XOR is then created by the two layers as A XOR B := (A OR B) WITHOUT (BOTH A AND B). Also, three perceptrons could set A IFF B := (A NOR B) OR (BOTH A AND B).

### Part III (Third Option)
After teaching 99 samples randomly selected from 100 trials, the network sucessfully identifies the remaining test trial. Figure 3 is produced by multiplying each pixel by its respective weight. The figure thus shows all the values that are typically added up and filtered through the threshold.

### Part IV (Fourth Option)
For all the pixels, The learning curve shows what appears to be exponentially decreasing error in test prediction as the number of trained trials increases from 5 to 90. Twenty samples is enough to give a normalized variance of approximately 1.

### Part IV (Fifth Option)
After training 90% of the trials, the learning curve shows decreasing error in test prediction as the number of pixels trainable increases from 5 to 50. Twenty samples is enough to give a normalized variance of approximately 1. Typically, 10/64 pixels will be enough to predict the remaining 10% of trials with 90% acuracy, but ocasionally 25/64 may even be insufficient.
