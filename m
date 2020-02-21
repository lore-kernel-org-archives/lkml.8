Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE146C35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7B020679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YfT9DbWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgBUPXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:23:48 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43912 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbgBUPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:23:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id p11so970846plq.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eGSAlyMC8XNfRzqFB86VcO6XVS/ScDdpJAM7h7DxvAs=;
        b=YfT9DbWmKEdCGKiAyx4d4Q83WyQF1RvTM2ZOk86SzHZ87NU5LIZHv984brkP6v18gY
         eZlpOsuW/PZcu7F+3GnxeG8cNqFlsG3CWIpzEXqi62HBvno7NAh46OSbyW2NTk4ZxWUg
         +WFcRU5qlxieV2l7PGxKV5abrcnMOcU0yaLOgObSjfjUL/5vcx3uTPEcXjzhcDW7egir
         CVLw8FdMObzjpXxvIUO30NN9YIoi3iouNYV9nrdUCLceafKkgaY6Nd87IPl7JSrxHgTi
         ed4RUkm1v/+tnEYeqTHUiO95Q4JvW5v7bNuGsEgpfPakjV3CARp8mODZlDkX1IWuYpIj
         TYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eGSAlyMC8XNfRzqFB86VcO6XVS/ScDdpJAM7h7DxvAs=;
        b=PTWXJba+U0TMxYV5xaY2BTVzg1PzumjKvk9dLTepDJTs0y/EWRT49FKZt8viOCBwt8
         N3u+oZzlwiJho2x7GFYT8/9B9juyLFR4U6lnO1FB5whb2XqLxxczuczKKoOeBrUXEWKL
         giW3+7vCBmxvTiu+jO3mp/b9l1dbK6VZYWVYLREq13efVltDZLQRicSHU3bzKTqTd5mG
         U5Acl2Y4b9SFQbgYwCaL8852qrfT+jV+lT8eYcAgUHV3YV3EDhGDeut0jvb61EA98x0B
         l3PZA5sfkwrB1kIxQA+AnfDhvrhoksSqWioPKE0k5zQM2RH4zBaEEirFBNZbDQJaSvd8
         96vA==
X-Gm-Message-State: APjAAAWbpn1q46Oa27t+I43f2G8ZNlzmZTFsgtNrRDeDOmtCBnGVT3Xv
        6e84Bftz03dWcQaBnL3y2fY1Jg==
X-Google-Smtp-Source: APXvYqwRUEbSCc8TeNWLRs9cdtbXHyFyvFRzKWKLGgp7T85CICoh1id0uqvCFG/jSpgemTdrfOeBtg==
X-Received: by 2002:a17:902:14d:: with SMTP id 71mr33213218plb.162.1582298626849;
        Fri, 21 Feb 2020 07:23:46 -0800 (PST)
Received: from localhost ([2600:3c01::f03c:91ff:feee:c20d])
        by smtp.gmail.com with ESMTPSA id g19sm3161654pfh.134.2020.02.21.07.23.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 07:23:46 -0800 (PST)
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
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf symbols: Consolidate symbol fixup issue
Date:   Fri, 21 Feb 2020 23:23:24 +0800
Message-Id: <20200221152324.22018-1-leo.yan@linaro.org>
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

Reported-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/sym-handling.c   | 19 -------------------
 tools/perf/arch/powerpc/util/sym-handling.c | 10 ----------
 tools/perf/util/symbol-elf.c                |  8 +++++++-
 3 files changed, 7 insertions(+), 30 deletions(-)
 delete mode 100644 tools/perf/arch/arm64/util/sym-handling.c

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

