use std::fs::{read_dir, File};
use std::io::prelude::*;
use base64::prelude::*;

fn main() {
  let directory = read_dir("frames").unwrap();
  let mut frames_txt = File::create("frames_base64.txt").unwrap();

  for entry in directory {
    let entry = entry.unwrap();
    if entry.metadata().unwrap().is_file() {
      let mut file = File::open(entry.path()).unwrap();
      let mut data: Vec<u8> = Vec::new();
      file.read_to_end(&mut data).unwrap();
      frames_txt.write_all(format!("data:image/png;base64,{}\n", BASE64_STANDARD.encode(data)).as_bytes()).unwrap();
    }
  }
}
