Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B419DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7348020720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594155222;
	bh=Am7A3A6UOe/TTTq60FXqPLUwzt5ErTmMyWNaG1kzMBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vLPD+ayWCdXio9j2bHGYTBW3TzZqbL5T3ms2UFt4Xagw+vz5fvpC7e45lF6mSQji3
	 INcI5bgI7oJFZYcjXqum5sNO9B4TBPjjm1RtYesj3OqYklMNkVwUp9395k9wDy+V27
	 t6pdJrjteURRS3TOUPsDpP6aiTLMKGjmuMLzgaUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgGGUxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:53:41 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:36694 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbgGGUxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:53:38 -0400
Received: by mail-il1-f196.google.com with SMTP id x9so37267565ila.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 13:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ytul7o//Hj8Kul9SphDqp24K8Fjv9p6tJv7xdegBWDw=;
        b=Yo0KNR0PT7zAP7cwA1eXte3/rY+rBQY4C/oGZCaoHHG7jSuZ6hv/AWfsQlACanipgE
         2YJkcNYzZX/6OisSExovd+hIiIBo/ZDwWkmMvfrm483RhnL450ZYpRWuj7ZZ1P3gZTv4
         8ZnBa/5ky6JVaBwTOUgic5C/Li0XSng9e+wNOWxdaNm6DRiYJSUiQIn+F4vbAE0DTXR3
         J94KzuTBN89xsibh8JnqTybCg70+rxFmon/QokB8/P4uK+cOXkpkfKkBWVZvOL1044bV
         qsHxXTPye5hgWI8yXgekwhUN8W+bP1jfRVKCdgFlThDry0D8Cuwz++KyPXb4yX1elck6
         C6KQ==
X-Gm-Message-State: AOAM532X/7Hajh663qgsdItTAxSP/1Su1BBWYuunjebLxk/ABtP5o1Xc
        osbnqkws3rC/Dq/UiF45Kg==
X-Google-Smtp-Source: ABdhPJxoaIa93RPB97Or14vp4uPQSbA7gZloZzLFdqA6rmUtoTeU2KBbXYzir/FD0EPLiSEdOYsaJg==
X-Received: by 2002:a92:cacf:: with SMTP id m15mr36241983ilq.34.1594155216866;
        Tue, 07 Jul 2020 13:53:36 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.254])
        by smtp.googlemail.com with ESMTPSA id y6sm13110712ila.74.2020.07.07.13.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:53:36 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/5] perf: arm64: Add tests to check userspace access to hardware counters
Date:   Tue,  7 Jul 2020 14:53:29 -0600
Message-Id: <20200707205333.624938-2-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707205333.624938-1-robh@kernel.org>
References: <20200707205333.624938-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

These tests test PMU registers access from userspace. It uses
perf_event_mmap_page() to retrieve the counter index and access the
underlying register.

For heterogeneous systems, userspace is expected to pin itself to like
CPUs and open the corresponding PMU. Test test__rd_pinned() demonstrates
this.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Changes:
- Rebase to v5.8 and update includes
- Add cycle counter test
- Add test for heterogeneous systems
- check pmc_width
- Tests check access first instead of getting garbage data
---
 tools/perf/arch/arm64/include/arch-tests.h |  11 +
 tools/perf/arch/arm64/tests/Build          |   1 +
 tools/perf/arch/arm64/tests/arch-tests.c   |  12 +
 tools/perf/arch/arm64/tests/user-events.c  | 454 +++++++++++++++++++++
 4 files changed, 478 insertions(+)
 create mode 100644 tools/perf/arch/arm64/tests/user-events.c

diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch/arm64/include/arch-tests.h
index 90ec4c8cb880..a15ed7da4e8f 100644
--- a/tools/perf/arch/arm64/include/arch-tests.h
+++ b/tools/perf/arch/arm64/include/arch-tests.h
@@ -2,11 +2,22 @@
 #ifndef ARCH_TESTS_H
 #define ARCH_TESTS_H

+#include <linux/compiler.h>
+
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 struct thread;
 struct perf_sample;
+int test__arch_unwind_sample(struct perf_sample *sample,
+			     struct thread *thread);
 #endif

 extern struct test arch_tests[];
+int test__rd_pmevcntr(struct test *test __maybe_unused,
+		      int subtest __maybe_unused);
+int test__rd_pmccntr(struct test *test __maybe_unused,
+		     int subtest __maybe_unused);
+int test__rd_pinned(struct test __maybe_unused *test,
+		       int __maybe_unused subtest);
+

 #endif
diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/tests/Build
index a61c06bdb757..3f9a20c17fc6 100644
--- a/tools/perf/arch/arm64/tests/Build
+++ b/tools/perf/arch/arm64/tests/Build
@@ -1,4 +1,5 @@
 perf-y += regs_load.o
 perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o

+perf-y += user-events.o
 perf-y += arch-tests.o
diff --git a/tools/perf/arch/arm64/tests/arch-tests.c b/tools/perf/arch/arm64/tests/arch-tests.c
index 5b1543c98022..f2a9a261cb55 100644
--- a/tools/perf/arch/arm64/tests/arch-tests.c
+++ b/tools/perf/arch/arm64/tests/arch-tests.c
@@ -10,6 +10,18 @@ struct test arch_tests[] = {
 		.func = test__dwarf_unwind,
 	},
 #endif
+	{
+		.desc = "User event counter access",
+		.func = test__rd_pmevcntr,
+	},
+	{
+		.desc = "User cycle counter access",
+		.func = test__rd_pmccntr,
+	},
+	{
+		.desc = "Pinned CPU user counter access",
+		.func = test__rd_pinned,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/arch/arm64/tests/user-events.c b/tools/perf/arch/arm64/tests/user-events.c
new file mode 100644
index 000000000000..7b05ac084773
--- /dev/null
+++ b/tools/perf/arch/arm64/tests/user-events.c
@@ -0,0 +1,454 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <asm/bug.h>
+#include <errno.h>
+#include <unistd.h>
+#include <sched.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <sys/sysinfo.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <linux/types.h>
+#include <linux/perf_event.h>
+#include <linux/string.h>
+#include <internal/lib.h>
+#include <cpumap.h>
+
+#include "pmu.h"
+#include "perf-sys.h"
+#include "debug.h"
+#include "tests/tests.h"
+#include "cloexec.h"
+#include "arch-tests.h"
+
+/*
+ * ARMv8 ARM reserves the following encoding for system registers:
+ * (Ref: ARMv8 ARM, Section: "System instruction class encoding overview",
+ *  C5.2, version:ARM DDI 0487A.f)
+ *      [20-19] : Op0
+ *      [18-16] : Op1
+ *      [15-12] : CRn
+ *      [11-8]  : CRm
+ *      [7-5]   : Op2
+ */
+#define Op0_shift       19
+#define Op0_mask        0x3
+#define Op1_shift       16
+#define Op1_mask        0x7
+#define CRn_shift       12
+#define CRn_mask        0xf
+#define CRm_shift       8
+#define CRm_mask        0xf
+#define Op2_shift       5
+#define Op2_mask        0x7
+
+#define __stringify(x)	#x
+
+#define read_sysreg(r) ({						\
+	u64 __val;							\
+	asm volatile("mrs %0, " __stringify(r) : "=r" (__val));		\
+	__val;								\
+})
+
+#define PMEVCNTR_READ_CASE(idx)					\
+	case idx:						\
+		return read_sysreg(pmevcntr##idx##_el0)
+
+#define PMEVCNTR_CASES(readwrite)		\
+	PMEVCNTR_READ_CASE(0);			\
+	PMEVCNTR_READ_CASE(1);			\
+	PMEVCNTR_READ_CASE(2);			\
+	PMEVCNTR_READ_CASE(3);			\
+	PMEVCNTR_READ_CASE(4);			\
+	PMEVCNTR_READ_CASE(5);			\
+	PMEVCNTR_READ_CASE(6);			\
+	PMEVCNTR_READ_CASE(7);			\
+	PMEVCNTR_READ_CASE(8);			\
+	PMEVCNTR_READ_CASE(9);			\
+	PMEVCNTR_READ_CASE(10);			\
+	PMEVCNTR_READ_CASE(11);			\
+	PMEVCNTR_READ_CASE(12);			\
+	PMEVCNTR_READ_CASE(13);			\
+	PMEVCNTR_READ_CASE(14);			\
+	PMEVCNTR_READ_CASE(15);			\
+	PMEVCNTR_READ_CASE(16);			\
+	PMEVCNTR_READ_CASE(17);			\
+	PMEVCNTR_READ_CASE(18);			\
+	PMEVCNTR_READ_CASE(19);			\
+	PMEVCNTR_READ_CASE(20);			\
+	PMEVCNTR_READ_CASE(21);			\
+	PMEVCNTR_READ_CASE(22);			\
+	PMEVCNTR_READ_CASE(23);			\
+	PMEVCNTR_READ_CASE(24);			\
+	PMEVCNTR_READ_CASE(25);			\
+	PMEVCNTR_READ_CASE(26);			\
+	PMEVCNTR_READ_CASE(27);			\
+	PMEVCNTR_READ_CASE(28);			\
+	PMEVCNTR_READ_CASE(29);			\
+	PMEVCNTR_READ_CASE(30)
+
+/*
+ * Read a value direct from PMEVCNTR<idx>
+ */
+static u64 read_evcnt_direct(int idx)
+{
+	switch (idx) {
+	PMEVCNTR_CASES(READ);
+	case 31:
+		return read_sysreg(pmccntr_el0);
+	default:
+		WARN_ON(1);
+	}
+
+	return 0;
+}
+
+static int mmap_read_check_user_access(void *addr, bool cnt64)
+{
+	struct perf_event_mmap_page *pc = addr;
+
+	if (!pc->cap_user_rdpmc) {
+		pr_err("Userspace access not enabled.\n");
+		return -1;
+	}
+
+	if (!pc->index) {
+		pr_err("No event index.\n");
+		return -1;
+	}
+
+	if (!cnt64 && pc->pmc_width != 32) {
+		pr_err("Unexpected counter width - %d, expected 32.\n", pc->pmc_width);
+		return -1;
+	}
+	if (cnt64 && pc->pmc_width != 64) {
+		pr_err("Unexpected counter width - %d, expected 64.\n", pc->pmc_width);
+		return -1;
+	}
+
+	return 0;
+}
+
+static u64 mmap_read_self(void *addr)
+{
+	struct perf_event_mmap_page *pc = addr;
+	u32 seq, idx, time_mult = 0, time_shift = 0;
+	u64 count, cyc = 0, time_offset = 0, enabled, running, delta;
+
+	do {
+		seq = READ_ONCE(pc->lock);
+		barrier();
+
+		enabled = READ_ONCE(pc->time_enabled);
+		running = READ_ONCE(pc->time_running);
+
+		if (enabled != running) {
+			cyc = read_sysreg(cntvct_el0);
+			time_mult = READ_ONCE(pc->time_mult);
+			time_shift = READ_ONCE(pc->time_shift);
+			time_offset = READ_ONCE(pc->time_offset);
+		}
+
+		idx = READ_ONCE(pc->index);
+		count = READ_ONCE(pc->offset);
+		if (idx) {
+			u64 evcnt = read_evcnt_direct(idx - 1);
+			u16 width = READ_ONCE(pc->pmc_width);
+
+			evcnt <<= 64 - width;
+			evcnt >>= 64 - width;
+			count += evcnt;
+		}
+		barrier();
+	} while (READ_ONCE(pc->lock) != seq);
+
+	if (enabled != running) {
+		u64 quot, rem;
+
+		quot = (cyc >> time_shift);
+		rem = cyc & (((u64)1 << time_shift) - 1);
+		delta = time_offset + quot * time_mult +
+			((rem * time_mult) >> time_shift);
+
+		enabled += delta;
+		if (idx)
+			running += delta;
+
+		quot = count / running;
+		rem = count % running;
+		count = quot * enabled + (rem * enabled) / running;
+	}
+
+	return count;
+}
+
+static int run_test(void *addr)
+{
+	int n;
+	volatile int tmp = 0;
+	u64 delta, i, loops = 1000;
+
+	for (n = 0; n < 6; n++) {
+		u64 stamp, now;
+
+		stamp = mmap_read_self(addr);
+
+		for (i = 0; i < loops; i++)
+			tmp++;
+
+		now = mmap_read_self(addr);
+		loops *= 10;
+
+		delta = now - stamp;
+		pr_debug("%14d: %14llu\n", n, (long long)delta);
+
+		if (!delta)
+			break;
+	}
+	return delta ? 0 : -1;
+}
+
+static struct perf_pmu *pmu_for_cpu(int cpu)
+{
+	int acpu, idx;
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (pmu->is_uncore)
+			continue;
+		perf_cpu_map__for_each_cpu(acpu, idx, pmu->cpus)
+			if (acpu == cpu)
+				return pmu;
+	}
+	return NULL;
+}
+
+static bool pmu_is_homogeneous(void)
+{
+	int core_cnt = 0;
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (!pmu->is_uncore && !perf_cpu_map__empty(pmu->cpus))
+			core_cnt++;
+	}
+	return core_cnt == 1;
+}
+
+static int __test__rd_pinned(void)
+{
+	int cpu, cputmp, ret = -1;
+	int fd;
+	void *addr;
+	struct perf_event_attr attr = {
+		.config = 0x8, /* Instruction count */
+		.config1 = 0, /* 32-bit counter */
+		.exclude_kernel = 1,
+	};
+	char sbuf[STRERR_BUFSIZE];
+	cpu_set_t cpu_set;
+	struct perf_pmu *pmu;
+
+	cpu = sched_getcpu();
+	pmu = pmu_for_cpu(cpu);
+	if (!pmu)
+		return -1;
+	attr.type = pmu->type;
+
+	CPU_ZERO(&cpu_set);
+	perf_cpu_map__for_each_cpu(cpu, cputmp, pmu->cpus)
+		CPU_SET(cpu, &cpu_set);
+	if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set) < 0)
+		pr_err("Could not set affinity\n");
+
+	fd = sys_perf_event_open(&attr, 0, -1, -1,
+				 perf_event_open_cloexec_flag());
+	if (fd < 0) {
+		pr_err("Error: sys_perf_event_open() syscall returned with %d (%s)\n", fd,
+		       str_error_r(errno, sbuf, sizeof(sbuf)));
+		return -1;
+	}
+
+	addr = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (addr == (void *)(-1)) {
+		pr_err("Error: mmap() syscall returned with (%s)\n",
+		       str_error_r(errno, sbuf, sizeof(sbuf)));
+		goto out_close;
+	}
+
+	if (mmap_read_check_user_access(addr, false))
+		goto out_close;
+
+	perf_cpu_map__for_each_cpu(cpu, cputmp, pmu->cpus) {
+		CPU_ZERO(&cpu_set);
+		CPU_SET(cpu, &cpu_set);
+		if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set) < 0)
+			pr_err("Could not set affinity\n");
+
+		pr_debug("Running on CPU %d\n", cpu);
+
+		ret = run_test(addr);
+		if (ret)
+			break;
+	}
+
+	munmap(addr, page_size);
+	pr_debug("   ");
+
+out_close:
+	close(fd);
+	return ret;
+}
+
+static int __test__rd_pmevcntr(u64 config, bool cnt64)
+{
+	int ret = -1;
+	int fd;
+	void *addr;
+	struct perf_event_attr attr = {
+		.type = PERF_TYPE_HARDWARE,
+		.config = config,
+		.config1 = cnt64,
+		.exclude_kernel = 1,
+	};
+	char sbuf[STRERR_BUFSIZE];
+
+	fd = sys_perf_event_open(&attr, 0, -1, -1,
+				 perf_event_open_cloexec_flag());
+	if (fd < 0) {
+		pr_err("Error: sys_perf_event_open() syscall returned with %d (%s)\n", fd,
+		       str_error_r(errno, sbuf, sizeof(sbuf)));
+		return -1;
+	}
+
+	addr = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (addr == (void *)(-1)) {
+		pr_err("Error: mmap() syscall returned with (%s)\n",
+		       str_error_r(errno, sbuf, sizeof(sbuf)));
+		goto out_close;
+	}
+
+	if (mmap_read_check_user_access(addr, cnt64))
+		goto out_close;
+
+	ret = run_test(addr);
+
+	munmap(addr, page_size);
+	pr_debug("   ");
+
+out_close:
+	close(fd);
+	return ret;
+}
+
+int test__rd_pinned(struct test __maybe_unused *test,
+		       int __maybe_unused subtest)
+{
+	int status = 0;
+	int wret = 0;
+	int ret = 0;
+	int pid;
+
+	pid = fork();
+	if (pid < 0)
+		return -1;
+
+	if (!pid) {
+		ret = __test__rd_pinned();
+		exit(ret);
+	}
+
+	wret = waitpid(pid, &status, 0);
+	if (wret < 0)
+		return -1;
+
+	if (WIFSIGNALED(status)) {
+		pr_err("Error: the child process was interrupted by a signal\n");
+		return -1;
+	}
+
+	if (WIFEXITED(status) && WEXITSTATUS(status)) {
+		pr_err("Error: the child process exited with: %d\n",
+		       WEXITSTATUS(status));
+		return -1;
+	}
+
+	return 0;
+}
+
+int test__rd_pmevcntr(struct test __maybe_unused *test,
+		     int __maybe_unused subtest)
+{
+	int status = 0;
+	int wret = 0;
+	int ret = 0;
+	int pid;
+
+	if (!pmu_is_homogeneous())
+		return TEST_SKIP;
+
+	pid = fork();
+	if (pid < 0)
+		return -1;
+
+	if (!pid) {
+		ret = __test__rd_pmevcntr(PERF_COUNT_HW_INSTRUCTIONS, 0);
+		exit(ret);
+	}
+
+	wret = waitpid(pid, &status, 0);
+	if (wret < 0)
+		return -1;
+
+	if (WIFSIGNALED(status)) {
+		pr_err("Error: the child process was interrupted by a signal\n");
+		return -1;
+	}
+
+	if (WIFEXITED(status) && WEXITSTATUS(status)) {
+		pr_err("Error: the child process exited with: %d\n",
+		       WEXITSTATUS(status));
+		return -1;
+	}
+
+	return 0;
+}
+
+int test__rd_pmccntr(struct test __maybe_unused *test,
+		     int __maybe_unused subtest)
+{
+	int status = 0;
+	int wret = 0;
+	int ret = 0;
+	int pid;
+
+	if (!pmu_is_homogeneous())
+		return TEST_SKIP;
+
+	pid = fork();
+	if (pid < 0)
+		return -1;
+
+	if (!pid) {
+		ret = __test__rd_pmevcntr(PERF_COUNT_HW_CPU_CYCLES, 1);
+		exit(ret);
+	}
+
+	wret = waitpid(pid, &status, 0);
+	if (wret < 0)
+		return -1;
+
+	if (WIFSIGNALED(status)) {
+		pr_err("Error: the child process was interrupted by a signal\n");
+		return -1;
+	}
+
+	if (WIFEXITED(status) && WEXITSTATUS(status)) {
+		pr_err("Error: the child process exited with: %d\n",
+		       WEXITSTATUS(status));
+		return -1;
+	}
+
+	return 0;
+}
--
2.25.1
