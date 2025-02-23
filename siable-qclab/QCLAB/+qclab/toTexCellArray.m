%> @file toTexCellArray.m
%> @brief saves a cell array containing a graphic for a quantum object to 
%> compilable TeX file.
% ==============================================================================
%
%> @param fid  file id to write to
%> @param cellArray cell array containing the TeX graphic for the quantum object
%> @param qubits array containing (ascending) qubit indices of quantum objects,
%>        length(qubits) should be equal to size(cellArray,1)
%
% (C) Copyright Daan Camps 2021.  
% ==============================================================================
function toTexCellArray( fid, cellArray, qubits )

% write TeX header
fprintf(fid, '%% TeX QCircuit generated by QCLAB\n') ;
fprintf(fid, '%% (c) Copyright Daan Camps 2021\n') ;
fprintf(fid, '\\documentclass[border=2cm]{standalone}\n') ;
fprintf(fid, '\\usepackage[braket]{qcircuit}\n') ;
fprintf(fid, '\\usepackage{environ}\n') ;
fprintf(fid, ['\\newcommand{\\myqctmp}[2][0.25]{\\Qcircuit', ...
              ' @C=#2em @R=#1em @!R}\n']) ;
fprintf(fid, ['\\NewEnviron{myqcircuit}[1][0.25]{\\vcenter{', ...
              '\\myqctmp[#1]{0.5} {\\BODY}}}\n']) ;
fprintf(fid, '\\begin{document}\n') ;
fprintf(fid, '\n') ;
fprintf(fid, '$\n\\begin{myqcircuit}\n') ;

% write TeX body
[ rows, ~ ] = size( cellArray ) ;
assert( rows == length(qubits) ) ;

for i = 1:rows
  % add qubit label
  fprintf(fid, ['\\lstick{q_{', num2str(qubits(i)), '}}\t']) ;
  
  % add body of line
  fprintf( fid, cellArray{i} );
  
  % add end of line
  fprintf(fid, '&\t\\qw\t\\\\\n') ;
end

% write TeX footer
fprintf(fid, '\\end{myqcircuit}\n$\n') ;
fprintf(fid, '\n') ;
fprintf(fid, '\\end{document}\n') ;
end