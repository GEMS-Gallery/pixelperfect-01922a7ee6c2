import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface Image {
  'id' : bigint,
  'owner' : Principal,
  'data' : Uint8Array | number[],
}
export interface _SERVICE {
  'deleteImage' : ActorMethod<[bigint], boolean>,
  'getImage' : ActorMethod<[bigint], [] | [Image]>,
  'getUserImages' : ActorMethod<[], Array<bigint>>,
  'uploadImage' : ActorMethod<[Uint8Array | number[]], bigint>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
