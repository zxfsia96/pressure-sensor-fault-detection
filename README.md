# pressure-sensor-fault-detection
﻿# A novel diagnostic method utilizing Trend Features in the Time-Frequency domain (TFTF)
## Multi-Scale Time Series Decomposition
In earlier time series decomposition techniques, Wu and Zeng utilized moving averages to reduce periodic oscillations and emphasize long-term trends[19, 20]. The algorithm for time series $X\in R^{I×q}$is as follows:
$$
\begin{equation}
\begin{aligned}
X_{p(i)} = Padding(X)_{kernel\underline{} p(i)} \\
\end{aligned}
\end{equation} 
$$
$$
\begin{equation}
\begin{aligned}
X_{trend(i)}= Avgpool{(X_{p(i)} ) } _{kernel\underline{}a(i)}\\
\end{aligned}
\end{equation} 
$$
$$
\begin{equation}
\begin{aligned}
X_{periodic(i)}=X-X_{trend(i)}\\
\end{aligned}
\end{equation} 
$$
$$
\begin{equation}
\begin{aligned}
kernel\underline{}a(i)=kernel\underline{}p(i)-1
\end{aligned}
\end{equation} 
$$

Here,  $X_{p(i)}$ represents the time series padded (Padding(∙)) using the different sizes of kernels ($kernel\underline{}p(i)$). The trend component is represented by $X_{trend(i)}\in R^{I×q}$, and the periodic component is represented by $X_(periodic(i))\in R^{I×q}$. Padding(∙) and Avgpool(∙) are to keep the length of the time series unchanged. The purpose of (Avgpool(∙)) is to reduce data dimensionality by calculating the average within a fixed-size window ($kernel\underline{}a(i)$), referred to as the average pooling. However, $kernel\underline{}p(i)$ is determined by $kernel\underline{}a(i)$ and they are artificially predetermined, which can lead to significant variations between the trend and periodic components derived from different kernels. 
The files are data_process_1_cu.ipynb and data_process_1_xi.ipynb.
The auxiliary file is local_global.py.
## Feature Extraction in Time-Frequency Domain
Files are data_process_read_cu.m, data_process_read_xi.m and feature_together.m.

In order to analyze the characteristics of the trend components in the sensor signals, the sliding window algorithm is employed to divide the trend components into appropriately sized segments. Time-domain and frequen-cy-domain features are extracted from each data segment to create a feature da-taset, which provides an information source for the fault detection of the sensing line. 
Through multiple experiments, it was concluded that setting the window size to 2000 and the stride to 1000 achieves a balance between accuracy and feature represen-tation capability. This configuration effectively captures trend information while avoiding excessive redundancy.

## Classfication 
The file is method_together.ipynb.




