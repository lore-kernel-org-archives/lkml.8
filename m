Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE87EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 07:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94002075E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 07:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgCGHhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 02:37:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55245 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgCGHhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 02:37:07 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAU0t-0004HY-On; Sat, 07 Mar 2020 08:36:47 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0EC1C1C21A5;
        Sat,  7 Mar 2020 08:36:47 +0100 (CET)
Date:   Sat, 07 Mar 2020 07:36:46 -0000
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools: Fix off-by 1 relative directory includes
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Igor Lubashev <ilubashe@akamai.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Li <liwei391@huawei.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200306071110.130202-2-irogers@google.com>
References: <20200306071110.130202-2-irogers@google.com>
MIME-Version: 1.0
Message-ID: <158356660669.28353.345183437718949512.tip-bot2@tip-bot2>
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

Commit-ID:     441b62acd9c809e87bab45ad1d82b1b3b77cb4f0
Gitweb:        https://git.kernel.org/tip/441b62acd9c809e87bab45ad1d82b1b3b77cb4f0
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Thu, 05 Mar 2020 23:11:08 -08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 06 Mar 2020 08:36:46 -03:00

tools: Fix off-by 1 relative directory includes

This is currently working due to extra include paths in the build.

Committer testing:

  $ cd tools/include/uapi/asm/

Before this patch:

  $ ls -la ../../arch/x86/include/uapi/asm/errno.h
  ls: cannot access '../../arch/x86/include/uapi/asm/errno.h': No such file or directory
  $

After this patch;

  $ ls -la ../../../arch/x86/include/uapi/asm/errno.h
  -rw-rw-r--. 1 acme acme 31 Feb 20 12:42 ../../../arch/x86/include/uapi/asm/errno.h
  $

Check that that is still under tools/, i.e. hasn't escaped into the main
kernel sources:

  $ cd ../../../arch/x86/include/uapi/asm/
  $ pwd
  /home/acme/git/perf/tools/arch/x86/include/uapi/asm
  $

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexios Zavras <alexios.zavras@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Igor Lubashev <ilubashe@akamai.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Li <liwei391@huawei.com>
Link: http://lore.kernel.org/lkml/20200306071110.130202-2-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm/errno.h           | 14 +++++------
 tools/perf/arch/arm64/util/arm-spe.c     | 20 +++++++--------
 tools/perf/arch/arm64/util/perf_regs.c   |  2 +-
 tools/perf/arch/powerpc/util/perf_regs.c |  4 +--
 tools/perf/arch/x86/util/auxtrace.c      | 14 +++++------
 tools/perf/arch/x86/util/event.c         | 12 ++++-----
 tools/perf/arch/x86/util/header.c        |  4 +--
 tools/perf/arch/x86/util/intel-bts.c     | 24 +++++++++---------
 tools/perf/arch/x86/util/intel-pt.c      | 30 +++++++++++------------
 tools/perf/arch/x86/util/machine.c       |  6 ++---
 tools/perf/arch/x86/util/perf_regs.c     |  8 +++---
 tools/perf/arch/x86/util/pmu.c           |  6 ++---
 12 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/tools/include/uapi/asm/errno.h b/tools/include/uapi/asm/errno.h
index ce3c594..637189e 100644
--- a/tools/include/uapi/asm/errno.h
+++ b/tools/include/uapi/asm/errno.h
@@ -1,18 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #if defined(__i386__) || defined(__x86_64__)
-#include "../../arch/x86/include/uapi/asm/errno.h"
+#include "../../../arch/x86/include/uapi/asm/errno.h"
 #elif defined(__powerpc__)
-#include "../../arch/powerpc/include/uapi/asm/errno.h"
+#include "../../../arch/powerpc/include/uapi/asm/errno.h"
 #elif defined(__sparc__)
-#include "../../arch/sparc/include/uapi/asm/errno.h"
+#include "../../../arch/sparc/include/uapi/asm/errno.h"
 #elif defined(__alpha__)
-#include "../../arch/alpha/include/uapi/asm/errno.h"
+#include "../../../arch/alpha/include/uapi/asm/errno.h"
 #elif defined(__mips__)
-#include "../../arch/mips/include/uapi/asm/errno.h"
+#include "../../../arch/mips/include/uapi/asm/errno.h"
 #elif defined(__ia64__)
-#include "../../arch/ia64/include/uapi/asm/errno.h"
+#include "../../../arch/ia64/include/uapi/asm/errno.h"
 #elif defined(__xtensa__)
-#include "../../arch/xtensa/include/uapi/asm/errno.h"
+#include "../../../arch/xtensa/include/uapi/asm/errno.h"
 #else
 #include <asm-generic/errno.h>
 #endif
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 8d6821d..27653be 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -11,17 +11,17 @@
 #include <linux/zalloc.h>
 #include <time.h>
 
-#include "../../util/cpumap.h"
-#include "../../util/event.h"
-#include "../../util/evsel.h"
-#include "../../util/evlist.h"
-#include "../../util/session.h"
+#include "../../../util/cpumap.h"
+#include "../../../util/event.h"
+#include "../../../util/evsel.h"
+#include "../../../util/evlist.h"
+#include "../../../util/session.h"
 #include <internal/lib.h> // page_size
-#include "../../util/pmu.h"
-#include "../../util/debug.h"
-#include "../../util/auxtrace.h"
-#include "../../util/record.h"
-#include "../../util/arm-spe.h"
+#include "../../../util/pmu.h"
+#include "../../../util/debug.h"
+#include "../../../util/auxtrace.h"
+#include "../../../util/record.h"
+#include "../../../util/arm-spe.h"
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
index 2864e2e..2833e10 100644
--- a/tools/perf/arch/arm64/util/perf_regs.c
+++ b/tools/perf/arch/arm64/util/perf_regs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../../util/perf_regs.h"
+#include "../../../util/perf_regs.h"
 
 const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
index e9c436e..0a52429 100644
--- a/tools/perf/arch/powerpc/util/perf_regs.c
+++ b/tools/perf/arch/powerpc/util/perf_regs.c
@@ -4,8 +4,8 @@
 #include <regex.h>
 #include <linux/zalloc.h>
 
-#include "../../util/perf_regs.h"
-#include "../../util/debug.h"
+#include "../../../util/perf_regs.h"
+#include "../../../util/debug.h"
 
 #include <linux/kernel.h>
 
diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
index 7abc9fd..3da506e 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -7,13 +7,13 @@
 #include <errno.h>
 #include <stdbool.h>
 
-#include "../../util/header.h"
-#include "../../util/debug.h"
-#include "../../util/pmu.h"
-#include "../../util/auxtrace.h"
-#include "../../util/intel-pt.h"
-#include "../../util/intel-bts.h"
-#include "../../util/evlist.h"
+#include "../../../util/header.h"
+#include "../../../util/debug.h"
+#include "../../../util/pmu.h"
+#include "../../../util/auxtrace.h"
+#include "../../../util/intel-pt.h"
+#include "../../../util/intel-bts.h"
+#include "../../../util/evlist.h"
 
 static
 struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index ac45015..047dc00 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -3,12 +3,12 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 
-#include "../../util/event.h"
-#include "../../util/synthetic-events.h"
-#include "../../util/machine.h"
-#include "../../util/tool.h"
-#include "../../util/map.h"
-#include "../../util/debug.h"
+#include "../../../util/event.h"
+#include "../../../util/synthetic-events.h"
+#include "../../../util/machine.h"
+#include "../../../util/tool.h"
+#include "../../../util/map.h"
+#include "../../../util/debug.h"
 
 #if defined(__x86_64__)
 
diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index aa6deb4..578c8c5 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -7,8 +7,8 @@
 #include <string.h>
 #include <regex.h>
 
-#include "../../util/debug.h"
-#include "../../util/header.h"
+#include "../../../util/debug.h"
+#include "../../../util/header.h"
 
 static inline void
 cpuid(unsigned int op, unsigned int *a, unsigned int *b, unsigned int *c,
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 26cee10..09f9380 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -11,18 +11,18 @@
 #include <linux/log2.h>
 #include <linux/zalloc.h>
 
-#include "../../util/cpumap.h"
-#include "../../util/event.h"
-#include "../../util/evsel.h"
-#include "../../util/evlist.h"
-#include "../../util/mmap.h"
-#include "../../util/session.h"
-#include "../../util/pmu.h"
-#include "../../util/debug.h"
-#include "../../util/record.h"
-#include "../../util/tsc.h"
-#include "../../util/auxtrace.h"
-#include "../../util/intel-bts.h"
+#include "../../../util/cpumap.h"
+#include "../../../util/event.h"
+#include "../../../util/evsel.h"
+#include "../../../util/evlist.h"
+#include "../../../util/mmap.h"
+#include "../../../util/session.h"
+#include "../../../util/pmu.h"
+#include "../../../util/debug.h"
+#include "../../../util/record.h"
+#include "../../../util/tsc.h"
+#include "../../../util/auxtrace.h"
+#include "../../../util/intel-bts.h"
 #include <internal/lib.h> // page_size
 
 #define KiB(x) ((x) * 1024)
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 7eea4fd..1643aed 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -13,23 +13,23 @@
 #include <linux/zalloc.h>
 #include <cpuid.h>
 
-#include "../../util/session.h"
-#include "../../util/event.h"
-#include "../../util/evlist.h"
-#include "../../util/evsel.h"
-#include "../../util/evsel_config.h"
-#include "../../util/cpumap.h"
-#include "../../util/mmap.h"
+#include "../../../util/session.h"
+#include "../../../util/event.h"
+#include "../../../util/evlist.h"
+#include "../../../util/evsel.h"
+#include "../../../util/evsel_config.h"
+#include "../../../util/cpumap.h"
+#include "../../../util/mmap.h"
 #include <subcmd/parse-options.h>
-#include "../../util/parse-events.h"
-#include "../../util/pmu.h"
-#include "../../util/debug.h"
-#include "../../util/auxtrace.h"
-#include "../../util/record.h"
-#include "../../util/target.h"
-#include "../../util/tsc.h"
+#include "../../../util/parse-events.h"
+#include "../../../util/pmu.h"
+#include "../../../util/debug.h"
+#include "../../../util/auxtrace.h"
+#include "../../../util/record.h"
+#include "../../../util/target.h"
+#include "../../../util/tsc.h"
 #include <internal/lib.h> // page_size
-#include "../../util/intel-pt.h"
+#include "../../../util/intel-pt.h"
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
diff --git a/tools/perf/arch/x86/util/machine.c b/tools/perf/arch/x86/util/machine.c
index e17e080..31679c3 100644
--- a/tools/perf/arch/x86/util/machine.c
+++ b/tools/perf/arch/x86/util/machine.c
@@ -5,9 +5,9 @@
 #include <stdlib.h>
 
 #include <internal/lib.h> // page_size
-#include "../../util/machine.h"
-#include "../../util/map.h"
-#include "../../util/symbol.h"
+#include "../../../util/machine.h"
+#include "../../../util/map.h"
+#include "../../../util/symbol.h"
 #include <linux/ctype.h>
 
 #include <symbol/kallsyms.h>
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index c218b83..fca81b3 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -5,10 +5,10 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 
-#include "../../perf-sys.h"
-#include "../../util/perf_regs.h"
-#include "../../util/debug.h"
-#include "../../util/event.h"
+#include "../../../perf-sys.h"
+#include "../../../util/perf_regs.h"
+#include "../../../util/debug.h"
+#include "../../../util/event.h"
 
 const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(AX, PERF_REG_X86_AX),
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index e33ef5b..d48d608 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -4,9 +4,9 @@
 #include <linux/stddef.h>
 #include <linux/perf_event.h>
 
-#include "../../util/intel-pt.h"
-#include "../../util/intel-bts.h"
-#include "../../util/pmu.h"
+#include "../../../util/intel-pt.h"
+#include "../../../util/intel-bts.h"
+#include "../../../util/pmu.h"
 
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
