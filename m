Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F59C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A2520752
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgDDInY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:43:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41731 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgDDImP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:15 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNU-0001Dp-2E; Sat, 04 Apr 2020 10:42:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 091611C04DF;
        Sat,  4 Apr 2020 10:41:58 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:57 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf tools: Unify a bit the build directory output
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200318204522.1200981-1-jolsa@kernel.org>
References: <20200318204522.1200981-1-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <158598971761.28353.13721723958021809450.tip-bot2@tip-bot2>
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

Commit-ID:     7cd053d4cf8a3dc1a06bdb4be0ed9b0ecbaa21f5
Gitweb:        https://git.kernel.org/tip/7cd053d4cf8a3dc1a06bdb4be0ed9b0ecbaa21f5
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Wed, 18 Mar 2020 21:45:22 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 24 Mar 2020 10:35:58 -03:00

perf tools: Unify a bit the build directory output

Removing the extra 'SUBDIR' line from clean and doc build output.
Because it's annoying.. ;-)

Before:

  $ make clean
  ...
  SUBDIR   Documentation
  CLEAN    Documentation

After:

  $ make clean
  ...
  CLEAN    Documentation

Before:

  $ make doc
  BUILD:   Doing 'make -j8' parallel build
  SUBDIR   Documentation
  ASCIIDOC perf-stat.html
  ...

After:

  $ make doc
  BUILD:   Doing 'make -j8' parallel build
  ASCIIDOC perf-stat.html
  ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200318204522.1200981-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 3eda9d4..a02aca9 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -231,6 +231,7 @@ TRACE_EVENT_DIR = $(srctree)/tools/lib/traceevent/
 BPF_DIR         = $(srctree)/tools/lib/bpf/
 SUBCMD_DIR      = $(srctree)/tools/lib/subcmd/
 LIBPERF_DIR     = $(srctree)/tools/lib/perf/
+DOC_DIR         = $(srctree)/tools/perf/Documentation/
 
 # Set FEATURE_TESTS to 'all' so all possible feature checkers are executed.
 # Without this setting the output feature dump file misses some features, for
@@ -792,7 +793,6 @@ $(LIBSUBCMD): FORCE
 	$(Q)$(MAKE) -C $(SUBCMD_DIR) O=$(OUTPUT) $(OUTPUT)libsubcmd.a
 
 $(LIBSUBCMD)-clean:
-	$(call QUIET_CLEAN, libsubcmd)
 	$(Q)$(MAKE) -C $(SUBCMD_DIR) O=$(OUTPUT) clean
 
 help:
@@ -832,7 +832,7 @@ INSTALL_DOC_TARGETS += quick-install-doc quick-install-man quick-install-html
 
 # 'make doc' should call 'make -C Documentation all'
 $(DOC_TARGETS):
-	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) $(@:doc=all)
+	$(Q)$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) $(@:doc=all)
 
 TAG_FOLDERS= . ../lib ../include
 TAG_FILES= ../../include/uapi/linux/perf_event.h
@@ -959,7 +959,7 @@ install-python_ext:
 
 # 'make install-doc' should call 'make -C Documentation install'
 $(INSTALL_DOC_TARGETS):
-	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) $(@:-doc=)
+	$(Q)$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) $(@:-doc=)
 
 ### Cleaning rules
 
@@ -1008,7 +1008,8 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(rename_flags_array) \
 		$(OUTPUT)$(arch_errno_name_array) \
 		$(OUTPUT)$(sync_file_range_arrays)
-	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
+	$(call QUIET_CLEAN, Documentation) \
+	$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) clean >/dev/null
 
 #
 # To provide FEATURE-DUMP into $(FEATURE_DUMP_COPY)
