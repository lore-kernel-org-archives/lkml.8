Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565E0C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D8B2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgAQJBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:01:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55040 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgAQJBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:01:48 -0500
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1isNVg-0003eT-M1; Fri, 17 Jan 2020 10:01:44 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/3] smp: Remove allocation mask from on_each_cpu_cond.*()
Date:   Fri, 17 Jan 2020 10:01:37 +0100
Message-Id: <20200117090137.1205765-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200117090137.1205765-1-bigeasy@linutronix.de>
References: <20200117090137.1205765-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocation mask is no longer used by on_each_cpu_cond() and
on_each_cpu_cond_mask() and ca be removed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/mm/tlb.c   |  2 +-
 fs/buffer.c         |  2 +-
 include/linux/smp.h |  5 ++---
 kernel/smp.c        | 13 +++----------
 kernel/up.c         |  7 +++----
 mm/slub.c           |  2 +-
 6 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e6a9edc5baaf0..66f96f21a7b60 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -708,7 +708,7 @@ void native_flush_tlb_others(const struct cpumask *cpum=
ask,
 			       (void *)info, 1);
 	else
 		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func_remote,
-				(void *)info, 1, GFP_ATOMIC, cpumask);
+				(void *)info, 1, cpumask);
 }
=20
 /*
diff --git a/fs/buffer.c b/fs/buffer.c
index 18a87ec8a465b..b8d28370cfd7f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1433,7 +1433,7 @@ static bool has_bh_in_lru(int cpu, void *dummy)
=20
 void invalidate_bh_lrus(void)
 {
-	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1, GFP_KERNEL);
+	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);
 }
 EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
=20
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 4734416855aad..cbc9162689d0f 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -51,11 +51,10 @@ void on_each_cpu_mask(const struct cpumask *mask, smp_c=
all_func_t func,
  * processor.
  */
 void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
-		      void *info, bool wait, gfp_t gfp_flags);
+		      void *info, bool wait);
=20
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
-			   void *info, bool wait, gfp_t gfp_flags,
-			   const struct cpumask *mask);
+			   void *info, bool wait, const struct cpumask *mask);
=20
 int smp_call_function_single_async(int cpu, call_single_data_t *csd);
=20
diff --git a/kernel/smp.c b/kernel/smp.c
index e17e6344ab54d..3b7bedc97af38 100644
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
  * Preemption is disabled to protect against CPUs going offline but not on=
line.
  * CPUs going online during the call will not be seen or sent an IPI.
@@ -692,8 +687,7 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * from a hardware interrupt handler or from a bottom half handler.
  */
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
-			   void *info, bool wait, gfp_t gfp_flags,
-			   const struct cpumask *mask)
+			   void *info, bool wait, const struct cpumask *mask)
 {
 	int cpu =3D get_cpu();
=20
@@ -710,10 +704,9 @@ void on_each_cpu_cond_mask(smp_cond_func_t cond_func, =
smp_call_func_t func,
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
=20
 void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
-		      void *info, bool wait, gfp_t gfp_flags)
+		      void *info, bool wait)
 {
-	on_each_cpu_cond_mask(cond_func, func, info, wait, gfp_flags,
-				cpu_online_mask);
+	on_each_cpu_cond_mask(cond_func, func, info, wait, cpu_online_mask);
 }
 EXPORT_SYMBOL(on_each_cpu_cond);
=20
diff --git a/kernel/up.c b/kernel/up.c
index 5c0d4f2bece22..53144d0562522 100644
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
=20
@@ -85,9 +84,9 @@ void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp=
_call_func_t func,
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
=20
 void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
-		      void *info, bool wait, gfp_t gfp_flags)
+		      void *info, bool wait)
 {
-	on_each_cpu_cond_mask(cond_func, func, info, wait, gfp_flags, NULL);
+	on_each_cpu_cond_mask(cond_func, func, info, wait, NULL);
 }
 EXPORT_SYMBOL(on_each_cpu_cond);
=20
diff --git a/mm/slub.c b/mm/slub.c
index d11389710b12d..e77f19db41f16 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2341,7 +2341,7 @@ static bool has_cpu_slab(int cpu, void *info)
=20
 static void flush_all(struct kmem_cache *s)
 {
-	on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1, GFP_ATOMIC);
+	on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
 }
=20
 /*
--=20
2.25.0

