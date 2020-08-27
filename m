Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F16C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56A1C20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g+k8o1Eh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Rod2lJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgH0H4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:56:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36776 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbgH0Hyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:31 -0400
Date:   Thu, 27 Aug 2020 07:54:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VwNDj4exCKcgi5b6FbBTzc0tc0/z7gQN+SMC+eABkek=;
        b=g+k8o1Eh36LskHP/WK36boWbU/5de9dqGElNELhLvXOq+vbIpZMTSq32QbCjLVD7mjjmi6
        sYDuPckUz9QgRh3/sfLluLv/mq0RRlUuVYMCzXgKZ/m6rhENeX2n2geardALkt5gDO8Urt
        VhLoC7dtY2ofydBI4k3wSqcJOWP309rxE/V8ux8Y3LPTZ1mslPtuJNEBXkp8rfA6RoZeK2
        vwd59KkGGAiXubO4bGe1Wp7Sf5NcpYNFvtYWhCHA/XRNiY6OwVPg0vniMFddR23xTwMFd6
        Ub27tYAVptXgHXJagjM1VNIMo1kWshiMTrDAJEAQg5oakLA3mfj/smVrR4Dtkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VwNDj4exCKcgi5b6FbBTzc0tc0/z7gQN+SMC+eABkek=;
        b=0Rod2lJBJUAv9rfU3yZ4m7Z8r412tbJRBv1yBU6NXEwkXYpssHOgwacHRaLCG45rwWh9RE
        /ET66hGZ2XgczuBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] cpuidle: Make CPUIDLE_FLAG_TLB_FLUSHED generic
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Marco Elver <elver@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821085348.369441600@infradead.org>
References: <20200821085348.369441600@infradead.org>
MIME-Version: 1.0
Message-ID: <159851486767.20229.4562609465121962731.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     bf9282dc26e7fe2a0736edc568762f0f05d12416
Gitweb:        https://git.kernel.org/tip/bf9282dc26e7fe2a0736edc568762f0f05d12416
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 12 Aug 2020 12:22:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:41:53 +02:00

cpuidle: Make CPUIDLE_FLAG_TLB_FLUSHED generic

This allows moving the leave_mm() call into generic code before
rcu_idle_enter(). Gets rid of more trace_*_rcuidle() users.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Marco Elver <elver@google.com>
Link: https://lkml.kernel.org/r/20200821085348.369441600@infradead.org
---
 arch/x86/include/asm/mmu.h  |  1 +
 arch/x86/mm/tlb.c           | 13 ++-----------
 drivers/cpuidle/cpuidle.c   |  4 ++++
 drivers/idle/intel_idle.c   | 16 ----------------
 include/linux/cpuidle.h     | 13 +++++++------
 include/linux/mmu_context.h |  5 +++++
 6 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 0a301ad..9257667 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -59,5 +59,6 @@ typedef struct {
 	}
 
 void leave_mm(int cpu);
+#define leave_mm leave_mm
 
 #endif /* _ASM_X86_MMU_H */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 1a3569b..0951b47 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -555,21 +555,12 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
 		load_new_mm_cr3(next->pgd, new_asid, true);
 
-		/*
-		 * NB: This gets called via leave_mm() in the idle path
-		 * where RCU functions differently.  Tracing normally
-		 * uses RCU, so we need to use the _rcuidle variant.
-		 *
-		 * (There is no good reason for this.  The idle code should
-		 *  be rearranged to call this before rcu_idle_enter().)
-		 */
-		trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
+		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
 	} else {
 		/* The new ASID is already up to date. */
 		load_new_mm_cr3(next->pgd, new_asid, false);
 
-		/* See above wrt _rcuidle. */
-		trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, 0);
+		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, 0);
 	}
 
 	/* Make sure we write CR3 before loaded_mm. */
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 9bcda41..04becd7 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/suspend.h>
 #include <linux/tick.h>
+#include <linux/mmu_context.h>
 #include <trace/events/power.h>
 
 #include "cpuidle.h"
@@ -228,6 +229,9 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 		broadcast = false;
 	}
 
+	if (target_state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
+		leave_mm(dev->cpu);
+
 	/* Take note of the planned idle state. */
 	sched_idle_set_state(target_state);
 
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 8e0fb1a..9a810e4 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -90,14 +90,6 @@ static unsigned int mwait_substates __initdata;
 #define CPUIDLE_FLAG_ALWAYS_ENABLE	BIT(15)
 
 /*
- * Set this flag for states where the HW flushes the TLB for us
- * and so we don't need cross-calls to keep it consistent.
- * If this flag is set, SW flushes the TLB, so even if the
- * HW doesn't do the flushing, this flag is safe to use.
- */
-#define CPUIDLE_FLAG_TLB_FLUSHED	BIT(16)
-
-/*
  * MWAIT takes an 8-bit "hint" in EAX "suggesting"
  * the C-state (top nibble) and sub-state (bottom nibble)
  * 0x00 means "MWAIT(C1)", 0x10 means "MWAIT(C2)" etc.
@@ -131,14 +123,6 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
 	unsigned long eax = flg2MWAIT(state->flags);
 	unsigned long ecx = 1; /* break on interrupt flag */
 	bool tick;
-	int cpu = smp_processor_id();
-
-	/*
-	 * leave_mm() to avoid costly and often unnecessary wakeups
-	 * for flushing the user TLB's associated with the active mm.
-	 */
-	if (state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
-		leave_mm(cpu);
 
 	if (!static_cpu_has(X86_FEATURE_ARAT)) {
 		/*
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index b65909a..75895e6 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -75,12 +75,13 @@ struct cpuidle_state {
 };
 
 /* Idle State Flags */
-#define CPUIDLE_FLAG_NONE       (0x00)
-#define CPUIDLE_FLAG_POLLING	BIT(0) /* polling state */
-#define CPUIDLE_FLAG_COUPLED	BIT(1) /* state applies to multiple cpus */
-#define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
-#define CPUIDLE_FLAG_UNUSABLE	BIT(3) /* avoid using this state */
-#define CPUIDLE_FLAG_OFF	BIT(4) /* disable this state by default */
+#define CPUIDLE_FLAG_NONE       	(0x00)
+#define CPUIDLE_FLAG_POLLING		BIT(0) /* polling state */
+#define CPUIDLE_FLAG_COUPLED		BIT(1) /* state applies to multiple cpus */
+#define CPUIDLE_FLAG_TIMER_STOP 	BIT(2) /* timer is stopped on this state */
+#define CPUIDLE_FLAG_UNUSABLE		BIT(3) /* avoid using this state */
+#define CPUIDLE_FLAG_OFF		BIT(4) /* disable this state by default */
+#define CPUIDLE_FLAG_TLB_FLUSHED	BIT(5) /* idle-state flushes TLBs */
 
 struct cpuidle_device_kobj;
 struct cpuidle_state_kobj;
diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index c51a841..03dee12 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -3,10 +3,15 @@
 #define _LINUX_MMU_CONTEXT_H
 
 #include <asm/mmu_context.h>
+#include <asm/mmu.h>
 
 /* Architectures that care about IRQ state in switch_mm can override this. */
 #ifndef switch_mm_irqs_off
 # define switch_mm_irqs_off switch_mm
 #endif
 
+#ifndef leave_mm
+static inline void leave_mm(int cpu) { }
+#endif
+
 #endif
