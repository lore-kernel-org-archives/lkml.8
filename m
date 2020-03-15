Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44F5C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 15:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824CE20663
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 15:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgCOPQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 11:16:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50142 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgCOPQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 11:16:14 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jDUzp-0001hz-EQ; Sun, 15 Mar 2020 16:16:09 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id CF4691013A8;
        Sun, 15 Mar 2020 16:16:08 +0100 (CET)
Date:   Sun, 15 Mar 2020 15:14:38 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for 5.6-rc6
References: <158428527861.14940.12920965330771600615.tglx@nanos.tec.linutronix.de>
Message-ID: <158428527863.14940.2082155777571163931.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-03-15

up to:  f967140dfb74: perf/amd/uncore: Replace manual sampling check with CAP_NO_INTERRUPT flag

A pile of perf fixes:

  - AMD uncore driver:

    Replace the open coded sanity check with the core variant, which
    provides the correct error code and also leaves a hint in dmesg

  - tools:

    - Fix the stdio input handling with glibc versions >= 2.28

    - Unbreak the futex-wake benchmark which was reduced to 0 test threads
      due to the conversion to cpumaps

    - Initialize sigaction structs before invoking sys_sigactio()

    - Plug the mapfile memory leak in perf jevents

    - Fix off by one relative directory includes

    - Fix an undefined string comparison in perf diff

Thanks,

	tglx

------------------>
Arnaldo Carvalho de Melo (5):
      perf tests bp_account: Make global variable static
      perf env: Do not return pointers to local variables
      perf parse-events: Use asprintf() instead of strncpy() to read tracepoint files
      perf bench: Share some global variables to fix build with gcc 10
      perf symbols: Don't try to find a vmlinux file when looking for kernel modules

Ian Rogers (1):
      tools: Fix off-by 1 relative directory includes

John Garry (1):
      perf jevents: Fix leak of mapfile memory

Kim Phillips (1):
      perf/amd/uncore: Replace manual sampling check with CAP_NO_INTERRUPT flag

Nick Desaulniers (1):
      perf diff: Fix undefined string comparision spotted by clang's -Wstring-compare

Tommi Rantala (3):
      perf top: Fix stdio interface input handling with glibc 2.28+
      perf bench futex-wake: Restore thread count default to online CPU count
      perf bench: Clear struct sigaction before sigaction() syscall


 arch/x86/events/amd/uncore.c             | 17 +++++++----------
 tools/include/uapi/asm/errno.h           | 14 +++++++-------
 tools/perf/arch/arm64/util/arm-spe.c     | 20 ++++++++++----------
 tools/perf/arch/arm64/util/perf_regs.c   |  2 +-
 tools/perf/arch/powerpc/util/perf_regs.c |  4 ++--
 tools/perf/arch/x86/util/auxtrace.c      | 14 +++++++-------
 tools/perf/arch/x86/util/event.c         | 12 ++++++------
 tools/perf/arch/x86/util/header.c        |  4 ++--
 tools/perf/arch/x86/util/intel-bts.c     | 24 ++++++++++++------------
 tools/perf/arch/x86/util/intel-pt.c      | 30 +++++++++++++++---------------
 tools/perf/arch/x86/util/machine.c       |  6 +++---
 tools/perf/arch/x86/util/perf_regs.c     |  8 ++++----
 tools/perf/arch/x86/util/pmu.c           |  6 +++---
 tools/perf/bench/bench.h                 |  4 ++++
 tools/perf/bench/epoll-ctl.c             |  8 ++++----
 tools/perf/bench/epoll-wait.c            | 12 ++++++------
 tools/perf/bench/futex-hash.c            | 13 +++++++------
 tools/perf/bench/futex-lock-pi.c         | 12 ++++++------
 tools/perf/bench/futex-requeue.c         |  1 +
 tools/perf/bench/futex-wake-parallel.c   |  1 +
 tools/perf/bench/futex-wake.c            |  5 +++--
 tools/perf/builtin-diff.c                |  3 ++-
 tools/perf/builtin-top.c                 |  4 +++-
 tools/perf/pmu-events/jevents.c          | 15 +++++++++------
 tools/perf/tests/bp_account.c            |  2 +-
 tools/perf/util/block-info.c             |  3 ++-
 tools/perf/util/env.c                    |  4 ++--
 tools/perf/util/map.c                    |  2 +-
 tools/perf/util/parse-events.c           | 10 ++--------
 tools/perf/util/symbol.c                 | 13 ++++++-------
 30 files changed, 139 insertions(+), 134 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index a6ea07f2aa84..4d867a752f0e 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -190,15 +190,12 @@ static int amd_uncore_event_init(struct perf_event *event)
 
 	/*
 	 * NB and Last level cache counters (MSRs) are shared across all cores
-	 * that share the same NB / Last level cache. Interrupts can be directed
-	 * to a single target core, however, event counts generated by processes
-	 * running on other cores cannot be masked out. So we do not support
-	 * sampling and per-thread events.
+	 * that share the same NB / Last level cache.  On family 16h and below,
+	 * Interrupts can be directed to a single target core, however, event
+	 * counts generated by processes running on other cores cannot be masked
+	 * out. So we do not support sampling and per-thread events via
+	 * CAP_NO_INTERRUPT, and we do not enable counter overflow interrupts:
 	 */
-	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
-		return -EINVAL;
-
-	/* and we do not enable counter overflow interrupts */
 	hwc->config = event->attr.config & AMD64_RAW_EVENT_MASK_NB;
 	hwc->idx = -1;
 
@@ -306,7 +303,7 @@ static struct pmu amd_nb_pmu = {
 	.start		= amd_uncore_start,
 	.stop		= amd_uncore_stop,
 	.read		= amd_uncore_read,
-	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
 };
 
 static struct pmu amd_llc_pmu = {
@@ -317,7 +314,7 @@ static struct pmu amd_llc_pmu = {
 	.start		= amd_uncore_start,
 	.stop		= amd_uncore_stop,
 	.read		= amd_uncore_read,
-	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
 };
 
 static struct amd_uncore *amd_uncore_alloc(unsigned int cpu)
diff --git a/tools/include/uapi/asm/errno.h b/tools/include/uapi/asm/errno.h
index ce3c5945a1c4..637189ec1ab9 100644
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
index 8d6821d9c3f6..27653be24447 100644
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
index 2864e2e3776d..2833e101a7c6 100644
--- a/tools/perf/arch/arm64/util/perf_regs.c
+++ b/tools/perf/arch/arm64/util/perf_regs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../../util/perf_regs.h"
+#include "../../../util/perf_regs.h"
 
 const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
index e9c436eeffc9..0a5242900248 100644
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
index 7abc9fd4cbec..3da506e13f49 100644
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
index ac45015cc6ba..047dc00eafa6 100644
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
index aa6deb463bf3..578c8c568ffd 100644
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
index 26cee1052179..09f93800bffd 100644
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
index 7eea4fd7ce58..1643aed8c4c8 100644
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
index e17e080e76f4..31679c35d493 100644
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
index c218b83e063b..fca81b39b09f 100644
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
index e33ef5bc31c5..d48d608517fd 100644
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
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index fddb3ced9db6..4aa6de1aa67d 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -2,6 +2,10 @@
 #ifndef BENCH_H
 #define BENCH_H
 
+#include <sys/time.h>
+
+extern struct timeval bench__start, bench__end, bench__runtime;
+
 /*
  * The madvise transparent hugepage constants were added in glibc
  * 2.13. For compatibility with older versions of glibc, define these
diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index bb617e568841..cadc18d42aa4 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -35,7 +35,6 @@
 
 static unsigned int nthreads = 0;
 static unsigned int nsecs    = 8;
-struct timeval start, end, runtime;
 static bool done, __verbose, randomize;
 
 /*
@@ -94,8 +93,8 @@ static void toggle_done(int sig __maybe_unused,
 {
 	/* inform all threads that we're done for the day */
 	done = true;
-	gettimeofday(&end, NULL);
-	timersub(&end, &start, &runtime);
+	gettimeofday(&bench__end, NULL);
+	timersub(&bench__end, &bench__start, &bench__runtime);
 }
 
 static void nest_epollfd(void)
@@ -313,6 +312,7 @@ int bench_epoll_ctl(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
@@ -361,7 +361,7 @@ int bench_epoll_ctl(int argc, const char **argv)
 
 	threads_starting = nthreads;
 
-	gettimeofday(&start, NULL);
+	gettimeofday(&bench__start, NULL);
 
 	do_threads(worker, cpu);
 
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index 7af694437f4e..f938c585d512 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -90,7 +90,6 @@
 
 static unsigned int nthreads = 0;
 static unsigned int nsecs    = 8;
-struct timeval start, end, runtime;
 static bool wdone, done, __verbose, randomize, nonblocking;
 
 /*
@@ -276,8 +275,8 @@ static void toggle_done(int sig __maybe_unused,
 {
 	/* inform all threads that we're done for the day */
 	done = true;
-	gettimeofday(&end, NULL);
-	timersub(&end, &start, &runtime);
+	gettimeofday(&bench__end, NULL);
+	timersub(&bench__end, &bench__start, &bench__runtime);
 }
 
 static void print_summary(void)
@@ -287,7 +286,7 @@ static void print_summary(void)
 
 	printf("\nAveraged %ld operations/sec (+- %.2f%%), total secs = %d\n",
 	       avg, rel_stddev_stats(stddev, avg),
-	       (int) runtime.tv_sec);
+	       (int)bench__runtime.tv_sec);
 }
 
 static int do_threads(struct worker *worker, struct perf_cpu_map *cpu)
@@ -427,6 +426,7 @@ int bench_epoll_wait(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
@@ -479,7 +479,7 @@ int bench_epoll_wait(int argc, const char **argv)
 
 	threads_starting = nthreads;
 
-	gettimeofday(&start, NULL);
+	gettimeofday(&bench__start, NULL);
 
 	do_threads(worker, cpu);
 
@@ -519,7 +519,7 @@ int bench_epoll_wait(int argc, const char **argv)
 		qsort(worker, nthreads, sizeof(struct worker), cmpworker);
 
 	for (i = 0; i < nthreads; i++) {
-		unsigned long t = worker[i].ops/runtime.tv_sec;
+		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
 
 		update_stats(&throughput_stats, t);
 
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 8ba0c3330a9a..65eebe06c04d 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -37,7 +37,7 @@ static unsigned int nfutexes = 1024;
 static bool fshared = false, done = false, silent = false;
 static int futex_flag = 0;
 
-struct timeval start, end, runtime;
+struct timeval bench__start, bench__end, bench__runtime;
 static pthread_mutex_t thread_lock;
 static unsigned int threads_starting;
 static struct stats throughput_stats;
@@ -103,8 +103,8 @@ static void toggle_done(int sig __maybe_unused,
 {
 	/* inform all threads that we're done for the day */
 	done = true;
-	gettimeofday(&end, NULL);
-	timersub(&end, &start, &runtime);
+	gettimeofday(&bench__end, NULL);
+	timersub(&bench__end, &bench__start, &bench__runtime);
 }
 
 static void print_summary(void)
@@ -114,7 +114,7 @@ static void print_summary(void)
 
 	printf("%sAveraged %ld operations/sec (+- %.2f%%), total secs = %d\n",
 	       !silent ? "\n" : "", avg, rel_stddev_stats(stddev, avg),
-	       (int) runtime.tv_sec);
+	       (int)bench__runtime.tv_sec);
 }
 
 int bench_futex_hash(int argc, const char **argv)
@@ -137,6 +137,7 @@ int bench_futex_hash(int argc, const char **argv)
 	if (!cpu)
 		goto errmem;
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
@@ -161,7 +162,7 @@ int bench_futex_hash(int argc, const char **argv)
 
 	threads_starting = nthreads;
 	pthread_attr_init(&thread_attr);
-	gettimeofday(&start, NULL);
+	gettimeofday(&bench__start, NULL);
 	for (i = 0; i < nthreads; i++) {
 		worker[i].tid = i;
 		worker[i].futex = calloc(nfutexes, sizeof(*worker[i].futex));
@@ -204,7 +205,7 @@ int bench_futex_hash(int argc, const char **argv)
 	pthread_mutex_destroy(&thread_lock);
 
 	for (i = 0; i < nthreads; i++) {
-		unsigned long t = worker[i].ops/runtime.tv_sec;
+		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
 		update_stats(&throughput_stats, t);
 		if (!silent) {
 			if (nfutexes == 1)
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index d0cae8125423..89fd8f325f38 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -37,7 +37,6 @@ static bool silent = false, multi = false;
 static bool done = false, fshared = false;
 static unsigned int nthreads = 0;
 static int futex_flag = 0;
-struct timeval start, end, runtime;
 static pthread_mutex_t thread_lock;
 static unsigned int threads_starting;
 static struct stats throughput_stats;
@@ -64,7 +63,7 @@ static void print_summary(void)
 
 	printf("%sAveraged %ld operations/sec (+- %.2f%%), total secs = %d\n",
 	       !silent ? "\n" : "", avg, rel_stddev_stats(stddev, avg),
-	       (int) runtime.tv_sec);
+	       (int)bench__runtime.tv_sec);
 }
 
 static void toggle_done(int sig __maybe_unused,
@@ -73,8 +72,8 @@ static void toggle_done(int sig __maybe_unused,
 {
 	/* inform all threads that we're done for the day */
 	done = true;
-	gettimeofday(&end, NULL);
-	timersub(&end, &start, &runtime);
+	gettimeofday(&bench__end, NULL);
+	timersub(&bench__end, &bench__start, &bench__runtime);
 }
 
 static void *workerfn(void *arg)
@@ -161,6 +160,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	if (!cpu)
 		err(EXIT_FAILURE, "calloc");
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
@@ -185,7 +185,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
 
 	threads_starting = nthreads;
 	pthread_attr_init(&thread_attr);
-	gettimeofday(&start, NULL);
+	gettimeofday(&bench__start, NULL);
 
 	create_threads(worker, thread_attr, cpu);
 	pthread_attr_destroy(&thread_attr);
@@ -211,7 +211,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	pthread_mutex_destroy(&thread_lock);
 
 	for (i = 0; i < nthreads; i++) {
-		unsigned long t = worker[i].ops/runtime.tv_sec;
+		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
 
 		update_stats(&throughput_stats, t);
 		if (!silent)
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index a00a6891447a..7a15c2e61022 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -128,6 +128,7 @@ int bench_futex_requeue(int argc, const char **argv)
 	if (!cpu)
 		err(EXIT_FAILURE, "cpu_map__new");
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index a053cf2b7039..cd2b81a845ac 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -234,6 +234,7 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index df810096abfe..2dfcef3e371e 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -43,7 +43,7 @@ static bool done = false, silent = false, fshared = false;
 static pthread_mutex_t thread_lock;
 static pthread_cond_t thread_parent, thread_worker;
 static struct stats waketime_stats, wakeup_stats;
-static unsigned int ncpus, threads_starting, nthreads = 0;
+static unsigned int threads_starting, nthreads = 0;
 static int futex_flag = 0;
 
 static const struct option options[] = {
@@ -136,12 +136,13 @@ int bench_futex_wake(int argc, const char **argv)
 	if (!cpu)
 		err(EXIT_FAILURE, "calloc");
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
 
 	if (!nthreads)
-		nthreads = ncpus;
+		nthreads = cpu->nr;
 
 	worker = calloc(nthreads, sizeof(*worker));
 	if (!worker)
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index f8b6ae557d8b..c03c36fde7e2 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1312,7 +1312,8 @@ static int cycles_printf(struct hist_entry *he, struct hist_entry *pair,
 	end_line = map__srcline(he->ms.map, bi->sym->start + bi->end,
 				he->ms.sym);
 
-	if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
+	if ((strncmp(start_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0) &&
+	    (strncmp(end_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0)) {
 		scnprintf(buf, sizeof(buf), "[%s -> %s] %4ld",
 			  start_line, end_line, block_he->diff.cycles);
 	} else {
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index f6dd1a63f159..d2539b793f9d 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -684,7 +684,9 @@ static void *display_thread(void *arg)
 	delay_msecs = top->delay_secs * MSEC_PER_SEC;
 	set_term_quiet_input(&save);
 	/* trash return*/
-	getc(stdin);
+	clearerr(stdin);
+	if (poll(&stdin_poll, 1, 0) > 0)
+		getc(stdin);
 
 	while (!done) {
 		perf_top__print_sym_table(top);
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 079c77b6a2fd..27b4da80f751 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -1082,10 +1082,9 @@ static int process_one_file(const char *fpath, const struct stat *sb,
  */
 int main(int argc, char *argv[])
 {
-	int rc;
+	int rc, ret = 0;
 	int maxfds;
 	char ldirname[PATH_MAX];
-
 	const char *arch;
 	const char *output_file;
 	const char *start_dirname;
@@ -1156,7 +1155,8 @@ int main(int argc, char *argv[])
 		/* Make build fail */
 		fclose(eventsfp);
 		free_arch_std_events();
-		return 1;
+		ret = 1;
+		goto out_free_mapfile;
 	} else if (rc) {
 		goto empty_map;
 	}
@@ -1174,14 +1174,17 @@ int main(int argc, char *argv[])
 		/* Make build fail */
 		fclose(eventsfp);
 		free_arch_std_events();
-		return 1;
+		ret = 1;
 	}
 
-	return 0;
+
+	goto out_free_mapfile;
 
 empty_map:
 	fclose(eventsfp);
 	create_empty_mapping(output_file);
 	free_arch_std_events();
-	return 0;
+out_free_mapfile:
+	free(mapfile);
+	return ret;
 }
diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index d0b935356274..489b50604cf2 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -19,7 +19,7 @@
 #include "../perf-sys.h"
 #include "cloexec.h"
 
-volatile long the_var;
+static volatile long the_var;
 
 static noinline int test_function(void)
 {
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index c4b030bf6ec2..fbbb6d640dad 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -295,7 +295,8 @@ static int block_range_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	end_line = map__srcline(he->ms.map, bi->sym->start + bi->end,
 				he->ms.sym);
 
-	if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
+	if ((strncmp(start_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0) &&
+	    (strncmp(end_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0)) {
 		scnprintf(buf, sizeof(buf), "[%s -> %s]",
 			  start_line, end_line);
 	} else {
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 6242a9215df7..4154f944f474 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -343,11 +343,11 @@ static const char *normalize_arch(char *arch)
 
 const char *perf_env__arch(struct perf_env *env)
 {
-	struct utsname uts;
 	char *arch_name;
 
 	if (!env || !env->arch) { /* Assume local operation */
-		if (uname(&uts) < 0)
+		static struct utsname uts = { .machine[0] = '\0', };
+		if (uts.machine[0] == '\0' && uname(&uts) < 0)
 			return NULL;
 		arch_name = uts.machine;
 	} else
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index a08ca276098e..95428511300d 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -431,7 +431,7 @@ int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 
 	if (map && map->dso) {
 		char *srcline = map__srcline(map, addr, NULL);
-		if (srcline != SRCLINE_UNKNOWN)
+		if (strncmp(srcline, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0)
 			ret = fprintf(fp, "%s%s", prefix, srcline);
 		free_srcline(srcline);
 	}
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c01ba6f8fdad..a14995835d85 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -257,21 +257,15 @@ struct tracepoint_path *tracepoint_id_to_path(u64 config)
 				path = zalloc(sizeof(*path));
 				if (!path)
 					return NULL;
-				path->system = malloc(MAX_EVENT_LENGTH);
-				if (!path->system) {
+				if (asprintf(&path->system, "%.*s", MAX_EVENT_LENGTH, sys_dirent->d_name) < 0) {
 					free(path);
 					return NULL;
 				}
-				path->name = malloc(MAX_EVENT_LENGTH);
-				if (!path->name) {
+				if (asprintf(&path->name, "%.*s", MAX_EVENT_LENGTH, evt_dirent->d_name) < 0) {
 					zfree(&path->system);
 					free(path);
 					return NULL;
 				}
-				strncpy(path->system, sys_dirent->d_name,
-					MAX_EVENT_LENGTH);
-				strncpy(path->name, evt_dirent->d_name,
-					MAX_EVENT_LENGTH);
 				return path;
 			}
 		}
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 1077013d8ce2..26bc6a0096ce 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1622,7 +1622,12 @@ int dso__load(struct dso *dso, struct map *map)
 		goto out;
 	}
 
-	if (dso->kernel) {
+	kmod = dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE ||
+		dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP ||
+		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE ||
+		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
+
+	if (dso->kernel && !kmod) {
 		if (dso->kernel == DSO_TYPE_KERNEL)
 			ret = dso__load_kernel_sym(dso, map);
 		else if (dso->kernel == DSO_TYPE_GUEST_KERNEL)
@@ -1650,12 +1655,6 @@ int dso__load(struct dso *dso, struct map *map)
 	if (!name)
 		goto out;
 
-	kmod = dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE ||
-		dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP ||
-		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE ||
-		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
-
-
 	/*
 	 * Read the build id if possible. This is required for
 	 * DSO_BINARY_TYPE__BUILDID_DEBUGINFO to work

