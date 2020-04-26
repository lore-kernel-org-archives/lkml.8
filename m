Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77293C55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A1020A8B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgDZSnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726404AbgDZSnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:43:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E279FC061A10;
        Sun, 26 Apr 2020 11:43:00 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSmEw-0007E3-Iu; Sun, 26 Apr 2020 20:42:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3AD5F1C0178;
        Sun, 26 Apr 2020 20:42:54 +0200 (CEST)
Date:   Sun, 26 Apr 2020 18:42:53 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/cr4: Sanitize CR4.PCE update
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421092559.049499158@linutronix.de>
References: <20200421092559.049499158@linutronix.de>
MIME-Version: 1.0
Message-ID: <158792657377.28353.3722593728596584201.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     cb2a02355b042ec3ef11d0ba2a46742678e41632
Gitweb:        https://git.kernel.org/tip/cb2a02355b042ec3ef11d0ba2a46742678e41632
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 21 Apr 2020 11:20:30 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 24 Apr 2020 19:01:17 +02:00

x86/cr4: Sanitize CR4.PCE update

load_mm_cr4_irqsoff() is really a strange name for a function which has
only one purpose: Update the CR4.PCE bit depending on the perf state.

Rename it to update_cr4_pce_mm(), move it into the tlb code and provide a
function which can be invoked by the perf smp function calls.

Another step to remove exposure of cpu_tlbstate.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200421092559.049499158@linutronix.de
---
 arch/x86/events/core.c             | 11 +++--------
 arch/x86/include/asm/mmu_context.h | 14 +-------------
 arch/x86/mm/tlb.c                  | 22 +++++++++++++++++++++-
 3 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a619763..30d2b1d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2162,11 +2162,6 @@ static int x86_pmu_event_init(struct perf_event *event)
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
@@ -2185,7 +2180,7 @@ static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
 	lockdep_assert_held_write(&mm->mmap_sem);
 
 	if (atomic_inc_return(&mm->context.perf_rdpmc_allowed) == 1)
-		on_each_cpu_mask(mm_cpumask(mm), refresh_pce, NULL, 1);
+		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
 }
 
 static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
@@ -2195,7 +2190,7 @@ static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *m
 		return;
 
 	if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
-		on_each_cpu_mask(mm_cpumask(mm), refresh_pce, NULL, 1);
+		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
 }
 
 static int x86_pmu_event_idx(struct perf_event *event)
@@ -2253,7 +2248,7 @@ static ssize_t set_attr_rdpmc(struct device *cdev,
 		else if (x86_pmu.attr_rdpmc == 2)
 			static_branch_dec(&rdpmc_always_available_key);
 
-		on_each_cpu(refresh_pce, NULL, 1);
+		on_each_cpu(cr4_update_pce, NULL, 1);
 		x86_pmu.attr_rdpmc = val;
 	}
 
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 9608536..2985d06 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -24,21 +24,9 @@ static inline void paravirt_activate_mm(struct mm_struct *prev,
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
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index ea6f98a..3d9d819 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -272,6 +272,26 @@ static void cond_ibpb(struct task_struct *next)
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
@@ -440,7 +460,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
 
 	if (next != real_prev) {
-		load_mm_cr4_irqsoff(next);
+		cr4_update_pce_mm(next);
 		switch_ldt(real_prev, next);
 	}
 }
