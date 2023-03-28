# Griffin Benchmarks

This is a very small repository with utility functions for running Griffin performance benchmarks. It follows a similar structure to [11ty's benchmarking strategy](https://www.zachleat.com/web/build-benchmark/)

## Testing a release

To test a release, you can set the `{:griffin_ssg, "~> VERSION"}` in the dependencies inside `mix.exs`, where VERSION is the version you want to test.

#### Testing a local version

If you have a custom or unreleased version you want to test, you can set the `{:griffin_ssg, path: PATH}`, where PATH is a String path to the root of your copy of Griffin.

### Creating source files
This repository doesn't ship with source markdown files, but it has a text file in `priv` from which source files are generated. The generated files have the following structure:

```
---
title: TITLE
---
P1

P2

P3
```

`TITLE` is randomly generated and `P1`, `P2`, `P3` are paragraphs extracted from the text file in `priv`. The file names for the source files will also be randomly generated.

You can generate source files using `mix grf.gen.files`. The following command generates 1000 markdown files in the `src` directory.

```
  mix grf.gen.files --count 1000 --output src
```

### Running Griffin

You can run Griffin using `mix grf.build`, passing in appropriate command line options to change the input directories. The following command runs Griffin with limited console output and sets the input directory to `src`

```
  mix grf.build --input src --quiet
```

#### Cleaning in between runs

It is advised to clean the output directory (`_site` by default) in between runs of Griffin to measure realistic results.

The following command removes all of the pages Griffin generated in `_site`:

```
  rm -rf _site
```

The following command removes the generated source files from the previous steps:

```
  rm -rf src
```

Please ensure that both these directories, `src` and `_site`, do not contain any other files that should not be deleted.

## Results

The tests were ran in a Macbook Pro with an Apple M2 Pro processor and 16GB of system memory using macOS 13.2.1 (22D68). Here are the results:

| # Files | Minimum | Maximum | Mean    | Median | Q1    | Q2     | Q3    |
|---------|---------|---------|---------|--------|-------|--------|-------|
| 250     | 0.2     | 0.79    | 0.484   | 0.5    | 0.42  | 0.5    | 0.55  |
| 500     | 0.31    | 1.06    | 0.557   | 0.405  | 0.33  | 0.405  | 0.805 |
| 1000    | 0.55    | 2.06    | 1.0695  | 0.745  | 0.615 | 0.745  | 1.56  |
| 2000    | 1.1     | 1.83    | 1.332   | 1.325  | 1.2   | 1.325  | 1.415 |
| 4000    | 2.2     | 3.53    | 2.935   | 2.97   | 2.75  | 2.97   | 3.195 |
<!-- | 8000    | 5.22    | 6.22    | 5.589   | 5.365  | 5.325 | 5.365  | 5.985 | -->
<!-- | 16000   | 11.75   | 15.7    | 12.7575 | 12.395 | 12.26 | 12.395 | 12.83 | -->

All values in this table are in seconds.

The values demonstrate that Griffin seems to be *fast enough*. The median runtimes seem comparable to 11ty, as can be seen from this [11ty performance study](https://www.zachleat.com/web/build-benchmark/). 11ty is considered to be the fastest JavaScript static site generator, so these results seem promising.

No changes were made to the source code before or after these tests to improve the performance of Griffin.
