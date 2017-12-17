
derivative_order(coefficients::AbstractDerivativeCoefficients) = coefficients.derivative_order
accuracy_order(coefficients::AbstractDerivativeCoefficients) = coefficients.accuracy_order
Base.eltype(coefficients::AbstractDerivativeCoefficients{T}) where {T} = T
Base.issymmetric(coefficients::AbstractDerivativeCoefficients) = coefficients.symmetric


derivative_order(D::AbstractDerivativeOperator) = derivative_order(D.coefficients)
accuracy_order(D::AbstractDerivativeOperator) = accuracy_order(D.coefficients)
Base.eltype(D::AbstractDerivativeOperator{T}) where {T} = T
Base.issymmetric(D::AbstractDerivativeOperator) = issymmetric(D.coefficients)
Base.size(D::AbstractDerivativeOperator) = (length(D.grid), length(D.grid))
function Base.size(D::AbstractDerivativeOperator, i::Int)
    if i <= 0
        error("arraysize: dimension out of range")
    elseif i <= 2
        length(D.grid)
    else
        1
    end
end

function Base.full(D::AbstractDerivativeOperator{T}) where {T}
    v = zeros(T, size(D, 2))
    A = zeros(T, size(D)...)
    for i in 1:size(D,2)
        v .= zero(T)
        v[i] = one(T)
        A_mul_B!(view(A,:,i), D, v)
    end
    A
end