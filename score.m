function [s] = score(nll,free_params,complexityFactor)
    s = complexityFactor*sum(free_params) +sum(nll);%tyy��Ϊ����50
end