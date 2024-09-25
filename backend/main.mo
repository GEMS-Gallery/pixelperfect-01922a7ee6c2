import Bool "mo:base/Bool";
import Principal "mo:base/Principal";

import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Buffer "mo:base/Buffer";

actor PhotoEditor {
  type Image = {
    id: Nat;
    data: Blob;
    owner: Principal;
  };

  stable var imageId: Nat = 0;
  let images = Buffer.Buffer<Image>(0);

  public shared(msg) func uploadImage(imageData: Blob) : async Nat {
    let id = imageId;
    imageId += 1;
    let newImage: Image = {
      id = id;
      data = imageData;
      owner = msg.caller;
    };
    images.add(newImage);
    id
  };

  public shared query(msg) func getImage(id: Nat) : async ?Image {
    let foundImage = images.getOpt(id);
    switch (foundImage) {
      case (null) { null };
      case (?img) {
        if (img.owner == msg.caller) {
          ?img
        } else {
          null
        }
      };
    }
  };

  public shared query(msg) func getUserImages() : async [Nat] {
    let userImages = Buffer.Buffer<Nat>(0);
    for (image in images.vals()) {
      if (image.owner == msg.caller) {
        userImages.add(image.id);
      }
    };
    Buffer.toArray(userImages)
  };

  public shared(msg) func deleteImage(id: Nat) : async Bool {
    var index : Nat = 0;
    var found : Bool = false;
    while (index < images.size() and not found) {
      let image = images.get(index);
      if (image.id == id) {
        found := true;
      } else {
        index += 1;
      };
    };
    if (found) {
      let image = images.get(index);
      if (image.owner == msg.caller) {
        ignore images.remove(index);
        true
      } else {
        false
      }
    } else {
      false
    }
  };
}
