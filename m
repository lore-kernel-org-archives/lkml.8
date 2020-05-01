Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF92C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995202166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hLOEG5PH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgEAUcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgEAUbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:31:37 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87278C08E859
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 13:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=gUkb4NfOmtdTDe5bvKVmr/K+ksa8BJ32JLleyTZU4QM=; b=hLOEG5PHJQKLQRsUoKRo2RO4BR
        xF+zOxgaz4V2nGEVE9p8HFCkgPRDivl6itQW/OiWX2s+BOV972ycJws4twcsC2kVxRT74KhZNRHK4
        ZHbOW5pLtz292UC+FJLf+dksEyqMUSFa3YpNZzbr1QYAFJRmmzdCRtw7dxeJQO+cRc4roIIxYIMsk
        OWhIklr2uGxFQ55qB8/aeLaBhpR7+xQDJ1kQ50FpAZMMxx7HNJHl4/JRGFK2WbjkT4UOwK+wGDLUH
        7SQjXEScVmWqNosAw6QKny/SLEerWfkU5LZswzXLEHorXAdYRyuiBhQkUXOniIWUw6ZqgYfBIVZz4
        C+qkL0BQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUcJO-0007RJ-Sk; Fri, 01 May 2020 20:31:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A1749307632;
        Fri,  1 May 2020 22:31:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0EBE629BF626A; Fri,  1 May 2020 22:31:01 +0200 (CEST)
Message-Id: <20200501202944.763303401@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 01 May 2020 22:29:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: [PATCH v4 17/18] x86/perf, static_call: Optimize x86_pmu methods
References: <20200501202849.647891881@infradead.org>
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
 arch/x86/events/core.c |  140 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 100 insertions(+), 40 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -28,6 +28,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/nospec.h>
+#include <linux/static_call.h>
 
 #include <asm/apic.h>
 #include <asm/stacktrace.h>
@@ -52,6 +53,40 @@ DEFINE_PER_CPU(struct cpu_hw_events, cpu
 DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
 DEFINE_STATIC_KEY_FALSE(rdpmc_always_available_key);
 
+/*
+ * This here 'abuses' DEFINE_STATIC_COND_CALL() to get a static_call defined
+ * from just a typename, as opposed to an actual function. While some of these
+ * will indeed be used with static_cond_call(), many of them will not.
+ *
+ * Just like you can unconditionally call a function pointer that's initialized
+ * to NULL, as long as you make sure to set it to a valid function _before_
+ * use, so too can you use static_call() on a DEFINE_STATIC_COND_CALL(), as
+ * long as you use static_call_update() to set it before use.
+ */
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
@@ -660,7 +695,7 @@ static void x86_pmu_disable(struct pmu *
 	cpuc->enabled = 0;
 	barrier();
 
-	x86_pmu.disable_all();
+	static_call(x86_pmu_disable_all)();
 }
 
 void x86_pmu_enable_all(int added)
@@ -907,8 +942,7 @@ int x86_schedule_events(struct cpu_hw_ev
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		n0 -= cpuc->n_txn;
 
-	if (x86_pmu.start_scheduling)
-		x86_pmu.start_scheduling(cpuc);
+	static_cond_call(x86_pmu_start_scheduling)(cpuc);
 
 	for (i = 0, wmin = X86_PMC_IDX_MAX, wmax = 0; i < n; i++) {
 		c = cpuc->event_constraint[i];
@@ -925,7 +959,7 @@ int x86_schedule_events(struct cpu_hw_ev
 		 * change due to external factors (sibling state, allow_tfa).
 		 */
 		if (!c || (c->flags & PERF_X86_EVENT_DYNAMIC)) {
-			c = x86_pmu.get_event_constraints(cpuc, i, cpuc->event_list[i]);
+			c = static_call(x86_pmu_get_event_constraints)(cpuc, i, cpuc->event_list[i]);
 			cpuc->event_constraint[i] = c;
 		}
 
@@ -1008,8 +1042,7 @@ int x86_schedule_events(struct cpu_hw_ev
 	if (!unsched && assign) {
 		for (i = 0; i < n; i++) {
 			e = cpuc->event_list[i];
-			if (x86_pmu.commit_scheduling)
-				x86_pmu.commit_scheduling(cpuc, i, assign[i]);
+			static_cond_call(x86_pmu_commit_scheduling)(cpuc, i, assign[i]);
 		}
 	} else {
 		for (i = n0; i < n; i++) {
@@ -1018,15 +1051,13 @@ int x86_schedule_events(struct cpu_hw_ev
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
@@ -1217,7 +1248,7 @@ static void x86_pmu_enable(struct pmu *p
 	cpuc->enabled = 1;
 	barrier();
 
-	x86_pmu.enable_all(added);
+	static_call(x86_pmu_enable_all)(added);
 }
 
 static DEFINE_PER_CPU(u64 [X86_PMC_IDX_MAX], pmc_prev_left);
@@ -1338,7 +1369,7 @@ static int x86_pmu_add(struct perf_event
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		goto done_collect;
 
-	ret = x86_pmu.schedule_events(cpuc, n, assign);
+	ret = static_call(x86_pmu_schedule_events)(cpuc, n, assign);
 	if (ret)
 		goto out;
 	/*
@@ -1356,13 +1387,11 @@ static int x86_pmu_add(struct perf_event
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
@@ -1390,7 +1419,7 @@ static void x86_pmu_start(struct perf_ev
 	cpuc->events[idx] = event;
 	__set_bit(idx, cpuc->active_mask);
 	__set_bit(idx, cpuc->running);
-	x86_pmu.enable(event);
+	static_call(x86_pmu_enable)(event);
 	perf_event_update_userpage(event);
 }
 
@@ -1460,7 +1489,7 @@ void x86_pmu_stop(struct perf_event *eve
 	struct hw_perf_event *hwc = &event->hw;
 
 	if (test_bit(hwc->idx, cpuc->active_mask)) {
-		x86_pmu.disable(event);
+		static_call(x86_pmu_disable)(event);
 		__clear_bit(hwc->idx, cpuc->active_mask);
 		cpuc->events[hwc->idx] = NULL;
 		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
@@ -1510,8 +1539,7 @@ static void x86_pmu_del(struct perf_even
 	if (i >= cpuc->n_events - cpuc->n_added)
 		--cpuc->n_added;
 
-	if (x86_pmu.put_event_constraints)
-		x86_pmu.put_event_constraints(cpuc, event);
+	static_cond_call(x86_pmu_put_event_constraints)(cpuc, event);
 
 	/* Delete the array entry. */
 	while (++i < cpuc->n_events) {
@@ -1524,13 +1552,12 @@ static void x86_pmu_del(struct perf_even
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
@@ -1608,7 +1635,7 @@ perf_event_nmi_handler(unsigned int cmd,
 		return NMI_DONE;
 
 	start_clock = sched_clock();
-	ret = x86_pmu.handle_irq(regs);
+	ret = static_call(x86_pmu_handle_irq)(regs);
 	finish_clock = sched_clock();
 
 	perf_sample_event_took(finish_clock - start_clock);
@@ -1821,6 +1848,38 @@ ssize_t x86_event_sysfs_show(char *page,
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
@@ -1889,6 +1948,11 @@ static int __init init_hw_perf_events(vo
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
@@ -1925,11 +1989,9 @@ static int __init init_hw_perf_events(vo
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
@@ -2006,7 +2068,7 @@ static int x86_pmu_commit_txn(struct pmu
 	if (!x86_pmu_initialized())
 		return -EAGAIN;
 
-	ret = x86_pmu.schedule_events(cpuc, n, assign);
+	ret = static_call(x86_pmu_schedule_events)(cpuc, n, assign);
 	if (ret)
 		return ret;
 
@@ -2299,15 +2361,13 @@ static const struct attribute_group *x86
 
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


