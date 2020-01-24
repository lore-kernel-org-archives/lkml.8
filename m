Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2035CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F274A20718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392269AbgAXTp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:45:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43561 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390664AbgAXTp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:45:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iv4tO-0000Bq-KI; Fri, 24 Jan 2020 20:45:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 395051C1A69;
        Fri, 24 Jan 2020 20:45:22 +0100 (CET)
Date:   Fri, 24 Jan 2020 19:45:21 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] smp: Remove allocation mask from on_each_cpu_cond.*()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200117090137.1205765-4-bigeasy@linutronix.de>
References: <20200117090137.1205765-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <157989512196.396.4216786603220868613.tip-bot2@tip-bot2>
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

Commit-ID:     cb923159bbb8cc8fe09c19a3435ee11fd546f3d3
Gitweb:        https://git.kernel.org/tip/cb923159bbb8cc8fe09c19a3435ee11fd546f3d3
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 17 Jan 2020 10:01:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jan 2020 20:40:09 +01:00

smp: Remove allocation mask from on_each_cpu_cond.*()

The allocation mask is no longer used by on_each_cpu_cond() and
on_each_cpu_cond_mask() and can be removed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20200117090137.1205765-4-bigeasy@linutronix.de

---
 arch/x86/mm/tlb.c   |  2 +-
 fs/buffer.c         |  2 +-
 include/linux/smp.h |  5 ++---
 kernel/smp.c        | 13 +++----------
 kernel/up.c         |  7 +++----
 mm/slub.c           |  2 +-
 6 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e6a9edc..66f96f2 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -708,7 +708,7 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 			       (void *)info, 1);
 	else
 		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func_remote,
-				(void *)info, 1, GFP_ATOMIC, cpumask);
+				(void *)info, 1, cpumask);
 }
 
 /*
diff --git a/fs/buffer.c b/fs/buffer.c
index 18a87ec..b8d2837 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1433,7 +1433,7 @@ static bool has_bh_in_lru(int cpu, void *dummy)
 
 void invalidate_bh_lrus(void)
 {
-	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1, GFP_KERNEL);
+	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);
 }
 EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
 
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 4734416..cbc9162 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -51,11 +51,10 @@ void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
  * processor.
  */
 void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
-		      void *info, bool wait, gfp_t gfp_flags);
+		      void *info, bool wait);
 
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
-			   void *info, bool wait, gfp_t gfp_flags,
-			   const struct cpumask *mask);
+			   void *info, bool wait, const struct cpumask *mask);
 
 int smp_call_function_single_async(int cpu, call_single_data_t *csd);
 
diff --git a/kernel/smp.c b/kernel/smp.c
index e17e634..3b7bedc 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -679,11 +679,6 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * @info:	An arbitrary pointer to pass to both functions.
  * @wait:	If true, wait (atomically) until function has
  *		completed on other CPUs.
- * @gfp_flags:	GFP flags to use when allocating the cpumask
- *		used internally by the function.
- *
- * The function might sleep if the GFP flags indicates a non
- * atomic allocation is allowed.
  *
  * Preemption is disabled to protect against CPUs going offline but not online.
  * CPUs going online during the call will not be seen or sent an IPI.
@@ -692,8 +687,7 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * from a hardware interrupt handler or from a bottom half handler.
  */
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
-			   void *info, bool wait, gfp_t gfp_flags,
-			   const struct cpumask *mask)
+			   void *info, bool wait, const struct cpumask *mask)
 {
 	int cpu = get_cpu();
 
@@ -710,10 +704,9 @@ void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
 
 void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
-		      void *info, bool wait, gfp_t gfp_flags)
+		      void *info, bool wait)
 {
-	on_each_cpu_cond_mask(cond_func, func, info, wait, gfp_flags,
-				cpu_online_mask);
+	on_each_cpu_cond_mask(cond_func, func, info, wait, cpu_online_mask);
 }
 EXPORT_SYMBOL(on_each_cpu_cond);
 
diff --git a/kernel/up.c b/kernel/up.c
index 5c0d4f2..53144d0 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -69,8 +69,7 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * same condtions in UP and SMP.
  */
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
-			   void *info, bool wait, gfp_t gfp_flags,
-			   const struct cpumask *mask)
+			   void *info, bool wait, const struct cpumask *mask)
 {
 	unsigned long flags;
 
@@ -85,9 +84,9 @@ void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
 
 void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
-		      void *info, bool wait, gfp_t gfp_flags)
+		      void *info, bool wait)
 {
-	on_each_cpu_cond_mask(cond_func, func, info, wait, gfp_flags, NULL);
+	on_each_cpu_cond_mask(cond_func, func, info, wait, NULL);
 }
 EXPORT_SYMBOL(on_each_cpu_cond);
 
diff --git a/mm/slub.c b/mm/slub.c
index 8eafccf..2e1a577 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2341,7 +2341,7 @@ static bool has_cpu_slab(int cpu, void *info)
 
 static void flush_all(struct kmem_cache *s)
 {
-	on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1, GFP_ATOMIC);
+	on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
 }
 
 /*
