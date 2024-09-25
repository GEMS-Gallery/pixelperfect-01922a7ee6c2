export const idlFactory = ({ IDL }) => {
  const Image = IDL.Record({ 'id' : IDL.Nat, 'data' : IDL.Vec(IDL.Nat8) });
  return IDL.Service({
    'adjustImage' : IDL.Func([IDL.Nat, IDL.Int, IDL.Int], [IDL.Opt(Image)], []),
    'getImage' : IDL.Func([IDL.Nat], [IDL.Opt(Image)], ['query']),
    'uploadImage' : IDL.Func([IDL.Vec(IDL.Nat8)], [IDL.Nat], []),
  });
};
export const init = ({ IDL }) => { return []; };
