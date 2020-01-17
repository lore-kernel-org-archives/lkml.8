Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AEBC33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316CB2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgAQJBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:01:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55037 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbgAQJBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:01:47 -0500
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1isNVg-0003eT-8q; Fri, 17 Jan 2020 10:01:44 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/3] smp: Add a smp_cond_func_t argument to smp_call_function_many()
Date:   Fri, 17 Jan 2020 10:01:36 +0100
Message-Id: <20200117090137.1205765-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200117090137.1205765-1-bigeasy@linutronix.de>
References: <20200117090137.1205765-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

on_each_cpu_cond_mask() allocates a new CPU mask. The newly allocated
mask is a subset of the provided mask based on the conditional function.
This memory allocation could be avoided by extending
smp_call_function_many() with the conditional function and performing the
remote function call based on the mask and the conditional function.

Rename smp_call_function_many() to smp_call_function_many_cond() and add
the smp_cond_func_t argument. If smp_cond_func_t is provided then it is
used before invoking the function.
Provide smp_call_function_many() with cond_func set to NULL.
Let on_each_cpu_cond_mask() use smp_call_function_many_cond().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/smp.c | 77 ++++++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 41 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index c64044d68bc62..e17e6344ab54d 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -395,22 +395,9 @@ int smp_call_function_any(const struct cpumask *mask,
 }
 EXPORT_SYMBOL_GPL(smp_call_function_any);
=20
-/**
- * smp_call_function_many(): Run a function on a set of other CPUs.
- * @mask: The set of cpus to run on (only runs on online subset).
- * @func: The function to run. This must be fast and non-blocking.
- * @info: An arbitrary pointer to pass to the function.
- * @wait: If true, wait (atomically) until function has completed
- *        on other CPUs.
- *
- * If @wait is true, then returns once @func has returned.
- *
- * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler or from a bottom half handler. Preemption
- * must be disabled when calling this function.
- */
-void smp_call_function_many(const struct cpumask *mask,
-			    smp_call_func_t func, void *info, bool wait)
+static void smp_call_function_many_cond(const struct cpumask *mask,
+					smp_call_func_t func, void *info,
+					bool wait, smp_cond_func_t cond_func)
 {
 	struct call_function_data *cfd;
 	int cpu, next_cpu, this_cpu =3D smp_processor_id();
@@ -448,7 +435,8 @@ void smp_call_function_many(const struct cpumask *mask,
=20
 	/* Fastpath: do that cpu by itself. */
 	if (next_cpu >=3D nr_cpu_ids) {
-		smp_call_function_single(cpu, func, info, wait);
+		if (!cond_func || (cond_func && cond_func(cpu, info)))
+			smp_call_function_single(cpu, func, info, wait);
 		return;
 	}
=20
@@ -465,6 +453,9 @@ void smp_call_function_many(const struct cpumask *mask,
 	for_each_cpu(cpu, cfd->cpumask) {
 		call_single_data_t *csd =3D per_cpu_ptr(cfd->csd, cpu);
=20
+		if (cond_func && !cond_func(cpu, info))
+			continue;
+
 		csd_lock(csd);
 		if (wait)
 			csd->flags |=3D CSD_FLAG_SYNCHRONOUS;
@@ -486,6 +477,26 @@ void smp_call_function_many(const struct cpumask *mask,
 		}
 	}
 }
+
+/**
+ * smp_call_function_many(): Run a function on a set of other CPUs.
+ * @mask: The set of cpus to run on (only runs on online subset).
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @wait: If true, wait (atomically) until function has completed
+ *        on other CPUs.
+ *
+ * If @wait is true, then returns once @func has returned.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler. Preemption
+ * must be disabled when calling this function.
+ */
+void smp_call_function_many(const struct cpumask *mask,
+			    smp_call_func_t func, void *info, bool wait)
+{
+	smp_call_function_many_cond(mask, func, info, wait, NULL);
+}
 EXPORT_SYMBOL(smp_call_function_many);
=20
 /**
@@ -684,33 +695,17 @@ void on_each_cpu_cond_mask(smp_cond_func_t cond_func,=
 smp_call_func_t func,
 			   void *info, bool wait, gfp_t gfp_flags,
 			   const struct cpumask *mask)
 {
-	cpumask_var_t cpus;
-	int cpu, ret;
+	int cpu =3D get_cpu();
=20
-	might_sleep_if(gfpflags_allow_blocking(gfp_flags));
+	smp_call_function_many_cond(mask, func, info, wait, cond_func);
+	if (cpumask_test_cpu(cpu, mask) && cond_func(cpu, info)) {
+		unsigned long flags;
=20
-	if (likely(zalloc_cpumask_var(&cpus, (gfp_flags|__GFP_NOWARN)))) {
-		preempt_disable();
-		for_each_cpu(cpu, mask)
-			if (cond_func(cpu, info))
-				__cpumask_set_cpu(cpu, cpus);
-		on_each_cpu_mask(cpus, func, info, wait);
-		preempt_enable();
-		free_cpumask_var(cpus);
-	} else {
-		/*
-		 * No free cpumask, bother. No matter, we'll
-		 * just have to IPI them one by one.
-		 */
-		preempt_disable();
-		for_each_cpu(cpu, mask)
-			if (cond_func(cpu, info)) {
-				ret =3D smp_call_function_single(cpu, func,
-								info, wait);
-				WARN_ON_ONCE(ret);
-			}
-		preempt_enable();
+		local_irq_save(flags);
+		func(info);
+		local_irq_restore(flags);
 	}
+	put_cpu();
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
=20
--=20
2.25.0

