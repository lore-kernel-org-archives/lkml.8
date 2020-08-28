Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85885C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E3A207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598648212;
	bh=aU9paHI1A7MfFGAR9QNj01dN6jD7jLbJ+g1LRtqNi+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wU8Db06R0a4TTJLXbQ8cuLQaAJODBPNiDKsvU0l0E7wGLLmr9zUVlYMdtgy8jxnsw
	 kPB3rGasG1eT5FDybsZEKVwhfl7msu68sX7syV/OJuK7Z0lgYfXwjFDm4HQQmkT0re
	 pBWNGWDa0FP6dhbZ46PdCbRA8BbAq+czk5bzgFSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgH1U4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:56:51 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:36395 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgH1U4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:56:41 -0400
Received: by mail-il1-f196.google.com with SMTP id f75so1829045ilh.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1uoeeUQXGqu4Uf6HLlv5trG9Ierr5xwa79vETxfyzuA=;
        b=lz6mE6Ddp4r/LUQ6MHfTvjSzPRATITzCHtmZii0pQCYXf/5/0hH0IXSppEOROVe0Fp
         0pY14Yba72HLSA9nVEsYC8Q363MrK9833A0yc9yYO9pd8VPSkcVEGVuY7C2c8UFJQS3T
         K3WwU8Yw7bV6dbV6RM6JQVoU3kdymZchWronJ9gfT/S4OW5Au+5bT0L3PHtCVLRH7aKH
         hO/+ZQNZGleOVtxB7Sp9SP49B3wuvsWRu7wGh6q9dt+4rbwEZ9ck08QWiLnJUgClv3XG
         CfpI6K+TAZFMy9VWizNyoFvjsyzXKbbeHbzXP8O1zst2FbZeD9dZd74Isf90jWbK/5b1
         OYyw==
X-Gm-Message-State: AOAM533Iqn8c+tI7NBpAh53z+Z0W1G6GMuUyO/zWThTqPjDK3SFgFsfh
        CfrTDYdRzH3mYWCNrMEdHg==
X-Google-Smtp-Source: ABdhPJyPI/K0+ocmuBrRMKRrA/okUuO/9rO/D67BfewuVZSgkKJHTIIZ2Vx+htLWb7cBgYFm2ZDgZA==
X-Received: by 2002:a05:6e02:d52:: with SMTP id h18mr549850ilj.215.1598648199393;
        Fri, 28 Aug 2020 13:56:39 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id l203sm147089ioa.31.2020.08.28.13.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 13:56:38 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com
Subject: [PATCH v2 9/9] perf: Remove x86 specific rdpmc test
Date:   Fri, 28 Aug 2020 14:56:14 -0600
Message-Id: <20200828205614.3391252-10-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828205614.3391252-1-robh@kernel.org>
References: <20200828205614.3391252-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a common libperf based userspace counter read test
with the same functionality as the x86 specific rdpmc test, let's remove
it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
This one is optional. On the plus side, it eliminates a copy of the read
loop. The main downside I see is loosing the ability to test in 'perf test'.


 tools/perf/arch/x86/include/arch-tests.h |   1 -
 tools/perf/arch/x86/tests/Build          |   1 -
 tools/perf/arch/x86/tests/arch-tests.c   |   4 -
 tools/perf/arch/x86/tests/rdpmc.c        | 182 -----------------------
 4 files changed, 188 deletions(-)
 delete mode 100644 tools/perf/arch/x86/tests/rdpmc.c

diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
index c41c5affe4be..d9c32ba0cdac 100644
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@ -6,7 +6,6 @@
 struct test;

 /* Tests */
-int test__rdpmc(struct test *test __maybe_unused, int subtest);
 int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest);
 int test__insn_x86(struct test *test __maybe_unused, int subtest);
 int test__intel_pt_pkt_decoder(struct test *test, int subtest);
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 2997c506550c..e3b3cd3b40e8 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -2,7 +2,6 @@ perf-$(CONFIG_DWARF_UNWIND) += regs_load.o
 perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o

 perf-y += arch-tests.o
-perf-y += rdpmc.o
 perf-y += perf-time-to-tsc.o
 perf-$(CONFIG_AUXTRACE) += insn-x86.o intel-pt-pkt-decoder-test.o
 perf-$(CONFIG_X86_64) += bp-modify.o
diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
index 6763135aec17..300e9954d530 100644
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@ -4,10 +4,6 @@
 #include "arch-tests.h"

 struct test arch_tests[] = {
-	{
-		.desc = "x86 rdpmc",
-		.func = test__rdpmc,
-	},
 	{
 		.desc = "Convert perf time to TSC",
 		.func = test__perf_time_to_tsc,
diff --git a/tools/perf/arch/x86/tests/rdpmc.c b/tools/perf/arch/x86/tests/rdpmc.c
deleted file mode 100644
index 1ea916656a2d..000000000000
--- a/tools/perf/arch/x86/tests/rdpmc.c
+++ /dev/null
@@ -1,182 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <errno.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <signal.h>
-#include <sys/mman.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <linux/string.h>
-#include <linux/types.h>
-#include "perf-sys.h"
-#include "debug.h"
-#include "tests/tests.h"
-#include "cloexec.h"
-#include "event.h"
-#include <internal/lib.h> // page_size
-#include "arch-tests.h"
-
-static u64 rdpmc(unsigned int counter)
-{
-	unsigned int low, high;
-
-	asm volatile("rdpmc" : "=a" (low), "=d" (high) : "c" (counter));
-
-	return low | ((u64)high) << 32;
-}
-
-static u64 rdtsc(void)
-{
-	unsigned int low, high;
-
-	asm volatile("rdtsc" : "=a" (low), "=d" (high));
-
-	return low | ((u64)high) << 32;
-}
-
-static u64 mmap_read_self(void *addr)
-{
-	struct perf_event_mmap_page *pc = addr;
-	u32 seq, idx, time_mult = 0, time_shift = 0;
-	u64 count, cyc = 0, time_offset = 0, enabled, running, delta;
-
-	do {
-		seq = pc->lock;
-		barrier();
-
-		enabled = pc->time_enabled;
-		running = pc->time_running;
-
-		if (enabled != running) {
-			cyc = rdtsc();
-			time_mult = pc->time_mult;
-			time_shift = pc->time_shift;
-			time_offset = pc->time_offset;
-		}
-
-		idx = pc->index;
-		count = pc->offset;
-		if (idx)
-			count += rdpmc(idx - 1);
-
-		barrier();
-	} while (pc->lock != seq);
-
-	if (enabled != running) {
-		u64 quot, rem;
-
-		quot = (cyc >> time_shift);
-		rem = cyc & (((u64)1 << time_shift) - 1);
-		delta = time_offset + quot * time_mult +
-			((rem * time_mult) >> time_shift);
-
-		enabled += delta;
-		if (idx)
-			running += delta;
-
-		quot = count / running;
-		rem = count % running;
-		count = quot * enabled + (rem * enabled) / running;
-	}
-
-	return count;
-}
-
-/*
- * If the RDPMC instruction faults then signal this back to the test parent task:
- */
-static void segfault_handler(int sig __maybe_unused,
-			     siginfo_t *info __maybe_unused,
-			     void *uc __maybe_unused)
-{
-	exit(-1);
-}
-
-static int __test__rdpmc(void)
-{
-	volatile int tmp = 0;
-	u64 i, loops = 1000;
-	int n;
-	int fd;
-	void *addr;
-	struct perf_event_attr attr = {
-		.type = PERF_TYPE_HARDWARE,
-		.config = PERF_COUNT_HW_INSTRUCTIONS,
-		.exclude_kernel = 1,
-	};
-	u64 delta_sum = 0;
-        struct sigaction sa;
-	char sbuf[STRERR_BUFSIZE];
-
-	sigfillset(&sa.sa_mask);
-	sa.sa_sigaction = segfault_handler;
-	sa.sa_flags = 0;
-	sigaction(SIGSEGV, &sa, NULL);
-
-	fd = sys_perf_event_open(&attr, 0, -1, -1,
-				 perf_event_open_cloexec_flag());
-	if (fd < 0) {
-		pr_err("Error: sys_perf_event_open() syscall returned "
-		       "with %d (%s)\n", fd,
-		       str_error_r(errno, sbuf, sizeof(sbuf)));
-		return -1;
-	}
-
-	addr = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
-	if (addr == (void *)(-1)) {
-		pr_err("Error: mmap() syscall returned with (%s)\n",
-		       str_error_r(errno, sbuf, sizeof(sbuf)));
-		goto out_close;
-	}
-
-	for (n = 0; n < 6; n++) {
-		u64 stamp, now, delta;
-
-		stamp = mmap_read_self(addr);
-
-		for (i = 0; i < loops; i++)
-			tmp++;
-
-		now = mmap_read_self(addr);
-		loops *= 10;
-
-		delta = now - stamp;
-		pr_debug("%14d: %14Lu\n", n, (long long)delta);
-
-		delta_sum += delta;
-	}
-
-	munmap(addr, page_size);
-	pr_debug("   ");
-out_close:
-	close(fd);
-
-	if (!delta_sum)
-		return -1;
-
-	return 0;
-}
-
-int test__rdpmc(struct test *test __maybe_unused, int subtest __maybe_unused)
-{
-	int status = 0;
-	int wret = 0;
-	int ret;
-	int pid;
-
-	pid = fork();
-	if (pid < 0)
-		return -1;
-
-	if (!pid) {
-		ret = __test__rdpmc();
-
-		exit(ret);
-	}
-
-	wret = waitpid(pid, &status, 0);
-	if (wret < 0 || status)
-		return -1;
-
-	return 0;
-}
--
2.25.1
