Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D7FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB9C0206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594338962;
	bh=mOCiCawmSzJSH8oozt+tB3Xsg+QRar8YSiGNW7hyiPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=isnWY0H5vcNpov9MkQ6UNlSf76fcfCEidqwTZt/cowVp8YbWkcXCCLCGpDjn7upy8
	 RZNILofK+3LZUrGTCogwfoJdP6O8dnYnsmhoH+hmk5qJR9xOwaiq9rR/A7tnvLmZtn
	 +AKwz2tvq+uF8kgeeKWB6jGwe40PmmF0o/o81uGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGIX4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:56:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgGIX4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:56:00 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 965D520774;
        Thu,  9 Jul 2020 23:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594338959;
        bh=mOCiCawmSzJSH8oozt+tB3Xsg+QRar8YSiGNW7hyiPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XbA79lwePffqVaS7RK4RXTyLu6w1lPkDcf4i958kFD0PxP8LWe2mNlIKiLmDPmbq8
         KA9DPrpsV0doOBXXTtm8f4pwR6OiHQVocDeVU1A1yubGl4oWa2Aj09qksbAOlmJS2a
         gZk1aBQr0GNOhzhqTwndb6nEdgpCpmP5zKYD9pJQ=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, frederic@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH smp 2/2] kernel/smp: Provide CSD lock timeout diagnostics
Date:   Thu,  9 Jul 2020 16:55:57 -0700
Message-Id: <20200709235557.21080-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200709235436.GA20922@paulmck-ThinkPad-P72>
References: <20200709235436.GA20922@paulmck-ThinkPad-P72>
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

[ paulmck: Avoid 64-bit divides per kernel test robot feedback. ]
[ paulmck: Fix for syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com ]
[ paulmck: Fix KASAN use-after-free issue reported by Qian Cai. ]
[ paulmck: Fix botched nr_cpu_ids comparison per Dan Carpenter. ]
Link: https://lore.kernel.org/lkml/00000000000042f21905a991ecea@google.com
Link: https://lore.kernel.org/lkml/0000000000002ef21705a9933cf3@google.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/smp.c      | 133 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 lib/Kconfig.debug |  10 ++++
 2 files changed, 142 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 148d991..f292a7e 100644
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
@@ -34,6 +37,10 @@ struct call_function_data {
 
 static DEFINE_PER_CPU_ALIGNED(struct call_function_data, cfd_data);
 
+static DEFINE_PER_CPU(call_single_data_t *, cur_csd);
+static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
+static DEFINE_PER_CPU(void *, cur_csd_info);
+
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue);
 
 static void flush_smp_call_function_queue(bool warn_cpu_offline);
@@ -96,6 +103,106 @@ void __init call_function_init(void)
 	smpcfd_prepare_cpu(smp_processor_id());
 }
 
+#define CSD_LOCK_TIMEOUT (5 * 1000ULL) /* Milliseconds. */
+atomic_t csd_bug_count = ATOMIC_INIT(0);
+
+/* Record current CSD work for current CPU, NULL to erase. */
+static void csd_lock_record(call_single_data_t *csd)
+{
+	if (!csd) {
+		smp_mb(); // NULL cur_csd after unlock.
+		__this_cpu_write(cur_csd, NULL);
+		return;
+	}
+	__this_cpu_write(cur_csd, csd);
+	__this_cpu_write(cur_csd_func, csd->func);
+	__this_cpu_write(cur_csd_info, csd->info);
+	smp_mb(); // Update cur_csd before function call.
+		  // Or before unlock, as the case may be.
+}
+
+static __always_inline int csd_lock_wait_getcpu(call_single_data_t *csd)
+{
+	unsigned int csd_type;
+
+	csd_type = CSD_TYPE(csd);
+#ifdef CONFIG_64BIT
+	if (csd_type == CSD_TYPE_ASYNC || csd_type == CSD_TYPE_SYNC)
+		return csd->dst; // Other CSD_TYPE_ values might not have ->dst.
+#endif
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
+	call_single_data_t *cpu_cur_csd;
+	bool firsttime;
+	unsigned int flags = READ_ONCE(csd->flags);
+	u64 quo;
+	u32 rem;
+	u64 ts2, ts_delta;
+
+	if (!(flags & CSD_FLAG_LOCK)) {
+		if (!unlikely(*bug_id))
+			return true;
+		cpu = csd_lock_wait_getcpu(csd);
+		if (cpu >= 0)
+			pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, CPU#%02d released the lock after all. Phew!\n", *bug_id, raw_smp_processor_id(), cpu);
+		else
+			pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, the lock was released after all. Phew!\n", *bug_id, raw_smp_processor_id());
+		return true;
+	}
+
+	ts2 = div_u64_rem(sched_clock(), 1000 * 1000, &rem);
+	ts_delta = ts2 - *ts1;
+	if (likely(ts_delta <= CSD_LOCK_TIMEOUT)) {
+		cpu_relax();
+		return false;
+	}
+
+	firsttime = !*bug_id;
+	if (firsttime)
+		*bug_id = atomic_inc_return(&csd_bug_count);
+	cpu = csd_lock_wait_getcpu(csd);
+	smp_mb(); // No stale cur_csd values!
+	if (WARN_ONCE(cpu < 0 || cpu >= nr_cpu_ids, "%s: cpu = %d\n", __func__, cpu))
+		cpu_cur_csd = READ_ONCE(per_cpu(cur_csd, 0));
+	else
+		cpu_cur_csd = READ_ONCE(per_cpu(cur_csd, cpu));
+	smp_mb(); // No refetching cur_csd values!
+	quo = div_u64_rem(ts2 - ts0, 1000, &rem);
+#define CSD_FORMAT_PREFIX "csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu.%03u secs for CPU#%02d %pS(%ps), currently"
+#define CSD_ARGS_PREFIX firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), \
+	quo, rem, cpu, csd->func, csd->info
+	if (cpu_cur_csd && csd != cpu_cur_csd)
+		pr_alert(CSD_FORMAT_PREFIX " handling prior %pS(%ps) request.\n",
+			 CSD_ARGS_PREFIX, cpu_cur_csd->func, cpu_cur_csd->info);
+	else
+		pr_alert(CSD_FORMAT_PREFIX " %s.\n", CSD_ARGS_PREFIX,
+			 !cpu_cur_csd ? "unresponsive" : "handling this request");
+#undef CSD_FORMAT_PREFIX
+#undef CSD_ARGS_PREFIX
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
+	cpu_relax();
+
+	return false;
+}
+
 /*
  * csd_lock/csd_unlock used to serialize access to per-cpu csd resources
  *
@@ -105,7 +212,19 @@ void __init call_function_init(void)
  */
 static __always_inline void csd_lock_wait(call_single_data_t *csd)
 {
-	smp_cond_load_acquire(&csd->flags, !(VAL & CSD_FLAG_LOCK));
+	int bug_id = 0;
+	u32 rem;
+	u64 ts0, ts1;
+
+	if (!IS_ENABLED(CONFIG_CSD_LOCK_WAIT_DEBUG)) {
+		smp_cond_load_acquire(&csd->flags, !(VAL & CSD_FLAG_LOCK));
+		return;
+	}
+	ts1 = ts0 = div_u64_rem(sched_clock(), 1000 * 1000, &rem);
+	for (;;)
+		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id))
+			break;
+	smp_acquire__after_ctrl_dep();
 }
 
 static __always_inline void csd_lock(call_single_data_t *csd)
@@ -166,9 +285,11 @@ static int generic_exec_single(int cpu, call_single_data_t *csd)
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
@@ -268,8 +389,10 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 				entry = &csd_next->llist;
 			}
 
+			csd_lock_record(csd);
 			func(info);
 			csd_unlock(csd);
+			csd_lock_record(NULL);
 		} else {
 			prev = &csd->llist;
 		}
@@ -296,8 +419,10 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 				smp_call_func_t func = csd->func;
 				void *info = csd->info;
 
+				csd_lock_record(csd);
 				csd_unlock(csd);
 				func(info);
+				csd_lock_record(NULL);
 			} else if (type == CSD_TYPE_IRQ_WORK) {
 				irq_work_single(csd);
 			}
@@ -375,7 +500,10 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 
 	csd->func = func;
 	csd->info = info;
+#ifdef CONFIG_64BIT
+	csd->src = smp_processor_id();
 	csd->dst = cpu;
+#endif
 
 	err = generic_exec_single(cpu, csd);
 
@@ -541,7 +669,10 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 			csd->flags |= CSD_TYPE_SYNC;
 		csd->func = func;
 		csd->info = info;
+#ifdef CONFIG_64BIT
+		csd->src = smp_processor_id();
 		csd->dst = cpu;
+#endif
 		if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
 			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 	}
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 669f4d3..22443fa3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1332,6 +1332,16 @@ config SCF_TORTURE_TEST
 	  module may be built after the fact on the running kernel to
 	  be tested, if desired.
 
+config CSD_LOCK_WAIT_DEBUG
+	bool "Debugging for csd_lock_wait(), called from smp_call_function*()"
+	depends on DEBUG_KERNEL
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

