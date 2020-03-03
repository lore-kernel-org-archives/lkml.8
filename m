Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D054C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3682083E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ti92bbHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgCCLEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 06:04:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40714 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgCCLEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:04:24 -0500
Received: by mail-pg1-f194.google.com with SMTP id t24so1375299pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 03:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nAPbXs837serG3BFyvznjhuv5L0Vn6rqNDV51zQyu6E=;
        b=ti92bbHumylD6DoKt4gTTI7CVHdHDw0p6TxN2wVzxzpDpRgX5Mgk7nUrcZWX9nAfqk
         BlnKFrKxxx+p+4jey5wT1oTxBUu7tUUaigibBb6beFfLdjarLn5ViSbg8AwZqCeJCW1c
         M1MFXn+pwKcO2hz+ZHJu98GA0Sj1bIE+wtHZX/+yKG1SEvQuKwtOg0M+xX0YzwixW1+F
         cGS75MlTBEdsvFgK3xvajYkl2Qj6+lj5TvH/jpi3nKJ7xl7C/xnTYhLqXKhun2udkKN3
         9ytARBA6QwVz3Qb7XLmF5e/KzGd9De75cYLkG1Zv8sJu9fzgYMl2rryvtluN91C+N/KR
         tSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nAPbXs837serG3BFyvznjhuv5L0Vn6rqNDV51zQyu6E=;
        b=MYAD5DHuBzd9Uo0OnvtH6+jvvU3hT0BmDCHydm9+FR8Q7WyhVvN22UEoj185JL+1Yu
         q40vu8qFR9ohR1DzEyKQu/qSvYsFsStrXZEw7dBHAAufAvXq/GnR4YutaWtgEI8DqOkz
         Xv8B4q3NZq21o1I/w4YMkhPq8pspCIt+bRLKp+ybpvV/IjyaliKoL4HiFZn+97OKMnFA
         CIDGTUieP7oqtE3L6IfTX5hrYYokgEQX4xltT27IDA/EkfazkuCWamI/Y45VubDhpv1g
         lBAkMZRoB9n6Lpn0G+nOl9koYVvtIGcvZlyDkTqzTL+RJRht/uZCb0IQGqZ1uZGXXkmR
         fs7g==
X-Gm-Message-State: ANhLgQ1AbFBvtwHidEJ4SwP7BeELbQBoYPb6i84hEdAVO2ANXKBTMv4C
        ZmQVuBSQYgVCIzR/DfTJjP3iCQ==
X-Google-Smtp-Source: ADFU+vtKhTt3+/gSo1ZDYOJnqBXcvzb22mymig+Y9fn6GcOMNObHyLmEQbGjiBT1IA5rs6NKuaajwQ==
X-Received: by 2002:a63:2b4e:: with SMTP id r75mr3621307pgr.32.1583233462737;
        Tue, 03 Mar 2020 03:04:22 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id 186sm10262410pfz.145.2020.03.03.03.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2020 03:04:22 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        John Garry <john.garry@huawei.com>,
        Enrico Weigelt <info@metux.net>, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2] perf symbols: Consolidate symbol fixup issue
Date:   Tue,  3 Mar 2020 19:04:07 +0800
Message-Id: <20200303110407.28162-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After copying Arm64's perf archive with object files and perf.data file
to x86 laptop, the x86's perf kernel symbol resolution fails.  It
outputs 'unknown' for all symbols parsing.

This issue is root caused by the function elf__needs_adjust_symbols(),
x86 perf tool uses one weak version, Arm64 (and powerpc) has rewritten
their own version.  elf__needs_adjust_symbols() decides if need to parse
symbols with the relative offset address; but x86 building uses the weak
function which misses to check for the elf type 'ET_DYN', so that it
cannot parse symbols in Arm DSOs due to the wrong result from
elf__needs_adjust_symbols().

The DSO parsing should not depend on any specific architecture perf
building; e.g. x86 perf tool can parse Arm and Arm64 DSOs, vice versa.
So this patch changes elf__needs_adjust_symbols() as a common function
and removes the arch specific functions for Arm64 and powerpc.

In the common elf__needs_adjust_symbols(), it checks elf header and if
the machine type is one of Arm64/ppc/ppc64, it checks extra condition
for 'ET_DYN'.  Finally, the Arm64 DSO can be parsed properly with x86's
perf tool.

Before:

  # perf script
  main  3258          1          branches:                 0 [unknown] ([unknown]) => ffff800010c4665c [unknown] ([kernel.kallsyms])
  main  3258          1          branches:  ffff800010c46670 [unknown] ([kernel.kallsyms]) => ffff800010c4eaec [unknown] ([kernel.kallsyms])
  main  3258          1          branches:  ffff800010c4eaec [unknown] ([kernel.kallsyms]) => ffff800010c4eb00 [unknown] ([kernel.kallsyms])
  main  3258          1          branches:  ffff800010c4eb08 [unknown] ([kernel.kallsyms]) => ffff800010c4e780 [unknown] ([kernel.kallsyms])
  main  3258          1          branches:  ffff800010c4e7a0 [unknown] ([kernel.kallsyms]) => ffff800010c4eeac [unknown] ([kernel.kallsyms])
  main  3258          1          branches:  ffff800010c4eebc [unknown] ([kernel.kallsyms]) => ffff800010c4ed80 [unknown] ([kernel.kallsyms])

After:

  # perf script
  main  3258          1          branches:                 0 [unknown] ([unknown]) => ffff800010c4665c coresight_timeout+0x54 ([kernel.kallsyms])
  main  3258          1          branches:  ffff800010c46670 coresight_timeout+0x68 ([kernel.kallsyms]) => ffff800010c4eaec etm4_enable_hw+0x3cc ([kernel.kallsyms])
  main  3258          1          branches:  ffff800010c4eaec etm4_enable_hw+0x3cc ([kernel.kallsyms]) => ffff800010c4eb00 etm4_enable_hw+0x3e0 ([kernel.kallsyms])
  main  3258          1          branches:  ffff800010c4eb08 etm4_enable_hw+0x3e8 ([kernel.kallsyms]) => ffff800010c4e780 etm4_enable_hw+0x60 ([kernel.kallsyms])
  main  3258          1          branches:  ffff800010c4e7a0 etm4_enable_hw+0x80 ([kernel.kallsyms]) => ffff800010c4eeac etm4_enable+0x2d4 ([kernel.kallsyms])
  main  3258          1          branches:  ffff800010c4eebc etm4_enable+0x2e4 ([kernel.kallsyms]) => ffff800010c4ed80 etm4_enable+0x1a8 ([kernel.kallsyms])

v2: Fixed Arm64 and powerpc native building.

Reported-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/Build            |  1 -
 tools/perf/arch/arm64/util/sym-handling.c   | 19 -------------------
 tools/perf/arch/powerpc/util/Build          |  1 -
 tools/perf/arch/powerpc/util/sym-handling.c | 10 ----------
 tools/perf/util/symbol-elf.c                |  8 +++++++-
 5 files changed, 7 insertions(+), 32 deletions(-)
 delete mode 100644 tools/perf/arch/arm64/util/sym-handling.c

diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 0a7782c61209..789956f76d85 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -1,6 +1,5 @@
 perf-y += header.o
 perf-y += perf_regs.o
-perf-y += sym-handling.o
 perf-$(CONFIG_DWARF)     += dwarf-regs.o
 perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/arm64/util/sym-handling.c b/tools/perf/arch/arm64/util/sym-handling.c
deleted file mode 100644
index 8dfa3e5229f1..000000000000
--- a/tools/perf/arch/arm64/util/sym-handling.c
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *
- * Copyright (C) 2015 Naveen N. Rao, IBM Corporation
- */
-
-#include "symbol.h" // for the elf__needs_adjust_symbols() prototype
-#include <stdbool.h>
-
-#ifdef HAVE_LIBELF_SUPPORT
-#include <gelf.h>
-
-bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
-{
-	return ehdr.e_type == ET_EXEC ||
-	       ehdr.e_type == ET_REL ||
-	       ehdr.e_type == ET_DYN;
-}
-#endif
diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 7cf0b8803097..e5c9504f8586 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -1,5 +1,4 @@
 perf-y += header.o
-perf-y += sym-handling.o
 perf-y += kvm-stat.o
 perf-y += perf_regs.o
 perf-y += mem-events.o
diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index abb7a12d8f93..0856b32f9e08 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -10,16 +10,6 @@
 #include "probe-event.h"
 #include "probe-file.h"
 
-#ifdef HAVE_LIBELF_SUPPORT
-bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
-{
-	return ehdr.e_type == ET_EXEC ||
-	       ehdr.e_type == ET_REL ||
-	       ehdr.e_type == ET_DYN;
-}
-
-#endif
-
 int arch__choose_best_symbol(struct symbol *syma,
 			     struct symbol *symb __maybe_unused)
 {
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 1965aefccb02..ee788ac67415 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -704,8 +704,14 @@ void symsrc__destroy(struct symsrc *ss)
 	close(ss->fd);
 }
 
-bool __weak elf__needs_adjust_symbols(GElf_Ehdr ehdr)
+bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
 {
+	if (ehdr.e_machine == EM_AARCH64 ||
+	    ehdr.e_machine == EM_PPC ||
+	    ehdr.e_machine == EM_PPC64)
+		return ehdr.e_type == ET_EXEC || ehdr.e_type == ET_REL ||
+		       ehdr.e_type == ET_DYN;
+
 	return ehdr.e_type == ET_EXEC || ehdr.e_type == ET_REL;
 }
 
-- 
2.17.1

