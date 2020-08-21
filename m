Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A4EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A42E214F1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z+b/Se74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgHUIzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgHUIzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:55:10 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27266C061387
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 01:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=kVY6G7OO1/PxLKPfmwqxSzhSufkqfGnS7p5BgJnItxw=; b=Z+b/Se74Tgp5L/CXTNrafpSOD3
        2r4/X8iAGpOnFp7rrvE6NOY6ih3MveClg5xzvTLn6XHuSozv3YwVzMJeKHIfRA58NAe2K5fsXpJyl
        ahWujxGNZ9dShl+Sk/2eFJreQoDQR6hnGnK3VpYuklh3tGP+1fQXgXcCYIUys/Q738xc2T3UL6HOe
        HvMTJi2aI3LbuYKRAGmWt5JEu841T2r9QsXu4q05GKhuI3oiulOkAUnZtgzVbQ8GRDNYu9GNSxppK
        MRrr4rrT46xEmdc7tKvXjrL75E33jN/F5+l+bR2+ABJ3LZJ1zTGgkRFLSPSb+DQaKIc7VAvD9yoNp
        BrfwDLVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k92p1-0008U3-Ls; Fri, 21 Aug 2020 08:54:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 09116305815;
        Fri, 21 Aug 2020 10:54:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E1BBB2B649916; Fri, 21 Aug 2020 10:54:49 +0200 (CEST)
Message-ID: <20200821085348.369441600@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Aug 2020 10:47:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org
Cc:     npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        peterz@infradead.org
Subject: [PATCH v2 04/11] cpuidle: Make CPUIDLE_FLAG_TLB_FLUSHED generic
References: <20200821084738.508092956@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows moving the leave_mm() call into generic code before
rcu_idle_enter(). Gets rid of more trace_*_rcuidle() users.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Marco Elver <elver@google.com>
---
 arch/x86/include/asm/mmu.h  |    1 +
 arch/x86/mm/tlb.c           |   13 ++-----------
 drivers/cpuidle/cpuidle.c   |    4 ++++
 drivers/idle/intel_idle.c   |   16 ----------------
 include/linux/cpuidle.h     |   13 +++++++------
 include/linux/mmu_context.h |    5 +++++
 6 files changed, 19 insertions(+), 33 deletions(-)

--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -59,5 +59,6 @@ typedef struct {
 	}
 
 void leave_mm(int cpu);
+#define leave_mm leave_mm
 
 #endif /* _ASM_X86_MMU_H */
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -555,21 +555,12 @@ void switch_mm_irqs_off(struct mm_struct
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
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/suspend.h>
 #include <linux/tick.h>
+#include <linux/mmu_context.h>
 #include <trace/events/power.h>
 
 #include "cpuidle.h"
@@ -230,6 +231,9 @@ int cpuidle_enter_state(struct cpuidle_d
 		broadcast = false;
 	}
 
+	if (target_state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
+		leave_mm(dev->cpu);
+
 	/* Take note of the planned idle state. */
 	sched_idle_set_state(target_state);
 
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -90,14 +90,6 @@ static unsigned int mwait_substates __in
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
@@ -131,14 +123,6 @@ static __cpuidle int intel_idle(struct c
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


