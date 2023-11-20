function y_reverb = reverb(y, Fs, decay)
    % Fonction pour ajouter de la réverbération au signal audio y
    % y : signal audio d'entrée
    % Fs : fréquence d'échantillonnage du signal

    % Calcul du délai pour l'écho en fonction de la fréquence d'échantillonnage
    delay = round(0.5 * Fs);

    % Création de l'écho
    echo = zeros(size(y));
    echo(delay+1:end) = y(1:end-delay) * decay;

    % Ajout de l'écho au signal d'origine pour obtenir le signal avec réverbération
    y_reverb = y + echo;
end