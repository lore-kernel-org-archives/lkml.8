Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A665CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D5122072D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590767768;
	bh=7l4Ew2D+G+sxO12In3X2Re/Of1kEef9ojOLifzqBArc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=icbs1vOnje+1s+YsorvE+BBKbynWPXtIoMu79gD/XzoU/i2ltkDRDJOfbdskCJaes
	 zhENLOyGpX5ZuiESdKU677OGy0k3T2A7yx+a6ewKLf5h6+k+fvABoxiE5s5WMZaXD9
	 HPSnJcPXrJbKzyBlOHNEiXaYoe8ENSZFv1YXqXf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgE2P4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgE2P4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:56:05 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83D972077D;
        Fri, 29 May 2020 15:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590767764;
        bh=7l4Ew2D+G+sxO12In3X2Re/Of1kEef9ojOLifzqBArc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ARPePP3/g0wRgqa5CIoDqYld1qU0INofJ/ZcSFCRO4dbUphOrDKY6Cm4GV5mk9aA1
         UeBHOssNS9rOCB29K6i0rcQWksbiIdraJifuhdgsYjMI0MHfVi1BIofKmLgb7c+M2S
         fGbC8d1UnedMHq2nF5SjlmPZSBmfTzO4MyVdz7Jg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/2] perf build: Allow explicitely disabling the NO_SYSCALL_TABLE variable
Date:   Fri, 29 May 2020 12:55:52 -0300
Message-Id: <20200529155552.463-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200529155552.463-1-acme@kernel.org>
References: <20200529155552.463-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This is useful to see if, on x86, the legacy libaudit still works, as it
is used in architectures that don't have the SYSCALL_TABLE logic and we
want to have it tested in 'make -C tools/perf/ build-test'.

E.g.:

Without having audit-libs-devel installed:

  $ make NO_SYSCALL_TABLE=1 O=/tmp/build/perf -C tools/perf install-bin
  make: Entering directory '/home/acme/git/perf/tools/perf'
    BUILD:   Doing 'make -j12' parallel build
  <SNIP>
  Auto-detecting system features:
  <SNIP>
  ...                      libaudit: [ OFF ]
  ...                        libbfd: [ on  ]
  ...                        libcap: [ on  ]
  <SNIP>
  Makefile.config:664: No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev
  <SNIP>

After installing it:

  $ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf
  $ time make NO_SYSCALL_TABLE=1 O=/tmp/build/perf  -C tools/perf install-bin ; perf test python
  make: Entering directory '/home/acme/git/perf/tools/perf'
    BUILD:   Doing 'make -j12' parallel build
    HOSTCC   /tmp/build/perf/fixdep.o
    HOSTLD   /tmp/build/perf/fixdep-in.o
    LINK     /tmp/build/perf/fixdep
  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'
  diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
  Warning: Kernel ABI header at 'tools/perf/util/hashmap.h' differs from latest version at 'tools/lib/bpf/hashmap.h'
  diff -u tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
  Warning: Kernel ABI header at 'tools/perf/util/hashmap.c' differs from latest version at 'tools/lib/bpf/hashmap.c'
  diff -u tools/perf/util/hashmap.c tools/lib/bpf/hashmap.c

  Auto-detecting system features:
  <SNIP>
  ...                      libaudit: [ on  ]
  ...                        libbfd: [ on  ]
  ...                        libcap: [ on  ]
  <SNIP>
  $ ldd ~/bin/perf | grep audit
  	libaudit.so.1 => /lib64/libaudit.so.1 (0x00007fc18978e000)
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 93fb7510a9a9..6bc9251f1634 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -24,20 +24,22 @@ $(call detected_var,SRCARCH)
 
 NO_PERF_REGS := 1
 
-NO_SYSCALL_TABLE := 1
+ifneq ($(NO_SYSCALL_TABLE),1)
+  NO_SYSCALL_TABLE := 1
 
-ifeq ($(SRCARCH),x86)
-  ifeq (${IS_64_BIT}, 1)
-    NO_SYSCALL_TABLE := 0
-  endif
-else
-  ifneq ($(SRCARCH),$(filter $(SRCARCH),powerpc arm64 s390))
-    NO_SYSCALL_TABLE := 0
+  ifeq ($(SRCARCH),x86)
+    ifeq (${IS_64_BIT}, 1)
+      NO_SYSCALL_TABLE := 0
+    endif
+  else
+    ifneq ($(SRCARCH),$(filter $(SRCARCH),powerpc arm64 s390))
+      NO_SYSCALL_TABLE := 0
+    endif
   endif
-endif
 
-ifneq ($(NO_SYSCALL_TABLE),1)
-  CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
+  ifneq ($(NO_SYSCALL_TABLE),1)
+    CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
+  endif
 endif
 
 # Additional ARCH settings for ppc
-- 
2.25.3

