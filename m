Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0BDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73CA620838
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595894129;
	bh=KcCEWS52S2QsBri0LP2Q9KH4ugrMl+8/Vd5KHvS7mXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E0CZC89Op4Lu1P4Qmcr5dXCGrGvjkpaA7M+Lqkp9aw7D/27FHyRYtq4Rs/flUCzs+
	 Y5hvc47hEM2IxOxQhFgdjw1UOM7dhhYrHRlj1wNqVyMNxjhSwLZ7WPC4Jbv2vbkHQn
	 3cFy4eqniJFBgh+bKh4a+IVKvx0P2qB1juNVcZ2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgG0Xz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:55:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgG0Xz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:55:27 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80AD0208E4;
        Mon, 27 Jul 2020 23:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595894126;
        bh=KcCEWS52S2QsBri0LP2Q9KH4ugrMl+8/Vd5KHvS7mXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IJEsFZj9ZVgwg7YoMX+sINMvTwP+LRNrBr/scsmreKdBbyIXgPIp9BtJe9XyrMAE5
         7Xce6mWvMplXFvxoeMGldojcbE8ML4tzStlHa2Wb5ZIpeWtHqDYRPVcKghJiOYzvR6
         KuLkkOk1zkpZhF7g9qPod4nOqwv2a7X6kIaPCjxs=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, peterz@infradead.org, mingo@kernel.org,
        tglx@linutronix.de, bigeasy@linutronix.de, frederic@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH smp v2 2/3] kernel/smp: Provide CSD lock timeout diagnostics
Date:   Mon, 27 Jul 2020 16:55:23 -0700
Message-Id: <20200727235524.828-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200727235343.GA30963@paulmck-ThinkPad-P72>
References: <20200727235343.GA30963@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit causes csd_lock_wait() to emit diagnostics when a CPU
fails to respond quickly enough to one of the smp_call_function()
family of function calls.  These diagnostics are enabled by a new
CSD_LOCK_WAIT_DEBUG Kconfig option that depends on DEBUG_KERNEL.

This commit was inspired by an earlier patch by Josef Bacik.

[ paulmck: Fix for syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com ]
[ paulmck: Fix KASAN use-after-free issue reported by Qian Cai. ]
[ paulmck: Fix botched nr_cpu_ids comparison per Dan Carpenter. ]
[ paulmck: Apply Peter Zijlstra feedback. ]
Link: https://lore.kernel.org/lkml/00000000000042f21905a991ecea@google.com
Link: https://lore.kernel.org/lkml/0000000000002ef21705a9933cf3@google.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/smp.c      | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug |  11 +++++
 2 files changed, 143 insertions(+)

diff --git a/kernel/smp.c b/kernel/smp.c
index 148d991..3830f93 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -20,6 +20,9 @@
 #include <linux/sched.h>
 #include <linux/sched/idle.h>
 #include <linux/hypervisor.h>
+#include <linux/sched/clock.h>
+#include <linux/nmi.h>
+#include <linux/sched/debug.h>
 
 #include "smpboot.h"
 #include "sched/smp.h"
@@ -96,6 +99,103 @@ void __init call_function_init(void)
 	smpcfd_prepare_cpu(smp_processor_id());
 }
 
+#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
+
+static DEFINE_PER_CPU(call_single_data_t *, cur_csd);
+static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
+static DEFINE_PER_CPU(void *, cur_csd_info);
+
+#define CSD_LOCK_TIMEOUT (5ULL * NSEC_PER_SEC)
+atomic_t csd_bug_count = ATOMIC_INIT(0);
+
+/* Record current CSD work for current CPU, NULL to erase. */
+static void csd_lock_record(call_single_data_t *csd)
+{
+	if (!csd) {
+		smp_mb(); /* NULL cur_csd after unlock. */
+		__this_cpu_write(cur_csd, NULL);
+		return;
+	}
+	__this_cpu_write(cur_csd_func, csd->func);
+	__this_cpu_write(cur_csd_info, csd->info);
+	smp_wmb(); /* func and info before csd. */
+	__this_cpu_write(cur_csd, csd);
+	smp_mb(); /* Update cur_csd before function call. */
+		  /* Or before unlock, as the case may be. */
+}
+
+static __always_inline int csd_lock_wait_getcpu(call_single_data_t *csd)
+{
+	unsigned int csd_type;
+
+	csd_type = CSD_TYPE(csd);
+	if (csd_type == CSD_TYPE_ASYNC || csd_type == CSD_TYPE_SYNC)
+		return csd->dst; /* Other CSD_TYPE_ values might not have ->dst. */
+	return -1;
+}
+
+/*
+ * Complain if too much time spent waiting.  Note that only
+ * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
+ * so waiting on other types gets much less information.
+ */
+static __always_inline bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
+{
+	int cpu = -1;
+	int cpux;
+	bool firsttime;
+	u64 ts2, ts_delta;
+	call_single_data_t *cpu_cur_csd;
+	unsigned int flags = READ_ONCE(csd->flags);
+
+	if (!(flags & CSD_FLAG_LOCK)) {
+		if (!unlikely(*bug_id))
+			return true;
+		cpu = csd_lock_wait_getcpu(csd);
+		pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, CPU#%02d released the lock.\n",
+			 *bug_id, raw_smp_processor_id(), cpu);
+		return true;
+	}
+
+	ts2 = sched_clock();
+	ts_delta = ts2 - *ts1;
+	if (likely(ts_delta <= CSD_LOCK_TIMEOUT))
+		return false;
+
+	firsttime = !*bug_id;
+	if (firsttime)
+		*bug_id = atomic_inc_return(&csd_bug_count);
+	cpu = csd_lock_wait_getcpu(csd);
+	if (WARN_ONCE(cpu < 0 || cpu >= nr_cpu_ids, "%s: cpu = %d\n", __func__, cpu))
+		cpux = 0;
+	else
+		cpux = cpu;
+	cpu_cur_csd = smp_load_acquire(&per_cpu(cur_csd, cpux)); /* Before func and info. */
+	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu ns for CPU#%02d %pS(%ps).\n",
+		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts2 - ts0,
+		 cpu, csd->func, csd->info);
+	if (cpu_cur_csd && csd != cpu_cur_csd) {
+		pr_alert("\tcsd: CSD lock (#%d) handling prior %pS(%ps) request.\n",
+			 *bug_id, READ_ONCE(per_cpu(cur_csd_func, cpux)),
+			 READ_ONCE(per_cpu(cur_csd_info, cpux)));
+	} else {
+		pr_alert("\tcsd: CSD lock (#%d) %s.\n",
+			 *bug_id, !cpu_cur_csd ? "unresponsive" : "handling this request");
+	}
+	if (cpu >= 0) {
+		if (!trigger_single_cpu_backtrace(cpu))
+			dump_cpu_task(cpu);
+		if (!cpu_cur_csd) {
+			pr_alert("csd: Re-sending CSD lock (#%d) IPI from CPU#%02d to CPU#%02d\n", *bug_id, raw_smp_processor_id(), cpu);
+			arch_send_call_function_single_ipi(cpu);
+		}
+	}
+	dump_stack();
+	*ts1 = ts2;
+
+	return false;
+}
+
 /*
  * csd_lock/csd_unlock used to serialize access to per-cpu csd resources
  *
@@ -105,8 +205,28 @@ void __init call_function_init(void)
  */
 static __always_inline void csd_lock_wait(call_single_data_t *csd)
 {
+	int bug_id = 0;
+	u64 ts0, ts1;
+
+	ts1 = ts0 = sched_clock();
+	for (;;) {
+		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id))
+			break;
+		cpu_relax();
+	}
+	smp_acquire__after_ctrl_dep();
+}
+
+#else
+static void csd_lock_record(call_single_data_t *csd)
+{
+}
+
+static __always_inline void csd_lock_wait(call_single_data_t *csd)
+{
 	smp_cond_load_acquire(&csd->flags, !(VAL & CSD_FLAG_LOCK));
 }
+#endif
 
 static __always_inline void csd_lock(call_single_data_t *csd)
 {
@@ -166,9 +286,11 @@ static int generic_exec_single(int cpu, call_single_data_t *csd)
 		 * We can unlock early even for the synchronous on-stack case,
 		 * since we're doing this from the same CPU..
 		 */
+		csd_lock_record(csd);
 		csd_unlock(csd);
 		local_irq_save(flags);
 		func(info);
+		csd_lock_record(NULL);
 		local_irq_restore(flags);
 		return 0;
 	}
@@ -268,8 +390,10 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 				entry = &csd_next->llist;
 			}
 
+			csd_lock_record(csd);
 			func(info);
 			csd_unlock(csd);
+			csd_lock_record(NULL);
 		} else {
 			prev = &csd->llist;
 		}
@@ -296,8 +420,10 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 				smp_call_func_t func = csd->func;
 				void *info = csd->info;
 
+				csd_lock_record(csd);
 				csd_unlock(csd);
 				func(info);
+				csd_lock_record(NULL);
 			} else if (type == CSD_TYPE_IRQ_WORK) {
 				irq_work_single(csd);
 			}
@@ -375,7 +501,10 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 
 	csd->func = func;
 	csd->info = info;
+#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
+	csd->src = smp_processor_id();
 	csd->dst = cpu;
+#endif
 
 	err = generic_exec_single(cpu, csd);
 
@@ -541,7 +670,10 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 			csd->flags |= CSD_TYPE_SYNC;
 		csd->func = func;
 		csd->info = info;
+#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
+		csd->src = smp_processor_id();
 		csd->dst = cpu;
+#endif
 		if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
 			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 	}
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 669f4d3..5cd8deb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1332,6 +1332,17 @@ config SCF_TORTURE_TEST
 	  module may be built after the fact on the running kernel to
 	  be tested, if desired.
 
+config CSD_LOCK_WAIT_DEBUG
+	bool "Debugging for csd_lock_wait(), called from smp_call_function*()"
+	depends on DEBUG_KERNEL
+	depends on 64BIT
+	default n
+	help
+	  This option enables debug prints when CPUs are slow to respond
+	  to the smp_call_function*() IPI wrappers.  These debug prints
+	  include the IPI handler function currently executing (if any)
+	  and relevant stack traces.
+
 endmenu # lock debugging
 
 config TRACE_IRQFLAGS
-- 
2.9.5

