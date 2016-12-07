function [ rotatedInterface,rotatedSegments,rotatedVoxelLabels ] = rotateInterface( imSiz,numIm,interfaceIndices,raw,segments,view,voxelLabels )
%ROTATECONTACT Returns video centered on rotated interface.

startPos = calculateStartPos(segments, interfaceIndices);
%label interface surface to identify it after rotation
segments(interfaceIndices) = intmax('uint16');

switch view
    case 'interface-rotated'
        [e_1,e_2,interfaceSurfaceNormal] = calculateReferenceCoordinateSystem(interfaceIndices,raw, startPos);
        [rotatedInterface, rotatedSegments,rotatedVoxelLabels] = arbitraryReslice(raw, interfaceSurfaceNormal, e_2, e_1, startPos, segments,voxelLabels);
    case 'interface-xy'
        %no rotation at all
        rotatedInterface = raw(startPos(1) - imSiz(1)/2:startPos(1) + imSiz(1)/2, ... 
            startPos(2) - imSiz(2)/2:startPos(2) + imSiz(2)/2, ...
            startPos(3) - numIm/2:startPos(3) + numIm/2);
        rotatedSegments = segments(startPos(1) - imSiz(1)/2:startPos(1) + imSiz(1)/2, ... 
            startPos(2) - imSiz(2)/2:startPos(2) + imSiz(2)/2, ...
            startPos(3) - numIm/2:startPos(3) + numIm/2);
        rotatedVoxelLabels = voxelLabels(startPos(1) - imSiz(1)/2:startPos(1) + imSiz(1)/2, ... 
            startPos(2) - imSiz(2)/2:startPos(2) + imSiz(2)/2, ...
            startPos(3) - numIm/2:startPos(3) + numIm/2);
    case 'interface-xz'
        rotatedInterface = raw(startPos(1) - imSiz(1)/2:startPos(1) + imSiz(1)/2, ... 
            startPos(2) - numIm:startPos(2) + numIm, ...
            startPos(3) - imSiz(2)/4:startPos(3) + imSiz(2)/4);
        rotatedSegments = segments(startPos(1) - imSiz(1)/2:startPos(1) + imSiz(1)/2, ... 
            startPos(2) - numIm:startPos(2) + numIm, ...
            startPos(3) - imSiz(2)/4:startPos(3) + imSiz(2)/4);
        rotatedVoxelLabels = voxelLabels(startPos(1) - imSiz(1)/2:startPos(1) + imSiz(1)/2, ... 
            startPos(2) - numIm:startPos(2) + numIm, ...
            startPos(3) - imSiz(2)/4:startPos(3) + imSiz(2)/4);
        rotatedInterface = permute(rotatedInterface,[1 3 2]);
        rotatedSegments = permute(rotatedSegments,[1 3 2]);
        rotatedVoxelLabels = permute(rotatedVoxelLabels,[1 3 2]);
    case 'interface-yz'
%         [rotatedInterface,rotatedSegments] = arbitraryReslice(raw,[0,1,0],[0,0,1],[1,0,0],startPos,segments);
        rotatedInterface = raw(startPos(1) - numIm:startPos(1) + numIm, ... 
            startPos(2) - imSiz(1)/2:startPos(2) + imSiz(1)/2, ...
            startPos(3) - imSiz(2)/4:startPos(3) + imSiz(2)/4);
        rotatedSegments = segments(startPos(1) - numIm:startPos(1) + numIm, ... 
            startPos(2) - imSiz(1)/2:startPos(2) + imSiz(1)/2, ...
            startPos(3) - imSiz(2)/4:startPos(3) + imSiz(2)/4);
        rotatedVoxelLabels = voxelLabels(startPos(1) - numIm:startPos(1) + numIm, ... 
            startPos(2) - imSiz(1)/2:startPos(2) + imSiz(1)/2, ...
            startPos(3) - imSiz(2)/4:startPos(3) + imSiz(2)/4);
        rotatedInterface = permute(rotatedInterface,[2 3 1]);
        rotatedSegments = permute(rotatedSegments,[2 3 1]);
        rotatedVoxelLabels = permute(rotatedVoxelLabels,[2 3 1]);
end


end

