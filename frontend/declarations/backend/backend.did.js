export const idlFactory = ({ IDL }) => {
  const Image = IDL.Record({
    'id' : IDL.Nat,
    'owner' : IDL.Principal,
    'data' : IDL.Vec(IDL.Nat8),
  });
  return IDL.Service({
    'deleteImage' : IDL.Func([IDL.Nat], [IDL.Bool], []),
    'getImage' : IDL.Func([IDL.Nat], [IDL.Opt(Image)], ['query']),
    'getUserImages' : IDL.Func([], [IDL.Vec(IDL.Nat)], ['query']),
    'uploadImage' : IDL.Func([IDL.Vec(IDL.Nat8)], [IDL.Nat], []),
  });
};
export const init = ({ IDL }) => { return []; };
