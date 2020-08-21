Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2A1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 069BB207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgHUT7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:59:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:3376 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgHUT7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:59:13 -0400
IronPort-SDR: yV/s0UR8RM7sw92NVY3w2qFjmN2Q/loV+CoFpjzXMVXg1r9BZddPiBGcLXzvVQRyhdnBGkiuvA
 inTfjJZoYozw==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="155604704"
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="155604704"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 12:59:11 -0700
IronPort-SDR: Y9bW1I0j1Otdrjpp+XDaAMgDE4RWLsbcTlv7GT+qk5hgUwXjiy2JCpBnVHnG8uHgzcglQELXE1
 t2l+A3oZIQfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="330137773"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by fmsmga002.fm.intel.com with ESMTP; 21 Aug 2020 12:59:11 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, mark.rutland@arm.com, luto@amacapital.net,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 3/3] perf/x86: Reset the dirty counter to prevent the leak for an RDPMC task
Date:   Fri, 21 Aug 2020 12:57:54 -0700
Message-Id: <20200821195754.20159-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200821195754.20159-1-kan.liang@linux.intel.com>
References: <20200821195754.20159-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The counter value of a perf task may leak to another RDPMC task.
For example, a perf stat task as below is running on CPU 0.

    perf stat -e 'branches,cycles' -- taskset -c 0 ./workload

In the meantime, an RDPMC task, which is also running on CPU 0, may read
the GP counters periodically. (The RDPMC task creates a fixed event,
but read four GP counters.)

    $ taskset -c 0 ./rdpmc_read_all_counters
    index 0x0 value 0x8001e5970f99
    index 0x1 value 0x8005d750edb6
    index 0x2 value 0x0
    index 0x3 value 0x0

    index 0x0 value 0x8002358e48a5
    index 0x1 value 0x8006bd1e3bc9
    index 0x2 value 0x0
    index 0x3 value 0x0

It is a potential security issue. Once the attacker knows what the other
thread is counting. The PerfMon counter can be used as a side-channel to
attack cryptosystems.

The counter value of the perf stat task leaks to the RDPMC task because
perf never clears the counter when it's stopped.

Two methods were considered to address the issue.
- Unconditionally reset the counter in x86_pmu_del(). It can bring extra
  overhead even when there is no RDPMC task running.
- Only reset the un-assigned dirty counters when the RDPMC task is
  scheduled in. The method is implemented here.

The dirty counter is a counter, on which the assigned event has been
deleted, but the counter is not reset. To track the dirty counters,
add a 'dirty' variable in the struct cpu_hw_events. The 'running'
variable is only used in P4 PMU, which doesn't support the RDPMC. Share
the memory space between the 'dirty' and the 'running' variable.

The current code doesn't reset the counter when the assigned event is
deleted. Set the corresponding bit in the 'dirty' variable in
x86_pmu_del(), if the RDPMC feature is available on the system.

The security issue can only be found with an RDPMC task. The event for
an RDPMC task is a non-sampling event, and requires the mmap buffer.
This can be used to detect an RDPMC task. Once the event is detected in
the event_mapped(), enable sched_task(), which is invoked in each
context switch. Add a check in the sched_task() to clear the dirty
counters, when the RDPMC task is scheduled in. Only the current
un-assigned dirty counters are reset, bacuase the RDPMC assigned dirty
counters will be updated soon.

The RDPMC instruction is also supported on the older platforms. Add
sched_task() for the core_pmu. The core_pmu doesn't support large PEBS
and LBR callstack, the intel_pmu_pebs/lbr_sched_task() will be ignored.

After applying the patch,

        $ taskset -c 0 ./rdpmc_read_all_counters
        index 0x0 value 0x0
        index 0x1 value 0x0
        index 0x2 value 0x0
        index 0x3 value 0x0

        index 0x0 value 0x0
        index 0x1 value 0x0
        index 0x2 value 0x0
        index 0x3 value 0x0

Performance

The performance of a context switch only be impacted when there are two
or more perf users and one of the users must be an RDPMC user. In other
cases, there is no performance impact.

The worst-case occurs when there are two users: the RDPMC user only
applies one counter; while the other user applies all available
counters. When the RDPMC task is scheduled in, all the counters, other
than the RDPMC assigned one, have to be reset.

Here is the test result for the worst-case.

The test is implemented on an Ice Lake platform, which has 8 GP
counters and 3 fixed counters (Not include SLOTS counter).

The lat_ctx is used to measure the context switching time.

    lat_ctx -s 128K -N 1000 processes 2

It creates 2 tasks. One task opens all 8 GP counters and 3 fixed
counters. The other task opens a fixed counter and enable RDPMC.

Without the patch:
The context switch time is 4.74 us
The context switch number per second is ~125K (from vmstat 1)

With the patch:
The context switch time is 5.19 us
The context switch number per second is ~118K

There is ~9% performance drop for the context switching time in the
worst-case.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Drop the old method, which unconditionally reset the counter in
  x86_pmu_del().
  Only reset the dirty counters when a RDPMC task is sheduled in.


 arch/x86/events/core.c       | 45 +++++++++++++++++++++++++++++++++++-
 arch/x86/events/intel/core.c | 29 +++++++++++++++++++++++
 arch/x86/events/perf_event.h |  7 +++++-
 3 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0f3d01562ded..fa08d810dcd2 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1440,7 +1440,10 @@ static void x86_pmu_start(struct perf_event *event, int flags)
 
 	cpuc->events[idx] = event;
 	__set_bit(idx, cpuc->active_mask);
-	__set_bit(idx, cpuc->running);
+	/* The cpuc->running is only used by the P4 PMU */
+	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON) &&
+	    (boot_cpu_data.x86 == 0xf))
+		__set_bit(idx, cpuc->running);
 	x86_pmu.enable(event);
 	perf_event_update_userpage(event);
 }
@@ -1544,6 +1547,9 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		goto do_del;
 
+	if (READ_ONCE(x86_pmu.attr_rdpmc) && x86_pmu.sched_task &&
+	    test_bit(event->hw.idx, cpuc->active_mask))
+		__set_bit(event->hw.idx, cpuc->dirty);
 	/*
 	 * Not a TXN, therefore cleanup properly.
 	 */
@@ -2219,11 +2225,45 @@ static int x86_pmu_event_init(struct perf_event *event)
 	return err;
 }
 
+void x86_pmu_clear_dirty_counters(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int i;
+
+	if (bitmap_empty(cpuc->dirty, X86_PMC_IDX_MAX))
+		return;
+
+	 /* Don't need to clear the assigned counter. */
+	for (i = 0; i < cpuc->n_events; i++)
+		__clear_bit(cpuc->assign[i], cpuc->dirty);
+
+	for_each_set_bit(i, cpuc->dirty, X86_PMC_IDX_MAX) {
+		/* Metrics events don't have corresponding HW counters. */
+		if (is_metric_idx(i))
+			continue;
+		else if (i >= INTEL_PMC_IDX_FIXED)
+			wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + (i - INTEL_PMC_IDX_FIXED), 0);
+		else
+			wrmsrl(x86_pmu_event_addr(i), 0);
+	}
+
+	bitmap_zero(cpuc->dirty, X86_PMC_IDX_MAX);
+}
+
 static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
 {
 	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
 		return;
 
+	/*
+	 * Enable sched_task() for the RDPMC task,
+	 * and clear the existing dirty counters.
+	 */
+	if (x86_pmu.sched_task && event->hw.target && !is_sampling_event(event)) {
+		perf_sched_cb_inc(event->ctx->pmu);
+		x86_pmu_clear_dirty_counters();
+	}
+
 	/*
 	 * This function relies on not being called concurrently in two
 	 * tasks in the same mm.  Otherwise one task could observe
@@ -2246,6 +2286,9 @@ static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *m
 	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
 		return;
 
+	if (x86_pmu.sched_task && event->hw.target && !is_sampling_event(event))
+		perf_sched_cb_dec(event->ctx->pmu);
+
 	if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
 		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
 }
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c72e4904e056..e67713bfa33a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4166,11 +4166,39 @@ static void intel_pmu_cpu_dead(int cpu)
 	intel_cpuc_finish(&per_cpu(cpu_hw_events, cpu));
 }
 
+static void intel_pmu_rdpmc_sched_task(struct perf_event_context *ctx)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct perf_event *event;
+
+	if (bitmap_empty(cpuc->dirty, X86_PMC_IDX_MAX))
+		return;
+
+	/*
+	 * If the new task has the RDPMC enabled, clear the dirty counters to
+	 * prevent the potential leak. If the new task doesn't have the RDPMC
+	 * enabled, do nothing.
+	 */
+	list_for_each_entry(event, &ctx->event_list, event_entry) {
+		if (event->hw.target &&
+		    (event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED) &&
+		    !is_sampling_event(event) &&
+		    atomic_read(&event->mmap_count))
+			break;
+	}
+	if (&event->event_entry == &ctx->event_list)
+		return;
+
+	x86_pmu_clear_dirty_counters();
+}
+
 static void intel_pmu_sched_task(struct perf_event_context *ctx,
 				 bool sched_in)
 {
 	intel_pmu_pebs_sched_task(ctx, sched_in);
 	intel_pmu_lbr_sched_task(ctx, sched_in);
+	if (sched_in && READ_ONCE(x86_pmu.attr_rdpmc))
+		intel_pmu_rdpmc_sched_task(ctx);
 }
 
 static void intel_pmu_swap_task_ctx(struct perf_event_context *prev,
@@ -4273,6 +4301,7 @@ static __initconst const struct x86_pmu core_pmu = {
 	.cpu_dying		= intel_pmu_cpu_dying,
 	.cpu_dead		= intel_pmu_cpu_dead,
 
+	.sched_task		= intel_pmu_sched_task,
 	.check_period		= intel_pmu_check_period,
 
 	.lbr_reset		= intel_pmu_lbr_reset_64,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 345442410a4d..52e7650cece5 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -227,7 +227,10 @@ struct cpu_hw_events {
 	 */
 	struct perf_event	*events[X86_PMC_IDX_MAX]; /* in counter order */
 	unsigned long		active_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
-	unsigned long		running[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	union {
+		unsigned long	running[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+		unsigned long	dirty[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	};
 	int			enabled;
 
 	int			n_events; /* the # of events in the below arrays */
@@ -1016,6 +1019,8 @@ void x86_pmu_enable_event(struct perf_event *event);
 
 int x86_pmu_handle_irq(struct pt_regs *regs);
 
+void x86_pmu_clear_dirty_counters(void);
+
 extern struct event_constraint emptyconstraint;
 
 extern struct event_constraint unconstrained;
-- 
2.17.1

