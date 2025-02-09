# BCTI

# BCTI   (MATLAB)  

## Introduction  
This project provides the MATLAB script “detect_switch_ave_path_P13K.m”, which reconstructs and visualizes gene regulatory networks at different time periods.  

## Required Toolbox  
This code requires a MATLAB toolbox   SEMLearn  that must be added to the MATLAB path before execution. Failure to do so may result in undefined function errors.  

### Adding the Toolbox to the MATLAB Path  
Before running the script, follow these steps to add the required toolbox:  

1. Extract the toolbox if it is in a compressed format.  
2. In the MATLAB command window, run the following commands to add the toolbox folder to the path:  
   ```matlab
   addpath(genpath('your_toolbox_path'))
   savepath
   ```
   Replace `'your_toolbox_path'` with the actual path of the toolbox directory.  

## Usage  

1. **Load the Data**  
   Before running `detect_switch_ave_path_P13K.m`, ensure that the input data is properly formatted according to the script's requirements.  

2. **Run `detect_switch_ave_path_P13K.m`**  
   Navigate to the directory containing the script and run the code

   The script will reconstruct the gene regulatory network and generate visualizations.  

## Example Output  
After running `detect_switch_ave_path_P13K.m`, the program will generate gene regulatory network graphs for different time periods, displaying their topological structures.  

## Contribution  
If you have any suggestions for improvements or encounter any issues, feel free to submit an issue or a pull request.  



