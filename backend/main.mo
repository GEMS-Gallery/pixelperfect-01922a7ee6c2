import Bool "mo:base/Bool";
import Int "mo:base/Int";

import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

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

  public func adjustImage(id: Nat, tone: Int, color: Int) : async ?Image {
    let image = Array.find(images, func (img: Image) : Bool { img.id == id });
    switch (image) {
      case (null) { null };
      case (?img) {
        // In a real implementation, we would process the image data here
        // applying the tone and color adjustments
        // For simplicity, we're just returning the original image
        ?img
      };
    }
  };
}
