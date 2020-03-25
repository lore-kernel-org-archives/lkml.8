Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E86C54FD3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BA92078E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140160;
	bh=VWGEnA/Uo+vZ025vQwvABvAvEMli9prCsOUG8RLy1Ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gHSaNn3jFvA9I0AsHz4vaTG/de8eZWz02jCABB3O83yb/xAmbiF10kU0XPq+Uguqp
	 yYmK1nIVzkj2kiGUpsaZZfFeyYWw3yN7r0+6Dx4OSt4JviwgWlT9sn1CjWC+IZqsIS
	 1RgJNIv1W3H0SujkEAz+k7Jw1s6v2hQ6OXudEt7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgCYMmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbgCYMme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:42:34 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7145B2078D;
        Wed, 25 Mar 2020 12:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585140153;
        bh=VWGEnA/Uo+vZ025vQwvABvAvEMli9prCsOUG8RLy1Ks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I0wtpg7TmhKaAiCcb8ghyCKJ7lGFNSWKMFBCPUD0jCigFM5fAX2hRjfCwUUC5C8vP
         uw/paXn2kabVQEHnz90+hbcbfgsR54FzbLmmSiZGAvDK9iOtehhMNSEhXXqzqaMBYz
         OfoQ/Pdh2qMkGCI7AZzAKDqTbMC2IMvSvOROg6N4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 15/24] perf tools: Unify a bit the build directory output
Date:   Wed, 25 Mar 2020 09:41:15 -0300
Message-Id: <20200325124124.32648-16-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
 tools/perf/Makefile.perf | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 3eda9d4b88e7..a02aca9b21f4 100644
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
-- 
2.21.1

