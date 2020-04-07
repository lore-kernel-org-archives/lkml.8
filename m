Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4D9C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1909212CC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586274700;
	bh=c0jLdhc6GrQbXSJF0eeBS4QF20hY2d4eCb8BGZSYd/M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KiIK8flKPZGClb/GeC9cFhWV5JAZtXtGcPQCmI4W/5Id7Z5gXeu3ERwoAmoZmePvF
	 jz1SA/qRLKnl7si5PLbpVFhOrvFvVHdDTU954fCzD5rc/zrDKevO/nVvu0GtiscZLC
	 OZmlKigeO7TM03YNt2GkQcOzRkRmQKMbcnhjd4vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgDGPvj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:51:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52570 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726637AbgDGPvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:51:39 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-YJR14UtLOt-0-mg4vgE9sw-1; Tue, 07 Apr 2020 11:51:33 -0400
X-MC-Unique: YJR14UtLOt-0-mg4vgE9sw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 029D218AB2C2;
        Tue,  7 Apr 2020 15:51:32 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1A04272A1;
        Tue,  7 Apr 2020 15:51:29 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: [PATCHv3] perf build-ids: Fall back to debuginfod query if debuginfo not found
Date:   Tue,  7 Apr 2020 17:51:28 +0200
Message-Id: <20200407155128.3203040-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Frank Ch. Eigler" <fche@redhat.com>

During a perf-record, use the -ldebuginfod API to query a debuginfod
server, should the debug data not be found in the usual system
locations.  If successful, the usual $HOME/.debug dir is populated.

Tested with:

  $ find .
  .
  ./ctags-debuginfo-5.8-26.fc31.x86_64.rpm
  ./usr
  ./usr/lib
  ./usr/lib/debug
  ./usr/lib/debug/.build-id
  ./usr/lib/debug/.build-id/ca
  ./usr/lib/debug/.build-id/ca/46f6ae6a0cee57d85abc1d461c49074248908d
  ./usr/lib/debug/.build-id/ca/46f6ae6a0cee57d85abc1d461c49074248908d.debug
  ./usr/lib/debug/usr
  ./usr/lib/debug/usr/bin
  ./usr/lib/debug/usr/bin/ctags-5.8-26.fc31.x86_64.debug

  $ debuginfod  -F .
  ...

  $ rm -rf ~/.debug/ ; mkdir ~/.debug

  $ perf record make tags
    BUILD:   Doing 'make -j8' parallel build
    GEN      tags
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.107 MB perf.data (1483 samples) ]

  $ find ~/.debug | grep ctags
  /home/jolsa/.debug/usr/bin/ctags
  /home/jolsa/.debug/usr/bin/ctags/ca46f6ae6a0cee57d85abc1d461c49074248908d
  /home/jolsa/.debug/usr/bin/ctags/ca46f6ae6a0cee57d85abc1d461c49074248908d/elf
  /home/jolsa/.debug/usr/bin/ctags/ca46f6ae6a0cee57d85abc1d461c49074248908d/probes

  $ rm -rf ~/.debug/ ; mkdir ~/.debug

  $ DEBUGINFOD_URLS=http://localhost:8002 perf record make tags
    BUILD:   Doing 'make -j8' parallel build
    GEN      tags
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.108 MB perf.data (1531 samples) ]

  $ find ~/.debug | grep ctag
  /home/jolsa/.debug/usr/bin/ctags
  /home/jolsa/.debug/usr/bin/ctags/ca46f6ae6a0cee57d85abc1d461c49074248908d
  /home/jolsa/.debug/usr/bin/ctags/ca46f6ae6a0cee57d85abc1d461c49074248908d/debug
  /home/jolsa/.debug/usr/bin/ctags/ca46f6ae6a0cee57d85abc1d461c49074248908d/elf
  /home/jolsa/.debug/usr/bin/ctags/ca46f6ae6a0cee57d85abc1d461c49074248908d/probes

Note the 'debug' file is created in the last run.

v3:
    added NO_LIBDEBUGINFOD variable
    moved the libdebuginfod check to FEATURE_TESTS_EXTRA

v2: use #ifdef HAVE_DEBUGINFOD_SUPPORT guards
    include feature test source file

Note that currently the debuginfo data are downloaded only on record path,
we still need add this support to perf build-id/report.. and test ;-)

Tested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Frank Ch. Eigler <fche@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/build/Makefile.feature             |  3 ++-
 tools/build/feature/Makefile             |  4 ++++
 tools/build/feature/test-libdebuginfod.c |  8 ++++++++
 tools/perf/Makefile.config               |  8 ++++++++
 tools/perf/Makefile.perf                 |  2 ++
 tools/perf/util/build-id.c               | 19 +++++++++++++++++++
 6 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 tools/build/feature/test-libdebuginfod.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 3e0c019ef297..8005608a2b78 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -98,7 +98,8 @@ FEATURE_TESTS_EXTRA :=                  \
          llvm                           \
          llvm-version                   \
          clang                          \
-         libbpf
+         libbpf                         \
+         libdebuginfod
 
 FEATURE_TESTS ?= $(FEATURE_TESTS_BASIC)
 
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 621f528f7822..f8a4105bc376 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -26,6 +26,7 @@ FILES=                                          \
          test-libelf-gelf_getnote.bin           \
          test-libelf-getshdrstrndx.bin          \
          test-libelf-mmap.bin                   \
+         test-libdebuginfod.bin                 \
          test-libnuma.bin                       \
          test-numa_num_possible_cpus.bin        \
          test-libperl.bin                       \
@@ -156,6 +157,9 @@ $(OUTPUT)test-libelf-gelf_getnote.bin:
 $(OUTPUT)test-libelf-getshdrstrndx.bin:
 	$(BUILD) -lelf
 
+$(OUTPUT)test-libdebuginfod.bin:
+	$(BUILD) -ldebuginfod
+
 $(OUTPUT)test-libnuma.bin:
 	$(BUILD) -lnuma
 
diff --git a/tools/build/feature/test-libdebuginfod.c b/tools/build/feature/test-libdebuginfod.c
new file mode 100644
index 000000000000..da22548b8413
--- /dev/null
+++ b/tools/build/feature/test-libdebuginfod.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <elfutils/debuginfod.h>
+
+int main(void)
+{
+	debuginfod_client* c = debuginfod_begin();
+	return (long)c;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 12a8204d63c6..5ff7d72688b1 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -480,6 +480,14 @@ ifndef NO_LIBELF
     CFLAGS += -DHAVE_ELF_GETSHDRSTRNDX_SUPPORT
   endif
 
+  ifndef NO_LIBDEBUGINFOD
+    $(call feature_check,libdebuginfod)
+    ifeq ($(feature-libdebuginfod), 1)
+      CFLAGS += -DHAVE_DEBUGINFOD_SUPPORT
+      EXTLIBS += -ldebuginfod
+    endif
+  endif
+
   ifndef NO_DWARF
     ifeq ($(origin PERF_HAVE_DWARF_REGS), undefined)
       msg := $(warning DWARF register mappings have not been defined for architecture $(SRCARCH), DWARF support disabled);
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d15a311408f1..5ccb5c694640 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -118,6 +118,8 @@ include ../scripts/utilities.mak
 #
 # Define LIBBPF_DYNAMIC to enable libbpf dynamic linking.
 #
+# Define NO_LIBDEBUGINFOD if you do not want support debuginfod
+#
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index c076fc7fe025..31207b6e2066 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -31,6 +31,10 @@
 #include "probe-file.h"
 #include "strlist.h"
 
+#ifdef HAVE_DEBUGINFOD_SUPPORT
+#include <elfutils/debuginfod.h>
+#endif
+
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
 
@@ -636,6 +640,21 @@ static char *build_id_cache__find_debug(const char *sbuild_id,
 	if (realname && access(realname, R_OK))
 		zfree(&realname);
 	nsinfo__mountns_exit(&nsc);
+
+#ifdef HAVE_DEBUGINFOD_SUPPORT
+        if (realname == NULL) {
+                debuginfod_client* c = debuginfod_begin();
+                if (c != NULL) {
+                        int fd = debuginfod_find_debuginfo(c,
+                                                           (const unsigned char*)sbuild_id, 0,
+                                                           &realname);
+                        if (fd >= 0)
+                                close(fd); /* retaining reference by realname */
+                        debuginfod_end(c);
+                }
+        }
+#endif
+
 out:
 	free(debugfile);
 	return realname;
-- 
2.25.2

