Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7FCC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 06:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8972166E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 06:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JPP+/1Nb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgDKGmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 02:42:54 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:37891 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgDKGmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 02:42:53 -0400
Received: by mail-pg1-f201.google.com with SMTP id s2so3399132pge.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 23:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=o8T35mmti0j311rGuSNvHnZQ8QtPYAc25M9quxv+fJA=;
        b=JPP+/1NbTUnmItcEPQyI7EpBmgc0MWsc4Q1Y3gxazab4e5bAa/u2Q+6PfSzOHhwiG5
         LTDO3GtNm2n1FeWnGZX1OkmwQR1NHQgvVc1OYA5bP9GLvkKR5JkZZzxn/CeyuxizXxZE
         HgReeqg8eP13680y84t3rATLq3MMXfT4eMOl1pDhpsxtfvILJzZDQ6Rlv8UyqGhhXV4R
         A194SxuxsZjGWrBckNT0KtjLktMxBZ/jYqO5CDSsCDMCWaEJ1hUbD1nHFdzqyCDRQas/
         BlAMkUYSsgWVh58xwg/1U5g7UmLklBuaP7X0WvjTTSK0YmEMR6BvMYhzv/7BcWjvf/B0
         B4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=o8T35mmti0j311rGuSNvHnZQ8QtPYAc25M9quxv+fJA=;
        b=TTIMR2l6GFea0RtbbYpQKNIf+fbGCZIp1QLv8gMnujoCn3s7s/dyU9WVPtfU37FdcS
         CZwOqfM0FWAK+YIsJhpgMzYMDHUyQGGZXZ328gpATi+ajovNI107rwQFwkG4725BCAFH
         KTb9fenJFW8eVv7mDcqcRmWgoLezSeHdKsBysLahcszPbn2d8DrEpti/JukXcDOFYsRZ
         gI+Ab1HiVyXVsipklYEsGmJtDKmKcjfVRKsH4oky6Ng7tyk2l9gjDnjzT8RCnuxPDkCx
         0QdaDygk9fk5+EXqZeO9i2zSlacsXi+mp6O/VSoNnNGosv1C5Apv0rb3j4TOJtVpanJE
         1SRw==
X-Gm-Message-State: AGi0PuY5oOomOdhYSGT7cEk+wlEwT96FQxPJqMnCdQt7C54RNRd9pSlH
        9iB2DKIDLIwi0YCU2DUA/2s8nqTi8dZQ
X-Google-Smtp-Source: APiQypKt9SivSPJ4ItT7y7Wym6wU8rYjxNS7C0OpgtuTEX7pKynH/GhE5BreqHTtd5ZiyUVt0zdfIrB5HlB8
X-Received: by 2002:a17:90b:3645:: with SMTP id nh5mr4066199pjb.104.1586587372186;
 Fri, 10 Apr 2020 23:42:52 -0700 (PDT)
Date:   Fri, 10 Apr 2020 23:42:47 -0700
Message-Id: <20200411064248.247530-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v4 1/2] tools api: add a lightweight buffered reading api
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The synthesize benchmark shows the majority of execution time going to
fgets and sscanf, necessary to parse /proc/pid/maps. Add a new buffered
reading library that will be used to replace these calls in a follow-up
CL. Add tests for the library to perf test.

v4 adds the test file missed in v3.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/io.h              | 112 ++++++++++++
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/api-io.c       | 304 ++++++++++++++++++++++++++++++++
 tools/perf/tests/builtin-test.c |   4 +
 tools/perf/tests/tests.h        |   1 +
 5 files changed, 422 insertions(+)
 create mode 100644 tools/lib/api/io.h
 create mode 100644 tools/perf/tests/api-io.c

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
new file mode 100644
index 000000000000..b7e55b5f8a4a
--- /dev/null
+++ b/tools/lib/api/io.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Lightweight buffered reading library.
+ *
+ * Copyright 2019 Google LLC.
+ */
+#ifndef __API_IO__
+#define __API_IO__
+
+struct io {
+	/* File descriptor being read/ */
+	int fd;
+	/* Size of the read buffer. */
+	unsigned int buf_len;
+	/* Pointer to storage for buffering read. */
+	char *buf;
+	/* End of the storage. */
+	char *end;
+	/* Currently accessed data pointer. */
+	char *data;
+	/* Set true on when the end of file on read error. */
+	bool eof;
+};
+
+static inline void io__init(struct io *io, int fd,
+			    char *buf, unsigned int buf_len)
+{
+	io->fd = fd;
+	io->buf_len = buf_len;
+	io->buf = buf;
+	io->end = buf;
+	io->data = buf;
+	io->eof = false;
+}
+
+/* Reads one character from the "io" file with similar semantics to fgetc. */
+static inline int io__get_char(struct io *io)
+{
+	char *ptr = io->data;
+
+	if (io->eof)
+		return -1;
+
+	if (ptr == io->end) {
+		ssize_t n = read(io->fd, io->buf, io->buf_len);
+
+		if (n <= 0) {
+			io->eof = true;
+			return -1;
+		}
+		ptr = &io->buf[0];
+		io->end = &io->buf[n];
+	}
+	io->data = ptr + 1;
+	return *ptr;
+}
+
+/* Read a hexadecimal value with no 0x prefix into the out argument hex. If the
+ * first character isn't hexadecimal returns -2, io->eof returns -1, otherwise
+ * returns the character after the hexadecimal value which may be -1 for eof.
+ * If the read value is larger than a u64 the high-order bits will be dropped.
+ */
+static inline int io__get_hex(struct io *io, __u64 *hex)
+{
+	bool first_read = true;
+
+	*hex = 0;
+	while (true) {
+		int ch = io__get_char(io);
+
+		if (ch < 0)
+			return ch;
+		if (ch >= '0' && ch <= '9')
+			*hex = (*hex << 4) | (ch - '0');
+		else if (ch >= 'a' && ch <= 'f')
+			*hex = (*hex << 4) | (ch - 'a' + 10);
+		else if (ch >= 'A' && ch <= 'F')
+			*hex = (*hex << 4) | (ch - 'A' + 10);
+		else if (first_read)
+			return -2;
+		else
+			return ch;
+		first_read = false;
+	}
+}
+
+/* Read a positive decimal value with out argument dec. If the first character
+ * isn't a decimal returns -2, io->eof returns -1, otherwise returns the
+ * character after the decimal value which may be -1 for eof. If the read value
+ * is larger than a u64 the high-order bits will be dropped.
+ */
+static inline int io__get_dec(struct io *io, __u64 *dec)
+{
+	bool first_read = true;
+
+	*dec = 0;
+	while (true) {
+		int ch = io__get_char(io);
+
+		if (ch < 0)
+			return ch;
+		if (ch >= '0' && ch <= '9')
+			*dec = (*dec * 10) + ch - '0';
+		else if (first_read)
+			return -2;
+		else
+			return ch;
+		first_read = false;
+	}
+}
+
+#endif /* __API_IO__ */
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index b3d1bf13ca07..c75557aeef0e 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -56,6 +56,7 @@ perf-y += mem2node.o
 perf-y += maps.o
 perf-y += time-utils-test.o
 perf-y += genelf.o
+perf-y += api-io.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/api-io.c b/tools/perf/tests/api-io.c
new file mode 100644
index 000000000000..2ada86ad6084
--- /dev/null
+++ b/tools/perf/tests/api-io.c
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "debug.h"
+#include "tests.h"
+#include <api/io.h>
+#include <linux/kernel.h>
+
+#define TEMPL "/tmp/perf-test-XXXXXX"
+
+#define EXPECT_EQUAL(val, expected)                             \
+do {								\
+	if (val != expected) {					\
+		pr_debug("%s:%d: %d != %d\n",			\
+			__FILE__, __LINE__, val, expected);	\
+		ret = -1;					\
+	}							\
+} while (0)
+
+#define EXPECT_EQUAL64(val, expected)                           \
+do {								\
+	if (val != expected) {					\
+		pr_debug("%s:%d: %lld != %lld\n",		\
+			__FILE__, __LINE__, val, expected);	\
+		ret = -1;					\
+	}							\
+} while (0)
+
+static int make_test_file(char path[PATH_MAX], const char *contents)
+{
+	ssize_t contents_len = strlen(contents);
+	int fd;
+
+	strcpy(path, TEMPL);
+	fd = mkstemp(path);
+	if (fd < 0) {
+		pr_debug("mkstemp failed");
+		return -1;
+	}
+	if (write(fd, contents, contents_len) < contents_len) {
+		pr_debug("short write");
+		close(fd);
+		unlink(path);
+		return -1;
+	}
+	close(fd);
+	return 0;
+}
+
+static int setup_test(char path[PATH_MAX], const char *contents,
+		      size_t buf_size, struct io *io)
+{
+	if (make_test_file(path, contents))
+		return -1;
+
+	io->fd = open(path, O_RDONLY);
+	if (io->fd < 0) {
+		pr_debug("Failed to open '%s'\n", path);
+		unlink(path);
+		return -1;
+	}
+	io->buf = malloc(buf_size);
+	if (io->buf == NULL) {
+		pr_debug("Failed to allocate memory");
+		close(io->fd);
+		unlink(path);
+		return -1;
+	}
+	io__init(io, io->fd, io->buf, buf_size);
+	return 0;
+}
+
+static void cleanup_test(char path[PATH_MAX], struct io *io)
+{
+	free(io->buf);
+	close(io->fd);
+	unlink(path);
+}
+
+static int do_test_get_char(const char *test_string, size_t buf_size)
+{
+	char path[PATH_MAX];
+	struct io io;
+	int ch, ret = 0;
+	size_t i;
+
+	if (setup_test(path, test_string, buf_size, &io))
+		return -1;
+
+	for (i = 0; i < strlen(test_string); i++) {
+		ch = io__get_char(&io);
+
+		EXPECT_EQUAL(ch, test_string[i]);
+		EXPECT_EQUAL(io.eof, false);
+	}
+	ch = io__get_char(&io);
+	EXPECT_EQUAL(ch, -1);
+	EXPECT_EQUAL(io.eof, true);
+
+	cleanup_test(path, &io);
+	return ret;
+}
+
+static int test_get_char(void)
+{
+	int i, ret = 0;
+	size_t j;
+
+	static const char *const test_strings[] = {
+		"12345678abcdef90",
+		"a\nb\nc\nd\n",
+		"\a\b\t\v\f\r",
+	};
+	for (i = 0; i <= 10; i++) {
+		for (j = 0; j < ARRAY_SIZE(test_strings); j++) {
+			if (do_test_get_char(test_strings[j], 1 << i))
+				ret = -1;
+		}
+	}
+	return ret;
+}
+
+static int do_test_get_hex(const char *test_string,
+			__u64 val1, int ch1,
+			__u64 val2, int ch2,
+			__u64 val3, int ch3,
+			bool end_eof)
+{
+	char path[PATH_MAX];
+	struct io io;
+	int ch, ret = 0;
+	__u64 hex;
+
+	if (setup_test(path, test_string, 4, &io))
+		return -1;
+
+	ch = io__get_hex(&io, &hex);
+	EXPECT_EQUAL64(hex, val1);
+	EXPECT_EQUAL(ch, ch1);
+
+	ch = io__get_hex(&io, &hex);
+	EXPECT_EQUAL64(hex, val2);
+	EXPECT_EQUAL(ch, ch2);
+
+	ch = io__get_hex(&io, &hex);
+	EXPECT_EQUAL64(hex, val3);
+	EXPECT_EQUAL(ch, ch3);
+
+	EXPECT_EQUAL(io.eof, end_eof);
+
+	cleanup_test(path, &io);
+	return ret;
+}
+
+static int test_get_hex(void)
+{
+	int ret = 0;
+
+	if (do_test_get_hex("12345678abcdef90",
+				0x12345678abcdef90, -1,
+				0, -1,
+				0, -1,
+				true))
+		ret = -1;
+
+	if (do_test_get_hex("1\n2\n3\n",
+				1, '\n',
+				2, '\n',
+				3, '\n',
+				false))
+		ret = -1;
+
+	if (do_test_get_hex("12345678ABCDEF90;a;b",
+				0x12345678abcdef90, ';',
+				0xa, ';',
+				0xb, -1,
+				true))
+		ret = -1;
+
+	if (do_test_get_hex("0x1x2x",
+				0, 'x',
+				1, 'x',
+				2, 'x',
+				false))
+		ret = -1;
+
+	if (do_test_get_hex("x1x",
+				0, -2,
+				1, 'x',
+				0, -1,
+				true))
+		ret = -1;
+
+	if (do_test_get_hex("10000000000000000000000000000abcdefgh99i",
+				0xabcdef, 'g',
+				0, -2,
+				0x99, 'i',
+				false))
+		ret = -1;
+
+	return ret;
+}
+
+static int do_test_get_dec(const char *test_string,
+			__u64 val1, int ch1,
+			__u64 val2, int ch2,
+			__u64 val3, int ch3,
+			bool end_eof)
+{
+	char path[PATH_MAX];
+	struct io io;
+	int ch, ret = 0;
+	__u64 dec;
+
+	if (setup_test(path, test_string, 4, &io))
+		return -1;
+
+	ch = io__get_dec(&io, &dec);
+	EXPECT_EQUAL64(dec, val1);
+	EXPECT_EQUAL(ch, ch1);
+
+	ch = io__get_dec(&io, &dec);
+	EXPECT_EQUAL64(dec, val2);
+	EXPECT_EQUAL(ch, ch2);
+
+	ch = io__get_dec(&io, &dec);
+	EXPECT_EQUAL64(dec, val3);
+	EXPECT_EQUAL(ch, ch3);
+
+	EXPECT_EQUAL(io.eof, end_eof);
+
+	cleanup_test(path, &io);
+	return ret;
+}
+
+static int test_get_dec(void)
+{
+	int ret = 0;
+
+	if (do_test_get_dec("12345678abcdef90",
+				12345678, 'a',
+				0, -2,
+				0, -2,
+				false))
+		ret = -1;
+
+	if (do_test_get_dec("1\n2\n3\n",
+				1, '\n',
+				2, '\n',
+				3, '\n',
+				false))
+		ret = -1;
+
+	if (do_test_get_dec("12345678;1;2",
+				12345678, ';',
+				1, ';',
+				2, -1,
+				true))
+		ret = -1;
+
+	if (do_test_get_dec("0x1x2x",
+				0, 'x',
+				1, 'x',
+				2, 'x',
+				false))
+		ret = -1;
+
+	if (do_test_get_dec("x1x",
+				0, -2,
+				1, 'x',
+				0, -1,
+				true))
+		ret = -1;
+
+	if (do_test_get_dec("10000000000000000000000000000000000000000000000000000000000123456789ab99c",
+				123456789, 'a',
+				0, -2,
+				99, 'c',
+				false))
+		ret = -1;
+
+	return ret;
+}
+
+int test__api_io(struct test *test __maybe_unused,
+		int subtest __maybe_unused)
+{
+	int ret = 0;
+
+	if (test_get_char())
+		ret = TEST_FAIL;
+	if (test_get_hex())
+		ret = TEST_FAIL;
+	if (test_get_dec())
+		ret = TEST_FAIL;
+	return ret;
+}
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index b6322eb0f423..3471ec52ea11 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -309,6 +309,10 @@ static struct test generic_tests[] = {
 		.desc = "Test jit_write_elf",
 		.func = test__jit_write_elf,
 	},
+	{
+		.desc = "Test api io",
+		.func = test__api_io,
+	},
 	{
 		.desc = "maps__merge_in",
 		.func = test__maps__merge_in,
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 61a1ab032080..d6d4ac34eeb7 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -112,6 +112,7 @@ int test__mem2node(struct test *t, int subtest);
 int test__maps__merge_in(struct test *t, int subtest);
 int test__time_utils(struct test *t, int subtest);
 int test__jit_write_elf(struct test *test, int subtest);
+int test__api_io(struct test *test, int subtest);
 
 bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
-- 
2.26.0.110.g2183baf09c-goog

