Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3984C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC30220726
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b21f6Jut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCFB6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 20:58:21 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53931 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgCFB6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 20:58:21 -0500
Received: by mail-pj1-f65.google.com with SMTP id cx7so381525pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 17:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wh7Q2VwyqtGAxtms6nglNFsFQ7MdfU9cND60WM5uI00=;
        b=b21f6Jut3JgisQtbwKqZArpDfn9DdJxApklh+IeiXoK95Rlh37sXtw7OQG2lD3r9gX
         HN7Ig0BJSuHn+wX8ACnTG9DimKJDah5LMFlovOaUC99jli6V8ZCMZO9W0QFGgJLdy6b5
         asnRKhgRPoHKOP+iHhrkyKTJcw13t3NXPGE9U4R5gY3zjyhsFTbCyzzrYsB4iPrlrGS3
         4hiSwTzhg1Lj3GuhIr7f1EQnER1oxu/YVMMHy9VMX92nzdryVt2nXiKxYD4vny6rIE10
         PI/xX0OA6upeSjIwFmzU791djf9965aPd4T38UjVni1GUIhkC+KsnnV7emgiZcx+yuKW
         wK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wh7Q2VwyqtGAxtms6nglNFsFQ7MdfU9cND60WM5uI00=;
        b=P7PvyjLj0ehdlisfLKUrRBBQ4CR2DsPQfTgLPdAC0wkxw2uCxiuom9fdpdtTtAHKwv
         in3sQsysyvgRNg3368nc6MfpMQzeu51uVfqAtUB7WA8y0Zh4CoAxtrJHqMAnvWCPxgD8
         s7p5BySrR/wJF/gakZ8FtSKYoGdfNwONUnNqowjKA4K5Ho+s4RdJuhuHL8NOo9bCis99
         cWfgV5yDNlxhCh6gY6klPguzC43V8d2f777FC1zLYTGf+kaYIHo4naHLVY4obaanmxxp
         U4qnii0Vf/Cs/EYhxZgAXalSMwTs7xp7MFijcajILzAwOs+10ROErUYqufzxm1+TuAqk
         94Ow==
X-Gm-Message-State: ANhLgQ1QaZk94L/cDXdaIfqdKvo7C03I1+vsSxFgCO92L5lqCPNhtm3q
        bkXILJKrybf09r9fXI5UtLHFNw==
X-Google-Smtp-Source: ADFU+vtIHGVEZP+AzwZw9Rs0iLTE3c16v/UyIoRjtixhKbiWacUffFNrXjt5ZH9q0g0zm8rRalxCKA==
X-Received: by 2002:a17:902:ab81:: with SMTP id f1mr709400plr.5.1583459899689;
        Thu, 05 Mar 2020 17:58:19 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id j4sm33839748pfh.152.2020.03.05.17.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Mar 2020 17:58:18 -0800 (PST)
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
Subject: [PATCH v3] perf symbols: Consolidate symbol fixup issue
Date:   Fri,  6 Mar 2020 09:57:58 +0800
Message-Id: <20200306015759.10084-1-leo.yan@linaro.org>
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
And confirmed by Naveen N. Rao that powerpc64 kernels are not being
built as ET_DYN anymore and change to ET_EXEC.

This patch removes the arch specific functions for Arm64 and powerpc and
changes elf__needs_adjust_symbols() as a common function.

In the common elf__needs_adjust_symbols(), it checks an extra condition
'ET_DYN' for elf header type.  With this fixing, the Arm64 DSO can be
parsed properly with x86's perf tool.

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

v3: Changed to check for ET_DYN across all architectures.

v2: Fixed Arm64 and powerpc native building.

Reported-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
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
2.17.1

