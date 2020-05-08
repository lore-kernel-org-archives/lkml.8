Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D4AC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C28B24969
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbgEHNGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730565AbgEHNFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:45 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD6EC05BD09;
        Fri,  8 May 2020 06:05:44 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2h2-0007sh-1F; Fri, 08 May 2020 15:05:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0D3541C086F;
        Fri,  8 May 2020 15:05:12 +0200 (CEST)
Date:   Fri, 08 May 2020 13:05:11 -0000
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] tools api: Add a lightweight buffered reading api
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200415054050.31645-3-irogers@google.com>
References: <20200415054050.31645-3-irogers@google.com>
MIME-Version: 1.0
Message-ID: <158894311194.8414.5944838962130126295.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e95770af4c4a280fab2080529d30452a7628d45d
Gitweb:        https://git.kernel.org/tip/e95770af4c4a280fab2080529d30452a7628d45d
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Tue, 14 Apr 2020 22:40:49 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 30 Apr 2020 10:48:28 -03:00

tools api: Add a lightweight buffered reading api

The synthesize benchmark shows the majority of execution time going to
fgets and sscanf, necessary to parse /proc/pid/maps. Add a new buffered
reading library that will be used to replace these calls in a follow-up
CL. Add tests for the library to perf test.

Committer tests:

  $ perf test api
  63: Test api io                                           : Ok
  $

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrey Zhizhikin <andrey.z@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200415054050.31645-3-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/io.h              | 112 +++++++++++-
 tools/perf/tests/Build          |   1 +-
 tools/perf/tests/api-io.c       | 304 +++++++++++++++++++++++++++++++-
 tools/perf/tests/builtin-test.c |   4 +-
 tools/perf/tests/tests.h        |   1 +-
 5 files changed, 422 insertions(+)
 create mode 100644 tools/lib/api/io.h
 create mode 100644 tools/perf/tests/api-io.c

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
new file mode 100644
index 0000000..b7e55b5
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
index b3d1bf1..c75557a 100644
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
index 0000000..2ada86a
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
index b6322eb..3471ec5 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -310,6 +310,10 @@ static struct test generic_tests[] = {
 		.func = test__jit_write_elf,
 	},
 	{
+		.desc = "Test api io",
+		.func = test__api_io,
+	},
+	{
 		.desc = "maps__merge_in",
 		.func = test__maps__merge_in,
 	},
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 61a1ab0..d6d4ac3 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -112,6 +112,7 @@ int test__mem2node(struct test *t, int subtest);
 int test__maps__merge_in(struct test *t, int subtest);
 int test__time_utils(struct test *t, int subtest);
 int test__jit_write_elf(struct test *test, int subtest);
+int test__api_io(struct test *test, int subtest);
 
 bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
