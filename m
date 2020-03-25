Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5FFC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895722078A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140108;
	bh=29VMnl0fgUFeAHF/WAd+aYq7dTuJFnPR6IwUK81TlUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lpjuXvfhD0Qs5FdZs0gCEjyIypCLALIbgp1B8bOMbrClg3KHrbUuaq6lLy/GYbKN6
	 9Ym90TvXbBZQQrueg0F67ytiz587E6ZumOCdM3GopOKHPwUSd2BEXtZNphXls0ZBP/
	 DtStMY/WvxYMfeZg+F2kiWikFUDZ6hyY6wwn4xdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgCYMlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbgCYMlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:41:46 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 336E92078E;
        Wed, 25 Mar 2020 12:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585140105;
        bh=29VMnl0fgUFeAHF/WAd+aYq7dTuJFnPR6IwUK81TlUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sUNHZ7t4rtJxjy5GxeHNZePNuk0Mq7MDURn9ExLomjZaj3MrkvMAuH7t84ypouGL0
         oC6SCE89T6zi8ZQXzPu4rp5xCzdB2UpZSmy8ra3t4CZOr2hwFOWv9LUHblk4hhotgy
         Tx29CHjys4kqKLIvOnjsgUg++ErEuM9vUw9KejXU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/24] perf symbols: Consolidate symbol fixup issue
Date:   Wed, 25 Mar 2020 09:41:02 -0300
Message-Id: <20200325124124.32648-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

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
index 1965aefccb02..be5b493f8284 100644
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
-- 
2.21.1

