Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D82C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C4C20838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404219AbgAXTpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:45:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43565 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392270AbgAXTpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:45:31 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iv4tO-0000Br-Vs; Fri, 24 Jan 2020 20:45:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 90AA61C1A6A;
        Fri, 24 Jan 2020 20:45:22 +0100 (CET)
Date:   Fri, 24 Jan 2020 19:45:22 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] smp: Add a smp_cond_func_t argument to
 smp_call_function_many()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200117090137.1205765-3-bigeasy@linutronix.de>
References: <20200117090137.1205765-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <157989512234.396.13725764794800050132.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     67719ef25eeb2048b11befa6a757aeb3848b5df1
Gitweb:        https://git.kernel.org/tip/67719ef25eeb2048b11befa6a757aeb3848b5df1
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 17 Jan 2020 10:01:36 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jan 2020 20:40:09 +01:00

smp: Add a smp_cond_func_t argument to smp_call_function_many()

on_each_cpu_cond_mask() allocates a new CPU mask. The newly allocated
mask is a subset of the provided mask based on the conditional function.

This memory allocation can be avoided by extending smp_call_function_many()
with the conditional function and performing the remote function call based
on the mask and the conditional function.

Rename smp_call_function_many() to smp_call_function_many_cond() and add
the smp_cond_func_t argument. If smp_cond_func_t is provided then it is
used before invoking the function.  Provide smp_call_function_many() with
cond_func set to NULL.  Let on_each_cpu_cond_mask() use
smp_call_function_many_cond().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20200117090137.1205765-3-bigeasy@linutronix.de

---
 kernel/smp.c | 81 +++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 43 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index c64044d..e17e634 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -395,22 +395,9 @@ call:
 }
 EXPORT_SYMBOL_GPL(smp_call_function_any);
 
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
 	int cpu, next_cpu, this_cpu = smp_processor_id();
@@ -448,7 +435,8 @@ void smp_call_function_many(const struct cpumask *mask,
 
 	/* Fastpath: do that cpu by itself. */
 	if (next_cpu >= nr_cpu_ids) {
-		smp_call_function_single(cpu, func, info, wait);
+		if (!cond_func || (cond_func && cond_func(cpu, info)))
+			smp_call_function_single(cpu, func, info, wait);
 		return;
 	}
 
@@ -465,6 +453,9 @@ void smp_call_function_many(const struct cpumask *mask,
 	for_each_cpu(cpu, cfd->cpumask) {
 		call_single_data_t *csd = per_cpu_ptr(cfd->csd, cpu);
 
+		if (cond_func && !cond_func(cpu, info))
+			continue;
+
 		csd_lock(csd);
 		if (wait)
 			csd->flags |= CSD_FLAG_SYNCHRONOUS;
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
 
 /**
@@ -684,33 +695,17 @@ void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 			   void *info, bool wait, gfp_t gfp_flags,
 			   const struct cpumask *mask)
 {
-	cpumask_var_t cpus;
-	int cpu, ret;
-
-	might_sleep_if(gfpflags_allow_blocking(gfp_flags));
-
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
-				ret = smp_call_function_single(cpu, func,
-								info, wait);
-				WARN_ON_ONCE(ret);
-			}
-		preempt_enable();
+	int cpu = get_cpu();
+
+	smp_call_function_many_cond(mask, func, info, wait, cond_func);
+	if (cpumask_test_cpu(cpu, mask) && cond_func(cpu, info)) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		func(info);
+		local_irq_restore(flags);
 	}
+	put_cpu();
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
 
