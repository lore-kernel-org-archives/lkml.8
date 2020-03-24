Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BAAC2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EB720B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s71UXnum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgCXOZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:25:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53674 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbgCXOYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=XZVv8XkxM9QWcVmY7RFKry2CjWqW6p5/DUZX7TjB8Q8=; b=s71UXnumciQtCwBjd4Cqftfxo1
        b+vHKdI11zcro7o6ARfaSIbmJwUi0GW8x58rpmK2oKhV5AcGiL/jlgKA1xPn8oCM5RJMhavvlj8l6
        4W7k1NqAMaRUGtZTR3ZCIt3vj9qaIFOiQcSMssT7G48FUti4/Pp1MgxWFhtcp3Y1Lpco5QDsAKRQO
        xFVaT9oq1AUde0lkGuKHOi7SqNnmWflSBpv4LIMQ+MPkYhtwH2bBFWDRXPlzfNUUfEnMDU53eLCoD
        +npER9j53VDUn3Mm3DJH3+IC+L43VfKaomOsfKk3wMmW07K+6RKHn7ZAUJA5XGCB6JSfzAMSwpIgP
        JdfcJM7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGkTw-0003p4-HZ; Tue, 24 Mar 2020 14:24:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 89EE4307970;
        Tue, 24 Mar 2020 15:24:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3C10D286C13BE; Tue, 24 Mar 2020 15:24:35 +0100 (CET)
Message-Id: <20200324142246.308204077@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 14:56:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [RESEND][PATCH v3 17/17] x86/perf, static_call: Optimize x86_pmu methods
References: <20200324135603.483964896@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace many of the indirect calls with static_call().

XXX run performance numbers

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/core.c |  130 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 90 insertions(+), 40 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -28,6 +28,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/nospec.h>
+#include <linux/static_call.h>
 
 #include <asm/apic.h>
 #include <asm/stacktrace.h>
@@ -52,6 +53,30 @@ DEFINE_PER_CPU(struct cpu_hw_events, cpu
 DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
 DEFINE_STATIC_KEY_FALSE(rdpmc_always_available_key);
 
+DEFINE_STATIC_COND_CALL(x86_pmu_handle_irq,  *x86_pmu.handle_irq);
+DEFINE_STATIC_COND_CALL(x86_pmu_disable_all, *x86_pmu.disable_all);
+DEFINE_STATIC_COND_CALL(x86_pmu_enable_all,  *x86_pmu.enable_all);
+DEFINE_STATIC_COND_CALL(x86_pmu_enable,	     *x86_pmu.enable);
+DEFINE_STATIC_COND_CALL(x86_pmu_disable,     *x86_pmu.disable);
+
+DEFINE_STATIC_COND_CALL(x86_pmu_add,  *x86_pmu.add);
+DEFINE_STATIC_COND_CALL(x86_pmu_del,  *x86_pmu.del);
+DEFINE_STATIC_COND_CALL(x86_pmu_read, *x86_pmu.read);
+
+DEFINE_STATIC_COND_CALL(x86_pmu_schedule_events,       *x86_pmu.schedule_events);
+DEFINE_STATIC_COND_CALL(x86_pmu_get_event_constraints, *x86_pmu.get_event_constraints);
+DEFINE_STATIC_COND_CALL(x86_pmu_put_event_constraints, *x86_pmu.put_event_constraints);
+
+DEFINE_STATIC_COND_CALL(x86_pmu_start_scheduling,  *x86_pmu.start_scheduling);
+DEFINE_STATIC_COND_CALL(x86_pmu_commit_scheduling, *x86_pmu.commit_scheduling);
+DEFINE_STATIC_COND_CALL(x86_pmu_stop_scheduling,   *x86_pmu.stop_scheduling);
+
+DEFINE_STATIC_COND_CALL(x86_pmu_sched_task,    *x86_pmu.sched_task);
+DEFINE_STATIC_COND_CALL(x86_pmu_swap_task_ctx, *x86_pmu.swap_task_ctx);
+
+DEFINE_STATIC_COND_CALL(x86_pmu_drain_pebs,   *x86_pmu.drain_pebs);
+DEFINE_STATIC_COND_CALL(x86_pmu_pebs_aliases, *x86_pmu.pebs_aliases);
+
 u64 __read_mostly hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -660,7 +685,7 @@ static void x86_pmu_disable(struct pmu *
 	cpuc->enabled = 0;
 	barrier();
 
-	x86_pmu.disable_all();
+	static_call(x86_pmu_disable_all)();
 }
 
 void x86_pmu_enable_all(int added)
@@ -907,8 +932,7 @@ int x86_schedule_events(struct cpu_hw_ev
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		n0 -= cpuc->n_txn;
 
-	if (x86_pmu.start_scheduling)
-		x86_pmu.start_scheduling(cpuc);
+	static_cond_call(x86_pmu_start_scheduling)(cpuc);
 
 	for (i = 0, wmin = X86_PMC_IDX_MAX, wmax = 0; i < n; i++) {
 		c = cpuc->event_constraint[i];
@@ -925,7 +949,7 @@ int x86_schedule_events(struct cpu_hw_ev
 		 * change due to external factors (sibling state, allow_tfa).
 		 */
 		if (!c || (c->flags & PERF_X86_EVENT_DYNAMIC)) {
-			c = x86_pmu.get_event_constraints(cpuc, i, cpuc->event_list[i]);
+			c = static_call(x86_pmu_get_event_constraints)(cpuc, i, cpuc->event_list[i]);
 			cpuc->event_constraint[i] = c;
 		}
 
@@ -1008,8 +1032,7 @@ int x86_schedule_events(struct cpu_hw_ev
 	if (!unsched && assign) {
 		for (i = 0; i < n; i++) {
 			e = cpuc->event_list[i];
-			if (x86_pmu.commit_scheduling)
-				x86_pmu.commit_scheduling(cpuc, i, assign[i]);
+			static_cond_call(x86_pmu_commit_scheduling)(cpuc, i, assign[i]);
 		}
 	} else {
 		for (i = n0; i < n; i++) {
@@ -1018,15 +1041,13 @@ int x86_schedule_events(struct cpu_hw_ev
 			/*
 			 * release events that failed scheduling
 			 */
-			if (x86_pmu.put_event_constraints)
-				x86_pmu.put_event_constraints(cpuc, e);
+			static_cond_call(x86_pmu_put_event_constraints)(cpuc, e);
 
 			cpuc->event_constraint[i] = NULL;
 		}
 	}
 
-	if (x86_pmu.stop_scheduling)
-		x86_pmu.stop_scheduling(cpuc);
+	static_cond_call(x86_pmu_stop_scheduling)(cpuc);
 
 	return unsched ? -EINVAL : 0;
 }
@@ -1217,7 +1238,7 @@ static void x86_pmu_enable(struct pmu *p
 	cpuc->enabled = 1;
 	barrier();
 
-	x86_pmu.enable_all(added);
+	static_call(x86_pmu_enable_all)(added);
 }
 
 static DEFINE_PER_CPU(u64 [X86_PMC_IDX_MAX], pmc_prev_left);
@@ -1338,7 +1359,7 @@ static int x86_pmu_add(struct perf_event
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		goto done_collect;
 
-	ret = x86_pmu.schedule_events(cpuc, n, assign);
+	ret = static_call(x86_pmu_schedule_events)(cpuc, n, assign);
 	if (ret)
 		goto out;
 	/*
@@ -1356,13 +1377,11 @@ static int x86_pmu_add(struct perf_event
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
+	static_cond_call(x86_pmu_add)(event);
 
 	ret = 0;
 out:
@@ -1390,7 +1409,7 @@ static void x86_pmu_start(struct perf_ev
 	cpuc->events[idx] = event;
 	__set_bit(idx, cpuc->active_mask);
 	__set_bit(idx, cpuc->running);
-	x86_pmu.enable(event);
+	static_call(x86_pmu_enable)(event);
 	perf_event_update_userpage(event);
 }
 
@@ -1460,7 +1479,7 @@ void x86_pmu_stop(struct perf_event *eve
 	struct hw_perf_event *hwc = &event->hw;
 
 	if (test_bit(hwc->idx, cpuc->active_mask)) {
-		x86_pmu.disable(event);
+		static_call(x86_pmu_disable)(event);
 		__clear_bit(hwc->idx, cpuc->active_mask);
 		cpuc->events[hwc->idx] = NULL;
 		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
@@ -1510,8 +1529,7 @@ static void x86_pmu_del(struct perf_even
 	if (i >= cpuc->n_events - cpuc->n_added)
 		--cpuc->n_added;
 
-	if (x86_pmu.put_event_constraints)
-		x86_pmu.put_event_constraints(cpuc, event);
+	static_cond_call(x86_pmu_put_event_constraints)(cpuc, event);
 
 	/* Delete the array entry. */
 	while (++i < cpuc->n_events) {
@@ -1524,13 +1542,12 @@ static void x86_pmu_del(struct perf_even
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
+	static_cond_call(x86_pmu_del)(event);
 }
 
 int x86_pmu_handle_irq(struct pt_regs *regs)
@@ -1608,7 +1625,7 @@ perf_event_nmi_handler(unsigned int cmd,
 		return NMI_DONE;
 
 	start_clock = sched_clock();
-	ret = x86_pmu.handle_irq(regs);
+	ret = static_call(x86_pmu_handle_irq)(regs);
 	finish_clock = sched_clock();
 
 	perf_sample_event_took(finish_clock - start_clock);
@@ -1821,6 +1838,38 @@ ssize_t x86_event_sysfs_show(char *page,
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
@@ -1885,6 +1934,11 @@ static int __init init_hw_perf_events(vo
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
@@ -1921,11 +1975,9 @@ static int __init init_hw_perf_events(vo
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
@@ -2002,7 +2054,7 @@ static int x86_pmu_commit_txn(struct pmu
 	if (!x86_pmu_initialized())
 		return -EAGAIN;
 
-	ret = x86_pmu.schedule_events(cpuc, n, assign);
+	ret = static_call(x86_pmu_schedule_events)(cpuc, n, assign);
 	if (ret)
 		return ret;
 
@@ -2300,15 +2352,13 @@ static const struct attribute_group *x86
 
 static void x86_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
 {
-	if (x86_pmu.sched_task)
-		x86_pmu.sched_task(ctx, sched_in);
+	static_cond_call(x86_pmu_sched_task)(ctx, sched_in);
 }
 
 static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
 				  struct perf_event_context *next)
 {
-	if (x86_pmu.swap_task_ctx)
-		x86_pmu.swap_task_ctx(prev, next);
+	static_cond_call(x86_pmu_swap_task_ctx)(prev, next);
 }
 
 void perf_check_microcode(void)


