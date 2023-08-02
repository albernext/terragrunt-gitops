include "root" {
  path = find_in_parent_folders()
}

include "common" {
  path = "${dirname(find_in_parent_folders())}/_common/sample-s3-bucket/sample-s3-bucket.hcl"
}

inputs = {
  bucket = "albernext-sample-230802"
}
