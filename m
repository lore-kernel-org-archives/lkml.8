Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A428C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A23A216C4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgE0ILy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbgE0ILt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:11:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246A1C03E97A;
        Wed, 27 May 2020 01:11:49 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAB-0002V2-Fw; Wed, 27 May 2020 10:11:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1D7EB1C03A9;
        Wed, 27 May 2020 10:11:47 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:47 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Convert reschedule interrupt to
 IDTENTRY_SYSVEC_SIMPLE
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202119.835425642@linutronix.de>
References: <20200521202119.835425642@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056710700.17951.6743495309914679803.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     064dc9d647c819f4c3196cdd10c06c0770cabf5f
Gitweb:        https://git.kernel.org/tip/064dc9d647c819f4c3196cdd10c06c0770cabf5f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:45 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:29 +02:00

x86/entry: Convert reschedule interrupt to IDTENTRY_SYSVEC_SIMPLE

The scheduler IPI does not need the full interrupt entry handling logic
when the entry is from kernel mode. Use IDTENTRY_SYSVEC_SIMPLE and spare
all the overhead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202119.835425642@linutronix.de
---
 arch/x86/entry/entry_64.S                |  4 ----
 arch/x86/include/asm/entry_arch.h        |  3 ---
 arch/x86/include/asm/hw_irq.h            |  3 ---
 arch/x86/include/asm/idtentry.h          |  1 +
 arch/x86/include/asm/trace/common.h      |  4 ----
 arch/x86/include/asm/trace/irq_vectors.h | 17 +----------------
 arch/x86/kernel/idt.c                    |  2 +-
 arch/x86/kernel/smp.c                    | 19 ++++---------------
 arch/x86/kernel/tracepoint.c             | 17 -----------------
 9 files changed, 7 insertions(+), 63 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index fd7efb8..9c0722e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -956,10 +956,6 @@ apicinterrupt3 \num \sym \do_sym
 POP_SECTION_IRQENTRY
 .endm
 
-#ifdef CONFIG_SMP
-apicinterrupt RESCHEDULE_VECTOR			reschedule_interrupt		smp_reschedule_interrupt
-#endif
-
 /*
  * Reload gs selector with exception handling
  * edi:  new selector
diff --git a/arch/x86/include/asm/entry_arch.h b/arch/x86/include/asm/entry_arch.h
index a01bb74..3e841ed 100644
--- a/arch/x86/include/asm/entry_arch.h
+++ b/arch/x86/include/asm/entry_arch.h
@@ -10,6 +10,3 @@
  * is no hardware IRQ pin equivalent for them, they are triggered
  * through the ICC by us (IPIs)
  */
-#ifdef CONFIG_SMP
-BUILD_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
-#endif
diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index fd5e7c8..74c1243 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -28,9 +28,6 @@
 #include <asm/irq.h>
 #include <asm/sections.h>
 
-/* Interrupt handlers registered during init_IRQ */
-extern asmlinkage void reschedule_interrupt(void);
-
 #ifdef	CONFIG_X86_LOCAL_APIC
 struct irq_data;
 struct pci_dev;
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index f24701f..d214a30 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -578,6 +578,7 @@ DECLARE_IDTENTRY_SYSVEC(X86_PLATFORM_IPI_VECTOR,	sysvec_x86_platform_ipi);
 #endif
 
 #ifdef CONFIG_SMP
+DECLARE_IDTENTRY(RESCHEDULE_VECTOR,			sysvec_reschedule_ipi);
 DECLARE_IDTENTRY_SYSVEC(IRQ_MOVE_CLEANUP_VECTOR,	sysvec_irq_move_cleanup);
 DECLARE_IDTENTRY_SYSVEC(REBOOT_VECTOR,			sysvec_reboot);
 DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_SINGLE_VECTOR,	sysvec_call_function_single);
diff --git a/arch/x86/include/asm/trace/common.h b/arch/x86/include/asm/trace/common.h
index 57c8da0..f0f9bcd 100644
--- a/arch/x86/include/asm/trace/common.h
+++ b/arch/x86/include/asm/trace/common.h
@@ -5,12 +5,8 @@
 DECLARE_STATIC_KEY_FALSE(trace_pagefault_key);
 #define trace_pagefault_enabled()			\
 	static_branch_unlikely(&trace_pagefault_key)
-DECLARE_STATIC_KEY_FALSE(trace_resched_ipi_key);
-#define trace_resched_ipi_enabled()			\
-	static_branch_unlikely(&trace_resched_ipi_key)
 #else
 static inline bool trace_pagefault_enabled(void) { return false; }
-static inline bool trace_resched_ipi_enabled(void) { return false; }
 #endif
 
 #endif
diff --git a/arch/x86/include/asm/trace/irq_vectors.h b/arch/x86/include/asm/trace/irq_vectors.h
index 33b9d0f..88e7f0f 100644
--- a/arch/x86/include/asm/trace/irq_vectors.h
+++ b/arch/x86/include/asm/trace/irq_vectors.h
@@ -10,9 +10,6 @@
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
-extern int trace_resched_ipi_reg(void);
-extern void trace_resched_ipi_unreg(void);
-
 DECLARE_EVENT_CLASS(x86_irq_vector,
 
 	TP_PROTO(int vector),
@@ -37,18 +34,6 @@ DEFINE_EVENT_FN(x86_irq_vector, name##_exit,	\
 	TP_PROTO(int vector),			\
 	TP_ARGS(vector), NULL, NULL);
 
-#define DEFINE_RESCHED_IPI_EVENT(name)		\
-DEFINE_EVENT_FN(x86_irq_vector, name##_entry,	\
-	TP_PROTO(int vector),			\
-	TP_ARGS(vector),			\
-	trace_resched_ipi_reg,			\
-	trace_resched_ipi_unreg);		\
-DEFINE_EVENT_FN(x86_irq_vector, name##_exit,	\
-	TP_PROTO(int vector),			\
-	TP_ARGS(vector),			\
-	trace_resched_ipi_reg,			\
-	trace_resched_ipi_unreg);
-
 /*
  * local_timer - called when entering/exiting a local timer interrupt
  * vector handler
@@ -99,7 +84,7 @@ TRACE_EVENT_PERF_PERM(irq_work_exit, is_sampling_event(p_event) ? -EPERM : 0);
 /*
  * reschedule - called when entering/exiting a reschedule vector handler
  */
-DEFINE_RESCHED_IPI_EVENT(reschedule);
+DEFINE_IRQ_VECTOR_EVENT(reschedule);
 
 /*
  * call_function - called when entering/exiting a call function interrupt
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index faaadd4..bc9b0d1 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -112,7 +112,7 @@ static const __initconst struct idt_data def_idts[] = {
  */
 static const __initconst struct idt_data apic_idts[] = {
 #ifdef CONFIG_SMP
-	INTG(RESCHEDULE_VECTOR,			reschedule_interrupt),
+	INTG(RESCHEDULE_VECTOR,			asm_sysvec_reschedule_ipi),
 	INTG(CALL_FUNCTION_VECTOR,		asm_sysvec_call_function),
 	INTG(CALL_FUNCTION_SINGLE_VECTOR,	asm_sysvec_call_function_single),
 	INTG(IRQ_MOVE_CLEANUP_VECTOR,		asm_sysvec_irq_move_cleanup),
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index e5647da..eff4ce3 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -220,26 +220,15 @@ static void native_stop_other_cpus(int wait)
 
 /*
  * Reschedule call back. KVM uses this interrupt to force a cpu out of
- * guest mode
+ * guest mode.
  */
-__visible void __irq_entry smp_reschedule_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_reschedule_ipi)
 {
 	ack_APIC_irq();
+	trace_reschedule_entry(RESCHEDULE_VECTOR);
 	inc_irq_stat(irq_resched_count);
-
-	if (trace_resched_ipi_enabled()) {
-		/*
-		 * scheduler_ipi() might call irq_enter() as well, but
-		 * nested calls are fine.
-		 */
-		irq_enter();
-		trace_reschedule_entry(RESCHEDULE_VECTOR);
-		scheduler_ipi();
-		trace_reschedule_exit(RESCHEDULE_VECTOR);
-		irq_exit();
-		return;
-	}
 	scheduler_ipi();
+	trace_reschedule_exit(RESCHEDULE_VECTOR);
 }
 
 DEFINE_IDTENTRY_SYSVEC(sysvec_call_function)
diff --git a/arch/x86/kernel/tracepoint.c b/arch/x86/kernel/tracepoint.c
index 496748e..fcfc077 100644
--- a/arch/x86/kernel/tracepoint.c
+++ b/arch/x86/kernel/tracepoint.c
@@ -25,20 +25,3 @@ void trace_pagefault_unreg(void)
 {
 	static_branch_dec(&trace_pagefault_key);
 }
-
-#ifdef CONFIG_SMP
-
-DEFINE_STATIC_KEY_FALSE(trace_resched_ipi_key);
-
-int trace_resched_ipi_reg(void)
-{
-	static_branch_inc(&trace_resched_ipi_key);
-	return 0;
-}
-
-void trace_resched_ipi_unreg(void)
-{
-	static_branch_dec(&trace_resched_ipi_key);
-}
-
-#endif
