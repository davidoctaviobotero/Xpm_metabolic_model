for r=1:length(Xam.rxns)
    XamParsedRules{r} = parseGPR(XamPreParsedRules{r}, Xam.genes)
end