funcDevide(var par1, var par2){

  try{
    if(par2 == null){
      throw IntegerDivisionByZeroException();
    }else{
      return par1 ~/ par2;
    }
  }catch (e){
    print('>> IntegerDivisionByZeroException');
    rethrow;
  }finally{
    print('::complete...');
  }
  
}

