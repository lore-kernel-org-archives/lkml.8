Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DE4C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8824020737
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgDDIto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:49:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41851 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgDDIto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:49:44 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeUi-0001bq-If; Sat, 04 Apr 2020 10:49:36 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2B87B1C070D;
        Sat,  4 Apr 2020 10:41:48 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:47 -0000
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf tools: Add file-handle feature test
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200402015249.3800462-1-namhyung@kernel.org>
References: <20200402015249.3800462-1-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <158598970782.28353.6782627101086180811.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     49f550ea87c73671ee4d5e08820e0976894dd610
Gitweb:        https://git.kernel.org/tip/49f550ea87c73671ee4d5e08820e0976894dd610
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Thu, 02 Apr 2020 10:52:49 +09:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 03 Apr 2020 09:37:55 -03:00

perf tools: Add file-handle feature test

The file handle (FHANDLE) support is configurable so some systems might not
have it.  So add a config feature item to check it on build time so that we
don't add the cgroup tracking feature based on that.

Committer notes:

Had to make the test use the same construct as its later use in
synthetic-events.c, in the next patch in this series. i.e. make it be:

	struct {
		struct file_handle fh;
		uint64_t cgroup_id;
	} handle;

To cope with:

    CC       /tmp/build/perf/util/cloexec.o
  util/synthetic-events.c:428:22: error: field 'fh' with   CC       /tmp/build/perf/util/call-path.o
  variable sized type 'struct file_handle' not at the end of a struct or class is a GNU
        extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
                  struct file_handle fh;
                                     ^
  1 error generated.

Deal with this at some point, i.e. investigate if the right thing is to
remove that -Wgnu-variable-sized-type-not-at-end from our CFLAGS, for
now do the test the same way as it is used looks more sensible.

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200402015249.3800462-1-namhyung@kernel.org
[ split from a larger patch, removed blank line at EOF ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature           |  3 ++-
 tools/build/feature/Makefile           |  6 +++++-
 tools/build/feature/test-file-handle.c | 17 +++++++++++++++++
 tools/perf/Makefile.config             |  4 ++++
 4 files changed, 28 insertions(+), 2 deletions(-)
 create mode 100644 tools/build/feature/test-file-handle.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 574c2e0..3e0c019 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -72,7 +72,8 @@ FEATURE_TESTS_BASIC :=                  \
         setns				\
         libaio				\
         libzstd				\
-        disassembler-four-args
+        disassembler-four-args		\
+        file-handle
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7ac0d80..621f528 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -67,7 +67,8 @@ FILES=                                          \
          test-llvm.bin				\
          test-llvm-version.bin			\
          test-libaio.bin			\
-         test-libzstd.bin
+         test-libzstd.bin			\
+         test-file-handle.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -321,6 +322,9 @@ $(OUTPUT)test-libaio.bin:
 $(OUTPUT)test-libzstd.bin:
 	$(BUILD) -lzstd
 
+$(OUTPUT)test-file-handle.bin:
+	$(BUILD)
+
 ###############################
 
 clean:
diff --git a/tools/build/feature/test-file-handle.c b/tools/build/feature/test-file-handle.c
new file mode 100644
index 0000000..4d3b03b
--- /dev/null
+++ b/tools/build/feature/test-file-handle.c
@@ -0,0 +1,17 @@
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <inttypes.h>
+
+int main(void)
+{
+	struct {
+		struct file_handle fh;
+		uint64_t cgroup_id;
+	} handle;
+	int mount_id;
+
+	name_to_handle_at(AT_FDCWD, "/", &handle.fh, &mount_id, 0);
+	return 0;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 80e55e7..eb95c0c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -348,6 +348,10 @@ ifeq ($(feature-gettid), 1)
   CFLAGS += -DHAVE_GETTID
 endif
 
+ifeq ($(feature-file-handle), 1)
+  CFLAGS += -DHAVE_FILE_HANDLE
+endif
+
 ifdef NO_LIBELF
   NO_DWARF := 1
   NO_DEMANGLE := 1
