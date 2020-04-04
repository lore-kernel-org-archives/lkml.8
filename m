Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3EEC2BA1B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1CA20752
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgDDImn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:42:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41814 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgDDImj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:39 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNa-0001Me-Fp; Sat, 04 Apr 2020 10:42:14 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 050581C04DD;
        Sat,  4 Apr 2020 10:42:05 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:42:04 -0000
From:   "tip-bot2 for Leo Yan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf symbols: Consolidate symbol fixup issue
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200306015759.10084-1-leo.yan@linaro.org>
References: <20200306015759.10084-1-leo.yan@linaro.org>
MIME-Version: 1.0
Message-ID: <158598972445.28353.16327680622961815325.tip-bot2@tip-bot2>
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

Commit-ID:     7eec00a74720d35b6d89505350e5b08ecef376c0
Gitweb:        https://git.kernel.org/tip/7eec00a74720d35b6d89505350e5b08ecef376c0
Author:        Leo Yan <leo.yan@linaro.org>
AuthorDate:    Fri, 06 Mar 2020 09:57:58 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 23 Mar 2020 11:08:29 -03:00

perf symbols: Consolidate symbol fixup issue

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
And confirmed by Naveen N. Rao that powerpc64 kernels are not being
built as ET_DYN anymore and change to ET_EXEC.

This patch removes the arch specific functions for Arm64 and powerpc and
changes elf__needs_adjust_symbols() as a common function.

In the common elf__needs_adjust_symbols(), it checks an extra condition
'ET_DYN' for elf header type.  With this fixing, the Arm64 DSO can be
parsed properly with x86's perf tool.

Before:

  # perf script
  main 3258 1 branches:                0 [unknown] ([unknown]) => ffff800010c4665c [unknown] ([kernel.kallsyms])
  main 3258 1 branches: ffff800010c46670 [unknown] ([kernel.kallsyms]) => ffff800010c4eaec [unknown] ([kernel.kallsyms])
  main 3258 1 branches: ffff800010c4eaec [unknown] ([kernel.kallsyms]) => ffff800010c4eb00 [unknown] ([kernel.kallsyms])
  main 3258 1 branches: ffff800010c4eb08 [unknown] ([kernel.kallsyms]) => ffff800010c4e780 [unknown] ([kernel.kallsyms])
  main 3258 1 branches: ffff800010c4e7a0 [unknown] ([kernel.kallsyms]) => ffff800010c4eeac [unknown] ([kernel.kallsyms])
  main 3258 1 branches: ffff800010c4eebc [unknown] ([kernel.kallsyms]) => ffff800010c4ed80 [unknown] ([kernel.kallsyms])

After:

  # perf script
  main 3258 1 branches:                0 [unknown] ([unknown]) => ffff800010c4665c coresight_timeout+0x54 ([kernel.kallsyms])
  main 3258 1 branches: ffff800010c46670 coresight_timeout+0x68 ([kernel.kallsyms]) => ffff800010c4eaec etm4_enable_hw+0x3cc ([kernel.kallsyms])
  main 3258 1 branches: ffff800010c4eaec etm4_enable_hw+0x3cc ([kernel.kallsyms]) => ffff800010c4eb00 etm4_enable_hw+0x3e0 ([kernel.kallsyms])
  main 3258 1 branches: ffff800010c4eb08 etm4_enable_hw+0x3e8 ([kernel.kallsyms]) => ffff800010c4e780 etm4_enable_hw+0x60 ([kernel.kallsyms])
  main 3258 1 branches: ffff800010c4e7a0 etm4_enable_hw+0x80 ([kernel.kallsyms]) => ffff800010c4eeac etm4_enable+0x2d4 ([kernel.kallsyms])
  main 3258 1 branches: ffff800010c4eebc etm4_enable+0x2e4 ([kernel.kallsyms]) => ffff800010c4ed80 etm4_enable+0x1a8 ([kernel.kallsyms])

v3: Changed to check for ET_DYN across all architectures.

v2: Fixed Arm64 and powerpc native building.

Reported-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Allison Randal <allison@lohutok.net>
Cc: Enrico Weigelt <info@metux.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lore.kernel.org/lkml/20200306015759.10084-1-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/util/Build            |  1 -
 tools/perf/arch/arm64/util/sym-handling.c   | 19 -------------------
 tools/perf/arch/powerpc/util/Build          |  1 -
 tools/perf/arch/powerpc/util/sym-handling.c | 10 ----------
 tools/perf/util/symbol-elf.c                | 10 ++++++++--
 5 files changed, 8 insertions(+), 33 deletions(-)
 delete mode 100644 tools/perf/arch/arm64/util/sym-handling.c

diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 0a7782c..789956f 100644
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
index 8dfa3e5..0000000
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
index 7cf0b88..e5c9504 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -1,5 +1,4 @@
 perf-y += header.o
-perf-y += sym-handling.o
 perf-y += kvm-stat.o
 perf-y += perf_regs.o
 perf-y += mem-events.o
diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index abb7a12..0856b32 100644
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
index 1965aef..be5b493 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -704,9 +704,15 @@ void symsrc__destroy(struct symsrc *ss)
 	close(ss->fd);
 }
 
-bool __weak elf__needs_adjust_symbols(GElf_Ehdr ehdr)
+bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
 {
-	return ehdr.e_type == ET_EXEC || ehdr.e_type == ET_REL;
+	/*
+	 * Usually vmlinux is an ELF file with type ET_EXEC for most
+	 * architectures; except Arm64 kernel is linked with option
+	 * '-share', so need to check type ET_DYN.
+	 */
+	return ehdr.e_type == ET_EXEC || ehdr.e_type == ET_REL ||
+	       ehdr.e_type == ET_DYN;
 }
 
 int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
