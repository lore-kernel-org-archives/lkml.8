Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520E7C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 340B3206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgD0GQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 02:16:27 -0400
Received: from foss.arm.com ([217.140.110.172]:57012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgD0GQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 02:16:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52B6931B;
        Sun, 26 Apr 2020 23:16:26 -0700 (PDT)
Received: from nicgas01-03-arm-vm.shanghai.arm.com (nicgas01-03-arm-vm.shanghai.arm.com [10.169.139.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8DFE3F73D;
        Sun, 26 Apr 2020 23:16:23 -0700 (PDT)
From:   Nick Gasson <nick.gasson@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Nick Gasson <nick.gasson@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] perf jvmti: Fix demangling Java symbols
Date:   Mon, 27 Apr 2020 14:15:16 +0800
Message-Id: <20200427061520.24905-4-nick.gasson@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200427061520.24905-1-nick.gasson@arm.com>
References: <20200427061520.24905-1-nick.gasson@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a Java method signature like:

    Ljava/lang/AbstractStringBuilder;appendChars(Ljava/lang/String;II)V

The demangler produces:

    void class java.lang.AbstractStringBuilder.appendChars(class java.lang., shorttring., int, int)

The arguments should be (java.lang.String, int, int) but the demangler
interprets the "S" in String as the type code for "short". Correct this
and two other minor things:

- There is no "bool" type in Java, should be "boolean".

- The demangler prepends "class" to every Java class name. This is not
  standard Java syntax and it wastes a lot of horizontal space if the
  signature is long. Remove this as there isn't any ambiguity between
  class names and primitives.

Also added a test case.

Signed-off-by: Nick Gasson <nick.gasson@arm.com>
---
 tools/perf/tests/Build                |  1 +
 tools/perf/tests/builtin-test.c       |  4 +++
 tools/perf/tests/demangle-java-test.c | 42 +++++++++++++++++++++++++++
 tools/perf/tests/tests.h              |  1 +
 tools/perf/util/demangle-java.c       | 13 +++++----
 5 files changed, 55 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/tests/demangle-java-test.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 1692529639b0..2c45ac4a9581 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -55,6 +55,7 @@ perf-y += mem2node.o
 perf-y += maps.o
 perf-y += time-utils-test.o
 perf-y += genelf.o
+perf-y += demangle-java-test.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 54d9516c9839..03b362b37f97 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -309,6 +309,10 @@ static struct test generic_tests[] = {
 		.desc = "maps__merge_in",
 		.func = test__maps__merge_in,
 	},
+	{
+		.desc = "Demangle Java",
+		.func = test__demangle_java,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/tests/demangle-java-test.c b/tools/perf/tests/demangle-java-test.c
new file mode 100644
index 000000000000..8f3b90832fb0
--- /dev/null
+++ b/tools/perf/tests/demangle-java-test.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include "tests.h"
+#include "session.h"
+#include "debug.h"
+#include "demangle-java.h"
+
+int test__demangle_java(struct test *test __maybe_unused, int subtest __maybe_unused)
+{
+	int ret = TEST_OK;
+	char *buf = NULL;
+	size_t i;
+
+	struct {
+		const char *mangled, *demangled;
+	} test_cases[] = {
+		{ "Ljava/lang/StringLatin1;equals([B[B)Z",
+		  "boolean java.lang.StringLatin1.equals(byte[], byte[])" },
+		{ "Ljava/util/zip/ZipUtils;CENSIZ([BI)J",
+		  "long java.util.zip.ZipUtils.CENSIZ(byte[], int)" },
+		{ "Ljava/util/regex/Pattern$BmpCharProperty;match(Ljava/util/regex/Matcher;ILjava/lang/CharSequence;)Z",
+		  "boolean java.util.regex.Pattern$BmpCharProperty.match(java.util.regex.Matcher, int, java.lang.CharSequence)" },
+		{ "Ljava/lang/AbstractStringBuilder;appendChars(Ljava/lang/String;II)V",
+		  "void java.lang.AbstractStringBuilder.appendChars(java.lang.String, int, int)" },
+		{ "Ljava/lang/Object;<init>()V",
+		  "void java.lang.Object<init>()" },
+	};
+
+	for (i = 0; i < sizeof(test_cases) / sizeof(test_cases[0]); i++) {
+		buf = java_demangle_sym(test_cases[i].mangled, 0);
+		if (strcmp(buf, test_cases[i].demangled)) {
+			pr_debug("FAILED: %s: %s != %s\n", test_cases[i].mangled,
+				 buf, test_cases[i].demangled);
+			ret = TEST_FAIL;
+		}
+		free(buf);
+	}
+
+	return ret;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 9a160fef47c9..49b791d978f6 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -111,6 +111,7 @@ int test__mem2node(struct test *t, int subtest);
 int test__maps__merge_in(struct test *t, int subtest);
 int test__time_utils(struct test *t, int subtest);
 int test__jit_write_elf(struct test *test, int subtest);
+int test__demangle_java(struct test *test, int subtest);
 
 bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
diff --git a/tools/perf/util/demangle-java.c b/tools/perf/util/demangle-java.c
index 6fb7f34c0814..39c05200ed65 100644
--- a/tools/perf/util/demangle-java.c
+++ b/tools/perf/util/demangle-java.c
@@ -15,7 +15,7 @@ enum {
 	MODE_CLASS  = 1,
 	MODE_FUNC   = 2,
 	MODE_TYPE   = 3,
-	MODE_CTYPE  = 3, /* class arg */
+	MODE_CTYPE  = 4, /* class arg */
 };
 
 #define BASE_ENT(c, n)	[c - 'A']=n
@@ -27,7 +27,7 @@ static const char *base_types['Z' - 'A' + 1] = {
 	BASE_ENT('I', "int" ),
 	BASE_ENT('J', "long" ),
 	BASE_ENT('S', "short" ),
-	BASE_ENT('Z', "bool" ),
+	BASE_ENT('Z', "boolean" ),
 };
 
 /*
@@ -59,15 +59,16 @@ __demangle_java_sym(const char *str, const char *end, char *buf, int maxlen, int
 
 		switch (*q) {
 		case 'L':
-			if (mode == MODE_PREFIX || mode == MODE_CTYPE) {
-				if (mode == MODE_CTYPE) {
+			if (mode == MODE_PREFIX || mode == MODE_TYPE) {
+				if (mode == MODE_TYPE) {
 					if (narg)
 						rlen += scnprintf(buf + rlen, maxlen - rlen, ", ");
 					narg++;
 				}
-				rlen += scnprintf(buf + rlen, maxlen - rlen, "class ");
 				if (mode == MODE_PREFIX)
 					mode = MODE_CLASS;
+				else
+					mode = MODE_CTYPE;
 			} else
 				buf[rlen++] = *q;
 			break;
@@ -120,7 +121,7 @@ __demangle_java_sym(const char *str, const char *end, char *buf, int maxlen, int
 			if (mode != MODE_CLASS && mode != MODE_CTYPE)
 				goto error;
 			/* safe because at least one other char to process */
-			if (isalpha(*(q + 1)))
+			if (isalpha(*(q + 1)) && mode == MODE_CLASS)
 				rlen += scnprintf(buf + rlen, maxlen - rlen, ".");
 			if (mode == MODE_CLASS)
 				mode = MODE_FUNC;
-- 
2.26.1

