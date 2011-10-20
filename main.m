% Conjuntos

%conj_muy_frio=[-1.5 -1 -0.5];
%conj_frio=[-0.75 -0.5 -0.25];
%conj_poco_frio=[-0.5 -0.25 0];
%conj_templado=[-0.25 0 0.25];
%conj_templado_caliente=[-0.15, 0.1, 0.35];
%conj_poco_caliente=[0 0.25 0.5];
%conj_caliente=[0.25 0.5 0.75];
%conj_muy_caliente=[0.5 1 1.5];

conj_muy_frio=[-1.5 -1 -0.7];
conj_frio=[-0.8 -0.5 -0.2];
conj_poco_frio=[-0.55 -0.25 0.05];
conj_templado=[-0.3 0 0.3];
conj_poco_caliente=[-0.05 0.25 0.55];
conj_caliente=[0.2 0.5 0.8];
conj_muy_caliente=[0.7 1 1.5];

conjuntos_entrada = [conj_muy_frio; conj_frio; conj_poco_frio; conj_templado; conj_poco_caliente; conj_caliente; conj_muy_caliente];

nro_conjuntos_e = size(conjuntos_entrada)(1);

conj_calentar_mucho=[-1.5 -1 -0.5];
conj_calentar=[-0.75 -0.5 -0.25];
conj_calentar_poco=[-0.5 -0.25 0];
conj_no_hacer_nada=[-0.25 0 0.25];
conj_enfriar_poco=[0 0.25 0.5];
conj_enfriar=[0.25 0.5 0.75];
conj_enfriar_mucho=[0.5 1 1.5];

conjuntos_salida = [conj_calentar_mucho; conj_calentar; conj_calentar_poco; conj_no_hacer_nada; conj_enfriar_poco; conj_enfriar; conj_enfriar_mucho];

nro_conjuntos_s = size(conjuntos_salida)(1);

% Funciones

% Para generar las reglas
function M = correlation_minimum (x, y)
  M = zeros(length(x), length(y));
  for i = 1 : length(x) for j = 1 : length(y)
      M(i, j) = min(x(i), y(j));
    end
  end
end

% Para usar las reglas
function y = max_min_composition (x, M)
  m = size(M)(1);
  n = size(M)(2);
  y = zeros(1, n);
  for j = 1 : n
    y(j) = min(x(1), M(1, j));
    for i = 2 : m
      y(j) = max(y(j), min(x(i), M(i, j)));
    end
  end
end

% Pertenencia
function p = pertenencia(d, conj) % para triangulos
  if (d < conj(1) || d > conj(3))
    p = 0;
  else
    if (d < conj(2))
      p = (1 / (conj(2)-conj(1))) * abs(d - conj(1));
    else
      p = (1 / (conj(3)-conj(2))) * abs(d - conj(3));
    end
  end
  
end

% Fit vector
function fv = fit_vector(d, ce)
  nce = size(ce)(1);
  fv = zeros(1, nce);
  for i = 1 : nce
    fv(i) = pertenencia(d, ce(i,:));
  end
end

fit_vectors_entrada = zeros(nro_conjuntos_e);
for i = 1 : nro_conjuntos_e
  fit_vectors_entrada(i, :) = fit_vector(conjuntos_entrada(i, 2), conjuntos_entrada);
end

fit_vectors_salida = zeros(nro_conjuntos_s);
for i = 1 : nro_conjuntos_s
  fit_vectors_salida(i, :) = fit_vector(conjuntos_salida(i, 2), conjuntos_salida);
end

% Reglas

si_muy_frio_calentar_mucho = correlation_minimum(fit_vectors_entrada(1, :), fit_vectors_salida(1, :));
si_frio_calentar = correlation_minimum(fit_vectors_entrada(2, :), fit_vectors_salida(2, :));
si_poco_frio_calentar_poco = correlation_minimum(fit_vectors_entrada(3, :), fit_vectors_salida(3, :));
si_templado_no_hacer_nada = correlation_minimum(fit_vectors_entrada(4, :), fit_vectors_salida(4, :));
si_poco_caliente_enfriar_poco = correlation_minimum(fit_vectors_entrada(5, :), fit_vectors_salida(5, :));
si_caliente_enfriar = correlation_minimum(fit_vectors_entrada(6, :), fit_vectors_salida(6, :));
si_muy_caliente_enfriar_mucho = correlation_minimum(fit_vectors_entrada(7, :), fit_vectors_salida(7, :));


