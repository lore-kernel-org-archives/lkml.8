Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D162C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30C562067C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zuf5m984";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQZJN4MR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgIALzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:55:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39614 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgIALs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:48:28 -0400
Date:   Tue, 01 Sep 2020 11:48:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960882;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=be5b2gJXkhE9gLzmWEtiWHjxErymWvKCYaQDu0U8Dn8=;
        b=zuf5m984xPbhWB13zUg8OElQDzEeD3kob9PJgGvOc4hTpqNoM2c2YhioUm9+1wFcVpe7U3
        OXvcUIQQtbXJewZdcf7sIiRsx21aKrL0txuxXO8hAs39Y3ICe5MqFb8EINmhBIv8P8Wzsc
        KYFabB5QEpxKZRewL62ZOxkIuwz3z90u6OkErovIJ8hyT+Cjfzn8G/Jj3nP6NhnYhnn43g
        313NxPfmIh4ieKe0IAOjO4DZlkUOUQlifiP7sGB70S/vaLvqgBEbgU3lZXAaqGoea3hlFf
        DtsQVeHkUTFhqGLManmx5uRsbLobBaB22lReOEcjYJkQ1doOvzAOfcnMSEzpAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960882;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=be5b2gJXkhE9gLzmWEtiWHjxErymWvKCYaQDu0U8Dn8=;
        b=GQZJN4MRM5gf5mE3THIG3ipUW/4o0fAlGkHBzdGycfT8SFiC2OZ7gSB+1W3qvntJFxJix/
        QoDByLSx8GwQmaCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/static_call] x86/perf, static_call: Optimize x86_pmu methods
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818135805.338001015@infradead.org>
References: <20200818135805.338001015@infradead.org>
MIME-Version: 1.0
Message-ID: <159896088203.20229.18201547304769937601.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/static_call branch of tip:

Commit-ID:     7c9903c9bf716d89b34f96cc2ed64e28dabf570b
Gitweb:        https://git.kernel.org/tip/7c9903c9bf716d89b34f96cc2ed64e28dabf570b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 18 Aug 2020 15:57:53 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:58:06 +02:00

x86/perf, static_call: Optimize x86_pmu methods

Replace many of the indirect calls with static_call().

The average PMI time, as measured by perf_sample_event_took()*:

  PRE:    3283.03 [ns]
  POST:   3145.12 [ns]

Which is a ~138 [ns] win per PMI, or a ~4.2% decrease.

[*] on an IVB-EP, using: 'perf record -a -e cycles -- make O=defconfig-build/ -j80'

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20200818135805.338001015@infradead.org
---
 arch/x86/events/core.c | 134 ++++++++++++++++++++++++++++------------
 1 file changed, 94 insertions(+), 40 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1cbf57d..360c395 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -28,6 +28,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/nospec.h>
+#include <linux/static_call.h>
 
 #include <asm/apic.h>
 #include <asm/stacktrace.h>
@@ -52,6 +53,34 @@ DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
 DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
 DEFINE_STATIC_KEY_FALSE(rdpmc_always_available_key);
 
+/*
+ * This here uses DEFINE_STATIC_CALL_NULL() to get a static_call defined
+ * from just a typename, as opposed to an actual function.
+ */
+DEFINE_STATIC_CALL_NULL(x86_pmu_handle_irq,  *x86_pmu.handle_irq);
+DEFINE_STATIC_CALL_NULL(x86_pmu_disable_all, *x86_pmu.disable_all);
+DEFINE_STATIC_CALL_NULL(x86_pmu_enable_all,  *x86_pmu.enable_all);
+DEFINE_STATIC_CALL_NULL(x86_pmu_enable,	     *x86_pmu.enable);
+DEFINE_STATIC_CALL_NULL(x86_pmu_disable,     *x86_pmu.disable);
+
+DEFINE_STATIC_CALL_NULL(x86_pmu_add,  *x86_pmu.add);
+DEFINE_STATIC_CALL_NULL(x86_pmu_del,  *x86_pmu.del);
+DEFINE_STATIC_CALL_NULL(x86_pmu_read, *x86_pmu.read);
+
+DEFINE_STATIC_CALL_NULL(x86_pmu_schedule_events,       *x86_pmu.schedule_events);
+DEFINE_STATIC_CALL_NULL(x86_pmu_get_event_constraints, *x86_pmu.get_event_constraints);
+DEFINE_STATIC_CALL_NULL(x86_pmu_put_event_constraints, *x86_pmu.put_event_constraints);
+
+DEFINE_STATIC_CALL_NULL(x86_pmu_start_scheduling,  *x86_pmu.start_scheduling);
+DEFINE_STATIC_CALL_NULL(x86_pmu_commit_scheduling, *x86_pmu.commit_scheduling);
+DEFINE_STATIC_CALL_NULL(x86_pmu_stop_scheduling,   *x86_pmu.stop_scheduling);
+
+DEFINE_STATIC_CALL_NULL(x86_pmu_sched_task,    *x86_pmu.sched_task);
+DEFINE_STATIC_CALL_NULL(x86_pmu_swap_task_ctx, *x86_pmu.swap_task_ctx);
+
+DEFINE_STATIC_CALL_NULL(x86_pmu_drain_pebs,   *x86_pmu.drain_pebs);
+DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_aliases, *x86_pmu.pebs_aliases);
+
 u64 __read_mostly hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -660,7 +689,7 @@ static void x86_pmu_disable(struct pmu *pmu)
 	cpuc->enabled = 0;
 	barrier();
 
-	x86_pmu.disable_all();
+	static_call(x86_pmu_disable_all)();
 }
 
 void x86_pmu_enable_all(int added)
@@ -907,8 +936,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		n0 -= cpuc->n_txn;
 
-	if (x86_pmu.start_scheduling)
-		x86_pmu.start_scheduling(cpuc);
+	static_call_cond(x86_pmu_start_scheduling)(cpuc);
 
 	for (i = 0, wmin = X86_PMC_IDX_MAX, wmax = 0; i < n; i++) {
 		c = cpuc->event_constraint[i];
@@ -925,7 +953,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 		 * change due to external factors (sibling state, allow_tfa).
 		 */
 		if (!c || (c->flags & PERF_X86_EVENT_DYNAMIC)) {
-			c = x86_pmu.get_event_constraints(cpuc, i, cpuc->event_list[i]);
+			c = static_call(x86_pmu_get_event_constraints)(cpuc, i, cpuc->event_list[i]);
 			cpuc->event_constraint[i] = c;
 		}
 
@@ -1008,8 +1036,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	if (!unsched && assign) {
 		for (i = 0; i < n; i++) {
 			e = cpuc->event_list[i];
-			if (x86_pmu.commit_scheduling)
-				x86_pmu.commit_scheduling(cpuc, i, assign[i]);
+			static_call_cond(x86_pmu_commit_scheduling)(cpuc, i, assign[i]);
 		}
 	} else {
 		for (i = n0; i < n; i++) {
@@ -1018,15 +1045,13 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 			/*
 			 * release events that failed scheduling
 			 */
-			if (x86_pmu.put_event_constraints)
-				x86_pmu.put_event_constraints(cpuc, e);
+			static_call_cond(x86_pmu_put_event_constraints)(cpuc, e);
 
 			cpuc->event_constraint[i] = NULL;
 		}
 	}
 
-	if (x86_pmu.stop_scheduling)
-		x86_pmu.stop_scheduling(cpuc);
+	static_call_cond(x86_pmu_stop_scheduling)(cpuc);
 
 	return unsched ? -EINVAL : 0;
 }
@@ -1226,7 +1251,7 @@ static void x86_pmu_enable(struct pmu *pmu)
 	cpuc->enabled = 1;
 	barrier();
 
-	x86_pmu.enable_all(added);
+	static_call(x86_pmu_enable_all)(added);
 }
 
 static DEFINE_PER_CPU(u64 [X86_PMC_IDX_MAX], pmc_prev_left);
@@ -1347,7 +1372,7 @@ static int x86_pmu_add(struct perf_event *event, int flags)
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		goto done_collect;
 
-	ret = x86_pmu.schedule_events(cpuc, n, assign);
+	ret = static_call(x86_pmu_schedule_events)(cpuc, n, assign);
 	if (ret)
 		goto out;
 	/*
@@ -1365,13 +1390,11 @@ done_collect:
 	cpuc->n_added += n - n0;
 	cpuc->n_txn += n - n0;
 
-	if (x86_pmu.add) {
-		/*
-		 * This is before x86_pmu_enable() will call x86_pmu_start(),
-		 * so we enable LBRs before an event needs them etc..
-		 */
-		x86_pmu.add(event);
-	}
+	/*
+	 * This is before x86_pmu_enable() will call x86_pmu_start(),
+	 * so we enable LBRs before an event needs them etc..
+	 */
+	static_call_cond(x86_pmu_add)(event);
 
 	ret = 0;
 out:
@@ -1399,7 +1422,7 @@ static void x86_pmu_start(struct perf_event *event, int flags)
 	cpuc->events[idx] = event;
 	__set_bit(idx, cpuc->active_mask);
 	__set_bit(idx, cpuc->running);
-	x86_pmu.enable(event);
+	static_call(x86_pmu_enable)(event);
 	perf_event_update_userpage(event);
 }
 
@@ -1469,7 +1492,7 @@ void x86_pmu_stop(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 
 	if (test_bit(hwc->idx, cpuc->active_mask)) {
-		x86_pmu.disable(event);
+		static_call(x86_pmu_disable)(event);
 		__clear_bit(hwc->idx, cpuc->active_mask);
 		cpuc->events[hwc->idx] = NULL;
 		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
@@ -1519,8 +1542,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	if (i >= cpuc->n_events - cpuc->n_added)
 		--cpuc->n_added;
 
-	if (x86_pmu.put_event_constraints)
-		x86_pmu.put_event_constraints(cpuc, event);
+	static_call_cond(x86_pmu_put_event_constraints)(cpuc, event);
 
 	/* Delete the array entry. */
 	while (++i < cpuc->n_events) {
@@ -1533,13 +1555,12 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	perf_event_update_userpage(event);
 
 do_del:
-	if (x86_pmu.del) {
-		/*
-		 * This is after x86_pmu_stop(); so we disable LBRs after any
-		 * event can need them etc..
-		 */
-		x86_pmu.del(event);
-	}
+
+	/*
+	 * This is after x86_pmu_stop(); so we disable LBRs after any
+	 * event can need them etc..
+	 */
+	static_call_cond(x86_pmu_del)(event);
 }
 
 int x86_pmu_handle_irq(struct pt_regs *regs)
@@ -1617,7 +1638,7 @@ perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 		return NMI_DONE;
 
 	start_clock = sched_clock();
-	ret = x86_pmu.handle_irq(regs);
+	ret = static_call(x86_pmu_handle_irq)(regs);
 	finish_clock = sched_clock();
 
 	perf_sample_event_took(finish_clock - start_clock);
@@ -1830,6 +1851,38 @@ ssize_t x86_event_sysfs_show(char *page, u64 config, u64 event)
 static struct attribute_group x86_pmu_attr_group;
 static struct attribute_group x86_pmu_caps_group;
 
+static void x86_pmu_static_call_update(void)
+{
+	static_call_update(x86_pmu_handle_irq, x86_pmu.handle_irq);
+	static_call_update(x86_pmu_disable_all, x86_pmu.disable_all);
+	static_call_update(x86_pmu_enable_all, x86_pmu.enable_all);
+	static_call_update(x86_pmu_enable, x86_pmu.enable);
+	static_call_update(x86_pmu_disable, x86_pmu.disable);
+
+	static_call_update(x86_pmu_add, x86_pmu.add);
+	static_call_update(x86_pmu_del, x86_pmu.del);
+	static_call_update(x86_pmu_read, x86_pmu.read);
+
+	static_call_update(x86_pmu_schedule_events, x86_pmu.schedule_events);
+	static_call_update(x86_pmu_get_event_constraints, x86_pmu.get_event_constraints);
+	static_call_update(x86_pmu_put_event_constraints, x86_pmu.put_event_constraints);
+
+	static_call_update(x86_pmu_start_scheduling, x86_pmu.start_scheduling);
+	static_call_update(x86_pmu_commit_scheduling, x86_pmu.commit_scheduling);
+	static_call_update(x86_pmu_stop_scheduling, x86_pmu.stop_scheduling);
+
+	static_call_update(x86_pmu_sched_task, x86_pmu.sched_task);
+	static_call_update(x86_pmu_swap_task_ctx, x86_pmu.swap_task_ctx);
+
+	static_call_update(x86_pmu_drain_pebs, x86_pmu.drain_pebs);
+	static_call_update(x86_pmu_pebs_aliases, x86_pmu.pebs_aliases);
+}
+
+static void _x86_pmu_read(struct perf_event *event)
+{
+	x86_perf_event_update(event);
+}
+
 static int __init init_hw_perf_events(void)
 {
 	struct x86_pmu_quirk *quirk;
@@ -1898,6 +1951,11 @@ static int __init init_hw_perf_events(void)
 	pr_info("... fixed-purpose events:   %d\n",     x86_pmu.num_counters_fixed);
 	pr_info("... event mask:             %016Lx\n", x86_pmu.intel_ctrl);
 
+	if (!x86_pmu.read)
+		x86_pmu.read = _x86_pmu_read;
+
+	x86_pmu_static_call_update();
+
 	/*
 	 * Install callbacks. Core will call them for each online
 	 * cpu.
@@ -1934,11 +1992,9 @@ out:
 }
 early_initcall(init_hw_perf_events);
 
-static inline void x86_pmu_read(struct perf_event *event)
+static void x86_pmu_read(struct perf_event *event)
 {
-	if (x86_pmu.read)
-		return x86_pmu.read(event);
-	x86_perf_event_update(event);
+	static_call(x86_pmu_read)(event);
 }
 
 /*
@@ -2015,7 +2071,7 @@ static int x86_pmu_commit_txn(struct pmu *pmu)
 	if (!x86_pmu_initialized())
 		return -EAGAIN;
 
-	ret = x86_pmu.schedule_events(cpuc, n, assign);
+	ret = static_call(x86_pmu_schedule_events)(cpuc, n, assign);
 	if (ret)
 		return ret;
 
@@ -2308,15 +2364,13 @@ static const struct attribute_group *x86_pmu_attr_groups[] = {
 
 static void x86_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
 {
-	if (x86_pmu.sched_task)
-		x86_pmu.sched_task(ctx, sched_in);
+	static_call_cond(x86_pmu_sched_task)(ctx, sched_in);
 }
 
 static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
 				  struct perf_event_context *next)
 {
-	if (x86_pmu.swap_task_ctx)
-		x86_pmu.swap_task_ctx(prev, next);
+	static_call_cond(x86_pmu_swap_task_ctx)(prev, next);
 }
 
 void perf_check_microcode(void)
