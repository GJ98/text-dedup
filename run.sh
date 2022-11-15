# 1. run minhash
export data_dir="/Users/gj/Documents/study/Polyglot/dedup/data"

python -m polyglot_dedup.minhash \
    --type "json" \
    --data_files "${data_dir}/mc4-id/c4-id.tfrecord-00001-of-01024.json" --split "train" \
    --cache_dir "${data_dir}/cache" \
    --output_dir "${data_dir}/output/minhash" \
    --index_name "lsh.pkl" \
    --graph_name "graph.networkit" \
    --dedup_name "polyglot_dedup" \
    --column "text" \
    --ngram 1 \
    --num_perm 128 \
    --threshold 0.8 \
    --seed 42


# 2. run suffix array

## 2.1. clone submodule
git clone https://github.com/google-research/deduplicate-text-datasets

## 2.2. build cargo
cd ./deduplicate-text-datasets
cargo build
cd ../

## 2.3. run suffix array
python -m polyglot_dedup.suffix_array \
    --type "json" \
    --data_files "${data_dir}/mc4-id/c4-id.tfrecord-00001-of-01024.json" \
    --split "train" \
    --cache_dir "${data_dir}/cache" \
    --output_dir "${data_dir}/output/suffix_array" \
    --index_name "lsh.pkl" \
    --graph_name "graph.networkit" \
    --dedup_name "oscar_gl_dedup" \
    --column "text" \
    --google_repo_path "/Users/gj/Documents/study/Polyglot/dedup/text-dedup/deduplicate-text-datasets"
