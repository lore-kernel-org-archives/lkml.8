Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47779C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E7D421974
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgDSUgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 16:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgDSUgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 16:36:15 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E886DC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 13:36:14 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQGfd-0007JY-3p; Sun, 19 Apr 2020 22:36:05 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 6E385100EA1;
        Sun, 19 Apr 2020 22:36:04 +0200 (CEST)
Message-Id: <20200419203335.947161065@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 19 Apr 2020 22:31:40 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [patch 03/15] x86/cr4: Sanitize CR4.PCE update
References: <20200419203137.214111265@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

load_mm_cr4_irqsoff() is really a strange name for a function which has
only one purpose: Update the CR4.PCE bit depending on the perf state.

Rename it to update_cr4_pce_mm(), move it into the tlb code and provide a
function which can be invoked by the perf smp function calls.

Another step to remove exposure of cpu_tlbstate.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/events/core.c             |   11 +++--------
 arch/x86/include/asm/mmu_context.h |   14 +-------------
 arch/x86/mm/tlb.c                  |   22 +++++++++++++++++++++-
 3 files changed, 25 insertions(+), 22 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2162,11 +2162,6 @@ static int x86_pmu_event_init(struct per
 	return err;
 }
 
-static void refresh_pce(void *ignored)
-{
-	load_mm_cr4_irqsoff(this_cpu_read(cpu_tlbstate.loaded_mm));
-}
-
 static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
 {
 	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
@@ -2185,7 +2180,7 @@ static void x86_pmu_event_mapped(struct
 	lockdep_assert_held_write(&mm->mmap_sem);
 
 	if (atomic_inc_return(&mm->context.perf_rdpmc_allowed) == 1)
-		on_each_cpu_mask(mm_cpumask(mm), refresh_pce, NULL, 1);
+		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
 }
 
 static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
@@ -2195,7 +2190,7 @@ static void x86_pmu_event_unmapped(struc
 		return;
 
 	if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
-		on_each_cpu_mask(mm_cpumask(mm), refresh_pce, NULL, 1);
+		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
 }
 
 static int x86_pmu_event_idx(struct perf_event *event)
@@ -2253,7 +2248,7 @@ static ssize_t set_attr_rdpmc(struct dev
 		else if (x86_pmu.attr_rdpmc == 2)
 			static_branch_dec(&rdpmc_always_available_key);
 
-		on_each_cpu(refresh_pce, NULL, 1);
+		on_each_cpu(cr4_update_pce, NULL, 1);
 		x86_pmu.attr_rdpmc = val;
 	}
 
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -24,21 +24,9 @@ static inline void paravirt_activate_mm(
 #endif	/* !CONFIG_PARAVIRT_XXL */
 
 #ifdef CONFIG_PERF_EVENTS
-
 DECLARE_STATIC_KEY_FALSE(rdpmc_never_available_key);
 DECLARE_STATIC_KEY_FALSE(rdpmc_always_available_key);
-
-static inline void load_mm_cr4_irqsoff(struct mm_struct *mm)
-{
-	if (static_branch_unlikely(&rdpmc_always_available_key) ||
-	    (!static_branch_unlikely(&rdpmc_never_available_key) &&
-	     atomic_read(&mm->context.perf_rdpmc_allowed)))
-		cr4_set_bits_irqsoff(X86_CR4_PCE);
-	else
-		cr4_clear_bits_irqsoff(X86_CR4_PCE);
-}
-#else
-static inline void load_mm_cr4_irqsoff(struct mm_struct *mm) {}
+void cr4_update_pce(void *ignored);
 #endif
 
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -272,6 +272,26 @@ static void cond_ibpb(struct task_struct
 	}
 }
 
+#ifdef CONFIG_PERF_EVENTS
+static inline void cr4_update_pce_mm(struct mm_struct *mm)
+{
+	if (static_branch_unlikely(&rdpmc_always_available_key) ||
+	    (!static_branch_unlikely(&rdpmc_never_available_key) &&
+	     atomic_read(&mm->context.perf_rdpmc_allowed)))
+		cr4_set_bits_irqsoff(X86_CR4_PCE);
+	else
+		cr4_clear_bits_irqsoff(X86_CR4_PCE);
+}
+
+void cr4_update_pce(void *ignored)
+{
+	cr4_update_pce_mm(this_cpu_read(cpu_tlbstate.loaded_mm));
+}
+
+#else
+static inline void cr4_update_pce_mm(struct mm_struct *mm) { }
+#endif
+
 void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			struct task_struct *tsk)
 {
@@ -440,7 +460,7 @@ void switch_mm_irqs_off(struct mm_struct
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
 
 	if (next != real_prev) {
-		load_mm_cr4_irqsoff(next);
+		cr4_update_pce_mm(next);
 		switch_ldt(real_prev, next);
 	}
 }

