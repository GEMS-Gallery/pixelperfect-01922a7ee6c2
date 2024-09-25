import Array "mo:base/Array";
import Bool "mo:base/Bool";

import Blob "mo:base/Blob";
import Nat "mo:base/Nat";

actor PhotoEditor {
  type Image = {
    id: Nat;
    data: Blob;
  };

  stable var imageId: Nat = 0;
  stable var images: [Image] = [];

  public func uploadImage(imageData: Blob) : async Nat {
    let id = imageId;
    imageId += 1;
    let newImage: Image = {
      id = id;
      data = imageData;
    };
    images := Array.append(images, [newImage]);
    id
  };

  public query func getImage(id: Nat) : async ?Image {
    Array.find(images, func (img: Image) : Bool { img.id == id })
  };
}
