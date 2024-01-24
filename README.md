
# Test Video

## Data set test results of 2 thousand sizes
https://github.com/hakankorhasan/H2o-optimizer-task/assets/75501687/0e2a7ff0-ec1e-437f-acc3-0df453823962

## Test results for a data set of 1 million size
https://github.com/hakankorhasan/H2o-optimizer-task/assets/75501687/ed143d1f-e6cb-4bf1-8b66-ac1b97e70bfb
## 1. Decoding Operation Comparison: Optimized vs. Non-Optimized Model

  ### Decoding Time:
   - In the provided video, decoding operations for the non-optimized model take approximately 6 minutes and 40 seconds. This extended processing time highlights the inefficiency of the non-optimized model, especially when handling substantial amounts of data.
   
## 2. Memory Usage and CPU Consumption:
### Before Optimization: 
 - **Memory Usage:** The non-optimized model significantly consumes memory, reaching up to 2 GB during the decoding process.
 - **CPU Utilization:** CPU usage remains high, peaking at 99%, indicating a resource-intensive operation.
    
### After Optimization: 
 - **Memory Usage:** The optimized model, benefiting from enhancements like asynchronous data processing and memory-efficient date formatting, significantly reduces memory usage.
 - **CPU Utilization:** CPU usage is optimized, providing a more streamlined and resource-efficient decoding operation.
 
 ## 3. Optimization Impact:
 The optimized model's decoding operation, completing in just 8 seconds on the optimized system, showcases remarkable improvements in efficiency and resource utilization.
 
## Extensions and CodingKeys Fixes

  - When it comes to CodingKeys, in this particular case, it's not necessary because the service provides the data with the same key names (`endsAt`). If the keys were different (`e.g., ends_at`), you would need to use CodingKeys for proper serialization.
 
  - Additionally, to optimize the date formatting process, you can create an extension for the Date type. This extension allows you to reuse a single DateFormatter instance, reducing the overhead of creating a new formatter every time.

    ![image](https://github.com/hakankorhasan/H2o-optimizer-task/assets/75501687/499fe988-af11-450e-b9eb-f34a22d10236)
    
    - By using this extension, you can create a `DateFormatter` instance once and pass it as a parameter wherever needed, avoiding unnecessary formatter creation for each date operation. This optimization can significantly reduce the performance cost associated with date formatting.
    
    
## Why Did We Use Generic Types for Encoder and Decoder in Our Model?
 - We chose to use generic types for our encoder and decoder to boost flexibility and minimize redundancy. This approach simplifies our codebase, making it adaptable to diverse data models without the need for model-specific implementations. By embracing generics, we align with Swift's principles, ensuring a concise and maintainable solution. This choice not only enhances scalability but also promotes a cleaner, more efficient code structure. Additionally, generics streamline date formatting within the decoding process, contributing to consistent and error-resistant code.
 
 
 ## Asynchronous Data Processing (Big Data)

To improve the performance of data processing, an asynchronous approach is implemented using GCD (Grand Central Dispatch). The `processMeasurementsAsynchronously` function demonstrates how to efficiently encode and decode a large dataset of `PKMeasurementOptimize` instances. (Millions of dataset...)

### Key Features:

1. **Concurrent Processing:** Utilizes a concurrent dispatch queue (`com.example.processQueue`) for parallelizing tasks and improving efficiency.

2. **Dispatch Group:** Uses a dispatch group to track the completion of asynchronous tasks, ensuring the `notify` block is only executed when all tasks are finished.

3. **Performance Measurement:** Records the start and end times to calculate the elapsed time for data processing.


# Comparison of two structures (`PKMeasurementOptimize` vs. `PKMeasurement`)

## Usage of Swift's Codable Protocol:

 - PKMeasurementOptimize: The `PKMeasurementOptimize` structure effectively utilizes Swift's Codable protocol. This automates JSON encoding and decoding processes, handling data models without requiring custom operations from the developer.
 - PKMeasurement: The `PKMeasurement` structure manually implements the `Encodable` and `Decodable` protocols. Handling date fields manually and adding custom code may be necessary.
 
## Data Fields: 
  
 - PKMeasurementOptimize: The `PKMeasurementOptimize` structure automatically handles date fields, eliminating complexity related to date transformations.
 - PKMeasurement: The `PKMeasurement` structure needs to manually convert and parse date fields to and from String, introducing additional complexity and potential sources of errors.
  
## Code Readability:
   
 - KMeasurementOptimize: The `PKMeasurementOptimize` structure provides the same functionality with less code. A simpler CodingKeys enum and automatic date handling contribute to more readable and concise code.
 - PKMeasurement: The `PKMeasurement` structure may require more code and manual processing, potentially leading to more complex code.
   
## Force Unwrapping:
    
 - PKMeasurementOptimize: The `PKMeasurementOptimize` structure minimizes the use of forced unwrapping (`as!`) and promotes safer coding practices.
 - PKMeasurement: The `PKMeasurement` structure might include forced unwrapping, which could reduce the reliability of the application.
 
## Performance and Optimization:
 
  - PKMeasurementOptimize: Manages automatic JSON encoding and decoding using the Codable protocol, often resulting in faster and optimized performance.
  - KMeasurement: Manually implementing encode and decode processes can lead to performance issues, especially when working with large datasets.

## General Design and API Conformance
  
 - PKMeasurementOptimize: Provides greater compliance with `Swift API Design Guidelines`. Effective use of Codable allows for a clearer and more comprehensive `API design`.
 - KMeasurement: Manually implemented encode and decode processes may increase the complexity of API design and require developers to focus on more details.
 
## Error Handling:

 - PKMeasurementOptimize: Codable operations are generally safer and provide automatic error handling.
 - PKMeasurement: Manual operations may require explicit error handling, making the code more sensitive and error-prone.



