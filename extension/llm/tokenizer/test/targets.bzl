load("@fbsource//xplat/executorch/build:runtime_wrapper.bzl", "runtime")

def define_common_targets():
    """Defines targets that should be shared between fbcode and xplat.

    The directory containing this targets.bzl file should also contain both
    TARGETS and BUCK files that call this function.
    """

    test_env = {
        "TEST_BPE_TOKENIZER": "$(location //executorch/extension/llm/tokenizer/test/resources/test_bpe_tokenizer.bin"
        "TEST_TIKTOKEN_INVALID_BASE64": "$(location //executorch/extension/llm/tokenizer/test/resources/test_tiktoken_invalid_base64.model"
        "TEST_TIKTOKEN_INVALID_RANK": "$(location //executorch/extension/llm/tokenizer/test/resources/test_tiktoken_invalid_rank.model"
        "TEST_TIKTOKEN_NO_SPACE": "$(location //executorch/extension/llm/tokenizer/test/resources/test_tiktoken_no_space.model"
        "TEST_TIKTOKEN_TOKENIZER": "$(location //executorch/extension/llm/tokenizer/test/resources/test_tiktoken_tokenizer.model"
    },

    runtime.python_test(
        name = "test_tokenizer_py",
        srcs = [
            "test_tokenizer.py",
        ],
        deps = [
            "//executorch/extension/llm/tokenizer:tokenizer_py_lib",
        ],
    )

    runtime.cxx_test(
        name = "test_bpe_tokenizer",
        srcs = [
            "test_bpe_tokenizer.cpp",
        ],
        deps = [
            "//executorch/extension/llm/tokenizer:bpe_tokenizer",
        ],
        env = test_env,
    )

    runtime.cxx_test(
        name = "test_tiktoken",
        srcs = [
            "test_tiktoken.cpp",
        ],
        deps = [
            "//executorch/extension/llm/tokenizer:tiktoken",
        ],
        env = {
            "RESOURCES_PATH": "$(location :resources)/resources",
        },
        external_deps = [
            "re2",
        ],
    )
