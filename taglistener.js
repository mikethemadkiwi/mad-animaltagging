let tagTick = setTick(async() => {
    let AIEvents = GetNumberOfEvents(0)
    if(AIEvents>0){
        let buffer = new ArrayBuffer(256);
        let view = new DataView(buffer);
        for (let eventkey = 0; eventkey < AIEvents; eventkey++) {
            const element = GetEventAtIndex(0, eventkey);
            switch(element){
                case 1553659161:
                    Citizen.invokeNative("0x57EC5FA4D4D6AFCA", 0, eventkey, view, 3, Citizen.returnResultAnyway());
                    let ReviveData = new Int32Array(buffer);
                    emitNet('mad-animatagging:ReviveData', ReviveData[2])
                break;
                default:
                   //nah
            }
        }
    }
})